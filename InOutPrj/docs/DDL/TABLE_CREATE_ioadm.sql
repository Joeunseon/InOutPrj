/**
* 형식
* TABLE 
* COMMENT 
* SEQUENCE
* 
* TB_MENU           메뉴
* CD_MST            공통코드_마스터
* CD_DTL            공통코드_상세
* TB_USER           사용자
* TB_ASSET          자산
* TB_ASSET_OP       자산옵션
* TB_INTYPE         수입유형
* TB_INCOMINGS      수입
* TB_INREPEAT       수입반복
* TB_OUTTYPE        지출유형
* TB_OUTGOINGS      지출
* TB_OUTREPEAT      지출반복
* TB_TRANSFER       이체
* TB_TRREPEAT       이체반복
* TB_REPORT         보고서
* TB_CHART          차트
*/

-- 메뉴
CREATE TABLE TB_MENU 
( MENU_ID VARCHAR(20) 
, PARENT_ID VARCHAR(20) 
, MENU_NM VARCHAR(50) NOT NULL 
, MENU_DESC VARCHAR(300)
, METHOD_NM VARCHAR(10) NOT NULL 
, URI VARCHAR(100) 
, DISP_NO NUMBER(3) NOT NULL 
, MENU_LEVEL NUMBER(3) NOT NULL
, ICON VARCHAR(50)
, AJAX_YN CHAR(1) DEFAULT 'N' 
, DISP_YN CHAR(1) DEFAULT 'N'
, USE_YN CHAR(1) DEFAULT 'Y'
, DEL_YN CHAR(1) DEFAULT 'N'
, CONSTRAINT MENU_MENUID_PK PRIMARY KEY (MENU_ID)
);
-- Table TB_MENU이(가) 생성되었습니다.

COMMENT ON TABLE TB_MENU IS '메뉴';
COMMENT ON COLUMN TB_MENU.MENU_ID IS '메뉴ID';
COMMENT ON COLUMN TB_MENU.PARENT_ID IS '상위메뉴ID';
COMMENT ON COLUMN TB_MENU.MENU_NM IS '메뉴/서비스이름';
COMMENT ON COLUMN TB_MENU.MENU_DESC IS '메뉴/서비스설명';
COMMENT ON COLUMN TB_MENU.METHOD_NM IS 'METHOD';
COMMENT ON COLUMN TB_MENU.URI IS 'URI';
COMMENT ON COLUMN TB_MENU.DISP_NO IS '표시순서';
COMMENT ON COLUMN TB_MENU.MENU_LEVEL IS '레벨';
COMMENT ON COLUMN TB_MENU.AJAX_YN IS 'AJAX여부';
COMMENT ON COLUMN TB_MENU.DISP_YN IS '표시여부';
COMMENT ON COLUMN TB_MENU.USE_YN IS '사용여부';
COMMENT ON COLUMN TB_MENU.DEL_YN IS '삭제여부';
-- Comment이(가) 생성되었습니다.
 

-- 공통코드_마스터
CREATE TABLE CD_MST 
( MST_CD VARCHAR(4) NOT NULL 
, MST_NM VARCHAR(200) NOT NULL 
, USE_YN VARCHAR(1) DEFAULT 'Y' 
, SORT_NO number(4) NULL
, DETAIL VARCHAR(1000) NOT NULL 
, CONSTRAINT CDMST_MSTCD_PK PRIMARY KEY(MST_CD)
);
-- Table CD_MST이(가) 생성되었습니다.
 
COMMENT ON TABLE CD_MST IS '공통코드_마스터';
COMMENT ON COLUMN CD_MST.MST_CD IS '공통코드마스터_코드';
COMMENT ON COLUMN CD_MST.MST_NM IS '공통코드마스터이름';
COMMENT ON COLUMN CD_MST.USE_YN IS '사용여부';
COMMENT ON COLUMN CD_MST.SORT_NO IS '정렬순서';
COMMENT ON COLUMN CD_MST.DETAIL IS '상세';
-- Comment이(가) 생성되었습니다.


-- 공통코드_상세
CREATE TABLE CD_DTL
( DTL_CD VARCHAR(8)
, MST_CD VARCHAR(4) NOT NULL
, DTL_NM VARCHAR(200) NOT NULL 
, USE_YN VARCHAR(1) DEFAULT 'Y' 
, SORT_NO NUMBER(4) NULL
, DETAIL VARCHAR(1000) NOT NULL 
, CONSTRAINT CDDTL_DTLCD_PK PRIMARY KEY(DTL_CD)
, CONSTRAINT CDDTL_MSTCD_FK FOREIGN KEY(MST_CD) REFERENCES CD_MST(MST_CD)
);
-- Table CD_DTL이(가) 생성되었습니다.
ALTER TABLE CD_DTL MODIFY USE_YN DEFAULT 'Y';

COMMENT ON TABLE CD_DTL IS '공통코드_상세';
COMMENT ON COLUMN CD_DTL.DTL_CD IS '공통코드상세_코드';
COMMENT ON COLUMN CD_DTL.MST_CD IS '공통코드마스터_코드';
COMMENT ON COLUMN CD_DTL.DTL_NM IS '공통코드이름';
COMMENT ON COLUMN CD_DTL.USE_YN IS '사용여부';
COMMENT ON COLUMN CD_DTL.SORT_NO IS '정렬순서';
COMMENT ON COLUMN CD_DTL.DETAIL IS '상세';
-- Comment이(가) 생성되었습니다.


-- 사용자
CREATE TABLE TB_USER
( USER_SEQ     NUMBER(8)
, USER_ID      VARCHAR(150) NOT NULL
, USER_NM      VARCHAR(150) NOT NULL
, USER_PWD     VARCHAR(150) NOT NULL
, TYPE_CD      VARCHAR(8) NOT NULL
, CATEATE_TIME DATE         DEFAULT SYSDATE 
, QUIT_YN      CHAR(1) DEFAULT 'N' 
, QUIT_TIME    DATE
, UPDATE_TIME  DATE DEFAULT SYSDATE

, CONSTRAINT USER_USERSEQ_PK PRIMARY KEY(USER_SEQ)
);
-- Table TB_USER이(가) 생성되었습니다. 

COMMENT ON TABLE TB_USER IS '사용자';
COMMENT ON COLUMN TB_USER.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_USER.USER_ID IS '사용자ID';
COMMENT ON COLUMN TB_USER.USER_NM IS '사용자이름';
COMMENT ON COLUMN TB_USER.USER_PWD IS '사용자비밀번호';
COMMENT ON COLUMN TB_USER.CATEATE_TIME IS '등록일시';
COMMENT ON COLUMN TB_USER.QUIT_YN IS '탈퇴여부';
COMMENT ON COLUMN TB_USER.QUIT_TIME IS '탈퇴일시';
COMMENT ON COLUMN TB_USER.UPDATE_TIME IS '갱신일시';
COMMENT ON COLUMN TB_USER.TYPE_CD IS '사용자유형(로그인)';
-- Comment이(가) 생성되었습니다.


-- 자산
CREATE TABLE TB_ASSET 
( ASSET_SEQ NUMBER(5)
, USER_SEQ NUMBER(8) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL 
, ASSET_NM VARCHAR(50) NOT NULL 
, AMOUNT NUMBER(15) DEFAULT 0 
, MEMO VARCHAR(300) 
, TOTAL_YN CHAR(1) DEFAULT 'Y'
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT ASSET_ASSETSEQ_PK PRIMARY KEY(ASSET_SEQ)
, CONSTRAINT ASSET_USERSEQ_FK FOREIGN KEY(USER_SEQ) REFERENCES TB_USER(USER_SEQ)
);
-- Table TB_ASSET이(가) 생성되었습니다.

COMMENT ON TABLE TB_ASSET IS '자산';
COMMENT ON COLUMN TB_ASSET.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_ASSET.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_ASSET.TYPE_CD IS '자산유형';
COMMENT ON COLUMN TB_ASSET.ASSET_NM IS '자산이름';
COMMENT ON COLUMN TB_ASSET.AMOUNT IS '금액';
COMMENT ON COLUMN TB_ASSET.MEMO IS '메모';
COMMENT ON COLUMN TB_ASSET.TOTAL_YN IS '총액반영여부';
COMMENT ON COLUMN TB_ASSET.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_ASSET.UPDATE_TIME IS '갱신일자';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_ASSET
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_ASSET이(가) 생성되었습니다.


-- 자산옵션
CREATE TABLE TB_ASSET_OP
( OPT_SEQ NUMBER(5)
, ASSET_SEQ NUMBER(5) NOT NULL 
, PAY_ASSET_SEQ NUMBER(5) NOT NULL
, SETTLEMENT_DATE NUMBER(2) DEFAULT 1
, PAYMENT_DATE NUMBER(2) DEFAULT 1
, CONSTRAINT ASSETOP_OPTSEQ_PK PRIMARY KEY (OPT_SEQ)
, CONSTRAINT ASSETOP_ASSETSEQ_FK FOREIGN KEY (ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
);
-- Table TB_ASSET_OP이(가) 생성되었습니다.

COMMENT ON TABLE TB_ASSET_OP IS '자산옵션';
COMMENT ON COLUMN TB_ASSET_OP.OPT_SEQ IS '자산옵션SEQ';
COMMENT ON COLUMN TB_ASSET_OP.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_ASSET_OP.PAY_ASSET_SEQ IS '결제은행SEQ';
COMMENT ON COLUMN TB_ASSET_OP.SETTLEMENT_DATE IS '정산일';
COMMENT ON COLUMN TB_ASSET_OP.PAYMENT_DATE IS '반영일';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_ASSET_OP
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_ASSET_OP이(가) 생성되었습니다.


-- 수입유형
CREATE TABLE TB_INTYPE
( INTYPE_SEQ NUMBER(5)
, USER_SEQ NUMBER(8) NOT NULL 
, INTYPE_NM VARCHAR(50) NOT NULL 
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE 
, CONSTRAINT INTYPE_INTYPESEQ_PK PRIMARY KEY(INTYPE_SEQ)
, CONSTRAINT INTYPE_USERSEQ_FK FOREIGN KEY(USER_SEQ) REFERENCES TB_USER(USER_SEQ)
);
-- Table TB_INTYPE이(가) 생성되었습니다.

COMMENT ON TABLE TB_INTYPE IS '수입유형';
COMMENT ON COLUMN TB_INTYPE.INTYPE_SEQ IS '수입유형SEQ';
COMMENT ON COLUMN TB_INTYPE.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_INTYPE.INTYPE_NM IS '수입유형이름';
COMMENT ON COLUMN TB_INTYPE.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_INTYPE.UPDATE_TIME IS '갱신일자';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_INTYPE 
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_INTYPE이(가) 생성되었습니다.


-- 수입
CREATE TABLE TB_INCOMINGS
( IN_SEQ NUMBER(10)
, USER_SEQ NUMBER(8) NOT NULL 
, INTYPE_SEQ NUMBER(5) NOT NULL 
, ASSET_SEQ NUMBER(5) NOT NULL
, AMOUNT NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300) 
, IN_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT INCOMINGS_INSEQ_PK PRIMARY KEY (IN_SEQ)
, CONSTRAINT INCOMINGS_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT INCOMINGS_INTYPESEQ_FK FOREIGN KEY (INTYPE_SEQ) REFERENCES TB_INTYPE(INTYPE_SEQ)
, CONSTRAINT INCOMINGS_ASSETSEQ_FK FOREIGN KEY (ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
);
-- Table TB_INCOMINGS이(가) 생성되었습니다.

COMMENT ON TABLE TB_INCOMINGS IS '수입';
COMMENT ON COLUMN TB_INCOMINGS.IN_SEQ IS '수입SEQ';
COMMENT ON COLUMN TB_INCOMINGS.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_INCOMINGS.INTYPE_SEQ IS '수입유형SEQ';
COMMENT ON COLUMN TB_INCOMINGS.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_INCOMINGS.AMOUNT IS '금액';
COMMENT ON COLUMN TB_INCOMINGS.DETAIL IS '상세';
COMMENT ON COLUMN TB_INCOMINGS.IN_TIME IS '수입일자';
COMMENT ON COLUMN TB_INCOMINGS.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_INCOMINGS.UPDATE_TIME IS '갱신일자';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_INCOMINGS
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 9999999999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_INCOMINGS이(가) 생성되었습니다.


-- 수입반복
CREATE TABLE TB_INREPEAT
( INREPEAT_SEQ NUMBER(5) 
, USER_SEQ NUMBER(8) NOT NULL
, ASSET_SEQ NUMBER(5) NOT NULL
, INTYPE_SEQ NUMBER(5) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL 
, REPEAT_NM VARCHAR(30) NOT NULL
, AMOUNT NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300)
, LASTDATE_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT INREPEAT_INREPEATSEQ_PK PRIMARY KEY (INREPEAT_SEQ)
, CONSTRAINT INREPEAT_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT INREPEAT_INTYPESEQ_FK FOREIGN KEY (INTYPE_SEQ) REFERENCES TB_INTYPE(INTYPE_SEQ)
, CONSTRAINT INREPEAT_ASSETSEQ_FK FOREIGN KEY (ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
);
-- Table TB_INREPEAT이(가) 생성되었습니다.

COMMENT ON TABLE TB_INREPEAT IS '수입반복';
COMMENT ON COLUMN TB_INREPEAT.INREPEAT_SEQ IS '수입반복SEQ';
COMMENT ON COLUMN TB_INREPEAT.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_INREPEAT.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_INREPEAT.INTYPE_SEQ IS '수입유형SEQ';
COMMENT ON COLUMN TB_INREPEAT.TYPE_CD IS '반복유형';
COMMENT ON COLUMN TB_INREPEAT.REPEAT_NM IS '반복명';
COMMENT ON COLUMN TB_INREPEAT.AMOUNT IS '금액';
COMMENT ON COLUMN TB_INREPEAT.DETAIL IS '상세';
COMMENT ON COLUMN TB_INREPEAT.LASTDATE_TIME IS '마지막반영일';
COMMENT ON COLUMN TB_INREPEAT.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_INREPEAT.UPDATE_TIME IS '갱신일자';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_INREPEAT
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;


-- 지출유형
CREATE TABLE TB_OUTTYPE
( OUTTYPE_SEQ NUMBER(5) 
, USER_SEQ NUMBER(8) NOT NULL
, OUTTYPE_NM VARCHAR(30) NOT NULL
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT OUTTYPE_OUTTYPESEQ_PK PRIMARY KEY (OUTTYPE_SEQ)
, CONSTRAINT OUTTYPE_USER_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
);
-- Table TB_OUTTYPE이(가) 생성되었습니다.

COMMENT ON TABLE TB_OUTTYPE IS '지출유형';
COMMENT ON COLUMN TB_OUTTYPE.OUTTYPE_SEQ IS '지출유형SEQ';
COMMENT ON COLUMN TB_OUTTYPE.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_OUTTYPE.OUTTYPE_NM IS '지출유형이름';
COMMENT ON COLUMN TB_OUTTYPE.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_OUTTYPE.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_OUTTYPE
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_OUTTYPE이(가) 생성되었습니다.


-- 지출
CREATE TABLE TB_OUTGOINGS
( OUT_SEQ NUMBER(10)
, USER_SEQ NUMBER(8) NOT NULL
, ASSET_SEQ NUMBER(5) NOT NULL
, OUTTYPE_SEQ NUMBER(5) NOT NULL
, AMOUNT NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300) 
, OUT_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT OUTGOINGS_OUTSEQ_PK PRIMARY KEY (OUT_SEQ)
, CONSTRAINT OUTGOINGS_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT OUTGOINGS_ASSETSEQ_FK FOREIGN KEY (ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
, CONSTRAINT OUTGOINGS_OUTTYPE_FK FOREIGN KEY (OUTTYPE_SEQ) REFERENCES TB_OUTTYPE(OUTTYPE_SEQ)
);
-- Table TB_OUTGOINGS이(가) 생성되었습니다.

COMMENT ON TABLE TB_OUTGOINGS IS '지출';
COMMENT ON COLUMN TB_OUTGOINGS.OUT_SEQ IS '지출SEQ';
COMMENT ON COLUMN TB_OUTGOINGS.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_OUTGOINGS.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_OUTGOINGS.OUTTYPE_SEQ IS '지출유형SEQ';
COMMENT ON COLUMN TB_OUTGOINGS.AMOUNT IS '금액';
COMMENT ON COLUMN TB_OUTGOINGS.DETAIL IS '상세';
COMMENT ON COLUMN TB_OUTGOINGS.OUT_TIME IS '지출일시';
COMMENT ON COLUMN TB_OUTGOINGS.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_OUTGOINGS.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_OUTGOINGS
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 9999999999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_OUTGOINGS이(가) 생성되었습니다.


-- 지출반복
CREATE TABLE TB_OUTREPEAT 
( OUTREPEAT_SEQ NUMBER(5)
, USER_SEQ NUMBER(8) NOT NULL
, ASSET_SEQ NUMBER(5) NOT NULL
, OUTTYPE_SEQ NUMBER(5) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL
, CNT NUMBER(5) DEFAULT NULL
, REPEAT_NM VARCHAR(30)
, AMOUNT NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300) 
, LASTDATE_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT OUTREPEAT_OUTREPEATSEQ_PK PRIMARY KEY (OUTREPEAT_SEQ)
, CONSTRAINT OUTREPEAT_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT OUTREPEAT_ASSETSEQ_FK FOREIGN KEY (ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
, CONSTRAINT OUTREPEAT_OUTTYPE_FK FOREIGN KEY (OUTTYPE_SEQ) REFERENCES TB_OUTTYPE(OUTTYPE_SEQ)
);
-- Table TB_OUTREPEAT이(가) 생성되었습니다.

COMMENT ON TABLE TB_OUTREPEAT IS '지출반복';
COMMENT ON COLUMN TB_OUTREPEAT.OUTREPEAT_SEQ IS '지출반복SEQ';
COMMENT ON COLUMN TB_OUTREPEAT.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_OUTREPEAT.ASSET_SEQ IS '자산SEQ';
COMMENT ON COLUMN TB_OUTREPEAT.OUTTYPE_SEQ IS '지출유형SEQ';
COMMENT ON COLUMN TB_OUTREPEAT.TYPE_CD IS '반복유형';
COMMENT ON COLUMN TB_OUTREPEAT.CNT IS '반복횟수';
COMMENT ON COLUMN TB_OUTREPEAT.AMOUNT IS '금액';
COMMENT ON COLUMN TB_OUTREPEAT.REPEAT_NM IS '반복명';
COMMENT ON COLUMN TB_OUTREPEAT.DETAIL IS '상세';
COMMENT ON COLUMN TB_OUTREPEAT.LASTDATE_TIME IS '마지막반영일';
COMMENT ON COLUMN TB_OUTREPEAT.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_OUTREPEAT.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_OUTREPEAT
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_OUTREPEAT이(가) 생성되었습니다.


-- 이체
CREATE TABLE TB_TRANSFER
( TRANSFER_SEQ NUMBER(10)
, USER_SEQ NUMBER(8) NOT NULL 
, OUT_ASSET_SEQ NUMBER(5) NOT NULL
, IN_ASSET_SEQ NUMBER(5) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL
, AMOUNT NUMBER(15) DEFAULT 0
, CHARGE NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300)
, ATDATE_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT TRANSFER_TRANSFERSEQ_PK PRIMARY KEY (TRANSFER_SEQ)
, CONSTRAINT TRANSFER_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT TRANSFER_OUTASSETSEQ_FK FOREIGN KEY (OUT_ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
, CONSTRAINT TRANSFER_INASSETSEQ_FK FOREIGN KEY (IN_ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
);
-- Table TB_TRANSFER이(가) 생성되었습니다.

COMMENT ON TABLE TB_TRANSFER IS '이체';
COMMENT ON COLUMN TB_TRANSFER.TRANSFER_SEQ IS '이체SEQ';
COMMENT ON COLUMN TB_TRANSFER.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_TRANSFER.OUT_ASSET_SEQ IS '출금자산SEQ';
COMMENT ON COLUMN TB_TRANSFER.IN_ASSET_SEQ IS '입금자산SEQ';
COMMENT ON COLUMN TB_TRANSFER.AMOUNT IS '금액';
COMMENT ON COLUMN TB_TRANSFER.CHARGE IS '수수료';
COMMENT ON COLUMN TB_TRANSFER.DETAIL IS '상세';
COMMENT ON COLUMN TB_TRANSFER.TYPE_CD IS '이체유형';
COMMENT ON COLUMN TB_TRANSFER.ATDATE_TIME IS '이체일시';
COMMENT ON COLUMN TB_TRANSFER.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_TRANSFER.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_TRANSFER
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 9999999999
NOCYCLE 
NOCACHE;
-- Sequence SEQ_TRANSFER이(가) 생성되었습니다.


-- 이체반복
CREATE TABLE TB_TRREPEAT
( TRREPEAT_SEQ NUMBER(5)
, USER_SEQ NUMBER(8) NOT NULL 
, OUT_ASSET_SEQ NUMBER(5) NOT NULL
, IN_ASSET_SEQ NUMBER(5) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL
, TRANSFER_TYPE VARCHAR(8) NOT NULL 
, AMOUNT NUMBER(15) DEFAULT 0
, CHARGE NUMBER(15) DEFAULT 0
, DETAIL VARCHAR(300)
, LASTDATE_TIME DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT TRREPEAT_TRREPEATSEQ_PK PRIMARY KEY (TRREPEAT_SEQ)
, CONSTRAINT TRREPEAT_USERSEQ_FK FOREIGN KEY (USER_SEQ) REFERENCES TB_USER(USER_SEQ)
, CONSTRAINT TRREPEAT_OUTASSETSEQ_FK FOREIGN KEY (OUT_ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
, CONSTRAINT TRREPEAT_INASSETSEQ_FK FOREIGN KEY (IN_ASSET_SEQ) REFERENCES TB_ASSET(ASSET_SEQ)
);
-- Table TB_TRREPEAT이(가) 생성되었습니다.

COMMENT ON TABLE TB_TRREPEAT IS '이체반복';
COMMENT ON COLUMN TB_TRREPEAT.TRREPEAT_SEQ IS '이체반복SEQ';
COMMENT ON COLUMN TB_TRREPEAT.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_TRREPEAT.OUT_ASSET_SEQ IS '출금자산SEQ';
COMMENT ON COLUMN TB_TRREPEAT.IN_ASSET_SEQ IS '입금자산SEQ';
COMMENT ON COLUMN TB_TRREPEAT.AMOUNT IS '금액';
COMMENT ON COLUMN TB_TRREPEAT.CHARGE IS '수수료';
COMMENT ON COLUMN TB_TRREPEAT.DETAIL IS '상세';
COMMENT ON COLUMN TB_TRREPEAT.TYPE_CD IS '반복유형';
COMMENT ON COLUMN TB_TRREPEAT.TRANSFER_TYPE IS '이체유형';
COMMENT ON COLUMN TB_TRREPEAT.LASTDATE_TIME IS '이체일시';
COMMENT ON COLUMN TB_TRREPEAT.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_TRREPEAT.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_TRREPEAT
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_TRREPEAT이(가) 생성되었습니다.


-- 보고서
CREATE TABLE TB_REPORT
( REPORT_SEQ NUMBER(5) 
, USER_SEQ NUMBER(8) NOT NULL
, REPORT_NM VARCHAR(30) NOT NULL
, STARTDATE DATE DEFAULT SYSDATE
, ENDDATE DATE DEFAULT SYSDATE
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT REPORT_REPORTSEQ_PK PRIMARY KEY (REPORT_SEQ)
, CONSTRAINT REPORT_USER_SEQ FOREIGN KEY (USER_SEQ) REFERENCES TB_USER (USER_SEQ)
);
-- Table TB_REPORT이(가) 생성되었습니다.

COMMENT ON TABLE TB_REPORT IS '보고서';
COMMENT ON COLUMN TB_REPORT.REPORT_SEQ IS '보고서SEQ';
COMMENT ON COLUMN TB_REPORT.REPORT_NM IS '보고서이름';
COMMENT ON COLUMN TB_REPORT.USER_SEQ IS '사용자SEQ';
COMMENT ON COLUMN TB_REPORT.STARTDATE IS '시작일';
COMMENT ON COLUMN TB_REPORT.ENDDATE IS '종료일';
COMMENT ON COLUMN TB_REPORT.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_REPORT.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_REPORT
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_REPORT이(가) 생성되었습니다.


-- 차트
CREATE TABLE TB_CHART
( CHART_SEQ NUMBER(5)
, REPORT_SEQ NUMBER(5) NOT NULL
, CHART_NM VARCHAR(30) NOT NULL
, TYPE_CD VARCHAR(8) NOT NULL
, CHART_TYPE VARCHAR(8) NOT NULL
, DEL_YN CHAR(1) DEFAULT 'N'
, UPDATE_TIME DATE DEFAULT SYSDATE
, CONSTRAINT CHART_CHARTSEQ_PK PRIMARY KEY (CHART_SEQ)
, CONSTRAINT CHART_REPORTSEQ_FK FOREIGN KEY (REPORT_SEQ) REFERENCES TB_REPORT(REPORT_SEQ)
);
-- Table TB_CHART이(가) 생성되었습니다.

COMMENT ON TABLE TB_CHART IS '차트';
COMMENT ON COLUMN TB_CHART.CHART_SEQ IS '차트SEQ';
COMMENT ON COLUMN TB_CHART.REPORT_SEQ IS '보고서SEQ';
COMMENT ON COLUMN TB_CHART.CHART_NM IS '차트이름';
COMMENT ON COLUMN TB_CHART.TYPE_CD IS '사용유형';
COMMENT ON COLUMN TB_CHART.CHART_TYPE IS '차트유형';
COMMENT ON COLUMN TB_CHART.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TB_CHART.UPDATE_TIME IS '갱신일시';
-- Comment이(가) 생성되었습니다.

CREATE SEQUENCE SEQ_CHART
INCREMENT BY 1
START WITH 1 
MINVALUE 1 
MAXVALUE 99999  
NOCYCLE 
NOCACHE;
-- Sequence SEQ_CHART이(가) 생성되었습니다.
