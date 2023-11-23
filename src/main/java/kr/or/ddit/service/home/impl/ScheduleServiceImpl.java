package kr.or.ddit.service.home.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.home.ScheduleMapper;
import kr.or.ddit.service.home.IScheduleService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.TodoVO;

@Service
public class ScheduleServiceImpl implements IScheduleService {

	// DI(Dependency 의존성 Injection 주입)
	@Inject
	private ScheduleMapper scheduleMapper;
	
	/**
	 * 일정을 추가하는 메소드
	 */
	@Override
	public int insert(ScheduleVO scheduel) {
		return scheduleMapper.insert(scheduel);
	}

	/**
	 * 일정을 불러오는 메소드
	 */
	@Override
	public List<ScheduleVO> findAll(String empNo) {
		return scheduleMapper.findAll(empNo);
	}

	/**
	 * 팀 일정을 불러오는 메소드
	 */
	@Override
	public List<ScheduleVO> findDept(String empDept) {
		return scheduleMapper.findDept(empDept);
	}

	/**
	 * 일정을 삭제하는 메소드
	 */
	@Override
	public int delete(String startDate) {
		return scheduleMapper.delete(startDate);
	}

	/**
	 * 일정을 수정하는 메소드
	 */
	@Override
	public int update(ScheduleVO scheduleVO) {
		return scheduleMapper.update(scheduleVO);
	}

	/**
	 * todoList를 불러오는 메소드
	 */
	@Override
	public List<TodoVO> selectTodoList() {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		List<TodoVO> todoList = scheduleMapper.selectTodoList(user.getEmp().getEmpNo());
		return todoList;
	}

	/**
	 * todoList에 등록하는 메소드
	 */
	@Override
	public ServiceResult insertTodoList(String todoContent) {
		ServiceResult result;
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		TodoVO todoVO = new TodoVO();
		todoVO.setEmpNo(user.getEmp().getEmpNo());
		todoVO.setTodoContent(todoContent);
		
		int status = scheduleMapper.insertTodoList(todoVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	/**
	 * todoList 삭제하는 메소드
	 */
	@Override
	public ServiceResult deleteTodoList(Map<String, String> map) {
		ServiceResult result = null;
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		TodoVO todoVO = new TodoVO();
		todoVO.setEmpNo(user.getEmp().getEmpNo());
		
		for(int i = 0; i < map.size(); i++) {
			
			String todoContent = map.get(String.valueOf(i));
			todoVO.setTodoContent(todoContent);
			
			int status = scheduleMapper.deleteTodoList(todoVO);
			
			if(status > 0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
				break;
			}
		}
		
		return result;
	}

}
