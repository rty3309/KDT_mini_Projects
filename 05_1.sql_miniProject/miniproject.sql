use mini_project;

# 인구수 검산용
select sum(population)
from gunwigun
order by dong_name;

# 지역키 지정 - 공시지가 테이블
alter table land_value_with_code
add foreign key (district_code) references daegu(daegu_id);

# 지역키 지정 - pc방
alter table pc_daegu
add foreign key (dong_id) references daegu(daegu_id);

# 지역키 지정 - 노래방
alter table sing_daegu
add foreign key (dong_id) references daegu(daegu_id);

# 지역키 지정 - 동 전체 인구
alter table total_population
add foreign key (gu_id) references daegu(daegu_id);

# pc방 구별 개수
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(region, ' ', 2), ' ', -1) AS gu_name,
COUNT(*) AS total_count
FROM pc_daegu
GROUP BY gu_name;

# 단위인구당 pc방 구별 개수
SELECT 
    d.gu_name, 
    d.population, 
    COUNT(p.number) AS store_count,
    ROUND( d.population / (COUNT(p.number)), 2) AS people_per_store
FROM daegu d
INNER JOIN pc_daegu p 
    ON p.region LIKE CONCAT('%', d.gu_name, '%')
GROUP BY d.gu_name, d.population
ORDER BY people_per_store DESC;

# 노래방 구별 개수
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(region, ' ', 2), ' ', -1) AS gu_name,
COUNT(*) AS total_count
FROM sing_daegu
GROUP BY gu_name;

# 단위인구당 노래방 구별 개수
SELECT 
    d.gu_name, 
    d.population, 
    COUNT(s.number) AS store_count,
    ROUND( d.population / (COUNT(s.number)), 2) AS people_per_store
FROM daegu d
INNER JOIN sing_daegu s 
    ON s.region LIKE CONCAT('%', d.gu_name, '%')
GROUP BY d.gu_name, d.population
ORDER BY people_per_store DESC;

SELECT *
FROM land_value_with_code
WHERE district LIKE '%군위군%'
order by `official land price by district` desc;