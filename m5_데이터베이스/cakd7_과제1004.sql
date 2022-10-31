--과제 9 1004 lmemvers 데이터를 고객별로 속성(성별,나이,거주지역), 구매합계(반기별), 평균구매(반기별), 구매빈도(반기별) 출력

select * from demo;
select * from purprd;
select * from channel;


SELECT d.custno 고객번호, d.age 나이, d.gender 성별, d.area 거주지역,
round(sum(case when p.purdate between '20150701' and '20151231' then p.puramt end)) "구매합계(2015후기)",
round(count(case when p.purdate between '20150701' and '20151231' then p.custno end)) "구매빈도(2015후기)",
round(avg(case when p.purdate between '20150701' and '20151231' then p.puramt end)) "구매평균(2015후기)",

round(sum(case when p.purdate between '20150101' and '20150630' then p.puramt end)) "구매합계(2015전기)",
round(count(case when p.purdate between '20150101' and '20150630' then p.custno end)) "구매빈도(2015전기)",
round(avg(case when p.purdate between '20150101' and '20150630' then p.puramt end)) "구매평균(2015전기)",

round(sum(case when p.purdate between '20140701' and '20141231' then p.puramt end)) "구매합계(2014후기)",
round(count(case when p.purdate between '20140701' and '20141231' then p.custno end)) "구매빈도(2014후기)",
round(avg(case when p.purdate between '20140701' and '20141231' then p.puramt end)) "구매평균(2014후기)",

sum(case when p.purdate between '20140101' and '20140630' then p.puramt end) "구매합계(2014전기)",
count(case when p.purdate between '20140101' and '20140630' then p.custno end) "구매빈도(2014전기)",
avg(case when p.purdate between '20140101' and '20140630' then p.puramt end) "구매평균(2014전기)"

from purprd p, demo d
where d.custno=p.custno
group by d.custno, d.age, d.gender, d.area order by d.custno;