------------------------��
CREATE SEQUENCE MEMBER_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

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



DESC MEMBER;

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
      VALIDDATE           DATE            NOT NULL,
      CARDNAME            VARCHAR2(255)   NOT NULL,
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
      CATEGORYSMALL              VARCHAR2(50)    NOT NULL,   
      REGIONNAME           VARCHAR2(50), 
      STORE                 VARCHAR2(255),                          -- ��������
      CARDHISDATE         DATE            NOT NULL,               -- �ŷ��ð�
      CARDHISTIME         VARCHAR(20)     NOT NULL,
      AMOUNT                NUMBER(10,0)    NOT NULL,                             -- �ŷ��ݾ�
      CONSTRAINT CARDID    FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);



-------------------------����/�н� �Ű���
DROP SEQUENCE LOSTCARD_ID_SEQ;
DROP table LOSTCARD;
CREATE SEQUENCE LOSTCARD_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

create table LOSTCARD(
LOSTCARDIDSEQ          NUMBER(20)      DEFAULT LOSTCARD_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
REGLOSTDATE             DATE DEFAULT SYSDATE,
CARDID               VARCHAR2(20)    NOT NULL,
LOSTDATE               DATE,
LOSTPLACE              VARCHAR2(255)    NOT NULL,
LOSTREASON               VARCHAR2(255)    NOT NULL,
REISSUED               CHAR(1)    CHECK(REISSUED IN ('Y','N')),
CONSTRAINT CON_LOSTCARD_CARDID  FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);



----------------------------------����
-----------------------����ī��info---------------
CREATE TABLE PaymentCardInfo (
      CARDID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CONSTRAINT PAYMENT_MEMBERID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL),
      CONSTRAINT PAYMENT_CARDID FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);


---------------------�����α�-------------------
DROP SEQUENCE PAYMENTLOG_ID_SEQ;

CREATE SEQUENCE PAYMENTLOGIDSEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

DROP TABLE PAYMENTLOG;
CREATE TABLE PAYMENTLOG (
      PAYMENTLOGID            NUMBER(20)       DEFAULT PAYMENTLOGIDSEQ.nextval     NOT NULL    PRIMARY KEY,
      CARDID                   VARCHAR2(20)     NOT NULL,               -- ī���ȣ
      ADDRESS                   VARCHAR2(255)     NOT NULL,               -- �������ּ�
      STORE                     VARCHAR2(255)    NOT NULL,               -- ��������
      PAYMENTDATE              TIMESTAMP        NOT NULL,               -- �����ð�
      categorySmall             VARCHAR2(255)     NOT NULL,               -- �����ڵ�
      AMOUNT                    NUMBER           NOT NULL,               -- �����ݾ�
      paymentApprovalStatus   CHAR(1)          CHECK(paymentApprovalStatus IN ('Y','N')),  --�������� ���ο���
      fdsDetectionStatus       CHAR(1),            --FDS Ž�� ���ο���
      CONSTRAINT PAYMENT_LOG_CARD_ID FOREIGN KEY (CARDID) REFERENCES PaymentCardInfo (CARDID)
);


-------------------------�Ƚɼ���
DROP SEQUENCE SAFETY_ID_SEQ;
DROP table safetycard;
CREATE SEQUENCE SAFETY_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

drop table safetycard;
create table safetycard(
        SAFETYIDSEQ          NUMBER(20)      DEFAULT SAFETY_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
        CARDID               VARCHAR2(20)    NOT NULL,
        SAFETYSTARTDATE        DATE, 
        SAFETYENDDATE         DATE,
        REGIONNAME      VARCHAR2(50),
        CATEGORYSMALL       VARCHAR2(50),
        TIME           VARCHAR2(50),
        STATUS            CHAR(1)         DEFAULT 'Y' CHECK(STATUS IN ('Y','N')),
        STOPSTARTDATE        DATE, 
        STOPENDDATE         DATE,
        CONSTRAINT CON_SAFETY_CARDID  FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);




---------------------------�̻�Һ�˸�����
CREATE TABLE FDS (
    CARDID VARCHAR2(20) PRIMARY KEY REFERENCES CARD(CARDID),
    SERREGDATE DATE,        -- ���� ��û����
    SERENDDATE DATE,        -- ���� ��������
    SERVICESTATUS VARCHAR2(50) NOT NULL, 
    LEARNINGDATE DATE ,         -- �н�����
    WEIGHTSAVEPATH VARCHAR2(255),          -- �̻�Ž������ġ������
    CATEGORYSMALLSTATS VARCHAR2(255),             -- �������
    REGIONSTATS VARCHAR2(255),               -- �������
    TIMESTATS VARCHAR2(255),                 -- �ð����
    AMOUNTSTATS VARCHAR2(255)               -- �������

);



---------------------- CODE ENTITY-----------------------------------------------------------------
---------------- CATEGORY
CREATE TABLE CATEGORY (
      CATEGORYCODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- �����ڵ�
      CATEGORYBIG          VARCHAR2(255)      NOT NULL,                -- ������з� 
      CATEGORYMIDDLE       VARCHAR2(255)      NOT NULL,                -- �����ߺз� 
      CATEGORYSMALL        VARCHAR2(255)      NOT NULL                 -- �����Һз� 
);



---------------- REGION
CREATE TABLE REGION (
      REGIONCODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --�����ڵ�
      REGIONNAME       VARCHAR2(50)      NOT NULL                -- �����̸� 
);



-------------------------�м����̺�-------------------

---------------------------Ŭ������
CREATE TABLE clusterTable (
    email VARCHAR2(50) PRIMARY KEY REFERENCES member(email),
    clusterNum Varchar2(20)
    );

---------------- MVIEW
DROP MATERIALIZED VIEW clusterstatic;
CREATE MATERIALIZED VIEW clusterstatic
BUILD IMMEDIATE
REFRESH ON DEMAND
AS 
SELECT 
    clt.CLUSTERNum as clusterNum,
    ch.categorySmall as categorySmall,
    trunc(SUM(ch.amount) /cc.clusterCount) as amount,
    ROUND(COUNT(*) /cc.clusterCount, 3) as count
FROM cardhistory ch 
JOIN card c ON ch.cardid = c.cardid
JOIN clusterTable clt ON c.email = clt.EMAIL
JOIN (
    SELECT clusterNum, COUNT(*) AS clusterCount
    FROM clusterTable
    GROUP BY clusterNum
) cc ON clt.CLUSTERNum = cc.clusterNum
GROUP BY clt.CLUSTERNum, ch.categorySmall, cc.clusterCount
ORDER BY clt.CLUSTERNum, count;



---------------- CATEGORYembedding
CREATE TABLE CATEGORYembedding (
      CATEGORYCODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- �����ڵ�
      CATEGORYSMALL        VARCHAR2(255)      NOT NULL,              -- �����Һз� 
      barToEmbedding       number,
      diamondToEmbedding   number
);

----------------- REGIONembedding
CREATE TABLE REGIONembedding (
      REGIONCODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --�����ڵ�
      REGIONNAME       VARCHAR2(50)      NOT NULL,
      seoultToRegionTime number(10),
      seoultToRegionDistance number(10)
);


INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('02', '����Ư����');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('031', '��⵵');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('032', '��õ������');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('033', '������');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('041', '��û����');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('042', '����������');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('043', '��û�ϵ�');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('044', '����Ư����ġ��');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('051', '�λ걤����');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('052', '��걤����');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('053', '�뱸������');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('054', '���ϵ�');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('055', '��󳲵�');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('061', '���󳲵�');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('062', '���ֱ�����');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('063', '����ϵ�');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('064', '���ֵ�');
COMMIT;


