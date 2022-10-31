SELECT ABS(-78), ABS(+78)
FROM dual; --�ܼ�����Ҷ� ���������� �� ���̺�� ��� ����

SELECT ROUND(4.875, 1)
FROM dual;

--Q. ���̸��� ��� �ֹ� �ݾ��� ��������� �ݿø��� ���� ���ϼ���.
SELECT * FROM orders;

select round(avg(saleprice),-2)
from orders
group by custid;

SELECT C.name ,ROUND(avg(O.saleprice),-2)
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.name;

--Q ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ���
SELECT * FROM book;
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price --BOOKNAME�� ���ο� Į������ �����
FROM book;

SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) AS ����Ʈ��
FROM book;

SELECT * FROM customer;
INSERT INTO customer VALUES(5, '�ڼ���', '���ѹα� ����', NULL);

--Q. ����4 1004 CUSTOMER ���̺��� ���� ���� ���� ����� �� ���̳� �Ǵ��� ����(����) �ο����� ���ϼ���. p215
SELECT * FROM customer;
SELECT SUBSTR(name, 1, 1) "��", COUNT(*) "�ο���" --substr(�÷�, ���ڿ��� ������ġ, ���� ����)
FROM customer
GROUP BY SUBSTR(name, 1, 1);

SELECT * FROM orders;
--Q. �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
SELECT orderid, orderdate, orderdate + 10 as Ȯ������
FROM orders;

--����5 1004 Q. 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���(���� '2020-07-07 ȭ����')
SELECT * FROM orders;
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ 
FROM orders
WHERE orderdate = '20/07/07';

SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̼���. ��, ��ȭ��ȣ�� ���� ���� '����ó ����'���� ǥ���Ͽ� ���
SELECT name, NVL(phone, '����ó ����') ��ȭ��ȣ
FROM customer;

--SELECT CIALESCE(NULLM NULL, ' THIRD VALUE', 'FORTH VALUE'); ����° ���� NULL�� �ƴ� ù��° ���̱� ������ ����° ���� ��ȯ
SELECT name �̸�, phone, COALESCE(phone, '����ó ����') ��ȭ��ȣ
FROM customer;

SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <=3;

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���
SELECT * FROM orders;
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice <(SELECT avg(saleprice) from orders);

--Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders o1
WHERE saleprice >(SELECT avg(saleprice) from orders o2 WHERE O1.custid=o2.custid);

--���� 6 1004 ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���
select * from orders;
SELECT SUM(saleprice) "�� �Ǹž�"
FROM orders
WHERE custid IN (SELECT custid from customer where address like '%���ѹα�%');

--���� 7 1004 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL ( SELECT saleprice FROM orders WHERE custid=3);

--���� 8 1004 ����ȣ�� 2 ������ ���� �Ǹž��� ���. ��, ���̸��� ���� �Ǹž� ����
select * from customer;
SELECT c.name ���̸�, SUM(o.saleprice) �Ǹž�
FROM (SELECT custid, name FROM customer WHERE custid<=2) c, orders o
WHERE c.custid=o.custid 
GROUP BY c.name;

--���� 9 1004 lmemvers �����͸� ������ �Ӽ�(����,����,��������), �����հ�(�ݱ⺰), ��ձ���(�ݱ⺰), ���ź�(�ݱ⺰) ���

--1005
select * from customer;
select * from orders;

select c.name, nvl(sum(o.saleprice),0) �����Ǹ�
from orders o, customer c
where c.custid=o.custid(+)
group by c.name;

--View�� ������ ���̺��̶�� �ϸ� �����ʹ� ���� SQL�� ����Ǿ��ִ� Object
--View�� �⺻ ���̺��̳� �並 �����ϰ� �Ǹ� �ش� �����͸� ���ʷ� �� �ٸ� ����� �ڵ��� �ǻ����ǰ� ALTER ����� ����� �� ����.
--������ �����ϱ� ���ؼ��� DROP & CREATE�� �ݺ��Ͽ����ϸ� ���� �̸����� ������ �� ����. �ǹ������� "vw_"���̻糪 ���λ縦 �ٿ� ���.
create view vw_customer
as select * 
from customer 
where address like '%���ѹα�%' ;

select * from vw_customer;

select * from orders;
--Q. Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ �� �迬�� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ��� ���
create view vw_ord_kim
as select  c.name ���̸�, o.orderid �ֹ���ȣ, b.bookname �����̸�, o.saleprice �ֹ���
from orders o, book b, customer c
where b.bookid=o.bookid and o.custid=c.custid;

select *
from vw_ord_kim
where ���̸� = '�迬��';

drop view vw_ord_kim;

