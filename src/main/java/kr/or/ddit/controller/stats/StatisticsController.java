package kr.or.ddit.controller.stats;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.service.stats.IStatsService;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.StatsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/stats")
public class StatisticsController {

	@Inject
	private IStatsService statsService;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String statistics(Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("경영관리", "/stats/list");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		MenuVO menu2 = new MenuVO("경영지표", "/stats/list");
		List<MenuVO> submenuList = Arrays.asList(menu2);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		log.info("statistics() 실행~~~~~");
		
		// 성별
		List<StatsVO> genderRateList = statsService.selectGenderRate();
		model.addAttribute("genderRateList", genderRateList);
		
		// 채용
		List<StatsVO> recuritList = statsService.selectRecruitYear();
		model.addAttribute("recuritList", recuritList);
	
		
		return "stats/list";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/genderchart", method = RequestMethod.POST)
	public String genderRateChart(Model model) {
		log.info("genderRateChart() 실행~~~~~");
		
		List<StatsVO> list = statsService.selectGenderRate();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<StatsVO> it = list.iterator();
		while(it.hasNext()) {
			StatsVO statsVO = it.next();
			JsonObject object = new JsonObject();
			String empGen = statsVO.getEmpGen();
			int cnt = statsVO.getGenCnt();
			int ratio = statsVO.getGenRatio();
			
			object.addProperty("empGen", empGen);
			object.addProperty("cnt", cnt);
			object.addProperty("ratio", ratio);
			jArray.add(object);
			
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/recruityearchart", method = RequestMethod.POST)
	public String RecruitYearChart(Model model) {
		log.info("RecruitYearChart() 실행~~~~~");
		
		List<StatsVO> list = statsService.selectRecruitYear();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<StatsVO> it = list.iterator();
		while(it.hasNext()) {
			StatsVO statsVO = it.next();
			JsonObject object = new JsonObject();
			String year = statsVO.getYear();
			int totalCnt = statsVO.getTotalCnt();
			int newCnt = statsVO.getNewCnt();
			int carCnt = statsVO.getCarCnt();
			
			object.addProperty("year", year);
			object.addProperty("totalCnt", totalCnt);
			object.addProperty("newCnt", newCnt);
			object.addProperty("carCnt", carCnt);
			jArray.add(object);
		
		}
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/workinfochart", method = RequestMethod.POST)
	public String workInfoChart(Model model) {
		log.info("workInfoChart() 실행~~~~~");
		
		List<StatsVO> list = statsService.selectWorkInfo();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Iterator<StatsVO> it = list.iterator();
		while(it.hasNext()) {
			StatsVO statsVO = it.next();
			JsonObject object = new JsonObject();
			String empNo = statsVO.getEmpNo();
			int totalWork = statsVO.getTotalWork();
			
//			Date dt = statsVO.getWorkStime();
//			String workStime = df.format(dt);
			
//			String format = "yyyy-MM-dd";
//			SimpleDateFormat sdf = new SimpleDateFormat(format);
			
			object.addProperty("empNo", empNo);
			object.addProperty("totalWork", totalWork);
//			object.addProperty("workStime", workStime);
			jArray.add(object);
		
		}
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	
	
}
