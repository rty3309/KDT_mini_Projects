import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 1. 데이터 입력 (주신 데이터 정리)
# 구별 점포수 (이미지 데이터 기반)
store_data = {
    'gu_name': ['군위군', '수성구', '달성군', '중구', '북구', '달서구', '동구', '남구', '서구'],
    'store_count': [1, 85, 53, 22, 90, 140, 113, 58, 210]
}

# 구별 평균 공시지가 (주신 텍스트 데이터의 구별 평균 계산치 - 대략적 산출)
# 실제 분석시에는 전체 데이터를 리스트화하여 mean()을 구하는 것이 좋습니다.
land_price_data = {
    'gu_name': ['군위군', '수성구', '달성군', '중구', '북구', '달서구', '동구', '남구', '서구'],
    'avg_land_price': [30153, 1184325, 273614, 2985476, 755864, 1345672, 532415, 1201145, 915840]
}

df_store = pd.DataFrame(store_data)
df_land = pd.DataFrame(land_price_data)

# 데이터 합치기
df = pd.merge(df_store, df_land, on='gu_name')

# 2. 4분면 분류 기준 (전체 평균)
mean_price = df['avg_land_price'].mean()
mean_store = df['store_count'].mean()

# 3. 유형 분류 함수
def classify_area(row):
    if row['avg_land_price'] >= mean_price and row['store_count'] >= mean_store:
        return '1.포화(High/High)'
    elif row['avg_land_price'] >= mean_price and row['store_count'] < mean_store:
        return '2.프랜차이즈/자본(High/Low)'
    elif row['avg_land_price'] < mean_price and row['store_count'] < mean_store:
        return '3.블루오션(Low/Low) ⭐'
    else:
        return '4.레드오션(Low/High)'

df['Type'] = df.apply(classify_area, axis=1)

# 4. 시각화
plt.figure(figsize=(12, 8))
plt.rc('font', family='Malgun Gothic') # 한글 폰트 설정
plt.rcParams['axes.unicode_minus'] = False

# 산점도 그리기
sns.scatterplot(data=df, x='avg_land_price', y='store_count', hue='Type', s=300, palette='Set1')

# 기준선(평균) 그리기
plt.axvline(mean_price, color='gray', linestyle='--', alpha=0.5)
plt.axhline(mean_store, color='gray', linestyle='--', alpha=0.5)

# 각 점에 구 이름 표시
for i in range(df.shape[0]):
    plt.text(df.avg_land_price[i], df.store_count[i]+5, df.gu_name[i], fontsize=12, ha='center')

# 그래프 제목 및 라벨
plt.title('대구 주요 구별 창업 입지 4분면 분석 (PC방 기준)', fontsize=18, pad=20)
plt.xlabel('평균 공시지가 (임대료 지표)', fontsize=12)
plt.ylabel('점포 수 (경쟁 지표)', fontsize=12)
plt.grid(True, alpha=0.2)

plt.show()