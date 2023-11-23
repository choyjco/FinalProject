package kr.or.ddit.service.work.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.work.WorkMapper;
import kr.or.ddit.service.work.IWorkService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.WorkVO;

@Service
public class WorkServiceImpl implements IWorkService {

	@Inject
	private WorkMapper workMapper;
	
	@Override
	public String adminCheck(String empNo) {
		return workMapper.adminCheck(empNo);
	}

	@Override
	public List<EmpVO> empList() {
		return workMapper.empList();
	}

	@Override
	public List<WorkVO> workList(HashMap<String, String> workMap) {
		return workMapper.workList(workMap);
	}

	@Override
	public List<WorkVO> teamWorkList(HashMap<String, String> map) {
		return workMapper.teamWorkList(map);
	}

	@Override
	public List<WorkVO> workManageList(HashMap<String, String> map) {
		return workMapper.workManageList(map);
	}

	@Override
	public List<WorkVO> selectWork(HashMap<String, String> workMap) {
		return workMapper.selectWork(workMap);
	}

	@Override
	public List<WorkVO> workApplyList(HashMap<String, String> map) {
		return workMapper.workApplyList(map);
	}

	@Override
	public List<WorkVO> workManagement(HashMap<String, String> map) {
		return workMapper.workManagement(map);
	}

	@Override
	public int selectTeamWorkCount(PaginationInfoVO<WorkVO> pagingVO) {
		return workMapper.selectTeamWorkCount(pagingVO);
	}

	@Override
	public List<WorkVO> selectTeamWorkList(PaginationInfoVO<WorkVO> pagingVO) {
		return workMapper.selectTeamWorkList(pagingVO);
	}

	@Override
	public int selectWorkManageCount(PaginationInfoVO<WorkVO> pagingVO) {
		return workMapper.selectWorkManageCount(pagingVO);
	}

	@Override
	public List<WorkVO> selectWorkManageList(PaginationInfoVO<WorkVO> pagingVO) {
		return workMapper.selectWorkManageList(pagingVO);
	}

	/**
	 *	출근버튼 메소드
	 *	@return 출근시간 반환
	 */
	@Override
	public WorkVO insertworkStart() {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int status = workMapper.insertworkStart(user.getEmp().getEmpNo());	// 출근시간 인서트
		WorkVO workVO = workMapper.selectoneWork(user.getEmp().getEmpNo());	// 위에서 넣었던 데이터 객체반환
		
		return workVO;
	}

	/**
	 *	퇴근버튼 메소드
	 *	@return 퇴근시간 반환
	 */
	@Override
	public WorkVO updateworkEnd() {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int status = workMapper.updateworkEnd(user.getEmp().getEmpNo());	// 퇴근시간 업로드
		WorkVO workVO = workMapper.selectoneWork(user.getEmp().getEmpNo());	// 업로드한 객체 반환
		
		long diffHor = (workVO.getWorkEtime().getTime() - workVO.getWorkStime().getTime()) / 3600000;	// 퇴근시간 - 출근시간 = 근무시간
		
		workVO.setWorkTotal((int) diffHor);		// 근무시간 세팅
		int status2 = workMapper.updateworkTotal(workVO);	// 근무시간 업데이트
		
		return workVO;
	}

	/**
	 *	오늘 날짜 출퇴근 기록 반환하는 메소드
	 *	@return 출퇴근 기록이 담긴 객체 반환
	 */
	@Override
	public WorkVO selectoneWork() {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		WorkVO workVO = workMapper.selectoneWork(user.getEmp().getEmpNo());
		
		return workVO;
	}

	@Override
	public List<WorkVO> workListMonth(HashMap<String, String> workMap) {
		return workMapper.workListMonth(workMap);
	}

	

	

}
