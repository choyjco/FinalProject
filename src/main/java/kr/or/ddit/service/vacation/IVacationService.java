package kr.or.ddit.service.vacation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationAplyVO;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.VacationVO;

public interface IVacationService {

	public List<VacationVO> vacationList();

	public List<VacationPersonalVO> myVacationList(HashMap<String, String> vacationMap);

	public List<VacationPersonalVO> haveVacList();

	public List<VacationPersonalVO> annualManageList(Map<String, String> map);

	public List<VacationAplyVO> vacationApplyList(String empNo);

	public ServiceResult cancelVacAply(String docNo);

	public int selectHaveVacCount(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationPersonalVO> selectHaveVacList(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationAplyVO> selectVacApply(Map<String, String> map);	// 휴가 신청 기안을 조회

	public int selectAnnualCount(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationPersonalVO> selectAnnualList(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationAplyVO> selectAllvacEmp();

	public ServiceResult allVacationChange();

}
