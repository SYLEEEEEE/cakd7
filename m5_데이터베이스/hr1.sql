select * from employees;
select last_name, 'is a' job_id from employees;
select last_name ||'is_a'||job_id as EXPLAIN from employees;

--unique
select DISTINCT job_id from employees;

--isnull, isnotnull
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--Q. employees ���̺��� commission_pct�� null �� ������ ���
select count(*) from employees where commission_pct is null;

--Q. employees ���̺��� employee_id�� Ȧ���� �͸� ���
select * from employees where mod(employee_id, 2) = 1;

select round(355.9555, 2) from dual;
select round(355.9555, -2) from dual;
select trunc(45.55551, 1) from dual;

select last_name, trunc(salary/12, 2) ���� from employees;

--width_bucket(������, �ּڰ�, �ִ�, bucket����) ���� ������ �������� ���°�� ����
select width_bucket(92, 0, 100, 10) from dual;
select width_bucket(38, 0, 100, 50) from dual;

select upper('hello world') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where last_name='king';
select last_name, salary from employees where lower(last_name)='king'; --���� 

select job_id, length(job_id) from employees;
select substr('Hello world', 3, 3) from dual;
select substr('Hello world', -3, 3) from dual; --���������� ����

select lpad('Hello World', 20, '#') from dual;
select rpad('Hello World', 20, '#') from dual;

select last_name, trim('A' from last_name) A���� from employees;
select ltrim('aaaHello worldaaa', 'a') from dual;
select rtrim('aaaHello worldaaa', 'a') from dual;
select trim('        Hello world      ') from dual;
select ltrim('        Hello world      ') from dual;
select rtrim('        Hello world      ') from dual;

select sysdate from dual; --���糯¥
select hire_date from employees;
select * from employees;
select last_name, trunc((sysdate-hire_date)/365, 0) �ټӿ��� from employees;

--���� 1 1005 employees ���̺��� ä���Ͽ� 6������ �߰��� ��¥�� last_name�� ���� ���
select last_name, add_months(hire_date,6) ä����6���� from employees;

--���� 2 1005 �̹����� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ������ ���
select last_day(sysdate) from dual;

--���� 3 1005 employees ���̺��� ä�뿡�� ä���ϰ� ����������� �ټӿ����� ���
select * from employees;
select hire_date, round(months_between(sysdate, hire_date)) �ټӿ��� from employees;

--���� 4 1005 �Ի��� 6���� �� ù��° �������� last_name���� ���
select last_name, next_day(add_months(hire_date, 6),'������') "6���� �� ù ������" from employees;

--���� 5 1005 job_id���� �����հ� ��տ���, �ְ���, �������� ��� ��, ��� ������ 5000 �̻��� ��츸 �����Ͽ� ������������ ���� --�𼾵�
select * from employees;
select job_id, avg(salary) ��տ���, max(salary) �ְ���, min(salary) ��������
from employees group by job_id 
having avg(salary)>=5000 order by ��տ��� desc;

--���� 6 1005�����ȣ(employee_id)�� 110�� ����� �μ����� ���
select * from employees;
select * from departments;  --�μ���
select d.department_name
from departments d, employees e
where d.department_id=e.department_id and e.employee_id=110;

--���� 7 1005 ����� 120�� ������ ���, �̸�, ����(job_id), ������(job_title)�� ���
select * from employees;
select * from jobs;--Ÿ��Ʋ
select e.employee_id ���, e.first_name ||' '|| e.last_name �̸�, e.job_id ����, j.job_title ������
from employees e, jobs j
where e.job_id=j.job_id and e.employee_id=120;

--���� 8 1005 ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'
SELECT employee_id, last_name, CASE WHEN SALARY > 20000 THEN '��ǥ�̻�'
    WHEN SALARY > 15000 THEN '�̻�'
    WHEN SALARY > 10000 THEN '����'
    WHEN SALARY > 5000 THEN '����'
    WHEN SALARY > 3000  THEN '�븮'
    ELSE '���' END ���� 
FROM employees;


--alter table employees add ���� varchar2(20) default '���' not null;
--update employees set ����= '�븮' where salary > 3000;
--update employees set ����= '����' where salary > 5000;
--update employees set ����= '����' where salary > 10000;
--update employees set ����= '�̻�' where salary > 15000;
--update employees set ����= '��ǥ�̻�' where salary > 20000;
--select employee_id ���, first_name ||' '|| last_name �̸�, ����
--from employees;
--alter table employees drop column ����;
--select * from employees;

--���� 9 1005 employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����Ͽ� ���
create table employee_salary
as select employee_id, salary from employees;
select * from employee_salary;
drop table employee_salary;

--���� 10 1005 employee_salary ���̺� first_name, last_name �÷��� �߰��� �� name���� �����Ͽ� ���
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

select first_name ||' '|| last_name �̸�
from employee_salary;
select * from employee_salary;

--���� 11 1005 employee_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� constraint_name�� ES_PK�� ���� �� ���
 table employee_salary add constraint ES_PK primary key(employee_id);

--���� 12 1005 employee_salary ���̺��� employee_id���� contraint_name�� ������ �� ���� ���� Ȯ��
alter table employee_salary drop primary key;
select * from user_constraints where table_name = 'employee_salary';
