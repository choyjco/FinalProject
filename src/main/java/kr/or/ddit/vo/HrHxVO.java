package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HrHxVO {
	private String hrCode; //인사발령코드
	private String hrType; //발령종류
	private Date hrDate; //처리일자
	private String hrResp; //책임자
	private String hrMemo; //메모
	private Date memoRegdate; //메모수정일자
	private String empName; //사원명
	private String empNo; //사원번호
	private String hrName; //사원명
	private String hrDept; //부서
	private String hrPos; //직책
	private String hrStat; //직책
	private String hrHistory; //전 부서, 전 직책
	
}
