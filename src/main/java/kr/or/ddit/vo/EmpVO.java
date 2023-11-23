package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmpVO {
	private String empNo;			// 사원번호
	private String empPw;			// 사원 패스워드
	private String empName;			// 사원 이름
	private String empEname;		// 사원 영어이름
	private String empGen;			// 사원 성별
	private String empReg1;			// 사원 주민번호 1
	private String empReg2;			// 사원 주민번호 2
	private String empTel;			// 사원 전화번호
	private String empAddr1;		// 사원 주소 1
	private String empAddr2;		// 사원 주소 2
	private String empEmail;		// 사원 이메일
	private Date empDate;			// 사원 입사일
	private String empStat;			// 사원 재직상태
	private String empWork;			// 사원
	private String empAcct;			// 사원 계좌번호
	private String empBank;			// 사원 은행명
	private String empProfile;		// 사원 프로필사진
	private MultipartFile imgFile;	// 사진
	private String empSignature;	// 사원 직인
	private String empDept;			// 사원 부서코드
	private String empPos;			// 사원 직책코드
	private String empRank;			// 사원 직급코드
	private String empJob;			// 사원 직위코드
	private String empFfile;		// 사원 가족관계증명서
	List<EmpAuth> authList;			// 사원 권한리스트
	
	private int recCode;			
	private String empKdate;
	private String empStatCount1;
	private String empStatCount2;
	private String empStatCount3;
	private String empStatCount4;
	private String empCount;
	private String deptName;
	private String posName;
	private String rankName;
	private String jobName;
	private String savePath;		// 사원 프로필 패스경로
	private String fileNo;
	
	private String searchType;		// 사원 검색타입
	private String searchWord;		// 사원 검색어
	private String hrMemo;			// 사원 메모
	private Date emptEndDate;

	private String hrHistoryNm; // hrHistory 이름
	
	
	
}
