package kr.or.ddit.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class DocVO {

	private String docNo;
	private String empNo;
	private String docClfCode;
	private String docTitle;
	private String docCont;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd(E)")
	private Date docDate;
	private String docStat;
	private String empName;
	private String empDept;
	private String peNo;
	private String peCont; 
	private String peDept; 
	private String peName; 
	private String peDate; 
	private String peAmt;
	private String peBank; 
	private String peAcct;
	private String peEmpName;
	private String peClf; 
	private String peConf;
	private int count;
	private String aprJob;
	private String aprEmpNo;
	private int aprNo;
	private String docClfFile;
	private String aprStat;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd(E)")
	private Date aprDate;
	private String aprRejConf;
	private String aprRejRsn;
	private String docClfName;
	private Date docConfDate;
	private String aprName;
	private String workDate;
	private String workSdate;
	private String workEdate;
	private String workAmt;
	private String vaapDate;
	private String vaapRsn;
	private String vaapStrtDate;
	private String vaapEndDate;
	private String vaapAmt;
	
}
