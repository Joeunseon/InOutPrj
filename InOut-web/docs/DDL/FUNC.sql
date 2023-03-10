/**
PACK_ENC_DEC.FN_ENCRYPT(IN_STR IN VARCHAR2)        ---------- ��ȣȭ
PACK_ENC_DEC.FN_DECRYPT(IN_STR IN VARCHAR2)        ---------- ��ȣȭ
FN_GET_COMM_NM(IN_STR VARCHAR2)                    ---------- �����ڵ�_���̸� ���
FN_NEW_USER_NO                                    ---------- �����SEQ  
*/

-- ��ȣȭ/��ȣȭ ��Ű��
CREATE OR REPLACE PACKAGE PACK_ENC_DEC
IS
    FUNCTION FN_ENCRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION FN_DECRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2;
END PACK_ENC_DEC;
-- Package PACK_ENC_DEC��(��) �����ϵǾ����ϴ�.

CREATE OR REPLACE PACKAGE BODY PACK_ENC_DEC
IS 
    FUNCTION FN_ENCRYPT(IN_STR VARCHAR2)
    RETURN VARCHAR2
    IS 
        KEY_RAW     RAW(64);        -- Ű ������
        ONG_RAW     RAW(64);        -- ���� ������
        ENC_RAW     RAW(64);        -- ��ȣȭ ������
        CHG_STR     VARCHAR(150);   -- �� ��ȯ
    
    BEGIN
    
        ONG_RAW := UTL_I18N.STRING_TO_RAW(IN_STR, 'AL32UTF8');
        KEY_RAW := UTL_I18N.STRING_TO_RAW('DLSDKDNTVMFHWPRXM', 'AL32UTF8');
        ENC_RAW := DBMS_CRYPTO.ENCRYPT( SRC => ONG_RAW ,
                                        TYP => DBMS_CRYPTO.DES_CBC_PKCS5 , 
                                        KEY => KEY_RAW ,
                                        IV =>  NULL);
        CHG_STR := UTL_RAW.CAST_TO_VARCHAR2(utl_encode.base64_encode(ENC_RAW));
        -- ����ȯ �ʿ�!! 
        -- ORA-06502: PL/SQL: numeric or value error: hex to raw conversion error ���� �߻�
    RETURN CHG_STR;
    END FN_ENCRYPT;
    
    FUNCTION FN_DECRYPT(IN_STR IN VARCHAR2)
    RETURN VARCHAR2
    IS 
        KEY_RAW     RAW(64);        -- Ű ������
        DEC_RAW     RAW(64);        -- ��ȣȭ ������
        CHG_STR     VARCHAR2(150);   -- ����ȯ 
    
    BEGIN
    
        KEY_RAW := UTL_I18N.STRING_TO_RAW('DLSDKDNTVMFHWPRXM', 'AL32UTF8');
        DEC_RAW := DBMS_CRYPTO.DECRYPT( SRC => utl_encode.base64_decode(utl_raw.cast_to_raw(IN_STR)) , -- ����ȯ �ʿ�!! 
                                        TYP => DBMS_CRYPTO.DES_CBC_PKCS5 ,
                                        KEY => KEY_RAW ,
                                        IV =>  NULL);
        CHG_STR := UTL_I18N.RAW_TO_CHAR(DEC_RAW, 'AL32UTF8');
    
    RETURN CHG_STR;
    END FN_DECRYPT;
    
END PACK_ENC_DEC;
-- Package Body PACK_ENC_DEC��(��) �����ϵǾ����ϴ�.


-- �����ڵ�_���̸� ���
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


-- �ű� �����SEQ ����
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
-- Function FN_NEW_USER_NO��(��) �����ϵǾ����ϴ�.