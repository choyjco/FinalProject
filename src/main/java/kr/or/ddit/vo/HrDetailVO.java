package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HrDetailVO {
		private String hrNo; //인사발령상세번호
		private String hrCode; //인사발령코드
		private String hrName; //사원명
		private String hrDept; //부서
		private String hrPos; //직책
		private String hrRank; //직급
		private String hrJob; //직위
		private String hrStat; //재직상태
		private String empNo; //사번
		private String hrType; //발령종류
		private Date hrDate; //처리일자
		private String hrHistory; //전 부서, 전 직책
		private String empDept;
		
}
