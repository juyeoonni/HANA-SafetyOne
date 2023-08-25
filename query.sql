DROP SEQUENCE CARD_HIS_ID_SEQ;
DROP TABLE CARDHISTORY;
DROP table CARD;
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
      EMAIL         VARCHAR2(50)    NOT NULL    PRIMARY KEY,    -- �̸���
      NAME          VARCHAR2(50)    NOT NULL,                   -- �̸�
      PASSWORD      VARCHAR2(50)    NOT NULL,                   -- ��й�ȣ
      PHONE         VARCHAR2(50)    NOT NULL,                   -- �޴���ȭ
      GENDER           CHAR(1)         CHECK(GENDER IN ('M','F')),    -- ����
      ADDRESS       VARCHAR2(255),                              -- �ּ�
      IDENTITYNUM   VARCHAR2(20)    NOT NULL,                   -- �ֹι�ȣ
      AGE           NUMBER          NOT NULL,
      REGDATE       DATE            NOT NULL,                   -- ����Ͻ�
      AUTHORITY  CHAR(1)         DEFAULT 'U' CHECK(AUTHORITY IN ('U','M'))  -- ȸ������
 
);



------------------------- ī��

CREATE TABLE CARD (
      CARDID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CARDCVC              CHAR(3)         NOT NULL,           -- CVC��ȣ
      CARDPASSWORD         CHAR(4)         NOT NULL,           -- ��й�ȣ
      CARDREGDATE         DATE            NOT NULL,           -- ī�� �������
      AMOUNTLIMIT          NUMBER(10)      NOT NULL,           -- ī�� �ѵ�
      FDSSERSTATUS        CHAR(1)         DEFAULT 'N' CHECK(FDSSERSTATUS IN ('Y','N')),        -- FDS ���񽺽�û����
      SELFFDSSERSTATUS    CHAR(1)         DEFAULT 'N' CHECK(SELFFDSSERSTATUS IN ('Y','N')),    -- SelfFDS ���� ��û����
      CONSTRAINT MEMBERID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL)
);

--------------------------- �ŷ�����
CREATE SEQUENCE CARD_HIS_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE CARDHISTORY (
      CARDHISID           NUMBER(20)      DEFAULT CARD_HIS_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
      CARDID               VARCHAR2(20)    NOT NULL,               -- ī���ȣ
      CATEGORYBIG              VARCHAR2(50)    NOT NULL,               -- �ŷ������ڵ�
      CATEGORYSMALL              VARCHAR2(50)    NOT NULL,               -- �ŷ������ڵ�
      REGIONNAME           VARCHAR2(50),                           -- ��������ġ�ڵ�
      STORE                 VARCHAR2(255),                          -- ��������
      CARDHISDATE         DATE            NOT NULL,               -- �ŷ��ð�
      CARDHISTIME         VARCHAR(20)     NOT NULL,
      AMOUNT                NUMBER(10,0)    NOT NULL,                             -- �ŷ��ݾ�
      CONSTRAINT CARDID    FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);


------------------------------------------------------
create table t_member (
    no number(5) primary key,
    id varchar2(50) not null,
    password varchar2(50) not null,
    name varchar2(50) not null,
    address varchar2(50) not null
);

create sequence seq_t_member_no nocache;

select * from t_member;
insert into t_member(no,id,password,name,address)
values(seq_t_member_no.nextval,'user2','dddd','�����ż�','�ѱ�');
commit;



------------------------------------------------------
select * from member;
select sum(amount) from cardhistory where cardid='5622-1737-9171-4512' and cardhisdate between to_date('23/05/02') and to_date('23/06/02');
truncate table member;
commit;

SELECT regionName 
FROM REGION
ORDER BY REGION_CODE;

SELECT * FROM REGION;

select * from cardhistory;

select * from member where gender='F' and age=25;
delete from member WHERE EMAIL='pooh5045@gmail.com';
select * from card WHERE EMAIL='pooh5045@gmail.com';
select * from cardhistory where cardid='6155-7952-7748-1647';
update card set EMAIL='pooh5045@gmail.com' where cardid='6155-7952-7748-1647';
commit;
----------------------------------------------
select count(*) from card_history
where card_his_date between to_char('23/03/01') and to_char('23/06/01');
select count(*) from card_history
where card_his_date between to_char('23/06/02') and to_char('23/09/01');
select * from card;
select count(*) from card;
SELECT count(*) FROM MEMBER;
SELECT * FROM CARD_HISTORY;

select category,sum(amount),count(*) from CARD_HISTORY
group by category
order by count(*);

SELECT * FROM cardhistory;
select count(*) from cardhistory;

select * From t_board;

select count(*) from card_history
where card_id='6968-6550-3681-4842' and card_his_date between to_char('23/03/01') and to_char('23/06/01');

SELECT *
FROM card_history
WHERE card_id = '6968-6550-3681-4842'
  AND card_his_date >= SYSDATE - INTERVAL '29' DAY
ORDER BY card_his_date DESC;

SELECT *
FROM card_history
WHERE card_id = '6968-6550-3681-4842'
  AND card_his_date >= ADD_MONTHS(TRUNC(SYSDATE, 'MONTH'),-1)
  AND card_his_date < TRUNC(SYSDATE, 'MONTH')
ORDER BY card_his_date DESC;

select category,count(*) as 
from (
SELECT *
FROM card_history
WHERE card_id = '6968-6550-3681-4842'
  AND card_his_date >= ADD_MONTHS(
                          TRUNC((SELECT MAX(card_his_date) FROM card_history), 'MONTH'),
                          -1)
  AND card_his_date <= TRUNC((SELECT MAX(card_his_date) FROM card_history), 'MONTH')
ORDER BY card_his_date DESC)
group by category
order by count(*) desc;

select * from member where sex='F' and identity_nm like '20%';
select * from member;
select * from card where email='yeonghyiji@dreamwiz.com';
update CATEGORY set CATEGORY_SMALL='�ڵ�������' where CATEGORY_SMALL='����';
commit;

select * from card where email='pooh5045@gmail.com';
delete from card where card_id='3333-3333-3333-3333';


SELECT category, COUNT(*) AS CATEGORY_CNT
FROM card_history
WHERE card_id = '6968-6550-3681-4842'
  AND card_his_date >= (SELECT ADD_MONTHS(TRUNC(MAX(card_his_date), 'MM'), -1) FROM card_history WHERE card_id = '6968-6550-3681-4842')
  AND card_his_date < (SELECT TRUNC(MAX(card_his_date), 'MM') + 1 FROM card_history WHERE card_id = '6968-6550-3681-4842')
GROUP BY category
ORDER BY COUNT(*) DESC;

select * from member where



drop table your_table_name;
drop sequence ex_SEQ;
------------------------�������ܾ���----------------------

CREATE SEQUENCE ex_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE your_table_name (
    CARD_HIS_ID NUMBER(20) PRIMARY KEY,
    id VARCHAR2(255),
    region VARCHAR2(255),
    industry VARCHAR2(255),
    time NUMBER
);

truncate table your_table_name;

-- ������ ����
INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', '����Ư����', NULL, NULL);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', '������', NULL, NULL);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', NULL, '���', NULL);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', NULL, NULL, 3);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', NULL, '�뷡��', 10);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'sim', NULL, '�ͱݼ�', 4);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'kim', '��⵵', NULL, NULL);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'kim', NULL, NULL, 2);

INSERT INTO your_table_name (CARD_HIS_ID, id, region, industry, time)
VALUES (ex_SEQ.nextval, 'kim', '������', '����', NULL);

commit;
select * from your_table_name;

SELECT *
FROM your_table_name
WHERE id='sim' and
    -- ���� 1: ������ ����, �ð� �߿��� ������ �� ���� NULL�̰� ������ �� �÷����� �ش� ���ǿ� �����ϴ� ���
    (region IS NULL AND industry IS NULL AND time = 10)
    OR (region = '����Ư����' AND industry IS NULL AND time IS NULL)
    OR (region IS NULL AND industry = '�뷡��' AND time IS NULL)
    
    -- ���� 2: 3���� �÷� �߿� 1���� NULL�� ���� 2���� �÷��� 2���� ������ ��� �����ؾ� ��µǴ� ���
    OR (region IS NULL AND industry = '�뷡��' AND time = 10)
    OR (region = '����Ư����' AND industry IS NULL AND time = 10)
    OR (region = '����Ư����' AND industry = '�뷡��' AND time IS NULL)
    
    -- ���� 3: 3���� �÷� ��� ������ ���� 3���� �÷��� 3���� ������ ��� �����ؾ� ��µǴ� ���
    OR (region = '����Ư����' AND industry = '�뷡��' AND time = 10);
    
    
<!-- your_mapper.xml -->
--<mapper namespace="your.namespace">
--
--  <select id="selectYourData" parameterType="map" resultMap="yourResultMap">
--    SELECT *
--    FROM your_table_name
--    WHERE id = 'sim'
--    <if test="condition1">
--      AND (
--        (region IS NULL AND industry IS NULL AND time = 10)
--        OR (region = '����Ư����' AND industry IS NULL AND time IS NULL)
--        OR (region IS NULL AND industry = '�뷡��' AND time IS NULL)
--      )
--    </if>
--    <if test="condition2">
--      AND (
--        (region IS NULL AND industry = '�뷡��' AND time = 10)
--        OR (region = '����Ư����' AND industry IS NULL AND time = 10)
--        OR (region = '����Ư����' AND industry = '�뷡��' AND time IS NULL)
--      )
--    </if>
--    <if test="condition3">
--      AND (region = '����Ư����' AND industry = '�뷡��' AND time = 10)
--    </if>
--  </select>
--
--</mapper>
    

------------------------------------------------------------

SELECT TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD'),count(*) AS CNT
FROM CARD_HISTORY
GROUP BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD')
ORDER BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD') DESC;

select * from CARD where EMAIL='pooh5045@gmail.com' ;
select * from card_history WHERE CARD_ID='6968-6550-3681-4842';
UPDATE card SET selffds_ser_status='N' WHERE CARD_ID='6968-6550-3681-4842';
delete from CARD where  EMAIL='pooh5045@gmail.com' and card_id='1111-1111-1111-1111';
commit;
SELECT Region_name, count(*) FROM CARD_HISTORY
group by Region_name;

insert into 

SELECT REGION_NAME, COUNT(*) AS REGION_CNT,SUM(AMOUNT) AS AMOUNT FROM CARD_HISTORY WHERE CARD_ID='6968-6550-3681-4842'
GROUP BY REGION_NAME;

SELECT REGION_NAME, COUNT(*) AS REGION_CNT,SUM(AMOUNT) AS amount_sum FROM CARD_HISTORY WHERE CARD_ID='6968-6550-3681-4842'
        GROUP BY REGION_NAME;

select category_big, count(*) from category
group by category_big;

select * from region;

SELECT category, COUNT(*) AS category_CNT,SUM(AMOUNT) AS AMOUNT FROM CARD_HISTORY WHERE CARD_ID='6968-6550-3681-4842'
GROUP BY category;

UPDATE card_history SET REGION_NAME='��⵵' WHERE CARD_ID='6968-6550-3681-4842' AND CARD_HIS_DATE = TO_DATE('23/03/23');
select * from card_history ;
SELECT * FROM REGION ORDER BY REGION_CODE;
COMMIT;
----------------------

INSERT INTO MEMBER (EMAIL, NAME, PASSWORD, PHONE,SEX,ADDRESS,IDENTITY_NM,REG_DATE)
VALUES ('pooh5045@gmail.com', '�ɹ���', 'test123', '010-5043-7629','F','��⵵ ����� ������','981223-2123122',TO_DATE('2020-08-07', 'YYYY-MM-DD'));
INSERT INTO MEMBER (EMAIL, NAME, PASSWORD, PHONE,SEX,ADDRESS,IDENTITY_NM,REG_DATE)
VALUES ('admin@gmail.com', '������', 'test123', '010-5043-7629','F','��⵵ ����� ������','981223-2123122',TO_DATE('2020-08-07', 'YYYY-MM-DD'));
commit;

---------------------- CODE ENTITY-----------------------
-- TIME

CREATE TABLE TIME (
      TIME_CODE   VARCHAR2(20)      NOT NULL   PRIMARY KEY,  --�ð��ڵ�
      TIME        VARCHAR2(50)      NOT NULL                 --�ð�  
);

INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0102', '0102');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0304', '0304');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0506', '0506');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0708', '0708');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0910', '0910');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1112', '1112');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1314', '1314');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1516', '1516');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1718', '1718');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1920', '1920');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T2122', '2122');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T2324', '2324');
COMMIT;

SELECT CATEGORY_BIG FROM CATEGORY
GROUP BY CATEGORY_BIG;

SELECT * FROM CATEGORY;

-- CATEGORY
CREATE TABLE CATEGORY (
      CATEGORY_CODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- �����ڵ�
      CATEGORY_BIG          VARCHAR2(255)      NOT NULL,                -- ������з� 
      CATEGORY_MIDDLE       VARCHAR2(255)      NOT NULL,                -- �����ߺз� 
      CATEGORY_SMALL        VARCHAR2(255)      NOT NULL                 -- �����Һз� 
);

select * from category;
update category set category_small='����/����' 
where category_small='����/����/��Ÿ����';
UPDATE card SET selffds_ser_status='N' WHERE CARD_ID='6968-6550-3681-4842';
commit;
-- REGION
DROP TABLE REGION;
CREATE TABLE REGION (
      REGIONCODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --�����ڵ�
      REGIONNAME       VARCHAR2(50)      NOT NULL                -- �����̸� 
);

commit;
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('02', '����Ư����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('031', '��⵵');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('032', '��õ������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('033', '������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('041', '��û����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('042', '����������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('043', '��û�ϵ�');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('044', '����Ư����ġ��');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('051', '�λ걤����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('052', '��걤����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('053', '�뱸������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('054', '���ϵ�');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('055', '��󳲵�');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('061', '���󳲵�');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('062', '���ֱ�����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('063', '����ϵ�');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('064', '���ֵ�');
COMMIT;

SELECT COUNT(*) FROM REGION;
