# 전체 회사 개발자 직무 공고 연도별 정리

import pandas as pd
import matplotlib.pyplot as plt
import glob
import koreanize_matplotlib

# 같은 폴더의 모든 csv 파일 불러오기
all_files = glob.glob("recruit_*.csv")

# 전체 합치기
df = pd.concat([pd.read_csv(f) for f in all_files], ignore_index=True)

# 연도별 공고 수 집계
year_count = df["year"].value_counts().sort_index()

# 그래프 그리기
fig, axes = plt.subplots(figsize=(10, 6))

axes.bar(year_count.index, year_count.values, color="cornflowerblue", alpha=0.6, label="공고 수")
axes.plot(year_count.index, year_count.values, color="tomato", marker="o", linewidth=2, label="추세")

axes.set_title("자동차 10개 기업 연도별 개발자 채용공고 수 변화", fontsize=16)
axes.set_xlabel("연도", fontsize=12)
axes.set_ylabel("공고 수", fontsize=12)
axes.set_xticks(year_count.index)
axes.set_xticklabels(year_count.index.astype(int))
axes.legend()
plt.tight_layout()
plt.show()