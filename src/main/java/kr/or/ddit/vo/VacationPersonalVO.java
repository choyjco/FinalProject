package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class VacationPersonalVO {
	private String vpNo;
	private String empNo;
	private String empName;
	private String empDept;
	private String empProfile;
	private String comName;
	private String vacCode;
	private String vpChgCase;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date vpChgDate;
	private String vpChgRsn;
	private String vpAddDays;
	private String vpSubDays;
	private String vpDays;
	private String latestVpDays;
	private String oldestVpDays;
	
	// 연차 상세 정보에서 월별로 정보를 받아오기 위한 쿼리의 pivot 함수 내에서 사용되는 이름
	private String month;
	private String jan;
	private String feb;
	private String mar;
	private String apr;
	private String may;
	private String jun;
	private String jul;
	private String aug;
	private String sep;
	private String oct;
	private String nov;
	private String dec;
	
}
