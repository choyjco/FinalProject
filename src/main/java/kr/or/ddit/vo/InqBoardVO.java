package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class InqBoardVO {

	private int inqNo;
	private String inqTitle;
	private String inqCont;
	private String inqRepl;
	private Date inqDate;
	private String inqConf;
	private String cusRnum;
	
	private CustomerVO customerVO;
	
}
