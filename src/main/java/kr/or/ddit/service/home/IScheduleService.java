package kr.or.ddit.service.home;

import java.util.List;
import java.util.Map;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.TodoVO;

public interface IScheduleService {
	/**
	 * 캘린더에 인서트하는 메소드
	 * @param scheduel 일정
	 * @return 처리결과
	 */
	public int insert(ScheduleVO scheduel);

	/**
	 * DB에 저장되어 있는 스케줄 가지고오는 메소드
	 * @return 일정
	 */
	public List<ScheduleVO> findAll(String empNo);

	/**
	 * 팀 일정을 불러오는 메소드
	 * @param empDept 부서코드
	 * @return 일정
	 */
	public List<ScheduleVO> findDept(String empDept);
	
	/**
	 * 스케줄 삭제하는 메소드
	 * @param startDate 삭제할 날짜
	 * @return 삭제 결과
	 */
	public int delete(String startDate);
	
	/**
	 * 스케줄 수정하는 메소드
	 * @param scheduleVO 업데이트 할 스케줄
	 * @return 업데이트 결과
	 */
	public int update(ScheduleVO scheduleVO);

	/**
	 * todoList 목록을 가져오는 메소드
	 * @return todoList
	 */
	public List<TodoVO> selectTodoList();

	/**
	 * todoList 등록하는 메소드
	 * @param todoContent 내용
	 * @return 등록결과
	 */
	public ServiceResult insertTodoList(String todoContent);

	/**
	 * todoList 삭제하는 메소드
	 * @param map 삭제내용
	 * @return 처리결과
	 */
	public ServiceResult deleteTodoList(Map<String, String> map);

}
