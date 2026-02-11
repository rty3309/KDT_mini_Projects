use mini_project;

grant all privileges on mini_project.* to 'sy'@'%';
grant all privileges on mini_project.* to 'yunjin'@'%';
grant all privileges on mini_project.* to 'yujin'@'%';

SET FOREIGN_KEY_CHECKS = 0; -- 외래키 때문에 안 지워질 때를 대비해 잠시 끄기
TRUNCATE TABLE daegu;
TRUNCATE TABLE junggu;
truncate table donggu;
TRUNCATE TABLE seogu;
TRUNCATE TABLE namgu;
truncate table bukgu;
TRUNCATE TABLE suseonggu;
TRUNCATE TABLE dalseogu;
truncate table dalseonggun;
truncate table gunwigun;
SET FOREIGN_KEY_CHECKS = 1; -- 다시 켜기

# 1) 대구 테이블
drop table if exists daegu;
create table daegu(
		daegu_id int not null auto_increment,
		gu_name varchar(20) not null,
		population int not null,
		area float not null,
		primary key(daegu_id));
insert into daegu(gu_name, population, area)
values ('중구', 101007, 8),
	('동구', 339281, 183),
	('서구', 163956, 17.5),
	('남구', 135542, 17.4),
	('북구', 409854, 94),
	('수성구', 409222, 76.5),
	('달서구', 517059, 62.4),
	('달성군', 254659, 428.4),
	('군위군', 22452, 614.3);

# 2) 중구 테이블
drop table if exists junggu;
create table junggu(
		jung_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (jung_id) references daegu(daegu_id));
insert into junggu(jung_id, dong_name, population)
values (1, '동인동', 11448),
	(1, '삼덕동', 7730),
	(1, '공평동', 374),
	(1, '교동', 819),
	(1, '동문동', 3),
	(1, '문화동', 300),
	(1, '봉산동', 2250),
	(1, '사일동', 1),
	(1, '상덕동', 7),
	(1, '완전동', 316),
	(1, '용덕동', 43),
	(1, '태평로', 805),
	(1, '동성로', 68),
	(1, '포정동', 306),
	(1, '화전동', 31),
	(1, '남일동', 296),
	(1, '덕산동', 5),
	(1, '북성로', 163),
	(1, '계산동', 734),
	(1, '남성로', 84),
	(1, '대안동', 107),
	(1, '북내동', 98),
	(1, '상서동', 121),
	(1, '서내동', 76),
	(1, '장관동', 178),
	(1, '동일동', 3),
	(1, '종로', 152),
	(1, '서문로', 197),
	(1, '하서동', 576),
	(1, '서성로', 1008),
	(1, '수동', 182),
	(1, '향촌동', 249),
	(1, '전동', 47),
	(1, '동산동', 1384),
	(1, '수창동', 5205),
	(1, '달성동', 4069),
	(1, '도원동', 3168),
	(1, '인교동', 367),
	(1, '서야동', 170),
	(1, '시장북로', 167),
	(1, '대신동', 7576),
	(1, '남산동', 35891),
	(1, '대봉동', 14233);

# 3) 동구 테이블
drop table if exists donggu;
create table donggu(
		dong_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (dong_id) references daegu(daegu_id));
insert into donggu(dong_id, dong_name, population)
values (2, '각산동', 17841),
	(2, '검사동', 9260),
	(2, '괴전동', 5737),
	(2, '금강동', 215),
	(2, '내곡동', 79),
	(2, '내동', 145),
	(2, '능성동', 175),
	(2, '대림동', 2440),
	(2, '덕곡동', 534),
	(2, '도동', 2579),
	(2, '도학동', 262),
	(2, '동내동', 125),
	(2, '동호동', 171),
	(2, '둔산동', 1182),
	(2, '매여동', 112),
	(2, '미곡동', 327),
	(2, '미대동', 334),
	(2, '방촌동', 26637),
	(2, '백안동', 699),
	(2, '봉무동', 14558),
	(2, '부동', 345),
	(2, '불로동', 9302),
	(2, '사복동', 3471),
	(2, '상매동', 71),
	(2, '서호동', 2593),
	(2, '송정동', 298),
	(2, '숙천동', 1576),
	(2, '신기동', 8064),
	(2, '신무동', 217),
	(2, '신서동', 25409),
	(2, '신암동', 55100),
	(2, '신용동', 214),
	(2, '신천동', 42318),
	(2, '신평동', 2346),
	(2, '용계동', 12293),
	(2, '용수동', 236),
	(2, '율암동', 4736),
	(2, '율하동', 29957),
	(2, '입석동', 5593),
	(2, '중대동', 762),
	(2, '지묘동', 15504),
	(2, '지저동', 8584),
	(2, '진인동', 476),
	(2, '평광동', 295),
	(2, '효목동', 26109);

# 4) 서구 테이블
drop table if exists seogu;
create table seogu(
		seo_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (seo_id) references daegu(daegu_id));
insert into seogu(seo_id, dong_name, population)
values (3, '내당동', 36279),
	(3, '비산동', 44078),
	(3, '상리동', 1265),
	(3, '원대동', 10053),
	(3, '이현동', 334),
	(3, '중리동', 15502),
	(3, '평리동', 56445);

# 5) 남구 테이블
drop table if exists namgu;
create table namgu(
		nam_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (nam_id) references daegu(daegu_id));
insert into namgu(nam_id, dong_name, population)
values (4, '이천동', 14228),
	(4, '봉덕동', 34841),
	(4, '대명동', 86473);

# 6) 북구 테이블
drop table if exists bukgu;
create table bukgu(
		buk_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (buk_id) references daegu(daegu_id));
insert into bukgu(buk_id, dong_name, population)
values (5, '검단동', 5537),
	(5, '고성동', 14502),
	(5, '관음동', 13923),
	(5, '구암동', 30765),
	(5, '국우동', 19534),
	(5, '금호동', 744),
	(5, '노곡동', 672),
	(5, '노원동', 11055),
	(5, '대현동', 15546),
	(5, '도남동', 1666),
	(5, '동변동', 9993),
	(5, '동천동', 25069),
	(5, '동호동', 169),
	(5, '매천동', 11962),
	(5, '복현동', 35743),
	(5, '사수동', 14945),
	(5, '산격동', 32243),
	(5, '서변동', 12576),
	(5, '연경동', 9334),
	(5, '읍내동', 24999),
	(5, '조야동', 1074),
	(5, '칠성동', 22995),
	(5, '침산동', 39433),
	(5, '태전동', 43011),
	(5, '팔달동', 4098),
	(5, '학정동', 8266);

# 7) 수성구 테이블
drop table if exists suseonggu;
create table suseonggu(
		suseong_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (suseong_id) references daegu(daegu_id));
insert into suseonggu(suseong_id, dong_name, population)
values (6, '가천동', 237),
	(6, '고모동', 213),
	(6, '노변동', 5982),
	(6, '대흥동', 147),
	(6, '두산동', 14812),
	(6, '만촌동', 54493),
	(6, '매호동', 14788),
	(6, '범물동', 25457),
	(6, '범어동', 72418),
	(6, '사월동', 11192),
	(6, '삼덕동', 424),
	(6, '상동', 14037),
	(6, '성동', 193),
	(6, '수성동', 40303),
	(6, '시지동', 17948),
	(6, '신매동', 28876),
	(6, '연호동', 429),
	(6, '욱수동', 5895),
	(6, '이천동', 479),
	(6, '중동', 14455),
	(6, '지산동', 37128),
	(6, '파동', 16546),
	(6, '황금동', 32770);

# 8) 달서구 테이블
drop table if exists dalseogu;
create table dalseogu(
		dalseo_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (dalseo_id) references daegu(daegu_id));
insert into dalseogu(dalseo_id, dong_name, population)
values (7, '갈산동', 167),
	(7, '감삼동', 35487),
	(7, '대곡동', 19519),
	(7, '대천동', 10731),
	(7, '도원동', 31351),
	(7, '두류동', 24671),
	(7, '본동', 12387),
	(7, '본리동', 22605),
	(7, '상인동', 59088),
	(7, '성당동', 20230),
	(7, '송현동', 34116),
	(7, '신당동', 14512),
	(7, '용산동', 52504),
	(7, '월성동', 52892),
	(7, '월암동', 233),
	(7, '유천동', 22714),
	(7, '이곡동', 34049),
	(7, '장기동', 16005),
	(7, '장동', 118),
	(7, '죽전동', 10033),
	(7, '진천동', 30471),
	(7, '파호동', 5947),
	(7, '호림동', 67),
	(7, '호산동', 7162);

# 9) 달성군 테이블
drop table if exists dalseonggun;
create table dalseonggun(
		dalseong_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (dalseong_id) references daegu(daegu_id));
insert into dalseonggun(dalseong_id, dong_name, population)
values (8, '화원읍', 45799),
	(8, '논공읍', 15078),
	(8, '다사읍', 89503),
	(8, '유가읍', 31374),
	(8, '옥포읍', 22631),
	(8, '현풍읍', 21296),
	(8, '가창면', 6831),
	(8, '하빈면', 3196),
	(8, '구지면', 18951);

# 10) 군위군 테이블
drop table if exists gunwigun;
create table gunwigun(
		gunwi_id int not null,
		dong_name varchar(20) not null,
		population int not null,
		foreign key (gunwi_id) references daegu(daegu_id));
insert into gunwigun(gunwi_id, dong_name, population)
values (9, '군위읍', 7852),
	(9, '소보면', 2235),
	(9, '효령면', 3624),
	(9, '부계면', 2067),
	(9, '우보면', 1937),
	(9, '의흥면', 2230),
	(9, '산성면', 1193),
	(9, '삼국유사면', 1314);