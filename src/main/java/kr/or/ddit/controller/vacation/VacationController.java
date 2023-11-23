package kr.or.ddit.controller.vacation;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.common.ICommonService;
import kr.or.ddit.service.vacation.IVacationService;
import kr.or.ddit.service.work.IWorkService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.VacationAplyVO;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/vacation")
public class VacationController {

	@Inject
	private IVacationService vacService;
	
	@Inject
	private ICommonService commonService;
	
	/**
	 * 휴가 신청 및 예정휴가정보 조회 페이지
	 * @param model
	 * @param request
	 * @return 휴가 신청 조회 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/vacationapply", method = RequestMethod.GET)
	public String vacationApply(Model model, HttpServletRequest request) {
		log.info("vacationApply() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("나의 휴가", "/vacation/vacationapply");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		// 로그인한 사원이 'ROLE_ADMIN', 'ROLE_MANAGER'일 때와 'ROLE_MEMBER'일 때 서로 다른 메뉴가 나타나게 함
		String empNo = user.getUsername();
		String empName = user.getEmp().getEmpName();
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("휴가 신청", "/vacation/vacationapply");
		MenuVO menu5 = new MenuVO("내 연차 상세", "/vacation/annuallist");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		// 휴가 종류 정보
		List<VacationVO> vacList = vacService.vacationList();
		model.addAttribute("vacList", vacList);
		
		// 로그인한 사원의 예정 휴가 정보
		List<VacationAplyVO> vacAplyList = vacService.vacationApplyList(empNo);
		log.info("리스트 왔나? {}", vacAplyList);
		model.addAttribute("vacAplyList", vacAplyList);
		model.addAttribute("empName", empName);
		
		return "vacation/vacationApply";
	}
	
	/**
	 * 휴가 승인 전 취소 신청에 대한 처리 응답
	 * @param docNo
	 * @param ra
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/vacationapply", method = RequestMethod.POST)
	public String vacationApply(
			@RequestParam("docNo") String docNo,
			RedirectAttributes ra,
			Model model) {
		ServiceResult result = vacService.cancelVacAply(docNo);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "휴가 신청이 취소되었습니다.");
		}else {
			model.addAttribute("message", "휴가 신청 취소에 실패하였습니다.");
			model.addAttribute("docNo", docNo);
		}
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String empNo = user.getUsername();
		String empName = user.getEmp().getEmpName();
		
		// 휴가 종류 정보
		List<VacationVO> vacList = vacService.vacationList();
		model.addAttribute("vacList", vacList);
		
		// 로그인한 사원의 예정 휴가 정보
		List<VacationAplyVO> vacAplyList = vacService.vacationApplyList(empNo);
		log.info("리스트 왔나? {}", vacAplyList);
		model.addAttribute("vacAplyList", vacAplyList);
		model.addAttribute("empName", empName);

		return "vacation/vacationApply";
	}

	/**
	 * 연차 상세 페이지
	 * @param model
	 * @param request
	 * @return 연차 상세 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/annuallist", method = RequestMethod.GET)
	public String annualList(Model model, HttpServletRequest request) {
		log.info("annualList() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("나의 휴가", "/vacation/vacationapply");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("휴가 신청", "/vacation/vacationapply");
		MenuVO menu5 = new MenuVO("내 연차 상세", "/vacation/annuallist");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		return "vacation/annualList";
	}
	
	/**
	 * 연차 정보 응답 
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/annuallist", method = RequestMethod.POST)
	public List<VacationPersonalVO> annualList(@RequestBody Map<String, String> map) {
		
		String year = map.get("year").toString();
		log.info("선택연도!!! : " + year);
		
		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String empNo = user.getUsername();
		
		HashMap<String, String> vacationMap = new HashMap<String, String>();
		
		vacationMap.put("year", year);
		vacationMap.put("empNo", empNo);
		
		List<VacationPersonalVO> vacationList = vacService.myVacationList(vacationMap);
		
		return vacationList;
	}

	
	/**
	 * 구성원 휴가 보유 현황 페이지(관리자)
	 * @param model
	 * @param request
	 * @return 구성원 휴가 보유 현황 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/teamvacationlist")
	public String teamVacationList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "a") String selectDept,
			@RequestParam(required = false) String searchWord,
			HttpServletRequest request,
			Model model
			) {
		log.info("teamVacationList() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("휴가 관리", "/vacation/teamvacationlist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("구성원 휴가 보유 현황", "/vacation/teamvacationlist");
		MenuVO menu5 = new MenuVO("구성원 휴가 신청 내역", "/vacation/teamvacationusinglist");
		MenuVO menu6 = new MenuVO("구성원 연차 관리", "/vacation/annualmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6);

		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		PaginationInfoVO<VacationPersonalVO> pagingVO = new PaginationInfoVO<VacationPersonalVO>();
		
		log.info("넘어온 부서 코드!!! {}", selectDept);
		log.info("넘어온 사원명!!! {}", searchWord);
		
		// 검색이 이루어지면 아래가 실행됨
		if(StringUtils.isBlank(searchWord)) {	// 부서로만 검색하고 사원명이 비어있을 때 
			pagingVO.setSearchType("empty");
			pagingVO.setSelectDept(selectDept);
			model.addAttribute("selectDept", selectDept);
		}else {		// 부서와 사원명을 모두 적용해서 검색할 때 
			pagingVO.setSearchType("notempty");
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSelectDept(selectDept);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("selectDept", selectDept);
		}
		
		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage가 결정됨
		int totalRecord = vacService.selectHaveVacCount(pagingVO); 	// 총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);	// totalPage 결정
		List<VacationPersonalVO> dataList = vacService.selectHaveVacList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);
		
		return "vacation/teamVacationList";
	}
	
	/**
	 * 나와 같은 팀의 팀 구성원 휴가 보유 현황 페이지
	 * @param model
	 * @param request
	 * @return 같은 팀 구성원 휴가 보유 현황 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/myteamvacation")
	public String myTeamVacation(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "a") String selectDept,
			@RequestParam(required = false) String searchWord,
			HttpServletRequest request,
			Model model) {
		log.info("myTeamVacation() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("우리 팀 휴가 보유 현황", "/vacation/myteamvacation");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
//		// 시큐리티에 담긴 로그인된 유저 정보
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		// 서브메뉴 리스트
		MenuVO menu3 = new MenuVO("우리 팀 휴가 보유 현황", "/vacation/myteamvacation");
		List<MenuVO> submenuList = Arrays.asList(menu3);
		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		PaginationInfoVO<VacationPersonalVO> pagingVO = new PaginationInfoVO<VacationPersonalVO>();
		
		log.info("넘어온 부서 코드!!! {}", selectDept);
		log.info("넘어온 사원명!!! {}", searchWord);
		
		// 검색이 이루어지면 아래가 실행됨
		if(StringUtils.isBlank(searchWord)) {	// 부서로만 검색하고 사원명이 비어있을 때 
			pagingVO.setSearchType("empty");
			pagingVO.setSelectDept(selectDept);
			model.addAttribute("selectDept", selectDept);
		}else {		// 부서와 사원명을 모두 적용해서 검색할 때 
			pagingVO.setSearchType("notempty");
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSelectDept(selectDept);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("selectDept", selectDept);
		}
		
		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage가 결정됨
		int totalRecord = vacService.selectHaveVacCount(pagingVO); 	// 총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);	// totalPage 결정
		List<VacationPersonalVO> dataList = vacService.selectHaveVacList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);
		
		String deptCode = user.getEmp().getEmpDept();
		model.addAttribute("deptCode", deptCode);
		
		return "vacation/myTeamVacation";
	}
	
	/**
	 * 구성원 휴가 신청 내역 페이지
	 * @param model
	 * @param request
	 * @return 구성원 휴가 신청 내역 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/teamvacationusinglist", method = RequestMethod.GET)
	public String teamVacationUsingList(Model model, HttpServletRequest request) {
		log.info("teamVacationUsingList() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("휴가 관리", "/vacation/teamvacationlist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("구성원 휴가 보유 현황", "/vacation/teamvacationlist");
		MenuVO menu5 = new MenuVO("구성원 휴가 신청 내역", "/vacation/teamvacationusinglist");
		MenuVO menu6 = new MenuVO("구성원 연차 관리", "/vacation/annualmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6);

		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		return "vacation/teamVacationUsingList";
	}
	
	/**
	 * 휴가 신청 내역 응답
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/teamvacationusinglist", method = RequestMethod.POST)
	public List<VacationAplyVO> teamVacationUsingList(@RequestBody Map<String, String> map) {
		
		String firstDate = map.get("firstDate").toString();
		log.info("선택연도!!! {} ", firstDate);
		List<VacationAplyVO> vacApplyList = vacService.selectVacApply(map);
		
		return vacApplyList;
	}
	
	/**
	 * 구성원 연차 관리 페이지
	 * @param model
	 * @param request
	 * @return 구성원 연차 관리 페이지
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/annualmanage")
	public String teamAnnualManage(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "a") String selectDept,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue = "2023") String yearSelect,
			HttpServletRequest request,
			Model model
			) {
		log.info("teamAnnualManage() 실행!!!!!!");
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("휴가 관리", "/vacation/teamvacationlist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("구성원 휴가 보유 현황", "/vacation/teamvacationlist");
		MenuVO menu5 = new MenuVO("구성원 휴가 신청 내역", "/vacation/teamvacationusinglist");
		MenuVO menu6 = new MenuVO("구성원 연차 관리", "/vacation/annualmanage");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6);

		model.addAttribute("submenuList", submenuList);
		
		// 현재 주소 보내주기
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		PaginationInfoVO<VacationPersonalVO> pagingVO = new PaginationInfoVO<VacationPersonalVO>();
		
		log.info("부서 코드 {}", selectDept);
		log.info("사원명 {}", searchWord);
		log.info("연도 {}", yearSelect);
		
		// 검색이 이루어지면 실행
		if(StringUtils.isBlank(searchWord)) {	// 사원명 검색을 하지 않을 때
			pagingVO.setSearchType("noname");
			pagingVO.setSelectDept(selectDept);
			pagingVO.setYearSelect(yearSelect);
			model.addAttribute("selectDept", selectDept);
			model.addAttribute("yearSelect", yearSelect);
		}else {									// 사원명 검색을 실행할 때
			pagingVO.setSearchType("yesname");
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSelectDept(selectDept);
			pagingVO.setYearSelect(yearSelect);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("selectDept", selectDept);
			model.addAttribute("yearSelect", yearSelect);
		}
		
		pagingVO.setCurrentPage(currentPage); // startRow, endRow, startPage, endPage가 결정됨
		int totalRecord = vacService.selectAnnualCount(pagingVO); 	// 총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);	// totalPage 결정
		List<VacationPersonalVO> dataList = vacService.selectAnnualList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		List<CommonVO> comList = commonService.selectAllCommon();
		model.addAttribute("comList", comList);
		
		return "vacation/teamAnnualManage";
	}
	
	/**
	 * 연차 일괄 조정 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/allvacchange", method = RequestMethod.GET)
	public ResponseEntity<ServiceResult> allVacChange() {
		log.info("연차 일괄 조정까지 왔다!!!!!!~~~~");
		ServiceResult result = vacService.allVacationChange();
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	
}
