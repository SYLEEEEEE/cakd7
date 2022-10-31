select * from employees;
select * from jobs;
select * from departments;

select job_id, department_id, trunc((sysdate-hire_date)/365, 0) 근속연수, salary, 
case when salary > 20000 then '대표이사'
when salary > 15000 then '이사'
when salary > 10000 then '부장' 
when salary > 5000 then '과장' 
when salary > 3000 then '대리'
else '사원' end 직급
from employees order by salary desc;

--직무별평균임금, 보너스 받는 비율 양, 부서 인원수, 근속년수, 입사년도 인원 수 >줄어들면 작아지는 회사?
select round(count(commission_pct)/count(employee_id),2) 보너스받는비율, round(avg(commission_pct),2) 보너스평균
from employees;

select department_id, count(employee_id) from employees group by department_id order by department_id;

--Q. HR employees 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력
select first_name ||' '|| last_name 이름, salary 연봉, salary *1.1 "10%인상연봉"
from employees;

--Q. HR employees 테이블에서 commission_pct의 null값 개수를 출력
select count(*) from employees where commission_pct is null ;

--과제2 1006 hr 테이블들을 분석해서 전체 현화을 설명할 수 있는 요약 테이블을 2개 이상 작성하세요.(예: 부서평 평균 salary 순위)
--입사 월, 년도별 입사 수, 보너스받는 비율, 보너스 평균
select * from employees;
select * from jobs;
select * from departments;
select e.department_id, round(avg(e.salary)) "부서별 평균연봉"
from employees e group by e.department_id
order by "부서별 평균연봉" desc;

select hire_date, count(employee_id)
from employees order
where 

--DCL
--user 생성, 삭제
create user c##user01
identified by userpass;

select * from all_users;
drop user c##user01;

--grant, revoke 권한 주고뺏기
create user c##user01
identified by userpass;
grant create session, create table to c##user01;
revoke create session, create table from c##user01;

--사용자 암호 변경
alter user c##user01
identified by passuser;

--삭제
drop user c##user01 cascade;

create table users(
id number,
name varchar2(20),
age number);

insert into users values(1, 'hong gildong', 30);
insert into users values(2, 'hong gildsoon', 30);
select * from users;

delete from users where id=1;
select * from users;
rollback; --이전 커밋으로 돌아감

commit; -- 시점 지정

show autocommit;
set autocommit on;
set autocommit off;