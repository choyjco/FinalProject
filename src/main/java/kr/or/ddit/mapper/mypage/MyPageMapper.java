package kr.or.ddit.mapper.mypage;

import java.util.List;

import kr.or.ddit.vo.AcadVO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FamilyVO;
import kr.or.ddit.vo.InfoVO;

public interface MyPageMapper {

	public InfoVO detail(EmpVO empVO);

	public List<FamilyVO> famDetail(EmpVO empVO);

	public List<AcadVO> acadDetail(EmpVO emp);

	public List<CareerVO> carrDetail(EmpVO emp);

	public int acadModify(AcadVO acadVO);

	public AcadVO acadSelect(AcadVO acadVO);

	public void carrModify(CareerVO carrerVO);

	public CareerVO carrSelect(CareerVO carrerVO);

	public void famModify(FamilyVO familyVO);

	public FamilyVO famSelect(FamilyVO familyVO);

	public int acadDelete(String acadNo);

	public int carrDelete(String caNo);

	public int famDelete(String efNo);

	public String efNoSelect(FamilyVO familVO);

	public int famRegister(FamilyVO familyVO);

	public int carrRegister(CareerVO careerVO);

	public int acadRegister(AcadVO acadVO);

	public String acadNoSelect(AcadVO acadVO);

	public String caNoSelect(CareerVO careerVO);

	public EmpVO selectEmpOne(EmpVO empVO);

	public EmpVO selectEmpProfileOne(String empNo);

	public AttachVO selectAttachOne(String fileNo);

	public int updateDeleteConf(AttachVO attachVO);

	public int insertProfile(AttachVO attachVO);

	public int updateEmpProfile(EmpVO emp);

}
