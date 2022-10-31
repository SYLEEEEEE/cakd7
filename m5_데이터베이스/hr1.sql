select * from employees;
select last_name, 'is a' job_id from employees;
select last_name ||'is_a'||job_id as EXPLAIN from employees;

--unique
select DISTINCT job_id from employees;

--isnull, isnotnull
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--Q. employees 테이블에서 commission_pct의 null 값 개수를 출력
select count(*) from employees where commission_pct is null;

--Q. employees 테이블에서 employee_id가 홀수인 것만 출력
select * from employees where mod(employee_id, 2) = 1;

select round(355.9555, 2) from dual;
select round(355.9555, -2) from dual;
select trunc(45.55551, 1) from dual;

select last_name, trunc(salary/12, 2) 월급 from employees;

--width_bucket(지정값, 최솟값, 최댓값, bucket개수) 구간 나눠서 지정값이 몇번째에 오냐
select width_bucket(92, 0, 100, 10) from dual;
select width_bucket(38, 0, 100, 50) from dual;

select upper('hello world') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where last_name='king';
select last_name, salary from employees where lower(last_name)='king'; --응용 

select job_id, length(job_id) from employees;
select substr('Hello world', 3, 3) from dual;
select substr('Hello world', -3, 3) from dual; --끝에서부터 세개

select lpad('Hello World', 20, '#') from dual;
select rpad('Hello World', 20, '#') from dual;

select last_name, trim('A' from last_name) A삭제 from employees;
select ltrim('aaaHello worldaaa', 'a') from dual;
select rtrim('aaaHello worldaaa', 'a') from dual;
select trim('        Hello world      ') from dual;
select ltrim('        Hello world      ') from dual;
select rtrim('        Hello world      ') from dual;

select sysdate from dual; --현재날짜
select hire_date from employees;
select * from employees;
select last_name, trunc((sysdate-hire_date)/365, 0) 근속연수 from employees;

--과제 1 1005 employees 테이블에서 채용일에 6개월을 추가한 날짜를 last_name과 같이 출력
select last_name, add_months(hire_date,6) 채용후6개월 from employees;

--과제 2 1005 이번달의 말일을 반환하는 함수를 사용하여 말일을 출력
select last_day(sysdate) from dual;

--과제 3 1005 employees 테이블에서 채용에서 채용일과 현재시점간의 근속월수를 출력
select * from employees;
select hire_date, round(months_between(sysdate, hire_date)) 근속월수 from employees;

--과제 4 1005 입사일 6개월 후 첫번째 월요일을 last_name별로 출력
select last_name, next_day(add_months(hire_date, 6),'월요일') "6개월 후 첫 월요일" from employees;

--과제 5 1005 job_id별로 연봉합계 평균연봉, 최고연봉, 최저연봉 출력 단, 평균 연봉이 5000 이상인 경우만 포함하여 내림차순으로 정렬 --디센딩
select * from employees;
select job_id, avg(salary) 평균연봉, max(salary) 최고연봉, min(salary) 최저연봉
from employees group by job_id 
having avg(salary)>=5000 order by 평균연봉 desc;

--과제 6 1005사원번호(employee_id)가 110인 사원의 부서명을 출력
select * from employees;
select * from departments;  --부서명
select d.department_name
from departments d, employees e
where d.department_id=e.department_id and e.employee_id=110;

--과제 7 1005 사번이 120인 직원의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력
select * from employees;
select * from jobs;--타이틀
select e.employee_id 사번, e.first_name ||' '|| e.last_name 이름, e.job_id 업무, j.job_title 업무명
from employees e, jobs j
where e.job_id=j.job_id and e.employee_id=120;

--과제 8 1005 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'
SELECT employee_id, last_name, CASE WHEN SALARY > 20000 THEN '대표이사'
    WHEN SALARY > 15000 THEN '이사'
    WHEN SALARY > 10000 THEN '부장'
    WHEN SALARY > 5000 THEN '과장'
    WHEN SALARY > 3000  THEN '대리'
    ELSE '사원' END 직급 
FROM employees;


--alter table employees add 직급 varchar2(20) default '사원' not null;
--update employees set 직급= '대리' where salary > 3000;
--update employees set 직급= '과장' where salary > 5000;
--update employees set 직급= '부장' where salary > 10000;
--update employees set 직급= '이사' where salary > 15000;
--update employees set 직급= '대표이사' where salary > 20000;
--select employee_id 사번, first_name ||' '|| last_name 이름, 직급
--from employees;
--alter table employees drop column 직급;
--select * from employees;

--과제 9 1005 employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하여 출력
create table employee_salary
as select employee_id, salary from employees;
select * from employee_salary;
drop table employee_salary;

--과제 10 1005 employee_salary 테이블에 first_name, last_name 컬럼을 추가한 후 name으로 변경하여 출력
alter table employee_salary add first_name varchar2(20);
alter table employee_salary add last_name varchar2(20);

update employee_salary es
set first_name=(
select first_name 
from employees e
where e.employee_id=es.employee_id), 
last_name=(
select last_name 
from employees e
where e.employee_id=es.employee_id);

select first_name ||' '|| last_name 이름
from employee_salary;
select * from employee_salary;

--과제 11 1005 employee_salary 테이블의 employee_id에 기본키를 적용하고 constraint_name을 ES_PK로 지정 후 출력
 table employee_salary add constraint ES_PK primary key(employee_id);

--과제 12 1005 employee_salary 테이블의 employee_id에서 contraint_name을 삭제한 후 삭제 여부 확인
alter table employee_salary drop primary key;
select * from user_constraints where table_name = 'employee_salary';
