package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SettingsVO {

	
	private String vacCode;
	private String vacName;
	private String vacCont;
	private String vacAmt;
	private String vacGen;
	private String vacWgPay;	// 'Y' or 'N'
	private String vacCert;		// 'Y' or 'N'
	
	private String cusRnum;
	private String cusPw;
	private String cusCom;
	private String cusName;
	private MultipartFile cusLogoFile;
	private String cusLogo;
	private String cusAddr;
	private String cusAddr2;
	private String cusTel;
	private int cusEmp;
	private String cusEmail;
	private String cusBirth;
	private MultipartFile cusImageFile;
	private String cusImage;
	private MultipartFile cusSignatureFile;
	private String cusSignature;
	
	private List<AttachVO> cusFileList;
	
	private String empNo;
	private String empName;
	private String empDept;
	private String empRole;
	
	
	private MultipartFile empListFile;
	private String empList;
}
