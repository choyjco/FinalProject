package kr.or.ddit.service.vacation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.vacation.VacationMapper;
import kr.or.ddit.service.vacation.IVacationService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationAplyVO;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.VacationVO;

@Service
public class VacationServiceImpl implements IVacationService {

	@Inject
	private VacationMapper vacMapper;
	
	@Override
	public List<VacationVO> vacationList() {
		return vacMapper.vacList();
	}

	@Override
	public List<VacationPersonalVO> haveVacList() {
		return vacMapper.haveVacList();
	}

	@Override
	public List<VacationPersonalVO> myVacationList(HashMap<String, String> vacationMap) {
		return vacMapper.myVacationList(vacationMap);
	}

	@Override
	public List<VacationPersonalVO> annualManageList(Map<String, String> map) {
		return vacMapper.annualManageList(map);
	}

	@Override
	public List<VacationAplyVO> vacationApplyList(String empNo) {
		return vacMapper.vacationApplyList(empNo);
	}

	@Override
	public ServiceResult cancelVacAply(String docNo) {
		ServiceResult result = null;
		int status = vacMapper.cancelVacAply(docNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int selectHaveVacCount(PaginationInfoVO<VacationPersonalVO> pagingVO) {
		return vacMapper.selectHaveVacCount(pagingVO);
	}

	@Override
	public List<VacationPersonalVO> selectHaveVacList(PaginationInfoVO<VacationPersonalVO> pagingVO) {
		return vacMapper.selectHaveVacList(pagingVO);
	}

	@Override
	public List<VacationAplyVO> selectVacApply(Map<String, String> map) {
		return vacMapper.selectVacApply(map);
	}

	@Override
	public int selectAnnualCount(PaginationInfoVO<VacationPersonalVO> pagingVO) {
		return vacMapper.selectAnnualCount(pagingVO);
	}

	@Override
	public List<VacationPersonalVO> selectAnnualList(PaginationInfoVO<VacationPersonalVO> pagingVO) {
		return vacMapper.selectAnnualList(pagingVO);
	}

	/**
	 *	휴가자 사원 조회
	 */
	@Override
	public List<VacationAplyVO> selectAllvacEmp() {
		return vacMapper.selectAllvacEmp();
	}

	@Override
	public ServiceResult allVacationChange() {
		vacMapper.allVacationChange();
		
		return ServiceResult.OK;
	}


	

}
