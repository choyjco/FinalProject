package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EmpAuth {
	private String empNo; //사원번호
	private String auth; //권한값
}
