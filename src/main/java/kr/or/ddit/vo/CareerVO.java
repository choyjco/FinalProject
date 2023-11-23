package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class CareerVO {

	private String empNo;		// 사원번호
	private String caNo;		// 경력번호
	private String caComName;	// 회사명
	private String caClf;		// 회사분류
	private String caType;		// 계약유형
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date caEntDate;		// 입사일자
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date caEndDate;		// 퇴사일자
	private String caDept;		// 부서
	private String caDut;		// 직책
	private String caPos;		// 직위
}
