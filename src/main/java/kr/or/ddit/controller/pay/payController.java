package kr.or.ddit.controller.pay;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
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
import kr.or.ddit.service.pay.IPayService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pay")
public class payController {
	
	@Inject
	private IPayService service;
	@Inject
	private ICommonService commonService;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String payList(Model model, HttpServletRequest request, @RequestBody @RequestParam(value="month",required = false) String month) {
		log.info("@@@@@@@@:" + month);
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("급여", "/pay/list");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		MenuVO menu2 = new MenuVO("내 급여", "/pay/list");
		List<MenuVO> submenuList = Arrays.asList(menu2);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);

		PayVO vo = new PayVO();
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
//		month = Integer.toString(Integer.parseInt(month) -1) ;
		
		vo.setEmpNo(empVO.getEmpNo());
		vo.setMonth(month);

		int yearPay = service.thisYearMyPay(vo);
		PayVO payvo = service.inCalIng(vo);
		vo = service.thisMonthMyPay(vo);
		
		vo.setIncSetAmt(vo.getIncSetAmt());
		vo.setIncSetRes(vo.getIncSetRes());
		vo.setIncSetDedt(vo.getIncSetDedt());
		vo.setYearAmt(yearPay);

//		int workTime = service.getWorkTime(vo);
//		int orgGibonpay = Integer.parseInt(payvo.getGibonpay());	//209시간 근무시 월급
//		if(workTime > 0) {
//			payvo.setGibonpay(Integer.toString((orgGibonpay/209) * workTime));
//		}else {
//			payvo.setGibonpay("0");
//			payvo.setGitapay("0");
//			payvo.setJikpay("0");
//		}
		int gibonPay = vo.getIncSetAmt() - (Integer.parseInt(payvo.getGitapay()) + Integer.parseInt(payvo.getJikpay()));
		vo.setGibonpay(Integer.toString(gibonPay));
		vo.setSadae((int)(vo.getIncSetAmt() * 0.0939));
		vo.setSodeuk(calSodeuk(vo.getIncSetAmt()));
		vo.setGitapay(payvo.getGitapay());
		vo.setJikpay(payvo.getJikpay());
		
		model.addAttribute("vo", vo);
		
		return "pay/list";
	}
	
	@RequestMapping(value = "/myDetailDownload", method = RequestMethod.GET)
	public String myDetailDownload(Model model, HttpServletRequest request, @RequestBody @RequestParam(value="paramMonth",required = false) String month) {
		String str = request.getParameter("paramMonth").toString();
//		log.info("@@@@@@@@str:" + str);
//		log.info("@@@@@@@@:" + month);

		PayVO vo = new PayVO();
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		vo.setEmpNo(empVO.getEmpNo());
		if(month == "월" || month.equals("월")) {
			vo.setMonth(null);
		}else {
			vo.setMonth(month);
		}
//		vo.setMonth(month);
		log.info("vogetMonth : "+vo.getMonth());

//		int yearPay = service.thisYearMyPay(vo);
		PayVO payvo = service.inCalIng(vo);
		vo = service.thisMonthMyPay(vo);
		
		vo.setIncSetAmt(vo.getIncSetAmt());
		vo.setIncSetRes(vo.getIncSetRes());
		vo.setIncSetDedt(vo.getIncSetDedt());
//		vo.setYearAmt(yearPay);
		
		int gibonPay = vo.getIncSetAmt() - (Integer.parseInt(payvo.getGitapay()) + Integer.parseInt(payvo.getJikpay()));
		vo.setGibonpay(Integer.toString(gibonPay));
		vo.setSadae((int)(vo.getIncSetAmt() * 0.0939));
		vo.setSodeuk(calSodeuk(vo.getIncSetAmt()));
		vo.setGitapay(payvo.getGitapay());
		vo.setJikpay(payvo.getJikpay());		
		vo.setEmpNo(empVO.getEmpNo());
		if(month == "월" || month.equals("월")) {
			vo.setMonth(null);
		}else {
			vo.setMonth(month);
		}

		
		model.addAttribute("vo", vo);
		log.info("vo : "+vo);
		
		return "pay/myDetailDownload";
	}
	
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_MEMBER')")
	@RequestMapping(value = "/list3", method = RequestMethod.POST)
	public Map<String,PayVO> payList3(Model model, HttpServletRequest request, @RequestBody Map<String,String> map) {
		Map rtnMap = new HashMap();
//		log.info("3333@@@@@@@@:" + map.get("month"));
		PayVO vo = new PayVO();
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		vo.setEmpNo(empVO.getEmpNo());
		vo.setMonth(map.get("month"));

		int yearPay = service.thisYearMyPay(vo);
		PayVO payvo = service.inCalIng(vo);
		vo = service.thisMonthMyPay(vo);
		
		vo.setIncSetAmt(vo.getIncSetAmt());
		vo.setIncSetRes(vo.getIncSetRes());
		vo.setIncSetDedt(vo.getIncSetDedt());
		vo.setYearAmt(yearPay);

		int gibonPay = vo.getIncSetAmt() - (Integer.parseInt(payvo.getGitapay()) + Integer.parseInt(payvo.getJikpay()));
		vo.setGibonpay(Integer.toString(gibonPay));
		vo.setSadae((int)(vo.getIncSetAmt() * 0.0939));
		vo.setSodeuk(calSodeuk(vo.getIncSetAmt()));
		vo.setGitapay(payvo.getGitapay());
		vo.setJikpay(payvo.getJikpay());
		
		rtnMap.put("incSetAmt", vo.getIncSetAmt());
		rtnMap.put("incSetRes", vo.getIncSetRes());
		rtnMap.put("incSetDedt", vo.getIncSetDedt());
		
		rtnMap.put("gibonpay", vo.getGibonpay());
		rtnMap.put("sadae", vo.getSadae());
		rtnMap.put("sodeuk", vo.getSodeuk());
		rtnMap.put("gitapay", payvo.getGitapay());
		rtnMap.put("jikpay", payvo.getJikpay());
		rtnMap.put("month", map.get("month"));
		
		log.info("return VO1 : "+vo.getIncSetAmt());
		log.info("return VO2 : "+vo.getIncSetRes());
		log.info("return VO3 : "+vo.getIncSetDedt());
		log.info("rtnMap : "+rtnMap);
		
		return rtnMap;
	}
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/pastDetail", method = RequestMethod.POST)
	public Map<String,PayVO> pastDetail(Model model, HttpServletRequest request, @RequestBody Map<String,String> map) {
		Map rtnMap = new HashMap();
//		log.info("pastDetail@@@@@@@:" + map.get("month"));
//		log.info("pastDetail@@@@@@@:" + map.get("empNo"));
		PayVO vo = new PayVO();
		
		vo.setEmpNo(map.get("empNo"));
		vo.setMonth(map.get("month"));
		
//		int yearPay = service.thisYearMyPay(vo);
		PayVO payvo = service.inCalIng(vo);
		vo = service.thisMonthMyPay(vo);
		
		vo.setIncSetAmt(vo.getIncSetAmt());
		vo.setIncSetRes(vo.getIncSetRes());
		vo.setIncSetDedt(vo.getIncSetDedt());
//		vo.setYearAmt(yearPay);
		
		int gibonPay = vo.getIncSetAmt() - (Integer.parseInt(payvo.getGitapay()) + Integer.parseInt(payvo.getJikpay()));
		vo.setGibonpay(Integer.toString(gibonPay));
		vo.setSadae((int)(vo.getIncSetAmt() * 0.0939));
		vo.setSodeuk(calSodeuk(vo.getIncSetAmt()));
		vo.setGitapay(payvo.getGitapay());
		vo.setJikpay(payvo.getJikpay());
		
		rtnMap.put("incSetAmt", vo.getIncSetAmt());
		rtnMap.put("incSetRes", vo.getIncSetRes());
		rtnMap.put("incSetDedt", vo.getIncSetDedt());
		
		rtnMap.put("gibonpay", vo.getGibonpay());
		rtnMap.put("sadae", vo.getSadae());
		rtnMap.put("sodeuk", vo.getSodeuk());
		rtnMap.put("gitapay", payvo.getGitapay());
		rtnMap.put("jikpay", payvo.getJikpay());
		rtnMap.put("month", map.get("month"));
		
		log.info("return VO1 : "+vo.getIncSetAmt());
		log.info("return VO2 : "+vo.getIncSetRes());
		log.info("return VO3 : "+vo.getIncSetDedt());
		log.info("rtnMap : "+rtnMap);
		
		return rtnMap;
	}
	
	//<- 사원/////////////////////////////////////////////////////////////관리자 ->
	
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String payHome (Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("급여정산", "/pay/home");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("정산 메뉴", "/pay/home");
		MenuVO menu3 = new MenuVO("정산", "/pay/inCal");
		MenuVO menu4 = new MenuVO("퇴직금 정산", "/pay/outCal");
		MenuVO menu5 = new MenuVO("중간 정산자 목록", "/pay/middleCal");
		List<MenuVO> submenuList = Arrays.asList(menu2, menu3, menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		List<EmpVO> empList = service.list();
		
		model.addAttribute("list", empList);
		
		return "pay/home";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/inCal", method = RequestMethod.GET)
	public String payHomeInCal (Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("급여정산", "/pay/home");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu2 = new MenuVO("정산 메뉴", "/pay/home");
		MenuVO menu3 = new MenuVO("정산", "/pay/inCal");
		MenuVO menu4 = new MenuVO("퇴직금 정산", "/pay/outCal");
		MenuVO menu5 = new MenuVO("중간 정산자 목록", "/pay/middleCal");
		List<MenuVO> submenuList = Arrays.asList(menu2, menu3, menu4, menu5);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		
		List<EmpVO> empList = service.list();
//		
		return "pay/inCal";
	}
	
	@ResponseBody
	@RequestMapping(value = "/inCalList", method = RequestMethod.GET)
	public ResponseEntity<List<PayVO>> empList(Map<String, Object> map) {
		
//		log.info("inCalList 실행");
		
		List<PayVO> payList = service.inCalList();
		
		return new ResponseEntity<List<PayVO>>(payList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchList", method = RequestMethod.POST, consumes = "application/json")
	public ResponseEntity<List<PayVO>> searchList(@RequestBody Map<String, String> map) {
		
		String searchWord = map.get("searchWord");
		
		PayVO pay = new PayVO();
		pay.setEmpName(searchWord);
		
		List<PayVO> searchList = service.searchList(pay);
		
		return new ResponseEntity<List<PayVO>>(searchList, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value = "/startInCal", method = RequestMethod.GET)
	public ResponseEntity<List<PayVO>> startInCal(Map<String, Object> map) {

		log.info("startInCal 실행");
		
		List<PayVO> payList = service.inCalList();
		
		return new ResponseEntity<List<PayVO>>(payList, HttpStatus.OK);
	}
	
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/inCalIng", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<List<PayVO>> inCalIng(@RequestBody List<PayVO> list) {

//		log.info("inCalIng 실행");
		
		List<PayVO> tempList = new ArrayList<PayVO>();
		
		for(PayVO pay : list) {
			int workTime = service.getWorkTime(pay);
			log.info(pay.getEmpNo() +"'s work time : " + workTime);
			PayVO payvo = service.inCalIng(pay);
			int orgGibonpay = Integer.parseInt(payvo.getGibonpay());	//209시간 근무시 월급
			if(workTime > 0) {
				payvo.setGibonpay(Integer.toString((orgGibonpay/209) * workTime));
			}else {
				payvo.setGibonpay("0");
				payvo.setGitapay("0");
				payvo.setJikpay("0");
			}
			payvo.setIncSetAmt(Integer.parseInt(payvo.getGibonpay())+Integer.parseInt(payvo.getGitapay())+Integer.parseInt(payvo.getJikpay()));
			payvo.setSadae((int)(payvo.getIncSetAmt() * 0.0939));
			payvo.setSodeuk(calSodeuk(payvo.getIncSetAmt()));
			payvo.setIncSetDedt(payvo.getSadae() + payvo.getSodeuk());
			payvo.setIncSetRes(payvo.getIncSetAmt() - payvo.getIncSetDedt());
			payvo.setWorkTime(workTime);
			tempList.add(payvo);
		}

		log.info("tempList : " + tempList);
		return new ResponseEntity<List<PayVO>>(tempList, HttpStatus.OK);
	}
		@ResponseBody
		@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
		@RequestMapping(value = "/inPaying", method = RequestMethod.POST, consumes = "application/json")
		public ResponseEntity<List<PayVO>> inPaying(@RequestBody List<PayVO> list) {
			
//			log.info("inPaying 실행");
//			
//			
			for(PayVO pay : list) {
				service.inPaying(pay);
			}
			
			log.info("list : " + list);
			return new ResponseEntity<List<PayVO>>(HttpStatus.OK);
		}
		
		@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
		@RequestMapping(value = "/outCal", method = RequestMethod.GET)
		public String payHomeOutCal (Model model, HttpServletRequest request) {
			
			// 메인메뉴 리스트
			MenuVO menu1 = new MenuVO("급여정산", "/pay/home");
			List<MenuVO> menuList = Arrays.asList(menu1);
			model.addAttribute("menuList", menuList);
			
			// 서브메뉴 리스트
			MenuVO menu2 = new MenuVO("정산 메뉴", "/pay/home");
			MenuVO menu3 = new MenuVO("정산", "/pay/inCal");
			MenuVO menu4 = new MenuVO("퇴직금 정산", "/pay/outCal");
			MenuVO menu5 = new MenuVO("중간 정산자 목록", "/pay/middleCal");
			List<MenuVO> submenuList = Arrays.asList(menu2, menu3, menu4, menu5);
			model.addAttribute("submenuList", submenuList);
			
			String currentURL = request.getRequestURI();
			request.setAttribute("currentURL", currentURL);
			
			
			List<EmpVO> empList = service.list();
//			
			return "pay/outCal";
		}
		
		@ResponseBody
		@RequestMapping(value = "/outCalList", method = RequestMethod.GET)
		public ResponseEntity<List<PayVO>> outCalList(Map<String, Object> map) {
			
//			log.info("inCalList 실행");
			
			List<PayVO> payList = service.outCalList();
			
			return new ResponseEntity<List<PayVO>>(payList, HttpStatus.OK);
		}
		
		@ResponseBody
		@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
		@RequestMapping(value = "/outCalIng", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
		public ResponseEntity<List<PayVO>> outCalIng(@RequestBody List<PayVO> list) {

//			log.info("outCalIng 실행");
			
			List<PayVO> tempList = new ArrayList<PayVO>();
			
			for(PayVO pay : list) {
				int threeMonthPay = service.get3monthPay(pay);
				int workDays = service.getWorkDays(pay);
				double oneDayAvgPay = threeMonthPay/91;
				
//				int workTime = service.getWorkTime(pay);
//				log.info(pay.getEmpNo() +"'s work time : " + workTime);
				PayVO payvo = service.inCalIng(pay);

				payvo.setOneDayAvgPay(oneDayAvgPay);
				payvo.setIncSetRes((int) (((oneDayAvgPay*30)*workDays)/365));
				payvo.setWorkDays(workDays);
				payvo.setThreeMonthPay(threeMonthPay);
				tempList.add(payvo);
			}

			log.info("tempList : " + tempList);
			return new ResponseEntity<List<PayVO>>(tempList, HttpStatus.OK);
		}
		
		@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
		@RequestMapping(value = "/middleCal", method = RequestMethod.GET)
		public String payHomeMiddleCal (Model model, HttpServletRequest request) {
			
			// 메인메뉴 리스트
			MenuVO menu1 = new MenuVO("급여정산", "/pay/home");
			List<MenuVO> menuList = Arrays.asList(menu1);
			model.addAttribute("menuList", menuList);
			
			// 서브메뉴 리스트
			MenuVO menu2 = new MenuVO("정산 메뉴", "/pay/home");
			MenuVO menu3 = new MenuVO("정산", "/pay/inCal");
			MenuVO menu4 = new MenuVO("퇴직금 정산", "/pay/outCal");
			MenuVO menu5 = new MenuVO("중간 정산자 목록", "/pay/middleCal");
			List<MenuVO> submenuList = Arrays.asList(menu2, menu3, menu4, menu5);
			model.addAttribute("submenuList", submenuList);
			
			String currentURL = request.getRequestURI();
			request.setAttribute("currentURL", currentURL);
			
			
			List<EmpVO> empList = service.list();
//			
			return "pay/middleCal";
		}
		
		@ResponseBody
		@RequestMapping(value = "/middleCalList", method = RequestMethod.GET)
		public ResponseEntity<List<PayVO>> middleCalList(Map<String, Object> map) {
			
//			log.info("inCalList 실행");
			
			List<PayVO> payList = service.middleCalList();
			
			return new ResponseEntity<List<PayVO>>(payList, HttpStatus.OK);
		}
		
		@ResponseBody
		@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
		@RequestMapping(value = "/middleCalIng", method = RequestMethod.POST)
		public List middleCalIng(Model model, HttpServletRequest request, @RequestBody Map<String,String> map) {
			List list = new ArrayList();
			Map rtnMap = new HashMap();
			PayVO vo = new PayVO();
			
			vo.setEmpNo(map.get("empNo"));
			vo.setMonth(map.get("month"));
			
			PayVO payvo = service.inCalIng(vo);
			PayVO payvo2 = service.middleCalIng(vo);
			PayVO payvo3 = service.thisMonthMyPay(vo);
//			PayVO2 vo2 = service
			
			vo.setIncSetAmt(payvo3.getIncSetAmt());
			vo.setIncSetRes(payvo3.getIncSetRes());
			vo.setIncSetDedt(payvo3.getIncSetDedt());
//			vo.setYearAmt(yearPay);
			
			int gibonPay = vo.getIncSetAmt() - (Integer.parseInt(payvo.getGitapay()) + Integer.parseInt(payvo.getJikpay()));
			vo.setGibonpay(Integer.toString(gibonPay));
			vo.setSadae((int)(vo.getIncSetAmt() * 0.0939));
			vo.setSodeuk(calSodeuk(vo.getIncSetAmt()));
			vo.setGitapay(payvo.getGitapay());
			vo.setJikpay(payvo.getJikpay());
			
			rtnMap.put("incSetAmt", vo.getIncSetAmt());
			rtnMap.put("incSetRes", vo.getIncSetRes());
			rtnMap.put("incSetDedt", vo.getIncSetDedt());
			
			rtnMap.put("gibonpay", vo.getGibonpay());
			rtnMap.put("sadae", vo.getSadae());
			rtnMap.put("sodeuk", vo.getSodeuk());
			rtnMap.put("gitapay", payvo.getGitapay());
			rtnMap.put("jikpay", payvo.getJikpay());
			
//			SimpleDateFormat format =new SimpleDateFormat("yyyy-MM-dd");
//			rtnMap.put("incSetRdate", format.format(payvo2.getIncSetRdate()));
			String rdate = payvo2.getIncSetRdate();
			String[] rdate1 = rdate.split(" ");
			rtnMap.put("incSetRdate", rdate1[0]);
			rtnMap.put("empName", payvo2.getEmpName());
			rtnMap.put("empNo", payvo2.getEmpNo());

//			log.info("payvo : "+payvo);
//			log.info("vo : "+vo);
//			log.info("rtnMap : "+rtnMap);
			
			list.add(rtnMap);
			return list;
		}
	////////////////////////////////////////////////////////////////////////
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "/past", method = RequestMethod.GET)
	public String payPast(Model model, HttpServletRequest request) {
		
		// 메인메뉴 리스트
		MenuVO menu1 = new MenuVO("지난 정산 내역", "/pay/past");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		// 서브메뉴 리스트
		MenuVO menu4 = new MenuVO("지난 정산 내역 조회", "/pay/past");
		List<MenuVO> submenuList = Arrays.asList(menu4);
		model.addAttribute("submenuList", submenuList);
		
		String currentURL = request.getRequestURI();
		request.setAttribute("currentURL", currentURL);
		
		List<EmpVO> empList = service.list();
		model.addAttribute("list", empList);
		
		return "pay/past";
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	private int calSodeuk(int incSetAmt) {
		int value = 0;
		if(incSetAmt > 1000000000) {
			value = (int) (incSetAmt * 0.45);
		}else if(incSetAmt > 500000000) {
			value = (int) (incSetAmt * 0.42);
		}else if(incSetAmt > 300000000) {
			value = (int) (incSetAmt * 0.40);
		}else if(incSetAmt > 150000000) {
			value = (int) (incSetAmt * 0.38);
		}else if(incSetAmt > 88000000) {
			value = (int) (incSetAmt * 0.35);
		}else if(incSetAmt > 46000000) {
			value = (int) (incSetAmt * 0.24);
		}else if(incSetAmt > 12000000) {
			value = (int) (incSetAmt * 0.15);
		}else {
			value = (int) (incSetAmt * 0.06);
		}
		return value;
	}
	
	@Scheduled(cron = "0 1 0 1 * *")
	public void newEmpList () {
		//매월 1일 0시 1분 0초 실행
		List<PayVO> empList = service.newEmpList();
		
		for (PayVO vo : empList) {
			service.insertNewMonth(vo);
		}
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////
}
