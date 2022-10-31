SELECT ABS(-78), ABS(+78)
FROM dual; --단순계산할때 관례적으로 씀 테이블로 결과 나옴

SELECT ROUND(4.875, 1)
FROM dual;

--Q. 고객이름별 평균 주문 금액을 백원단위로 반올림한 값을 구하세요.
SELECT * FROM orders;

select round(avg(saleprice),-2)
from orders
group by custid;

SELECT C.name ,ROUND(avg(O.saleprice),-2)
FROM orders O,customer C
WHERE C.custid=O.custid
GROUP BY c.name;

--Q 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서목록, 가격을 출력
SELECT * FROM book;
SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price --BOOKNAME을 새로운 칼럼으로 만드네
FROM book;

SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) AS 바이트수
FROM book;

SELECT * FROM customer;
INSERT INTO customer VALUES(5, '박세리', '대한민국 대전', NULL);

--Q. 과제4 1004 CUSTOMER 테이블에서 같은 성을 가진 사람이 몇 몇이나 되는지 성별(성씨) 인원수를 구하세요. p215
SELECT * FROM customer;
SELECT SUBSTR(name, 1, 1) "성", COUNT(*) "인원수" --substr(컬럼, 문자열의 시작위치, 지정 길이)
FROM customer
GROUP BY SUBSTR(name, 1, 1);

SELECT * FROM orders;
--Q. 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
SELECT orderid, orderdate, orderdate + 10 as 확정일자
FROM orders;

--과제5 1004 Q. 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 출력(포멧 '2020-07-07 화요일')
SELECT * FROM orders;
SELECT orderid 주문번호, TO_CHAR(orderdate, 'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호 
FROM orders
WHERE orderdate = '20/07/07';

SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q. 이름, 전화번호가 포함된 고객목록을 보이세요. 단, 전화번호가 없는 고객은 '연락처 없음'으로 표현하여 출력
SELECT name, NVL(phone, '연락처 없음') 전화번호
FROM customer;

--SELECT CIALESCE(NULLM NULL, ' THIRD VALUE', 'FORTH VALUE'); 세번째 값이 NULL이 아닌 첫번째 값이기 때문에 세번째 값을 반환
SELECT name 이름, phone, COALESCE(phone, '연락처 없음') 전화번호
FROM customer;

SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <=3;

--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 출력
SELECT * FROM orders;
SELECT orderid 주문번호, saleprice 금액
FROM orders
WHERE saleprice <(SELECT avg(saleprice) from orders);

--Q. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 출력
SELECT orderid 주문번호, custid 고객번호, saleprice 금액
FROM orders o1
WHERE saleprice >(SELECT avg(saleprice) from orders o2 WHERE O1.custid=o2.custid);

--과제 6 1004 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 출력
select * from orders;
SELECT SUM(saleprice) "총 판매액"
FROM orders
WHERE custid IN (SELECT custid from customer where address like '%대한민국%');

--과제 7 1004 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL ( SELECT saleprice FROM orders WHERE custid=3);

--과제 8 1004 고객번호가 2 이하인 고객의 판매액을 출력. 단, 고객이름과 고객별 판매액 포함
select * from customer;
SELECT c.name 고객이름, SUM(o.saleprice) 판매액
FROM (SELECT custid, name FROM customer WHERE custid<=2) c, orders o
WHERE c.custid=o.custid 
GROUP BY c.name;

--과제 9 1004 lmemvers 데이터를 고객별로 속성(성별,나이,거주지역), 구매합계(반기별), 평균구매(반기별), 구매빈도(반기별) 출력

--1005
select * from customer;
select * from orders;

select c.name, nvl(sum(o.saleprice),0) 고객별판매
from orders o, customer c
where c.custid=o.custid(+)
group by c.name;

--View는 가상의 테이블이라고 하며 데이터는 없고 SQL만 저장되어있는 Object
--View는 기본 테이블이나 뷰를 삭제하게 되면 해당 데이터를 기초로 한 다른 뷰들이 자동을 ㅗ삭제되고 ALTER 명령을 사용할 수 없다.
--내용을 수정하기 위해서는 DROP & CREATE를 반복하여야하며 원본 이름으로 생성할 수 없다. 실무에서는 "vw_"접미사나 접두사를 붙여 사용.
create view vw_customer
as select * 
from customer 
where address like '%대한민국%' ;

select * from vw_customer;

select * from orders;
--Q. Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액 출력
create view vw_ord_kim
as select  c.name 고객이름, o.orderid 주문번호, b.bookname 도서이름, o.saleprice 주문액
from orders o, book b, customer c
where b.bookid=o.bookid and o.custid=c.custid;

select *
from vw_ord_kim
where 고객이름 = '김연아';

drop view vw_ord_kim;

