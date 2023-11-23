package kr.or.ddit.service.mypage;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.AcadVO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FamilyVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.LibraryVO;

public interface IMyPageService {

	public InfoVO detail(EmpVO empVO);

	public List<FamilyVO> famdetail(EmpVO empVO);

	public List<CareerVO> carrDetail(EmpVO emp);

	public List<AcadVO> acadDetail(EmpVO emp);

	public AcadVO acadselect(AcadVO acadVO);

	public CareerVO carrselect(CareerVO carrerVO);

	public FamilyVO famSelect(FamilyVO familyVO);

	public String acadDelete(String acadNo);

	public String carrDelete(String caNo);

	public String famdDelete(String efNo);

	public FamilyVO famRegister(FamilyVO familyVO);

	public CareerVO carrRegister(CareerVO careerVO);

	public AcadVO acadRegister(AcadVO acadVO);

	public EmpVO selectEmpOne(EmpVO empVO);

	public ServiceResult imgUpdate(LibraryVO attach, EmpVO emp, AttachVO attachVO, HttpServletRequest req) throws IllegalStateException, IOException;

//	public EmpVO selectEmpProfileOne(String empNo);
//
//	public AttachVO selectAttachOne(String fileNo);
//
//	public ServiceResult updateProfile(HttpServletRequest req, EmpVO empVO);

}
