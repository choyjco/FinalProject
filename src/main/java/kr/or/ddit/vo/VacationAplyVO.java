package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class VacationAplyVO {
	private String empNo;
	private String empName;
	
	private String docNo;
	private String docStat;
	
	private String vacName;
	private String vacCode;
	private int vaapAmt;
	private String vaapRsn;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date vaapStrtDate;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date vaapEndDate;
	
}
