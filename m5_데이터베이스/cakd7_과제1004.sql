--���� 9 1004 lmemvers �����͸� ������ �Ӽ�(����,����,��������), �����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰) ���

select * from demo;
select * from purprd;
select * from channel;


SELECT d.custno ����ȣ, d.age ����, d.gender ����, d.area ��������,
round(sum(case when p.purdate between '20150701' and '20151231' then p.puramt end)) "�����հ�(2015�ı�)",
round(count(case when p.purdate between '20150701' and '20151231' then p.custno end)) "���ź�(2015�ı�)",
round(avg(case when p.purdate between '20150701' and '20151231' then p.puramt end)) "�������(2015�ı�)",

round(sum(case when p.purdate between '20150101' and '20150630' then p.puramt end)) "�����հ�(2015����)",
round(count(case when p.purdate between '20150101' and '20150630' then p.custno end)) "���ź�(2015����)",
round(avg(case when p.purdate between '20150101' and '20150630' then p.puramt end)) "�������(2015����)",

round(sum(case when p.purdate between '20140701' and '20141231' then p.puramt end)) "�����հ�(2014�ı�)",
round(count(case when p.purdate between '20140701' and '20141231' then p.custno end)) "���ź�(2014�ı�)",
round(avg(case when p.purdate between '20140701' and '20141231' then p.puramt end)) "�������(2014�ı�)",

sum(case when p.purdate between '20140101' and '20140630' then p.puramt end) "�����հ�(2014����)",
count(case when p.purdate between '20140101' and '20140630' then p.custno end) "���ź�(2014����)",
avg(case when p.purdate between '20140101' and '20140630' then p.puramt end) "�������(2014����)"

from purprd p, demo d
where d.custno=p.custno
group by d.custno, d.age, d.gender, d.area order by d.custno;