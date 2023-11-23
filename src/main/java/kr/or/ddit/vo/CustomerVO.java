package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CustomerVO {

	private String cusRnum;		// 사업자등록번호
	private String cusPw;		// 비밀번호
	private String cusCom;		// 회사명
	private String cusName;		// 대표자(이름)
	private String cusLogo;		// 회사로고
	private String cusAddr;		// 회사주소
	private String cusAddr2;	// 회사 상세주소
	private String cusZip;		// 우편번호
	private String cusTel;		// 회사 전화번호
	private int cusEmp;			// 사원수
	private String cusEmail;	// 이메일
//	@DateTimeFormat(pattern = "yyyyMMdd")
	private String cusBirth;	// 생년월일
	private String cusImage;	// 프로필 이미지
	private String cusSignature;// 회사직인
	
	PaymentVO paymentVO;
	
	AttachVO attachVO;
	
	List<AttachVO> attachList;
	
	private MultipartFile cusLogoImg;
	private MultipartFile cusProfileImg;
	private MultipartFile cusSignImg;
	
	
//	//CUSTOMER테이블 : PAYMENT테이블 = 1 : N 
//	private List<PaymentVO> paymentVOList;

	// 인원수 차트
	private String cusEmpRange;
	private int empCnt;
	
	private int rNum;
}
