select * from employees;
select * from jobs;
select * from departments;

select job_id, department_id, trunc((sysdate-hire_date)/365, 0) �ټӿ���, salary, 
case when salary > 20000 then '��ǥ�̻�'
when salary > 15000 then '�̻�'
when salary > 10000 then '����' 
when salary > 5000 then '����' 
when salary > 3000 then '�븮'
else '���' end ����
from employees order by salary desc;

--����������ӱ�, ���ʽ� �޴� ���� ��, �μ� �ο���, �ټӳ��, �Ի�⵵ �ο� �� >�پ��� �۾����� ȸ��?
select round(count(commission_pct)/count(employee_id),2) ���ʽ��޴º���, round(avg(commission_pct),2) ���ʽ����
from employees;

select department_id, count(employee_id) from employees group by department_id order by department_id;

--Q. HR employees ���̺��� �̸�, ����, 10% �λ�� ������ ���
select first_name ||' '|| last_name �̸�, salary ����, salary *1.1 "10%�λ󿬺�"
from employees;

--Q. HR employees ���̺��� commission_pct�� null�� ������ ���
select count(*) from employees where commission_pct is null ;

--����2 1006 hr ���̺���� �м��ؼ� ��ü ��ȭ�� ������ �� �ִ� ��� ���̺��� 2�� �̻� �ۼ��ϼ���.(��: �μ��� ��� salary ����)
--�Ի� ��, �⵵�� �Ի� ��, ���ʽ��޴� ����, ���ʽ� ���
select * from employees;
select * from jobs;
select * from departments;
select e.department_id, round(avg(e.salary)) "�μ��� ��տ���"
from employees e group by e.department_id
order by "�μ��� ��տ���" desc;

select hire_date, count(employee_id)
from employees order
where 

--DCL
--user ����, ����
create user c##user01
identified by userpass;

select * from all_users;
drop user c##user01;

--grant, revoke ���� �ְ���
create user c##user01
identified by userpass;
grant create session, create table to c##user01;
revoke create session, create table from c##user01;

--����� ��ȣ ����
alter user c##user01
identified by passuser;

--����
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
rollback; --���� Ŀ������ ���ư�

commit; -- ���� ����

show autocommit;
set autocommit on;
set autocommit off;