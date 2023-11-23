package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RecInfoVO {
	
	private int recCode; //지원번호
	private String recType; //지원종류
	private String recFile; //첨부자료
	private String recStat; //처리상태
	private String recRes; //처리내용
	private String recDel; //삭제여부
	private String recAgr; //개인정보동의여부
	private String recName; //지원자이름
	private String recGen; //성별
	private String recReg1; //주민번호앞자리
	private String recReg2; //주민번호뒷자리
	private String recPhone; //연락처
	private String recAddr; //주소
	private String recAddr2; //상세주소
	private String recEmail; //이메일
	private String recBank; //은행
	private String recAcct; //계좌번호

}
