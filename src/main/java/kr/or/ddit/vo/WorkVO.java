package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class WorkVO {
	public String workNo;
	
	public String empNo;
	public String empName;
	private String empProfile;
	public String deptName;
	public int workSum;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date workStime;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date workEtime;
	
	public int workTotal;
	public String comName;
	public String comCode;
	
	public String workKind;
	public int workAmt;
	public String docStat;
	public String docTitle;
	public String docCont;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date workSdate;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date workEdate;
	
}
