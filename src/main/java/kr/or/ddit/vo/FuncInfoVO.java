package kr.or.ddit.vo;

import lombok.Data;

@Data
public class FuncInfoVO {

	private String funcName;	// 기능명
	private String funcMemo;	// 기능설명
	private Long funcFee;		// 가격
	private String funcExplain;
	
//	private FuncLevelVO funcLevelVO;
}
