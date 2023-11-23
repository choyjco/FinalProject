package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StatsVO {

	// genderchart(사원 성비)
	private String empGen;
	private int genCnt;
	private int genRatio;
	
	// 채용	
	private String year;
	private int carCnt;
	private int newCnt;
	private int totalCnt;
	
	// 근무
	private String empNo;
	private int totalWork;
	private Date workStime;
	
}
