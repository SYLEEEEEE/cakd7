--DML
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
SELECT DISTINCT publisher FROM book; --unique()

SELECT * FROM book
WHERE price < 10000;

--Q. ������ 10000�� �̻� 20000�� ������ ���� �˻�

SELECT * FROM book
WHERE price <=20000 and price >=10000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Q. ���ǻ簡 �� ������ Ȥ�� ���ѹ̵���� ������ �˻�
SELECT * FROM book
WHERE publisher = '�½�����' or publisher = '���ѹ̵��';

SELECT * FROM book
WHERE publisher IN( '�½�����', '���ѹ̵��');

--Q. ���ǻ簡 �� ������ Ȥ�� ���ѹ̵� �ƴ� ������ �˻�
SELECT * FROM book
WHERE publisher NOT IN( '�½�����', '���ѹ̵��');

SELECT * FROM book
WHERE bookname LIKE '�౸�� ����';

--Q. ���� �̸��� �౸�� ���Ե� ���ǻ�˻�  (% �� �ڸ��� ���� �ִ� ��)
SELECT publisher FROM book
WHERE bookname LIKE '%�౸%';

--Q. ���� �̸��� ���� �ι� ° ��ġ�� '��'��� ���ڿ��� ���� �����˻�
SELECT * FROM book
WHERE bookname LIKE '_��%';

--Q. �౸�� ���� ���� �� ������ 20000�� �̻��� ���� �˻�
SELECT * FROM book
WHERE bookname LIKE '%�౸%' and price >= 20000;

-- ����
SELECT * FROM book
ORDER BY bookname;

--Q �������� ����
SELECT * FROM book
ORDER BY bookname DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻�
SELECT * FROM book
ORDER BY price, bookname;

--Q. ������ ������ ������������ �˻��ϼ���. ���� ������ ���ٸ� ���ǻ��� ������������ ���
SELECT * FROM book
ORDER BY price DESC, publisher ASC;


SELECT * FROM orders;

SELECT SUM(saleprice) FROM orders;

--Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) AS "�� �Ǹž�" FROM orders
WHERE custid = 2;

--Q. saleprice�� �հ�(TOTAL), ���(AVG), �ּڰ�(MIN), �ִ�(MAX) (���Ⱑ ������ "" �Ƚ��൵ ��)
SELECT SUM(saleprice) AS TOTAL, AVG(saleprice) AS AVG, MIN(saleprice) AS MIN, MAX(saleprice) AS MAX FROM orders;


SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�" FROM orders GROUP BY custid;

SELECT * FROM customer;
--����1 0930 Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ���. ��, �α� �̻� ������ ���� ���ϼ���. 

SELECT custid, COUNT(*) AS ��������
FROM orders 
WHERE saleprice >=8000
Group By custid
Having count(*) >=2; -- �߰����� HAVING




SELECT * FROM customer;
SELECT * FROM orders;

SELECT * FROM customer, orders WHERE customer.cusTid=orders.custid;

--Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���
SELECT * 
FROM customer, orders 
WHERE customer.custid=orders.custid ORDER BY customer.custid;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ ����
SELECT customer.name, SUM(orders.saleprice) 
FROM  customer, orders 
WHERE customer.custid = orders.custid 
GROUP BY customer.name 
ORDER BY customer.name;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid = O.custid AND O.bookid=B.bookid;

--Q. ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
SELECT customer.name, NVL(orders.saleprice, 0) AS �ǸŰ���   --NVL �ΰ��� ~�� ó���� 
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+); --LEFT JOIN

SELECT * FROM book;
--Q. ���� ��� ������ �̸��� ���
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--����2 0930 ������ ������ ���� �ִ� ���� �̸��� �˻�
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders); -- IN �ȿ� ����Ʈ

--����3 0930 ���ѹ̵��� ������ ������ ������ ���� �̸��� ���
SELECT C.name
FROM customer C, book B, orders O
WHERE C.custid=o.custid and o.bookid=b.bookid and b.publisher='���ѹ̵��';

select * from book;
--����4 0930 ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) FROM book b2 WHERE b1.publisher = b2.publisher);

--����5 0930 ������ �ֹ����� ���� ���� �̸��� ���
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

select c.name, o.orderid from customer c, orders o where c.custid = o.custid(+) and o.custid is null;

select name
from customer
minus
select name
from customer
where custid in (select custid from orders);


--����6 0930 �ֹ��� �ִ� ���� �̸��� �ּҸ� ���
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);
--�̰Ŷ� ���� ���� �ٸ���
SELECT C.name, C.address
FROM customer C
WHERE EXISTS (SELECT * FROM orders O WHERE C.custid=O.custid); --exists �Ѱ��̶� �����ϸ� true djqtdmaus false

--DDL
CREATE TABLE newbook(
bookid      NUMBER,
bookname    VARCHAR2(20) NOT NULL,
publisher   VARCHAR2(20) UNIQUE,
price       NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));

DESC NEWBOOK;

DROP TABLE NEWBOOK;

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

SELECT * FROM newcustomer;

DESC newcustomer;

CREATE TABLE neworders(
orderid NUMBER PRIMARY KEY,
custid NUMBER,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orederdate DATE,
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE); --���ﶧ ���� ������

DESC neworders;

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK (price>1000));

DESC newbook;

ALTER TABLE newbook ADD isbn VARCHAR2(15);

--����1 1004 newbook ���̺��� isbn �Ӽ��� �����ϼ���.
ALTER TABLE newbook DROP COLUMN isbn;
--����2 1004 newbook ���̺��� �⺻Ű�� ������ �� �ٽ� bookid �Ӽ��� �⺻Ű�� �����ϼ���.
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook ADD CONSTRAINT "create pk" PRIMARY KEY(bookid);
--����3 1004 newbook ���̺��� �����ϼ���.
DROP TABLE  newbook;
DESC newbook;

SELECT * FROM customer;
--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� �ּҸ� "���ѹα� �λ�"���� ����.
UPDATE customer
SET address = '���ѹα� �λ�'
WHERE custid = 5;

--Q. COSTOMER ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� ����
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '�迬��')
WHERE custid = 5;

--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ��
DELETE customer
WHERE custid = 5;

select* from customer;