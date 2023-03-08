package com.inout.demo.web.hist.vo;

import java.io.Serializable;

import com.inout.demo.common.vo.BaseVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 수입 VO
 */

@Getter
@Setter
public class IncomingsVO extends BaseVO implements Serializable {
    /** seralVersionUID */
    private static final long serialVersionUID = 1L;
    
    /** 수입 Seq */
    private String inSeq;
    /** 사용자 Seq */
    private String userSeq;
    /** 수입유형 Seq */
    private String intypeSeq;
    /** 자산 Seq */
    private String assetSeq;
    /** 금액 */
    private String amount;
    /** 상세 */
    private String detail;
    /** 수입시간 */
    private String inTime;
    /** 삭제여부 */
    private String delYn;
    /** 갱신일자 */
    private String updateTime;
}
