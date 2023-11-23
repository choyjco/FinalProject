package kr.or.ddit.controller.work;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.common.ICommonService;
import kr.or.ddit.service.work.IWorkService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TreeVO;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/work")
@Controller
public class WorkController {

	@Inject
	private IWorkService workService;
	
	@Inject
	private ICommonService commonService;
	
	/**
	 * 나의 주별 근무 기록 리스트 조회 메소드
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/myworklist", method = RequestMethod.GET)
	public String workList(Model model, HttpServletRequest request) {
		log.info("worklist() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("나의 근무", "/work/myworklist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("내 근무 기록", "/work/myworklist");
		List<MenuVO> submenuList = Arrays.asList(menu4);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		return "work/myWorkList";
	}
	
	/**
	 * 주별 근무기록 리스트 응답 메소드
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/myworklist", method = RequestMethod.POST)
	public List<WorkVO> workList(@RequestBody Map<String, String> map) {
		
		String firstDate = map.get("firstDate").toString();
		String lastDate = map.get("lastDate").toString();
		
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: {}", firstDate);
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: {}", lastDate);
		
		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		String empNo = user.getUsername();
		
		HashMap<String, String> workMap = new HashMap<String, String>();
		workMap.put("firstDate", firstDate);
		workMap.put("lastDate", lastDate);
		workMap.put("empNo", empNo);
		
		List<WorkVO> workList = workService.workList(workMap);
		
		return workList;
	}

	/**
	 * 월별 근무기록 리스트 응답 메소드
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/myworkList", method = RequestMethod.POST)
	public List<WorkVO> workListMonth(@RequestBody Map<String, String> map) {
		
		String selectedDate = map.get("selectedDate").toString();
		
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: {}", selectedDate);
		
		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		String empNo = user.getUsername();
		
		HashMap<String, String> workMap = new HashMap<String, String>();
		workMap.put("selectedDate", selectedDate);
		workMap.put("empNo", empNo);
		
		List<WorkVO> workListMonth = workService.workListMonth(workMap);
		
		return workListMonth;
	}
	

	/**
	 * (관리자)구성원 전체의 근무기록 리스트 조회 메소드
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/teamworklist", method = RequestMethod.GET)
	public String teamWorkList(Model model, HttpServletRequest request) {
		log.info("teamWorklist() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("구성원 근무", "/work/teamworklist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("구성원 근무 기록", "/work/teamworklist");
		List<MenuVO> submenuList = Arrays.asList(menu4);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		List<EmpVO> empList = workService.empList();
		model.addAttribute("empList", empList);
		
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);

		return "work/teamWorkList";
	}
	
	/**
	 * 검색 및 페이징 적용된 구성원 근무 리스트 응답
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/teamworklist", method = RequestMethod.POST)
	public PaginationInfoVO<WorkVO> teamWorkList(
			@RequestBody HashMap<String, String> map) {
		
		String firstDate = map.get("firstDate").toString();
		String lastDate = map.get("lastDate").toString();
		String selectDept = map.get("selectDept").toString();
		
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111:  {}", firstDate);
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: {}", lastDate);
		log.info("넘어온 부서이름 !!!!!!!!!!!!!!!!!!!!!: {}", selectDept);
		
		PaginationInfoVO<WorkVO> pagingVO = new PaginationInfoVO<WorkVO>();
		
		// 페이징을 위한 검색 형태 만들기
		pagingVO.setFirstDate(firstDate);
		pagingVO.setLastDate(lastDate);
		pagingVO.setSelectDept(selectDept);
		
		int page = Integer.parseInt(map.get("page"));
		pagingVO.setCurrentPage(page); // startRow, endRow, startPage, endPage가 결정됨

		int totalRecord = workService.selectTeamWorkCount(pagingVO); 	// 총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);	// totalPage 결정
		List<WorkVO> dataList = workService.selectTeamWorkList(pagingVO);
		pagingVO.setDataList(dataList);
		
		
		return pagingVO;
	}
	
	
	/**
	 * (사원)나와 같은 팀에 속한 구성원의 근무기록 리스트 조회 메소드
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/myteamworklist", method = RequestMethod.GET)
	public String myTeamWorkList(Model model, HttpServletRequest request) {
		log.info("myteamworklist() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("우리 부서 근무", "/work/myteamworklist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("부서 구성원 근무", "/work/myteamworklist");
		List<MenuVO> submenuList = Arrays.asList(menu4);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);

		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		String deptCode = user.getEmp().getEmpDept();
		model.addAttribute("deptCode", deptCode);
		
		List<EmpVO> empList = workService.empList();
		model.addAttribute("empList", empList);
		
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);

		return "work/myTeamWorkList";
	}
	
	
	/**
	 * 관리자가 사원의 근무 기록을 주별로 조회할 수 있는 페이지 
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/workmanagelist", method = RequestMethod.GET)
	public String workManageList(Model model, HttpServletRequest request) {
		log.info("workManage GET() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("근무 관리", "/work/workmanagelist");
		
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("근무 기록 조회", "/work/workmanagelist");
		MenuVO menu5 = new MenuVO("근무 신청 처리", "/work/workmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		List<EmpVO> empList = workService.empList();
		model.addAttribute("empList", empList);
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);
		
		return "work/workManageList";
	}
	
	/**
	 * 구성원 근무기록 응답
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/workmanagelist", method = RequestMethod.POST)
	public PaginationInfoVO<WorkVO> workManageList(@RequestBody HashMap<String, String> map) {
		
		String firstDate = map.get("firstDate").toString();
		String lastDate = map.get("lastDate").toString();
		String selectDept = map.get("selectDept").toString();
		
		log.info("넘어온 날짜!!!!!!!!!! : {} ", firstDate);
		log.info("넘어온 날짜 !!!!!!!!!!!!!: {}", lastDate);
		log.info("넘어온 부서이름 !!!!!!!!!!: {}", selectDept);
		
		PaginationInfoVO<WorkVO> pagingVO = new PaginationInfoVO<WorkVO>();
		
		// 페이징을 위한 검색 형태 만들기
		pagingVO.setFirstDate(firstDate);
		pagingVO.setLastDate(lastDate);
		pagingVO.setSelectDept(selectDept);
		
		int page = Integer.parseInt(map.get("page"));
		pagingVO.setCurrentPage(page); // startRow, endRow, startPage, endPage가 결정됨

		int totalRecord = workService.selectWorkManageCount(pagingVO); 	// 총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);	// totalPage 결정
		List<WorkVO> dataList = workService.selectWorkManageList(pagingVO);
		pagingVO.setDataList(dataList);
		
		
		return pagingVO;
	}
	
	/**
	 * 관리자가 근무 조회 페이지에서 사원 각각의 상세 근무 내역을 조회할 수 있는 페이지
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/workdetail")
	public String workDetail(
			Model model, 
			HttpServletRequest request, 
			@RequestParam(name = "empNo")String empNo,
			@RequestParam(name = "firstDate")String firstDate,
			@RequestParam(name = "lastDate")String lastDate
			) {
		log.info("workDetail() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("근무 관리", "/work/workdetail");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("근무 기록 조회", "/work/workmanagelist");
		MenuVO menu5 = new MenuVO("근무 신청  처리", "/work/workmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: " + firstDate);
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!!!111: " + lastDate);
		
		HashMap<String, String> workMap = new HashMap<String, String>();
		workMap.put("empNo", empNo);
		workMap.put("firstDate", firstDate);
		workMap.put("lastDate", lastDate);
		
		List<WorkVO> workList = workService.selectWork(workMap);
		log.info("workDetail() 실행!!!!!!!!!!!!!!");
		model.addAttribute("workList", workList);
		return "work/workDetail";
	}

	
	/**
	 * 초과근무 신청에 대해 승인/대기/반려 상태를 확인하고 처리할 수 있는 페이지
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/workmanage", method = RequestMethod.GET)
	public String workManage(Model model, HttpServletRequest request) {
		log.info("workManage() 실행...!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("근무 관리", "/work/workmanagelist");
		
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("근무 기록 조회", "/work/workmanagelist");
		MenuVO menu5 = new MenuVO("근무 신청 처리", "/work/workmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		return "work/workManage";
	}
	
	/**
	 * 근무신청 처리 데이터 응답
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/workmanage", method = RequestMethod.POST)
	public List<WorkVO> workManage(@RequestBody HashMap<String, String> map) {
		
		String firstDate = map.get("firstDate").toString();
		
		log.info("넘어온 날짜 !!!!!!!!!!!!!!!!!!!: " + firstDate);
		
		List<WorkVO> workManageList = workService.workApplyList(map);
		
		return workManageList;
	}
	
}
