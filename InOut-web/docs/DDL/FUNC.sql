/**
PACK_ENC_DEC.FN_ENCRYPT(IN_STR IN VARCHAR2)        ---------- 암호화
PACK_ENC_DEC.FN_DECRYPT(IN_STR IN VARCHAR2)        ---------- 복호화
FN_GET_COMM_NM(IN_STR VARCHAR2)                    ---------- 공통코드_상세이름 취득
FN_NEW_USER_NO                                    ---------- 사용자SEQ  
*/

-- 암호화/복호화 패키지
CREATE OR REPLACE PACKAGE PACK_ENC_DEC
IS
    FUNCTION FN_ENCRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION FN_DECRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2;
END PACK_ENC_DEC;
-- Package PACK_ENC_DEC이(가) 컴파일되었습니다.

CREATE OR REPLACE PACKAGE BODY PACK_ENC_DEC
IS 
    FUNCTION FN_ENCRYPT(IN_STR VARCHAR2)
    RETURN VARCHAR2
    IS 
        KEY_RAW     RAW(64);        -- 키 데이터
        ONG_RAW     RAW(64);        -- 원문 데이터
        ENC_RAW     RAW(64);        -- 암호화 데이터
        CHG_STR     VARCHAR(150);   -- 형 변환
    
    BEGIN
    
        ONG_RAW := UTL_I18N.STRING_TO_RAW(IN_STR, 'AL32UTF8');
        KEY_RAW := UTL_I18N.STRING_TO_RAW('DLSDKDNTVMFHWPRXM', 'AL32UTF8');
        ENC_RAW := DBMS_CRYPTO.ENCRYPT( SRC => ONG_RAW ,
                                        TYP => DBMS_CRYPTO.DES_CBC_PKCS5 , 
                                        KEY => KEY_RAW ,
                                        IV =>  NULL);
        CHG_STR := UTL_RAW.CAST_TO_VARCHAR2(utl_encode.base64_encode(ENC_RAW));
        -- 형변환 필요!! 
        -- ORA-06502: PL/SQL: numeric or value error: hex to raw conversion error 에러 발생
    RETURN CHG_STR;
    END FN_ENCRYPT;
    
    FUNCTION FN_DECRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2
    IS 
        KEY_RAW     RAW(64);        -- 키 데이터
        DEC_RAW     RAW(64);        -- 복호화 데이터
        CHG_STR     VARCHAR2(150);   -- 형변환 
    
    BEGIN
    
        KEY_RAW := UTL_I18N.STRING_TO_RAW('DLSDKDNTVMFHWPRXM', 'AL32UTF8');
        DEC_RAW := DBMS_CRYPTO.DECRYPT( SRC => utl_encode.base64_decode(utl_raw.cast_to_raw(IN_STR)) , -- 형변환 필요!! 
                                        TYP => DBMS_CRYPTO.DES_CBC_PKCS5 ,
                                        KEY => KEY_RAW ,
                                        IV =>  NULL);
        CHG_STR := UTL_I18N.RAW_TO_CHAR(DEC_RAW, 'AL32UTF8');
    
    RETURN CHG_STR;
    END FN_DECRYPT;
    
END PACK_ENC_DEC;
-- Package Body PACK_ENC_DEC이(가) 컴파일되었습니다.


-- 공통코드_상세이름 취득
CREATE OR REPLACE FUNCTION FN_GET_COMM_NM(IN_STR VARCHAR2)
RETURN VARCHAR2
IS 
    COMM_NM VARCHAR(200);
BEGIN
    SELECT 
        NVL((SELECT CD_DTL.DTL_NM
             FROM CD_MST 
             INNER JOIN CD_DTL ON CD_MST.MST_CD = CD_DTL.MST_CD AND CD_DTL.USE_YN = 'Y'
             WHERE CD_MST.USE_YN = 'Y'
             AND DTL_CD = IN_STR
        ), '-') INTO COMM_NM
    FROM DUAL;
RETURN COMM_NM;
END FN_GET_COMM_NM;


-- 신규 사용자SEQ 생성
CREATE OR REPLACE FUNCTION FN_NEW_USER_NO
RETURN NUMBER
IS
    yymm CHAR(4);
    CHG_NUM NUMBER(4);
    CNT NUMBER;
    CODE NUMBER(8);
BEGIN
    CODE := 23010001;
    yymm := TO_CHAR(SYSDATE, 'YYMM');
    CHG_NUM := TO_NUMBER(yymm);
    
    SELECT COUNT(USER_SEQ) + 1 INTO CNT 
    FROM TB_USER 
    WHERE (USER_SEQ/10000) = CHG_NUM;
    
    CODE := CASE WHEN CNT > 9999 THEN (CHG_NUM*10000)+10001 ELSE (CHG_NUM*10000)+CNT END; 
    
RETURN CODE;
    
END FN_NEW_USER_NO;
-- Function FN_NEW_USER_NO이(가) 컴파일되었습니다.