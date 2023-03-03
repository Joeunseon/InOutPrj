package com.inout.demo.common.beans;


import lombok.Data;

/**
 * 공통 Bean
 */
@Data
public class CommonBaseBean {
    /** 로그인 사용자 Bean */
    private LoginUserInfo userBean;
    
    /**
     * PAGING 처리
     */
    private int page = 1;
    private Integer startRow;
    private Integer endRow;
    private Integer startIndex;
    private Integer pageSize;
    private int rows = 0;
    private String rownum;
    
    /** 
     * 검색 처리
     */
    private String searchType;
    private String searchValue;
    private String searchKey;
    private String searchVal;
    private String searchSelectOption;
    
    /** 검색 조건 : 날짜 유형 */
    private String searchDateType;
    /** 검색 조건 : 시작 날짜 */
    private String searchStartDate;
    /** 검색 조건 : 종료 날짜 */
    private String searchEndDate;
    
    /** 검색 조건 : 시작 번호 */
    private String startNum;
    /** 검색 조건 : 끝 번호 */
    private String endNum;
    
    /**
     * SORT 처리
     */
    private String sortColumn;
    private String orderType;
    
    /** Sort Flag */
    private String sortFlag;
    /** Rotate Type */
    private String rotateType;
    
    /**
     * 엑셀 처리
     */
    private String workId;
    private String workNm;
    private String workPass;
    
    /** 등록자 ID */
    private String createId;
    /** 등록 일시 */
    private String createTime;
    /** 등록자 IP */
    private String createIp;
    /** 갱신자 ID */
    private String updateId;
    /** 갱신 일시 */
    private String updateTime;
    /** 갱신 IP */
    private String updateIp;
    
    
    /*
     * @Override public String toString() { return
     * ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE); }
     */
}