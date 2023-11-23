package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PaymentVO {

	private String payCode;
	private Date payDate;
	private Date payEdate;
	private Long payAmt;
	private String payMethod;
	private String cusRnum;
	private String payStatus;
	
	//PAYMENT테이블 : PAYMENT_DETAIL테이블 = 1 : 1
//	private PaymentDetailVO paymentDetailVO;
	
		
	// PaymentDetail
	private String levelName;
	
	// LevelInfo
	private String levelMemo;
	private long levelFee;
	private String levelVol;
	
//	private String funcName;
	private String[] funcNames;
	// FuncLevel
	List<FuncLevelVO> funcLevelList;
	
	// FuncInfo
	private String funcName;	// 기능설명
	private String funcMemo;	// 기능설명
	private Long funcFee;		// 가격 
	private String funcExplain;

	
	// 통계 차트!!!!!
	// 레벨 갯수
	private int levelCnt;
	private int levelRatio;
	// 기능 갯수
	private int funcCnt;
	private int funcRatio;
	// sales 매출
	private int salesCnt;
	private String month;
	private long totalCnt;
}
