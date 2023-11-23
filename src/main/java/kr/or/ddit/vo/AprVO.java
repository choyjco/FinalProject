package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AprVO {
	
	private String empNo;		// 결재선 결재자
	private String empName;		// 사원명
	private String empDept;		// 사원부서
	private String empPos;		// 사원직책
	private String docNo;		// 기안문서번호
	private String aprNo;		// 결재선 순번
	private String aprStat;		// 결재선 처리상태
	private String aprRejConf;	// 반려여부
	private String aprRejRsn;	// 반려사유
	private String aprJob;		// 전결여부
	private String aprDate;		// 결재일자
}
