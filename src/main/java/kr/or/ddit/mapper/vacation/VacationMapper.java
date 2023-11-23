package kr.or.ddit.mapper.vacation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationAplyVO;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.VacationVO;

public interface VacationMapper {

	public List<VacationVO> vacList();

	public List<VacationPersonalVO> myVacationList(HashMap<String, String> vacationMap);

	public List<VacationPersonalVO> haveVacList();

	public List<VacationPersonalVO> annualManageList(Map<String, String> map);

	public List<VacationAplyVO> vacationApplyList(String empNo);

	public int cancelVacAply(String docNo);

	public int selectHaveVacCount(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationPersonalVO> selectHaveVacList(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationAplyVO> selectVacApply(Map<String, String> map);

	public int selectAnnualCount(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationPersonalVO> selectAnnualList(PaginationInfoVO<VacationPersonalVO> pagingVO);

	public List<VacationAplyVO> selectAllvacEmp();

	public void allVacationChange();

}
