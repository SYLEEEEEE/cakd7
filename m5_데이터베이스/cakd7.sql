--L MEMBERS
select * 
from purprd left outer join demo on purprd.custno=demo.custno;

select * from purprd;

select custno, round(avg(puramt)) 구매평균
from purprd
group by custno
order by custno;

--Q. lmemverrs purprd 테이블로 부터 총 구매액, 2014구매액, 2015 구매액을 한번에 출력
select * from purprd;

select sum(puramt) 총구매액, 
sum(case when purdate < '20150101' then puramt end) "2014 구매액", 
sum(case when purdate >= '20150101' then puramt end) "2015 구매액"
from purprd;

--Q. lmambers 데이터에서 고객별 구매금액의 합계를 구한 cuspur 테이블을 생성한 후 demo 테이블과 고객번호(custno)를 기준으로 결합하여 출력
create table cuspur
as select custno, sum(puramt) puramt_sum 
from purprd group by custno;
select * from cuspur;

select demo.*, cuspur.puramt_sum
from cuspur, demo where cuspur.custno=demo.custno
order by demo.custno;

--과제1 1006 purprd 데이터로부터 아래 사항을 수행하세요.
--2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성(출력내용:고객번호,제휴사,sum(구매금액)구매금액)
select * from purprd;
create table AMT_14
as select custno 고객번호, asso 제휴사, 
sum(puramt) "14구매금액"
from purprd 
where purdate<'20150101' 
group by custno, asso;
select * from amt_14;
--drop table amt_14;

create table AMT_15
as select custno 고객번호, asso 제휴사, 
sum(puramt) "15구매금액"
from purprd 
where purdate>='20150101' 
group by custno, asso;
select * from amt_15;
--drop table amt_15;

--AMT_14와 AMT_15 2개 테이블을 고객번호와 제휴사를 기준으로 full outer join 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
create table AMT_YEAR_FOJ
as select amt_14.*, amt_15."15구매금액"
from amt_14 full outer join amt_15 on amt_15."고객번호" = amt_14."고객번호"
order by amt_14."고객번호";
select * from amt_year_foj;

--14년과 15년의 구매금액 차이를 표시하는 증감 칼럼을 추가하여 출력( 단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
alter table amt_year_foj add 구매차액 varchar2(20); 
update amt_year_foj
set 구매차액=(nvl("15구매금액",0)-nvl("14구매금액",0)
);
select count(구매차액)
from amt_year_foj
where 구매차액=0;

select 고객번호, 제휴사, 구매차액, case when nvl("15구매금액",0)-nvl("14구매금액",0)<0 then '감소'
when nvl("15구매금액",0)-nvl("14구매금액",0)>0 then '증가'
else '유지' end 구매증감
from amt_year_foj order by 고객번호, 제휴사;

