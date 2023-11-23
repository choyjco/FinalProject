package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AcadVO {
	
	private String empNo;		// 사원번호
	private String acadNo;		// 학력번호
	private String acadClf;		// 학교구분
	private String acadName;	// 학교명
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date acadEntDate;	// 입학일
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date acadEndDate;	// 졸업일
	private String acadStat;	// 졸업구분
	private String acadMaj;		// 전공
}
