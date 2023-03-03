package com.inout.demo.common.vo;

import com.inout.demo.common.beans.LoginUserInfo;
import lombok.Data;

import java.io.Serializable;

/**
 * Base VO
 */
@Data
public class BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 로그인 관리자 VO */
    private LoginUserInfo userVO;

    /**
     * PAGING 처리
     */
    /** 현재 페이지 */
    private int page = 1;
    private Integer startRow;
    private Integer endRow;
    private Integer startIndex;
    private Integer pageSize;
    /** 리스트 크기 : 한 페이지당 리스트의 사이즈 */
    private int rows = 10;
    private int totalCnt;
    private int rownum;
    
    public void setRows(int rows) {
        this.rows = rows;
    }
    

    public int getStartRow(){
        return (this.rows * this.page) - this.rows;
    }

    public int getEndRow(){
        return this.rows;
    }

    public int getPageCnt(){
        return this.rows;
    }

    public int getCurrentPage(){
        return this.page;
    }

    /** 페이지 블록 : 페이지 블록 사이즈 */
    public int getLastNo(){
        return 10;
    }



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

    /** 갱신 일시 */
    private String updateTime;

    /** 지역 코드 */

}
