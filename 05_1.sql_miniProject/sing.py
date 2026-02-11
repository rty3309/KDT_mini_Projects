import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 1. 데이터 입력 (업로드해주신 이미지 및 텍스트 기반)
# 구별 노래방 점포수 (이미지 데이터 기반)
sing_store_data = {
    'gu_name': ['달성군', '군위군', '수성구', '동구', '중구', '북구', '남구', '달서구', '서구'],
    'store_count': [101, 9, 189, 160, 58, 261, 100, 424, 537]
}

# 구별 평균 공시지가 (주신 텍스트 데이터를 구별로 평균 낸 수치)
land_price_data = {
    'gu_name': ['달성군', '군위군', '수성구', '동구', '중구', '북구', '남구', '달서구', '서구'],
    'avg_land_price': [273614, 30153, 1184325, 532415, 2985476, 755864, 1201145, 1345672, 915840]
}

df_sing = pd.DataFrame(sing_store_data)
df_land = pd.DataFrame(land_price_data)

# 데이터 병합
df = pd.merge(df_sing, df_land, on='gu_name')

# 2. 4분면 분류 기준 (전체 평균값)
mean_price = df['avg_land_price'].mean()
mean_store = df['store_count'].mean()

# 3. 4구역 분류 함수 정의
def classify_area(row):
    if row['avg_land_price'] >= mean_price and row['store_count'] >= mean_store:
        return '1.포화(이미 늦음)'
    elif row['avg_land_price'] >= mean_price and row['store_count'] < mean_store:
        return '2.자본력필요(프랜차이즈)'
    elif row['avg_land_price'] < mean_price and row['store_count'] < mean_store:
        return '3.블루오션(창업추천) ⭐'
    else:
        return '4.레드오션(박리다매)'

df['Type'] = df.apply(classify_area, axis=1)

# 4. 시각화 설정
plt.figure(figsize=(14, 9))
plt.rc('font', family='Malgun Gothic') # 윈도우 한글 폰트
plt.rcParams['axes.unicode_minus'] = False

# 산점도 그리기
scatter = sns.scatterplot(
    data=df, 
    x='avg_land_price', 
    y='store_count', 
    hue='Type', 
    s=400, 
    palette='Set1',
    edgecolor='black',
    alpha=0.8
)

# 기준선(평균) 추가
plt.axvline(mean_price, color='darkred', linestyle='--', linewidth=1, label=f'평균 지가: {mean_price:,.0f}')
plt.axhline(mean_store, color='darkblue', linestyle='--', linewidth=1, label=f'평균 점포수: {mean_store:.1f}')

# 구 이름 라벨링
for i in range(df.shape[0]):
    plt.text(
        df.avg_land_price[i], 
        df.store_count[i] + 10, 
        df.gu_name[i], 
        fontsize=12, 
        fontweight='bold', 
        ha='center'
    )

# 그래프 제목 및 디자인
plt.title('대구 노래방 창업 입지 4분면 분석 (공시지가 x 점포수)', fontsize=20, pad=20)
plt.xlabel('평균 공시지가 (임대료/초기비용 지표)', fontsize=14)
plt.ylabel('노래방 점포 수 (경쟁 지표)', fontsize=14)
plt.legend(title='입지 유형', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.grid(True, which='both', linestyle='--', alpha=0.5)

plt.tight_layout()
plt.show()