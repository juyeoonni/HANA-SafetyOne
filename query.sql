DROP SEQUENCE CARD_HIS_ID_SEQ;
DROP TABLE CARD_HISTORY;
DROP table CARD;
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
      EMAIL         VARCHAR2(50)    NOT NULL    PRIMARY KEY,    -- �̸���
      NAME          VARCHAR2(50)    NOT NULL,                   -- �̸�
      PASSWORD      VARCHAR2(50)    NOT NULL,                   -- ��й�ȣ
      PHONE         VARCHAR2(50)    NOT NULL,                   -- �޴���ȭ
      SEX           CHAR(1)         CHECK(SEX IN ('M','F')),    -- ����
      ADDRESS       VARCHAR2(255),                              -- �ּ�
      IDENTITY_NM   VARCHAR2(20)    NOT NULL,                   -- �ֹι�ȣ
      REG_DATE      DATE            NOT NULL,                   -- ����Ͻ�
      MEMBER_STATUS CHAR(1)         DEFAULT 'Y' CHECK(MEMBER_STATUS IN ('Y','N'))  -- ȸ������
 
);

------------------------- ī��

CREATE TABLE CARD (
      CARD_ID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CARD_CVC              CHAR(3)         NOT NULL,           -- CVC��ȣ
      CARD_PASSWORD         CHAR(4)         NOT NULL,           -- ��й�ȣ
      CARD_REG_DATE         DATE            NOT NULL,           -- ī�� �������
      AMOUNT_LIMIT          NUMBER(10)      NOT NULL,           -- ī�� �ѵ�
      FDS_SER_STATUS        CHAR(1)         DEFAULT 'N' CHECK(FDS_SER_STATUS IN ('Y','N')),        -- FDS ���񽺽�û����
      SELFFDS_SER_STATUS    CHAR(1)         DEFAULT 'N' CHECK(SELFFDS_SER_STATUS IN ('Y','N')),    -- SelfFDS ���� ��û����
      CONSTRAINT MEMBER_ID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL)
);




--------------------------- �ŷ�����
CREATE SEQUENCE CARD_HIS_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE CARD_HISTORY (
      CARD_HIS_ID           NUMBER(20)      DEFAULT CARD_HIS_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
      CARD_ID               VARCHAR2(20)    NOT NULL,               -- ī���ȣ
      CATEGORY              VARCHAR2(20)    NOT NULL,               -- �ŷ������ڵ�
      REGION_NAME           VARCHAR2(50),                           -- ��������ġ�ڵ�
      STORE                 VARCHAR2(255),                          -- ��������
      CARD_HIS_DATE         DATE            NOT NULL,               -- �ŷ��ð�
      CARD_HIS_TIME         VARCHAR(20)     NOT NULL,
      AMOUNT                NUMBER(10,0)    NOT NULL,                             -- �ŷ��ݾ�
      CONSTRAINT CARD_ID    FOREIGN KEY (CARD_ID) REFERENCES CARD (CARD_ID)
);



select count(*) from card;
SELECT count(*) FROM MEMBER;
SELECT count(*) FROM CARD_HISTORY;


SELECT TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD'),count(*) AS CNT
FROM CARD_HISTORY
GROUP BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD')
ORDER BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD') DESC;



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



-- CATEGORY
CREATE TABLE CATEGORY (
      CATEGORY_CODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- �����ڵ�
      CATEGORY_BIG          VARCHAR2(255)      NOT NULL,                -- ������з� 
      CATEGORY_MIDDLE       VARCHAR2(255)      NOT NULL,                -- �����ߺз� 
      CATEGORY_SMALL        VARCHAR2(255)      NOT NULL                 -- �����Һз� 
);


-- REGION
CREATE TABLE REGION (
      REGION_CODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --�����ڵ�
      REGION_NAME       VARCHAR2(50)      NOT NULL                -- �����̸� 
);


INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('02', '����Ư����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('031', '��⵵');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('032', '��õ������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('033', '������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('041', '��û����');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('042', '����������');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('043', '��û�ϵ�');
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

