package kr.or.ddit.controller.settings;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.hr.ITreeService;
import kr.or.ddit.service.settings.ISettingsService;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PayVO;
import kr.or.ddit.vo.SettingsVO;
import kr.or.ddit.vo.TreeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/settings")
public class settingsController {
	
	@Resource(name = "uploadPath")
	private String resourcePath;
	
	@Inject
	private ISettingsService service; 
	
	@Inject
	private ITreeService treeService; 
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String settingMain(Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("시스템 관리", "/settings/list");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("시스템 설정", "/settings/list");
		List<MenuVO> submenuList = Arrays.asList(menu2);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		SettingsVO settingsVO = service.selectCus("1028142945");
		model.addAttribute("settings", settingsVO);
//		AttachVO attach = service.delCusFile(settingsVO);
		
		
		List<SettingsVO> vacList = service.vacList();
		model.addAttribute("vacList", vacList);
		
		
		List<SettingsVO> empList = service.empList();
		model.addAttribute("empList", empList);
//		log.info("empList : " +empList);
			
		
		List<TreeVO> deptList = service.deptList();
		deptList.remove(0);
		model.addAttribute("deptList", deptList);
		
		
		List<TreeVO> posList = service.posList();
		model.addAttribute("posList", posList);
		
		
		List<TreeVO> rankList = service.rankList();
		model.addAttribute("rankList", rankList);
		
		
		List<TreeVO> jobList = service.jobList();
		model.addAttribute("jobList", jobList);
		
		
		List<SettingsVO> selectCustom = service.roleList();
		model.addAttribute("selectCustom", selectCustom);
		
		
		return "settings/list";
	}
	
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value = "/middlelist", method = RequestMethod.GET)
	public String settingMiddleMain(Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("시스템 관리", "/settings/list");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("시스템 설정", "/settings/list");
		List<MenuVO> submenuList = Arrays.asList(menu2);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		SettingsVO settingsVO = service.selectCus("2208162517");
		model.addAttribute("settings", settingsVO);
//		AttachVO attach = service.delCusFile(settingsVO);
		
		
		List<SettingsVO> vacList = service.vacList();
		model.addAttribute("vacList", vacList);
		
		
		List<SettingsVO> empList = service.empList();
		model.addAttribute("empList", empList);

		
		return "settings/middlelist";
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectEmp", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectEmp(Map<String, Object> map) {
		
//		log.info("selectEmp 실행");
		
		List<SettingsVO> empList = service.empList();
//		log.info("123empList : " +empList);
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@ResponseBody
	@RequestMapping(value = "/empModifyAuth", method = RequestMethod.POST)
	public ResponseEntity<Integer> empModifyAuth(HttpServletRequest request, @RequestParam Map<String,Object> paramList) throws Exception {
		
		String json = paramList.get("paramList").toString();
		ObjectMapper mapper = new ObjectMapper();
		List<SettingsVO> list = mapper.readValue(json, new TypeReference<ArrayList<SettingsVO>>(){}); 
		
//		String empNo = paramList.get("paramList").toString().;
//		SettingsVO settingsVO = new SettingsVO(); 
//		settingsVO.setEmpNo(empNo);
		for(SettingsVO vo : list) {
			log.info("empModifyAuth 실행, "+vo.toString());
			service.empModifyAuth(vo);
		}
		
		return new ResponseEntity<Integer>(HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectDefault", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectDefault(Map<String, Object> map) {
		List<SettingsVO> empList = service.empList();
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectMem", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectMem(Map<String, Object> map) {
		List<SettingsVO> empList = service.empMemList();
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectMan", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectMan(Map<String, Object> map) {
		List<SettingsVO> empList = service.empManList();
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectAdm", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectAdm(Map<String, Object> map) {
		List<SettingsVO> empList = service.empAdmList();
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectCustom", method = RequestMethod.GET)
	public ResponseEntity<List<SettingsVO>> selectCustom(Map<String, Object> map) {
		log.info("selectCustom()실행...!");
		List<SettingsVO> empList = service.roleList();
		log.info("selectCustom()실행...! : {}", empList);
		
		return new ResponseEntity<List<SettingsVO>>(empList, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/uploadLogo", method = RequestMethod.POST)
	public String register(
			HttpServletRequest req,
			RedirectAttributes ra,
			SettingsVO settingsVO, Model model) {
		log.info("settingsVO : " + settingsVO);
		
		String goPage = "";
		settingsVO.setCusRnum("1028142945");
		
		ServiceResult result = service.updateCus(req, settingsVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다.");
			goPage = "redirect:/settings/list";
		}else {
			model.addAttribute("message", "수정에 실패했습니다1");
			model.addAttribute("settingsVO", settingsVO);
			goPage = "settings/list";
		}
		return goPage;
		}
	
	/////////////////////// 회사 끝 ///////////////////// 휴가 시작 ////////////////////////
	@ResponseBody
	@RequestMapping(value = "/vacCheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> vacCheck(@RequestBody Map<String, String> map) {
		String vacName = map.get("vacName").toString();
//		log.info("넘겨받은 휴가명 : " + vacName);
		ServiceResult result = service.vacCheck(vacName);
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/registerVac", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> registerVac(HttpServletRequest req, SettingsVO settingsVO) {
//		log.info("registerVac @@@@@@@@@@@@@@@@@@@@@@@@@@ : " + settingsVO);
		
		ServiceResult result = service.registerVac(req, settingsVO);
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/delVac", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> deleteVac(@RequestBody Map<String, String> map) {
		
		String vacCode = map.get("vacCode").toString();
//		log.info("vacCode @####### : " + vacCode);
		
		ServiceResult result = service.deleteVac(vacCode);
		
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	/////////////////////// 휴가 끝 ///////////////////// 조직도 시작 ////////////////////////
	
	
	@ResponseBody
	@RequestMapping(value = "/searchList", method = RequestMethod.POST, consumes = "application/json")
	public ResponseEntity<List<TreeVO>> searchList(@RequestBody Map<String, String> map) {
		
		String searchWord = map.get("searchWord");
		
		TreeVO tree = new TreeVO();
		tree.setComName(searchWord);
		
		List<TreeVO> searchList = service.searchList(tree);
		
		return new ResponseEntity<List<TreeVO>>(searchList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/tree", produces = "application/json; charset=utf-8")
    public ResponseEntity<List<TreeVO>> treeList() {
		List<TreeVO> treeList = treeService.getList2();
		log.info("treeList->treeList : " + treeList);
        return new ResponseEntity<List<TreeVO>>(treeList, HttpStatus.OK);
    }
	
	@ResponseBody
	@RequestMapping(value = "/treeUpdate", method = RequestMethod.POST, produces = "application/json; charset=utf-8", consumes = "application/json")
	public ResponseEntity treeUpdate(RedirectAttributes ra, @RequestBody List<TreeVO> treeVO, Model model) {
		log.info("treeVO!!!!!!!!!!!!!!!!! : " + treeVO);
		
		ServiceResult result = service.treeUpdate(treeVO);
		
        return new ResponseEntity(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/pos", produces = "application/json; charset=utf-8")
	public ResponseEntity<List<TreeVO>> treePosList() {
		List<TreeVO> treeList = treeService.getPosList();
		log.info("treeList->treeList : " + treeList);
		return new ResponseEntity<List<TreeVO>>(treeList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/rank", produces = "application/json; charset=utf-8")
	public ResponseEntity<List<TreeVO>> treeLRankList() {
		List<TreeVO> treeList = treeService.getRankList();
		log.info("treeList->treeList : " + treeList);
		return new ResponseEntity<List<TreeVO>>(treeList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/job", produces = "application/json; charset=utf-8")
	public ResponseEntity<List<TreeVO>> treeJobList() {
		List<TreeVO> treeList = treeService.getJobList();
		log.info("treeList->treeList : " + treeList);
		return new ResponseEntity<List<TreeVO>>(treeList, HttpStatus.OK);
	}
	
	/////////////////// 조직도 끝 ///////////////////// 설정 시작 ////////////////////////
	
	@ResponseBody
	@RequestMapping(value = "/insertEmpExcel", method = RequestMethod.POST)
	public ResponseEntity<List<SettingsVO>> insertEmpExcel(
			HttpServletRequest req,
			RedirectAttributes ra,
			SettingsVO settingsVO, Model model) {
		log.info("insertEmpExcel 실행...");
		log.info("파일이름 : "+settingsVO.getEmpListFile());
		int status = service.insertEmpExcel(settingsVO, req);
		
		return new ResponseEntity<List<SettingsVO>>(HttpStatus.OK);
	}
	
	/////////////////// 끝 ///////////////////// 시작 ////////////////////////
	
	@ResponseBody
	@RequestMapping(value = "/registerRole", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> registerRole(HttpServletRequest req, SettingsVO settingsVO) {
		
		ServiceResult result = service.registerRole(req, settingsVO);
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
}
