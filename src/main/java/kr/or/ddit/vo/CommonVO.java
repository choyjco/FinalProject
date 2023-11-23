package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CommonVO {
	private String comCode;		// 공통코드
	private String comName;		// 코드명
	private String comAbs;		// 코드개요
	private String comPay;		// 수당
	private String comAmt;		// 연차갯수
	private String deptName;	// 상위코드
	private String comParent;	// 부모코드
}
