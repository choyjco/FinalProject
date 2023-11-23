package kr.or.ddit.controller.hr;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.or.ddit.service.hr.IHrService;
import kr.or.ddit.service.hr.ITreeService;
import kr.or.ddit.service.mypage.IMyPageService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.HrDetailVO;
import kr.or.ddit.vo.HrHxFormVO;
import kr.or.ddit.vo.HrHxVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TreeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hr")
public class hrController {
	
	@Inject
	private ITreeService treeService;
	
	@Inject
	private IHrService hrService;
			
	@Inject
	private IMyPageService mypageService;
	/**
	 * 사원 페이지 - 검색, 사원 전체 조회
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/ghr")
	public String ghr(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "empDept1") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(value="comCode",required=false) String comCode,
			Model model,
			HttpServletRequest request) {
		log.info("ghr() 실행...!");
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		//tree의 부서를 선택한 경우 조건 추가
		if(StringUtils.isNotBlank(comCode)) {
			pagingVO.setKeyword(comCode);
		}

		pagingVO.setCurrentPage(currentPage);	
		
		int totalRecord = hrService.selectGhrCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		
		log.info("ghr->pagingVO : " + pagingVO);
		List<EmpVO> ghrList = hrService.selectGhrList(pagingVO);
		log.info("사원 전체정보 : " + ghrList);
		pagingVO.setDataList(ghrList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		List<EmpVO> EmpCount = hrService.countEmp();
		String empCount = EmpCount.get(0).getEmpCount();
		model.addAttribute("EmpCount", EmpCount);
		
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("목록", "/hr/ghr");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("전체", "/hr/ghr");
		List<MenuVO> submenuList = Arrays.asList(menu2);
		model.addAttribute("submenuList", submenuList);
		
		model.addAttribute("comCode", comCode);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		return "hr/ghr";
	}
	
	
	/**
	 * 관리자 이상 - 검색, 사원 조회
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr1")
	public String mhr1(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "empName") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(value="comCode",required=false) String comCode,
			Model model, 
			HttpServletRequest request) {
		log.info("mhr1() 실행...!, comCode : " + comCode);
		
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		//tree의 부서를 선택한 경우 조건 추가
		if(StringUtils.isNotBlank(comCode)) {
			pagingVO.setKeyword(comCode);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = hrService.selectMhr1Count(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<EmpVO> mhr1List = hrService.selectMhr1List(pagingVO);
		pagingVO.setDataList(mhr1List);
		
		model.addAttribute("pagingVO", pagingVO);
		
		List<EmpVO> EmpCount = hrService.countEmp();
		String empCount = EmpCount.get(0).getEmpCount();
		model.addAttribute("EmpCount", EmpCount);
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("목록", "/hr/mhr1");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("사원 조회", "/hr/mhr1");
		MenuVO menu5 = new MenuVO("재직 상태", "/hr/mhr12");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		model.addAttribute("comCode", comCode);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		return "hr/mhr1";
	}
	
	
	/**
	 * 조직도
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/hr.do", produces = "application/json; charset=utf-8")
    public ResponseEntity<List<TreeVO>> treeList() {
		List<TreeVO> treeList = treeService.getList();
		log.info("treeList->treeList : " + treeList);
        return new ResponseEntity<List<TreeVO>>(treeList, HttpStatus.OK);
    }

	
	/**
	 * 관리자 이상 - 조직도 선택하고 팀 별로 사원 조회
	 * @param comCode
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/selectTree", produces = "application/json; charset=utf-8")
    public ResponseEntity<PaginationInfoVO<EmpVO>> selectTree(String comCode,
    		@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		//selectTree->comCode : a001 
		//selectTree->comCode : a
		log.info("selectTree->comCode : " + comCode);
		
        
        
        PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
        
        //selectTreeTotal
        //페이징 시작///////////////////
        pagingVO.setCurrentPage(currentPage);
		int totalRecord = hrService.selectTreeTotal(comCode);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<EmpVO> selectTreeList = hrService.getAllEmployees(comCode);
		pagingVO.setDataList(selectTreeList);
		//페이징 끝///////////////////
        
        log.info("pagingVO : " + pagingVO);
        return new ResponseEntity<PaginationInfoVO<EmpVO>>(pagingVO, HttpStatus.OK);
    }
	
	
	/**
	 * 사원 - 조직도 선택하고 팀 별로 사원 조회
	 * @param comCode
	 * @return
	 */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@RequestMapping(value = "/selectTreeG", produces = "application/json; charset=utf-8")
	public ResponseEntity<PaginationInfoVO<EmpVO>> selectTreeG(String comCode,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		
		
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		//selectTreeTotal
        //페이징 시작///////////////////
        pagingVO.setCurrentPage(currentPage);
		int totalRecord = hrService.selectTreeTotal(comCode);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<EmpVO> selectTreeList = hrService.getAllEmployeesG(comCode);
		pagingVO.setDataList(selectTreeList);
		//페이징 끝///////////////////
		log.info("pagingVO : " + pagingVO);
		return new ResponseEntity<PaginationInfoVO<EmpVO>>(pagingVO, HttpStatus.OK);
	}
	
	
	/**
	 * 관리자 이상 - 재직상태 사원수 조회
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr12")
	public String mhr12(Model model,HttpServletRequest request) {
		log.info("mhr12() 실행...!");
		
		// 재직중
		List<EmpVO> StatCountList = hrService.countEmpStat();
		String empStatCount1 = StatCountList.get(0).getEmpStatCount1();
		model.addAttribute("StatCountList", StatCountList);
		
		// 휴가중
		List<EmpVO> StatCountList2 = hrService.countEmpStat2();
		String empStatCount2 = StatCountList2.get(0).getEmpStatCount2();
		model.addAttribute("StatCountList2", StatCountList2);
		
		// 수습중
		List<EmpVO> StatCountList3 = hrService.countEmpStat3();
		String empStatCount3 = StatCountList3.get(0).getEmpStatCount3();
		model.addAttribute("StatCountList3", StatCountList3);
		
		// 퇴직 예정
		List<EmpVO> StatCountList4 = hrService.countEmpStat4();
		String empStatCount4 = StatCountList4.get(0).getEmpStatCount4();
		model.addAttribute("StatCountList4", StatCountList4);
		
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("목록", "/hr/mhr1");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("사원 조회", "/hr/mhr1");
		MenuVO menu5 = new MenuVO("재직 상태", "/hr/mhr12");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		return "hr/mhr12";
	}
	
	/**
	 * 클릭 재직중 카드 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/statList", method = RequestMethod.POST, consumes = "application/json")
	public ResponseEntity<List<EmpVO>> statList(@RequestBody Map<String, String> map) {
		log.info("statList() 실행...!");
		String searchType = map.get("searchType");
		String searchWord = map.get("searchWord");
		
		EmpVO empVO = new EmpVO();
		empVO.setSearchType(searchType);
		empVO.setSearchWord(searchWord);
		List<EmpVO> mhr12statList = hrService.gridStatList(empVO);
		
		return new ResponseEntity<List<EmpVO>>(mhr12statList,HttpStatus.OK);
	}
	
	/**
	 * 클릭 휴가중 카드 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/statList2", method = RequestMethod.POST)
	public ResponseEntity<List<EmpVO>> statList2(Map<String, Object> map) throws Exception {
		log.info("statList2() 실행...!");
		
		List<EmpVO> mhr12statList2 = hrService.gridStatList2();
		
		return new ResponseEntity<List<EmpVO>>(mhr12statList2,HttpStatus.OK);
	}
	
	/**
	 * 클릭 수습중 카드 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/statList3", method = RequestMethod.POST)
	public ResponseEntity<List<EmpVO>> statList3(Map<String, Object> map) throws Exception {
		log.info("statList3() 실행...!");
		
		List<EmpVO> mhr12statList3 = hrService.gridStatList3();
		
		return new ResponseEntity<List<EmpVO>>(mhr12statList3,HttpStatus.OK);
	}
	
	/**
	 * 클릭 퇴직 예정 카드 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/statList4", method = RequestMethod.POST)
	public ResponseEntity<List<EmpVO>> statList4(Map<String, Object> map) throws Exception {
		log.info("statList4() 실행...!");
		
		List<EmpVO> mhr12statList4 = hrService.gridStatList4();
		
		return new ResponseEntity<List<EmpVO>>(mhr12statList4,HttpStatus.OK);
	}
	
	/**
	 * 관리자 이상 - 그리드를 사용한 사원 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/mhr12GridList", method = RequestMethod.GET)
	public ResponseEntity<List<EmpVO>> boardPost(Map<String, Object> map) throws Exception {
		log.info("boardPost() 실행...!");
		
		List<EmpVO> mhr12List = hrService.gridList();
		
		return new ResponseEntity<List<EmpVO>>(mhr12List,HttpStatus.OK);
	}
	
	
	/**
	 *  관리자 이상 - 사원 검색 + 카테고리
	 * @param map
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/searchMhr12", method = RequestMethod.POST, consumes = "application/json")
	public ResponseEntity<List<EmpVO>> searchBoard(@RequestBody Map<String, String> map){
		String searchType = map.get("searchType");
		String searchWord = map.get("searchWord");
		log.info("searchType : " + searchType);
		log.info("searchWord : " + searchWord);
		
		EmpVO empVO = new EmpVO();
		empVO.setSearchType(searchType);
		empVO.setSearchWord(searchWord);
		List<EmpVO> mhr12List = hrService.searchMrh12List(empVO);
				
		return new ResponseEntity<List<EmpVO>>(mhr12List, HttpStatus.OK);
	}
	
	
	/**
	 * 관리자 이상 - 재직 상태 변경
	 * @param empVO
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/modifyMhr12", method = RequestMethod.POST, produces = "application/json; charset=utf-8" ,consumes = "application/json")
	public ResponseEntity<List<EmpVO>> modifyMhr12(@RequestBody EmpVO empVO) {
		log.info("modifyMhr12() 실행...!");
		log.info("empVO : " + empVO);
		hrService.modifyMhr12(empVO);
		List<EmpVO> mhr12List = hrService.gridList();
		return new ResponseEntity<List<EmpVO>>(mhr12List,HttpStatus.OK);
	}
	
	/**
	 * 관리자 이상 - 부서 이동을 위한 사원 조회 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr2")
	public String mhr2(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "empName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model,
			HttpServletRequest request
			) {
		log.info("mhr2() 실행...!");
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			log.info("searchType : " + searchType);
			log.info("searchWord : " + searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		log.info("mhr2->pagingVO : " + pagingVO);
		int totalRecord = hrService.selectMhr2Count(pagingVO);
		log.info("mhr2->totalRecord : " + totalRecord);
		
		pagingVO.setTotalRecord(totalRecord);
		List<EmpVO> mhr2List = hrService.selectMhr2List(pagingVO);
		pagingVO.setDataList(mhr2List);
		log.info("mhr2List : " + mhr2List);
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		// 메인메뉴 리스트
		MenuVO menu2 = new MenuVO("인사발령", "/hr/mhr2");
		List<MenuVO> menuList = Arrays.asList(menu2);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("부서 이동", "/hr/mhr2");
		MenuVO menu5 = new MenuVO("승진", "/hr/mhr21");
		MenuVO menu6 = new MenuVO("채용", "/hr/mhr22");
		MenuVO menu7 = new MenuVO("발령 내역", "/hr/mhr3");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6, menu7);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		return "hr/mhr2";
	}
	
	
	/**
	 * 관리자 이상 - 부서 이동, 부서 변경
	 * @param empList
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/modifyMhr2", method = RequestMethod.POST, produces = "application/json; charset=utf-8", consumes = "application/json")
	public ResponseEntity<List<EmpVO>> modifyMhr2(@RequestBody HrHxFormVO hrHxFormVO) {
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		//수정
		int result = hrService.modifyEmpDept(hrHxFormVO.getHrHxVOList(), hrHxFormVO.getHrMemo());
		List<EmpVO> mhr2List = hrService.selectMhr2List(pagingVO);
		
		return new ResponseEntity<List<EmpVO>>(mhr2List,HttpStatus.OK);
	}
	
	
	/**
	 * 관리자 이상 - 승진, 직책 변경 
	 * @param empList
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/modifyMhr21", method = RequestMethod.POST, produces = "application/json; charset=utf-8", consumes = "application/json")
	public ResponseEntity<List<EmpVO>> modifyMhr21(@RequestBody HrHxFormVO hrHxFormVO) {
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		int result = hrService.modifyEmpPos(hrHxFormVO.getHrHxVOList(), hrHxFormVO.getHrMemo());
		List<EmpVO> mhr2List = hrService.selectMhr2List(pagingVO);
		
		return new ResponseEntity<List<EmpVO>>(mhr2List,HttpStatus.OK);
	}
	
	
	/**
	 * 관리자 이상 - 승진을 위한 사원 조회 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr21")
	public String mhr21(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "empName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model,
			HttpServletRequest request
			) {
		log.info("mhr21() 실행...!");
		PaginationInfoVO<EmpVO> pagingVO = new PaginationInfoVO<EmpVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			log.info("searchType : " + searchType);
			log.info("searchWord : " + searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = hrService.selectMhr2Count(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<EmpVO> mhr2List = hrService.selectMhr2List(pagingVO);
		pagingVO.setDataList(mhr2List);
		log.info("mhr2List : " + mhr2List);
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		// 메인메뉴 리스트
		MenuVO menu2 = new MenuVO("인사발령", "/hr/mhr2");
		List<MenuVO> menuList = Arrays.asList(menu2);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("부서 이동", "/hr/mhr2");
		MenuVO menu5 = new MenuVO("승진", "/hr/mhr21");
		MenuVO menu6 = new MenuVO("채용", "/hr/mhr22");
		MenuVO menu7 = new MenuVO("발령 내역", "/hr/mhr3");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6, menu7);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);

		
		return "hr/mhr21";
	}
	
	
	/**
	 * 관리자 이상 - 채용페이지
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr22", method = RequestMethod.GET)
	public String mhr22(Model model, HttpServletRequest request) {
		log.info("mhr22() 실행...!");
		
		
		
		// 메인메뉴 리스트
		MenuVO menu2 = new MenuVO("인사발령", "/hr/mhr2");
		List<MenuVO> menuList = Arrays.asList(menu2);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("부서 이동", "/hr/mhr2");
		MenuVO menu5 = new MenuVO("승진", "/hr/mhr21");
		MenuVO menu6 = new MenuVO("채용", "/hr/mhr22");
		MenuVO menu7 = new MenuVO("발령 내역", "/hr/mhr3");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6, menu7);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		
		return "hr/mhr22";
	}
	
	
	/**
	 * 관리자 이상 - 채용 페이지를 위한 그리드 사원 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/mhr22GridList", method = RequestMethod.GET)
	public ResponseEntity<List<EmpVO>> mhr22GridList(Map<String, Object> map) throws Exception {
		log.info("mhr22GridList() 실행...!");
		
		List<EmpVO> mhr22List = hrService.mhr22grid();
		
		return new ResponseEntity<List<EmpVO>>(mhr22List,HttpStatus.OK);
	}
	
	/**
	 * 관리자 이상 - 인사발령 - 채용
	 * 합격한 지원자 >>> 사원으로 변경
	 * @param empVO
	 * @return
	 * @throws Exception 
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/register", method = RequestMethod.POST, produces = "application/json; charset=utf-8" ,consumes = "application/json")
	public int gridRegister(@RequestBody List<EmpVO> empList, HttpServletRequest req) throws Exception {
		log.info("gridRegister() 실행...!");
		int result = hrService.register(req,empList);
		log.info("gridRegister->result " + result);
		return result;
	}
	
	
	/**
	 * 관리자 이상 - 인사 발령 내역
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @param request
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/mhr3")
	public String mhr3(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "hrType") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, 
			HttpServletRequest request
			) {
		log.info("mhr3() 실행...!");
		
		PaginationInfoVO<HrHxVO> pagingVO = new PaginationInfoVO<HrHxVO>();
		
		// 검색이 이뤄지면 아래가 실행됨
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = hrService.selectMhr3Count(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<HrHxVO> mhr3List = hrService.selectMhr3List(pagingVO);
		pagingVO.setDataList(mhr3List);
		
		model.addAttribute("pagingVO", pagingVO);
		
		
		// 메인메뉴 리스트
		MenuVO menu2 = new MenuVO("인사발령", "/hr/mhr2");
		List<MenuVO> menuList = Arrays.asList(menu2);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("부서 이동", "/hr/mhr2");
		MenuVO menu5 = new MenuVO("승진", "/hr/mhr21");
		MenuVO menu6 = new MenuVO("채용", "/hr/mhr22");
		MenuVO menu7 = new MenuVO("발령 내역", "/hr/mhr3");
		List<MenuVO> submenuList = Arrays.asList(menu4, menu5, menu6, menu7);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
	    request.setAttribute("currentURL", currentURL);
		
		
		return "hr/mhr3";
	}
	
	/**
	 * 관리자 이상 - 인사 발령 내역에서 발령분류를 선택 후 모달로 상세보기
	 * @param currentPage
	 * @param hrVO
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value = "/mhr3Dept", method = RequestMethod.POST, produces = "application/json; charset=utf-8", consumes = "application/json")

	public ResponseEntity<List<HrDetailVO>> mhr3Dept(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestBody HrDetailVO hrDetailVO) {
	    PaginationInfoVO<HrDetailVO> pagingVO = new PaginationInfoVO<HrDetailVO>();
	    pagingVO.setCurrentPage(currentPage);
	    pagingVO.setSearchWord(hrDetailVO.getHrCode());
	    List<HrDetailVO> mhr3DeptList = hrService.selectMhr3DeptList(pagingVO);
	    return new ResponseEntity<List<HrDetailVO>>(mhr3DeptList, HttpStatus.OK);
	}

	/**
	 * 메모 수정 모달
	 * @param hrHxFormVO
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/modifyMemo", method = RequestMethod.POST)
	public String modifyMemo(@RequestBody HrHxVO hrHxVO) {
		
		int result = hrService.modifyMemo(hrHxVO);
		
		if(result<0) {
			return "failed";
		}else {
			return "success";
		}
		
	}
	
}




















