package com.inout.demo.web.hist.vo;

import java.io.Serializable;

import com.inout.demo.common.vo.BaseVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 지출 VO
 */

@Getter
@Setter
public class OutgoingsVO extends BaseVO implements Serializable {
    /** seralVersionUID */
    private static final long serialVersionUID = 1L;
    
    /** 지출 Seq */
    private String outSeq;
    /** 사용자 Seq */
    private String userSeq;
    /** 자산 Seq */
    private String assetSeq;
    /** 금액 */
    private String amount;
    /** 상세 */
    private String detail;
    /** 지출시간 */
    private String outTime;
    /** 삭제여부 */
    private String delYn;
    /** 갱신일자 */
    private String updateTime;
}
