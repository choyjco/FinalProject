package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AlarmVO {
	private String armNo;			// 알림번호
	private String armSender;		// 발신자
	private String armReceiver;		// 수신자
	private String armCont;			// 알림내용
	private Date armTime;			// 알림시간
	private String armUrl;			// URL
	private String armStat = "N";	// 알림확인여부
	
	private String armSendername;	// 발신자이름
	private String armSenderimg;	// 발신자사진
}
