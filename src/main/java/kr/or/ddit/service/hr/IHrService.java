package kr.or.ddit.service.hr;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.HrDetailVO;
import kr.or.ddit.vo.HrHxVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IHrService {

	public int selectGhrCount(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectGhrList(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectMhr1List(PaginationInfoVO<EmpVO> pagingVO);
	public int selectMhr1Count(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> getAllEmployees(String comCode);
	public List<EmpVO> countEmpStat();
	public List<EmpVO> countEmpStat2();
	public List<EmpVO> countEmpStat3();
	public List<EmpVO> countEmpStat4();
	public List<EmpVO> getAllEmployeesG(String comCode);
	public int selectMhr3Count(PaginationInfoVO<HrHxVO> pagingVO);
	public List<HrHxVO> selectMhr3List(PaginationInfoVO<HrHxVO> pagingVO);
	public List<EmpVO> gridList();
	public List<EmpVO> searchMrh12List(EmpVO empVO);
	public void modifyMhr12(EmpVO empVO);
	public int selectMhr2Count(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> selectMhr2List(PaginationInfoVO<EmpVO> pagingVO);
	public List<EmpVO> mhr22grid();
	public int register(HttpServletRequest req, List<EmpVO> empList) throws IOException, Exception;
	public List<EmpVO> countEmp();
	public int modifyEmpDept(List<EmpVO> empList, String hrMemo);
	public int modifyEmpPos(List<EmpVO> empList, String hrMemo);
	public int selectMhr3DeptCount(PaginationInfoVO<HrHxVO> pagingVO);
	public List<HrDetailVO> selectMhr3DeptList(PaginationInfoVO<HrDetailVO> pagingVO);
	public int modifyMemo(HrHxVO hrHxVO);
	public List<EmpVO> gridStatList(EmpVO empVO);
	public List<EmpVO> gridStatList2();
	public List<EmpVO> gridStatList3();
	public List<EmpVO> gridStatList4();
	public List<EmpVO> selectAll();
	public int selectTreeTotal(String deptCode);
	public List<EmpVO> excelMhr1List();
	public List<EmpVO> excelGhrList();
}
