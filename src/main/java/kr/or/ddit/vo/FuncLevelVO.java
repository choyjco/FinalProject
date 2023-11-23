package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class FuncLevelVO {

	private String payCode;
	private String funcName;
	
	private String funcMemo;
	private Long funcFee;
//	private List<FuncInfoVO> funcInfoVOList;
	
}
