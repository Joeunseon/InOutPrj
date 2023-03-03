package com.inout.demo.common.beans;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 사용자로그인
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class LoginUserInfo extends CommonBaseBean implements Serializable {
    /** serialVersionUID */
    private static final long serialVersionUID = 1L;
    
    /** 사용자 로그인 SEQ */
    private String userSeq;
    /** 가입유형(이메일/카카오/네이버) */
    private String loingType;
    /** 탈퇴여부 */
    private String quitYn;
    /** 사용자이름 */
    private String userNm;
}