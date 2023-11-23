package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class InfoVO {
	
	private String empNo;
	private String empPw;
	private String empName;
	private String empEname;
	private String empGen;
	private String empReg1;
	private String empReg2;
	private String empTel;
	private String empAddr1;
	private String empAddr2;
	private String empEmail;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date empDate;
	private String empStat;
	private String empWork;
	private String empAcct;
	private String empBank;
	private String empProfile;
	private String empSignature;
	private String empDept;
	private String empPos;
	private String empRank;
	private String empJob;
	private String empFfile;
	private String deptName;
	private String posName;
	
	List<EmpAuth> authList;
	List<AcadVO> acadList;
	List<CareerVO> carrList;
	List<FamilyVO> famList;
}
