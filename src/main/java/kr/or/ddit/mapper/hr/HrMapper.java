package kr.or.ddit.mapper.hr;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.EmpAuth;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmptVO;
import kr.or.ddit.vo.HrDetailVO;
import kr.or.ddit.vo.HrHxVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface HrMapper {

	public int selectGhrCount(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectGhrList(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectMhr1List(PaginationInfoVO<EmpVO> pagingVO);
	public int selectMhr1Count(PaginationInfoVO<EmpVO> pagingVO);
	public int selectTreeTotal(String comCode);
	public int selectTreeGTotal(String deptCode);
	public List<EmpVO> selectTreeList(String comCode);
	public List<EmpVO> countEmpStat();
	public List<EmpVO> countEmpStat2();
	public List<EmpVO> countEmpStat3();
	public List<EmpVO> countEmpStat4();
	public List<EmpVO> getAllEmployeesG(String comCode);
	public List<EmpVO> selectTreeListG(String comCode);
	public int selectMhr3Count(PaginationInfoVO<HrHxVO> pagingVO);
	public List<HrHxVO> selectMhr3List(PaginationInfoVO<HrHxVO> pagingVO);
	public List<EmpVO> gridList();
	public List<EmpVO> searchMrh12List(EmpVO empVO);
	public void modifyMhr12(EmpVO empVO);
	public int selectMhr2Count(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectMhr2List(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> mhr22grid();
	public int register(EmpVO empVO);
	public List<EmpVO> countEmp();
	public void createAuth(EmpAuth empAuth);
	public int modifyEmpDept(EmpVO empVO);
	public int modifyEmpPos(EmpVO empVO);
	public void createHrHxDept(HrHxVO hrHxVO);
	public void createHrHxPos(HrHxVO hrHxVO);
	public void createHrHxStat(HrHxVO hrHxVO);
	public int selectMhr3DeptCount(PaginationInfoVO<HrHxVO> pagingVO);
	public void createHrHxDetail(HrDetailVO hrDetailVO);
	public void createEmpt(EmptVO emptVO);
	public String selectHrCode();
	public void insertProfile(AttachVO attachVO);
	public String selectEmpNo();
//	public String selectFileNo();
//	public void empProfileUpdate(EmpVO empVO);
	public List<HrDetailVO> selectMhr3DeptList(PaginationInfoVO<HrDetailVO> pagingVO);
	public int modifyMemo(HrHxVO hrHxVO);
	public List<EmpVO> gridStatList(EmpVO empVO);
	public List<EmpVO> gridStatList2();
	public List<EmpVO> gridStatList3();
	public List<EmpVO> gridStatList4();
	public EmpVO selectOne(EmpVO empVO);
	public List<EmpVO> selectAll();
	public List<EmpVO> excelMhr1List();
	public CustomerVO selectCus();
	public AttachVO selectAttach(CustomerVO customerVO);
	public List<EmpVO> excelGhrList();
	public void insertHrHistory(HrDetailVO hrDetailVO);
	public void updateHrHxDetail(HrDetailVO hrDetailVO);
	public void insertHrHistoryPos(HrDetailVO hrDetailVO);
	public void updateHrHxDetailPos(HrDetailVO hrDetailVO);

}
