--L MEMBERS
select * 
from purprd left outer join demo on purprd.custno=demo.custno;

select * from purprd;

select custno, round(avg(puramt)) �������
from purprd
group by custno
order by custno;

--Q. lmemverrs purprd ���̺�� ���� �� ���ž�, 2014���ž�, 2015 ���ž��� �ѹ��� ���
select * from purprd;

select sum(puramt) �ѱ��ž�, 
sum(case when purdate < '20150101' then puramt end) "2014 ���ž�", 
sum(case when purdate >= '20150101' then puramt end) "2015 ���ž�"
from purprd;

--Q. lmambers �����Ϳ��� ���� ���űݾ��� �հ踦 ���� cuspur ���̺��� ������ �� demo ���̺�� ����ȣ(custno)�� �������� �����Ͽ� ���
create table cuspur
as select custno, sum(puramt) puramt_sum 
from purprd group by custno;
select * from cuspur;

select demo.*, cuspur.puramt_sum
from cuspur, demo where cuspur.custno=demo.custno
order by demo.custno;

--����1 1006 purprd �����ͷκ��� �Ʒ� ������ �����ϼ���.
--2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ����(��³���:����ȣ,���޻�,sum(���űݾ�)���űݾ�)
select * from purprd;
create table AMT_14
as select custno ����ȣ, asso ���޻�, 
sum(puramt) "14���űݾ�"
from purprd 
where purdate<'20150101' 
group by custno, asso;
select * from amt_14;
--drop table amt_14;

create table AMT_15
as select custno ����ȣ, asso ���޻�, 
sum(puramt) "15���űݾ�"
from purprd 
where purdate>='20150101' 
group by custno, asso;
select * from amt_15;
--drop table amt_15;

--AMT_14�� AMT_15 2�� ���̺��� ����ȣ�� ���޻縦 �������� full outer join �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
create table AMT_YEAR_FOJ
as select amt_14.*, amt_15."15���űݾ�"
from amt_14 full outer join amt_15 on amt_15."����ȣ" = amt_14."����ȣ"
order by amt_14."����ȣ";
select * from amt_year_foj;

--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� Į���� �߰��Ͽ� ���( ��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
alter table amt_year_foj add �������� varchar2(20); 
update amt_year_foj
set ��������=(nvl("15���űݾ�",0)-nvl("14���űݾ�",0)
);
select count(��������)
from amt_year_foj
where ��������=0;

select ����ȣ, ���޻�, ��������, case when nvl("15���űݾ�",0)-nvl("14���űݾ�",0)<0 then '����'
when nvl("15���űݾ�",0)-nvl("14���űݾ�",0)>0 then '����'
else '����' end ��������
from amt_year_foj order by ����ȣ, ���޻�;

