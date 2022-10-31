--DML
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
SELECT DISTINCT publisher FROM book; --unique()

SELECT * FROM book
WHERE price < 10000;

--Q. 가격이 10000원 이상 20000원 이하인 도서 검색

SELECT * FROM book
WHERE price <=20000 and price >=10000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Q. 출판사가 굿 스포츠 혹은 대한미디어인 도서를 검색
SELECT * FROM book
WHERE publisher = '굿스포츠' or publisher = '대한미디어';

SELECT * FROM book
WHERE publisher IN( '굿스포츠', '대한미디어');

--Q. 출판사가 굿 스포츠 혹은 대한미디어가 아닌 도서를 검색
SELECT * FROM book
WHERE publisher NOT IN( '굿스포츠', '대한미디어');

SELECT * FROM book
WHERE bookname LIKE '축구의 역사';

--Q. 도서 이름에 축구가 포함된 출판사검색  (% 그 자리에 무언가 있는 것)
SELECT publisher FROM book
WHERE bookname LIKE '%축구%';

--Q. 도서 이름의 왼쪽 두번 째 위치에 '구'라는 문자열을 갖는 도서검색
SELECT * FROM book
WHERE bookname LIKE '_구%';

--Q. 축구에 관한 도서 중 가격이 20000원 이상인 도서 검색
SELECT * FROM book
WHERE bookname LIKE '%축구%' and price >= 20000;

-- 정렬
SELECT * FROM book
ORDER BY bookname;

--Q 내림차순 정렬
SELECT * FROM book
ORDER BY bookname DESC;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색
SELECT * FROM book
ORDER BY price, bookname;

--Q. 도서를 가격의 내림차순으로 검색하세요. 만약 가격이 같다면 출판사의 오름차순으로 출력
SELECT * FROM book
ORDER BY price DESC, publisher ASC;


SELECT * FROM orders;

SELECT SUM(saleprice) FROM orders;

--Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS "총 판매액" FROM orders
WHERE custid = 2;

--Q. saleprice의 합계(TOTAL), 평균(AVG), 최솟값(MIN), 최댓값(MAX) (띄어쓰기가 없으면 "" 안써줘도 됨)
SELECT SUM(saleprice) AS TOTAL, AVG(saleprice) AS AVG, MIN(saleprice) AS MIN, MAX(saleprice) AS MAX FROM orders;


SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액" FROM orders GROUP BY custid;

SELECT * FROM customer;
--과제1 0930 Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요. 단, 두권 이상 구매한 고객만 구하세요. 

SELECT custid, COUNT(*) AS 도서수량
FROM orders 
WHERE saleprice >=8000
Group By custid
Having count(*) >=2; -- 추가조건 HAVING




SELECT * FROM customer;
SELECT * FROM orders;

SELECT * FROM customer, orders WHERE customer.cusTid=orders.custid;

--Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 출력
SELECT * 
FROM customer, orders 
WHERE customer.custid=orders.custid ORDER BY customer.custid;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬
SELECT customer.name, SUM(orders.saleprice) 
FROM  customer, orders 
WHERE customer.custid = orders.custid 
GROUP BY customer.name 
ORDER BY customer.name;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid = O.custid AND O.bookid=B.bookid;

--Q. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
SELECT customer.name, NVL(orders.saleprice, 0) AS 판매가격   --NVL 널값을 ~로 처리함 
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+); --LEFT JOIN

SELECT * FROM book;
--Q. 가장 비싼 도서의 이름을 출력
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--과제2 0930 도서를 구매한 적이 있는 고객의 이름을 검색
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders); -- IN 안에 리스트

--과제3 0930 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력
SELECT C.name
FROM customer C, book B, orders O
WHERE C.custid=o.custid and o.bookid=b.bookid and b.publisher='대한미디어';

select * from book;
--과제4 0930 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 출력
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) FROM book b2 WHERE b1.publisher = b2.publisher);

--과제5 0930 도서를 주문하지 않은 고객의 이름을 출력
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


--과제6 0930 주문이 있는 고객의 이름과 주소를 출력
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);
--이거랑 위랑 뭐가 다르냐
SELECT C.name, C.address
FROM customer C
WHERE EXISTS (SELECT * FROM orders O WHERE C.custid=O.custid); --exists 한건이라도 존재하면 true djqtdmaus false

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
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE); --지울때 같이 지워짐

DESC neworders;

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK (price>1000));

DESC newbook;

ALTER TABLE newbook ADD isbn VARCHAR2(15);

--과제1 1004 newbook 테이블의 isbn 속성을 삭제하세요.
ALTER TABLE newbook DROP COLUMN isbn;
--과제2 1004 newbook 테이블의 기본키를 삭제한 후 다시 bookid 속성을 기본키로 변경하세요.
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook ADD CONSTRAINT "create pk" PRIMARY KEY(bookid);
--과제3 1004 newbook 테이블을 삭제하세요.
DROP TABLE  newbook;
DESC newbook;

SELECT * FROM customer;
--Q. CUSTOMER 테이블에서 고객번호가 5인 고객의 주소를 "대한민국 부산"으로 변경.
UPDATE customer
SET address = '대한민국 부산'
WHERE custid = 5;

--Q. COSTOMER 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '김연아')
WHERE custid = 5;

--Q. CUSTOMER 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인
DELETE customer
WHERE custid = 5;

select* from customer;