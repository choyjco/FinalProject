package kr.or.ddit.controller.home;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.home.IScheduleService;
import kr.or.ddit.service.vacation.IVacationService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.TodoVO;
import kr.or.ddit.vo.VacationAplyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/full-calendar")
public class ScheduleController {
	
	@Inject
	IScheduleService scheduleservice;
	@Inject
	IVacationService vacationservice;
	
	/** 일정(풀캘린더)을 조회하는 컨트롤러
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/schedule", method = RequestMethod.GET)
	public String schedule(Model model) {
		log.info("schedule() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("🏘 홈", "/home/feed");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("메인", "/home/feed");
		MenuVO menu3 = new MenuVO("일정", "/full-calendar/schedule");
		MenuVO menu4 = new MenuVO("공지사항", "/notice/list");
		List<MenuVO> submenuList = Arrays.asList(menu2, menu3, menu4);
		model.addAttribute("submenuList", submenuList);
		
		model.addAttribute("currentURL", "/full-calendar/schedule");
		
		return "home/schedule";
	}
	
	/**
	 * 일정 조회 컨트롤러
	 * @return 일정
	 * @throws Exception
	 */
	@GetMapping("/calendar-admin-update")
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	public List<Map<String, Object>> showAllEventInUpdate() throws Exception{
		log.info("showAllEventInUpdate() 실행...!");
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // 시큐리티에 담긴 로그인된 유저 정보
		List<ScheduleVO> list = scheduleservice.findAll(user.getEmp().getEmpNo());
		
		for(ScheduleVO schedule : list) {
			hash.put("id", schedule.getSchNo());
			hash.put("title", schedule.getSchTitle());
			hash.put("start", schedule.getSchSdate());
			hash.put("end", schedule.getSchEdate());
			hash.put("classNames", schedule.getSchColor());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}
	
	// 이벤트 팀 조회
	@GetMapping("/calendar-admin-update/team")
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	public List<Map<String, Object>> showAllEventInUpdateteam() throws Exception{
		log.info("showAllEventInUpdateteam() 실행...! {}");
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // 시큐리티에 담긴 로그인된 유저 정보
		List<ScheduleVO> list = scheduleservice.findDept(user.getEmp().getEmpDept());
		
		for(ScheduleVO schedule : list) {
			hash.put("id", schedule.getSchNo());
			hash.put("title", schedule.getSchTitle());
			hash.put("start", schedule.getSchSdate());
			hash.put("end", schedule.getSchEdate());
			hash.put("classNames", schedule.getSchColor());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}
	
	// 이벤트 등록
	@PostMapping(value="/calendar-admin-update", produces = "application/json;charset=utf-8")
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	public String addEvent(@RequestBody List<Map<String, Object>> param) {
		
		log.info("addEvent() 실행...! param : {}", param);
		
		// 입력 문자열의 형식 지정
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("E MMM dd yyyy HH:mm:ss 'GMT'Z", java.util.Locale.ENGLISH);
        // 원하는 출력 형식 지정
        DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		 
        for (Map<String, Object> list : param) {
        	
            String schTitle = (String) list.get("title"); // 이름 받아오기
            String startDateString = (String) list.get("start");
            String endDateString = (String) list.get("end");
            String schColor = (String) list.get("classNames");
            String personal = (String) list.get("personal");
            
            startDateString = startDateString.replace(" (한국 표준시)", "");
            endDateString = endDateString.replace(" (한국 표준시)", "");
            
            // 문자열을 OffsetDateTime으로 파싱
            OffsetDateTime offsetstartDateTime = OffsetDateTime.parse(startDateString, inputFormat);
            OffsetDateTime offsetendDateTime = OffsetDateTime.parse(endDateString, inputFormat);
            
            // OffsetDateTime을 원하는 형식의 문자열로 포맷팅
            String startoutput = offsetstartDateTime.format(outputFormat);
            String endoutput = offsetendDateTime.format(outputFormat);
            
            ScheduleVO svo = new ScheduleVO();
            
            svo.setSchTitle(schTitle);
            svo.setSchSdate(String.valueOf(startoutput));
            svo.setSchEdate(String.valueOf(endoutput));
            svo.setSchColor(schColor);
            CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // 시큐리티에 담긴 로그인된 유저 정보
            if(personal.equals("팀")) {
            	svo.setSchDept(user.getEmp().getEmpDept());
            }else {
            	svo.setEmpNo(user.getEmp().getEmpNo());
			}
            
            this.scheduleservice.insert(svo);
          }
        return ServiceResult.OK.toString();
	}
	
	// 이벤트 삭제
	@DeleteMapping("/calendar-admin-update")
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	public String deleteEvent(@RequestBody List<Map<String, Object>> param) {
		log.info("deleteEvent() 실행...!");
		int result = 0;
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);
		
		for(Map<String, Object> list : param) {
			String startDateString =  (String)list.get("start");
							
			log.info("startDate : " + startDateString);
			
			LocalDateTime startDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
			
			log.info("startDateUTC : " + startDate);
			
			result = this.scheduleservice.delete(String.valueOf(startDate));
		}
		
		if(result>0) {
			return "index";	
		}else {
			return "/full-calendar/calendar-admin-update";
		}
	}
	
	// 이벤트 수정
	@PatchMapping("/calendar-admin-update")
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	public String modifyEvent(@RequestBody List<Map<String, Object>>param) {
		log.info("modifyEvent() 실행...!");
		int result = 0;
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);
		
		for(Map<String, Object> list : param) {
			
			String schTitle = (String)list.get("title"); // 이름 받아오기
			String startDateString = (String)list.get("start"); // 시작 시간
			String endDateString = (String)list.get("end"); // 끝나는 시간
			
			String oldStartString = (String)list.get("oldStart");
			String oldEndString = (String)list.get("oldEnd");
			
			LocalDateTime modifiedStartDate = LocalDateTime.parse(startDateString, dateTimeFormatter);
            LocalDateTime modifiedEndDate = LocalDateTime.parse(endDateString, dateTimeFormatter);
            LocalDateTime oldStart = LocalDateTime.parse(oldStartString, dateTimeFormatter);
            LocalDateTime oldEnd = LocalDateTime.parse(oldEndString, dateTimeFormatter);
            
            ScheduleVO scheduleVO = new ScheduleVO();
            scheduleVO.setSchTitle(schTitle);
            scheduleVO.setSchSdate(String.valueOf(modifiedStartDate));
            scheduleVO.setSchEdate(String.valueOf(modifiedEndDate));
            scheduleVO.setScholdSdate(String.valueOf(oldStart));
            scheduleVO.setScholdEdate(String.valueOf(oldEnd));
            
            log.info("update : " + scheduleVO.toString());
            
           result =  this.scheduleservice.update(scheduleVO);
		}
		
		if(result>0) {
			return "index";	
		}else {
			return "/full-calendar/calendar-admin-update";
		}
	}
	
	/**
	 * 휴가자 풀캘린더 리스트 출력
	 * @return jsonArr
	 * @throws Exception
	 */
	@GetMapping("/vac")
	@ResponseBody
	public List<Map<String, Object>> vac() throws Exception{
		log.info("vac() 실행...!");
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		
		List<VacationAplyVO> vaclist = vacationservice.selectAllvacEmp();
		
		for(VacationAplyVO vacEmp : vaclist) {
//			hash.put("id", vacEmp.getSchNo());
			hash.put("title", vacEmp.getEmpName()+" 휴가");
			hash.put("start", vacEmp.getVaapStrtDate());
			hash.put("end", vacEmp.getVaapEndDate());
//			hash.put("classNames", vacEmp.getSchColor());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}
	
	/**
	 * todoList 리스트 출력 컨트롤러
	 * @return todoList todoList 리스트
	 */
	@RequestMapping(value = "/todolist", method = RequestMethod.GET)
	@ResponseBody
	public List<TodoVO> todolist() {
		log.info("todolist() 실행...!");

		List<TodoVO> todoList = scheduleservice.selectTodoList();
		
		return todoList;
	}
		
	/**
	 * todoList 등록 컨트롤러
	 * @return
	 */
	@RequestMapping(value = "/inserttodo", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public ServiceResult inserttodo(@RequestBody Map<String, String> map) {
		log.info("inserttodo() 실행...!");
		
		String todoContent = map.get("todoContent");
		
		ServiceResult result = scheduleservice.insertTodoList(todoContent);
		
		return result;
	}
	
	/**
	 * todoList 삭제 컨트롤러
	 * @return
	 */
	@RequestMapping(value = "/deletetodo", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public ServiceResult deletetodo(@RequestBody Map<String, String> map) {
		log.info("deletetodo() 실행...!");
		
		ServiceResult result = scheduleservice.deleteTodoList(map);
		
		return result;
	}
	
}
