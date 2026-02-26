# 크롤링 미니 프로젝트 - 현대자동차
# 현대자동차 잡코리아 ID : 1360583

import re
import csv
import time
import random
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options    # 크롬 브라우저 설정 커스텀 도구
from selenium.webdriver.support.ui import WebDriverWait    # 페이지가 로딩될 때 까지 기다려주는 도구
from selenium.webdriver.support import expected_conditions as EC    # 조건이 충족될 때 까지 대기하는 도구

COMPANY_ID = "1360583"
MY_JOBS = ['AI/ML엔지니어', '데이터사이언티스트', '데이터엔지니어', 'R&D·연구원', '백엔드개발자', '소프트웨어개발자', 'QA']
BASE_URL = f"https://www.jobkorea.co.kr/company/{COMPANY_ID}/Recruit?GI_Part_Code={{code}}&Search_Order=1&ChkDispType=0&Part_Btn_Stat=1"

def get_driver():
    options = Options()
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('useAutomationExtension', False)
    options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
    options.add_argument("--disable-blink-features=AutomationControlled")
    return webdriver.Chrome(options=options)

def human_delay(a=2.0, b=4.0):
    time.sleep(random.uniform(a, b))

def parse_year(date_str):
    match = re.search(r"(\d{4})", date_str)
    return match.group(1) if match else str(datetime.now().year)

def get_job_codes(driver):
    url = BASE_URL.format(code=0)
    driver.get(url)
    human_delay()

    wait = WebDriverWait(driver, 20)

    try:
        wait.until(EC.frame_to_be_available_and_switch_to_it((By.ID, "gi_list_iframe")))
    except:
        pass

    wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "a.btnCtgr")))
    human_delay(1.0, 2.0)

    return [
        match.group()
        for btn in driver.find_elements(By.CSS_SELECTOR, "a.btnCtgr")
        if (name := btn.text.strip().split('(')[0].strip()) in MY_JOBS
        and (onclick := btn.get_attribute("onclick"))
        and (match := re.search(r"\d+", onclick))]

def recruit_info(driver, codes):
    # 공고이름, 날짜 수집
    results = []

    for code in codes:
        page = 1
        while True:
            url = BASE_URL.format(code=code) + (f"&page={page}" if page > 1 else "")
            driver.get(url)
            human_delay()

            wait = WebDriverWait(driver, 20)

            try:
                wait.until(EC.frame_to_be_available_and_switch_to_it((By.ID, "gi_list_iframe")))
                human_delay(1.0, 2.0)
            except:
                pass

            try:
                wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "dt.tit")))
            except:
                print(f"코드 {code} {page}페이지 공고 없음 → 다음으로 넘어갑니다")
                break

            human_delay(1.0, 2.0)

            titles = [el.text.strip() for el in driver.find_elements(By.CSS_SELECTOR, "dt.tit")]
            dates  = [el.text.strip() for el in driver.find_elements(By.CSS_SELECTOR, "span.day.tahoma")]

            if not titles:
                break

            for title, date in zip(titles, dates):
                results.append({"title": title, "date": date})

            print(f"코드 {code} {page}페이지 수집 완료 ({len(titles)}건)")
            page += 1
            human_delay(2.0, 4.0)

    return results


def main():
    driver = get_driver()
    try:
        codes = get_job_codes(driver)
        print(f"수집된 코드: {codes}")

        human_delay(2.0, 4.0)

        raw_data = recruit_info(driver, codes)
        print(f"중복 제거 전 공고 수: {len(raw_data)}건")

        # 제목 + 날짜 두 개 조합으로 중복 제거 후 연도 추출
        seen = set()
        unique_data = []
        for item in raw_data:
            key = (item["title"], item["date"])
            if key not in seen:
                seen.add(key)
                unique_data.append({"title": item["title"], "year": parse_year(item["date"])})

        print(f"중복 제거 후 공고 수: {len(unique_data)}건")

        with open(f"recruit_{COMPANY_ID}.csv", "w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=["title", "year"])
            writer.writeheader()
            writer.writerows(unique_data)

        print(f"저장 완료: recruit_{COMPANY_ID}.csv")

    finally:
        driver.quit()


if __name__ == "__main__":
    main()