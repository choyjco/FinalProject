package kr.or.ddit.controller.home;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.common.ICommonService;
import kr.or.ddit.service.home.IHomeService;
import kr.or.ddit.service.work.IWorkService;
import kr.or.ddit.vo.GridVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/home")
@Controller
public class HomeController {
	
	@Inject
	private IHomeService homeService;
	@Inject
	private IWorkService workService;
	
	/** 메인화면을 접속하는 컨트롤러
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/feed", method = RequestMethod.GET)
	public String feed(Model model) {
		log.info("feed() 실행...!");
		
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
		
		model.addAttribute("currentURL", "/home/feed");
		
		return "home/feed";
	}
	
	/**	출퇴근 시간을 조회하는 컨트롤러
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/work", method = RequestMethod.GET)
	public WorkVO work() {
		log.info("work() 실행...!");
		WorkVO workVO = workService.selectoneWork();
		if(workVO == null) {
			workVO = new WorkVO();
			workVO.setWorkNo("null");
		}
		return workVO;
	}
	
	/** 출근버튼을 눌렀을때 작동하는 컨트롤러
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/workStart", method = RequestMethod.GET)
	public WorkVO workStart() {
		log.info("workStart() 실행...!");
		WorkVO workVO = workService.insertworkStart();
		return workVO;
	}
	
	/** 퇴근버튼을 눌렀을때 작동하는 컨트롤러
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/workEnd", method = RequestMethod.GET)
	public WorkVO workEnd() {
		log.info("workEnd() 실행...!");
		WorkVO workVO = workService.updateworkEnd();
		return workVO;
	}
	
	/**	포틀릿 위치 정보를 가져오는 컨트롤러
	 * @return 위치값 json
	 */
	@ResponseBody
	@RequestMapping(value = "/gridstack", method = RequestMethod.GET)
	public List<Map<String, Object>> gridstack() {
		log.info("gridstack() 실행...!");
		
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<>();
		
		List<GridVO> gridList = homeService.selectGrid();
		
		for(GridVO grid : gridList) {
			hash.put("x", grid.getX());
			hash.put("y", grid.getY());
			hash.put("w", grid.getW());
			hash.put("h", grid.getH());
			hash.put("content", grid.getContent());
			hash.put("id", grid.getId());
			hash.put("noMove", grid.getNoMove());
			
			jsonObj = new JSONObject(hash);
			jsonArr.add(jsonObj);
		}
		log.info("jsonArrCheck:{}",jsonArr);
		
		return jsonArr;
	}
	
	/** 포틀릿 위치값을 업데이트하는 메소드
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/gridstack/update", method = RequestMethod.POST)
	public ServiceResult gridstackupdate(@RequestBody List<GridVO> param) {
		log.info("gridstackupdate() 실행...!");
 		
		ServiceResult result = homeService.updateGrid(param);
		
		return result;
	}
	
}
