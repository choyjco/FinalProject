package kr.or.ddit.controller.main;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.main.IMainAdminService;
import kr.or.ddit.service.main.IMainService;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainAdminController {
	
	@Inject
	private IMainAdminService mainAdminService;
	
	
	String goPage = "";
//	CustomerVO customerVO = (CustomerVO) session.getAttribute("SessionInfo");
//	if(customerVO.getCusRnum().equals("admin")) {
//		goPage = "mainhome/mypageAdmin";
//	}else {
//		ra.addFlashAttribute("message", "권한이 없습니다!");
//		goPage = "redirect:/main";
//	}
//	
//	return goPage;
	
	/**
	 * 판매페이지 회원 목록(관리자)
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mypageadmin/customerlist", method = RequestMethod.GET)
	public String customerList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session, RedirectAttributes ra) {
		log.info("customerList() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			PaginationInfoVO<CustomerVO> pagingVO = new PaginationInfoVO<CustomerVO>();
			
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchType", searchType);
				model.addAttribute("searchWord", searchWord);
			}
			
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = mainAdminService.selectCustomerCount(pagingVO);
			
			pagingVO.setTotalRecord(totalRecord);
			List<CustomerVO> customerList = mainAdminService.selectCustomerList(pagingVO);
			pagingVO.setDataList(customerList);
			
			model.addAttribute("pagingVO", pagingVO);
			goPage = "mainhome/customerList";
			
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	@RequestMapping(value = "/mypageadmin/customerdetail", method = RequestMethod.GET)
	public String customerDetail(
			String cusRnum, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("customerDetail() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			CustomerVO customerVO = mainAdminService.selectCustomer(cusRnum);
			log.info("확인용!!!!!!!!!!!!!" + customerVO.getCusRnum());
			model.addAttribute("customer", customerVO);
			goPage = "mainhome/customerDetail";
			
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
	
	// 기능 리스트 화면(관리자)
	@RequestMapping(value = "/mypageadmin/funclist", method = RequestMethod.GET)
	public String funcInfo(Model model, HttpSession session, RedirectAttributes ra) {
		log.info("funcInfo() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			List<FuncInfoVO> funcInfoList = mainAdminService.selectFuncList();
			model.addAttribute("funcInfoList", funcInfoList);
			goPage = "mainhome/funcList";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	// 기능 추가 양식
	@RequestMapping(value = "/mypageadmin/funcform", method = RequestMethod.GET)
	public String funcInsertForm(HttpSession session, RedirectAttributes ra) {
		log.info("funcInsertForm() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			goPage = "mainhome/funcForm";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}

	// 기능 추가
	@RequestMapping(value = "/mypageadmin/funcinsert", method = RequestMethod.POST)
	public String levelInsert(
			HttpServletRequest req, 
			HttpSession session, 
			RedirectAttributes ra,
			FuncInfoVO funcInfoVO, Model model) {
		log.info("levelInsert() 실행~~~~~");

		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");

		if(customer != null) {
			ServiceResult result = mainAdminService.insertFunc(req, funcInfoVO);
			if (result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "기능이 추가되었습니다!");
				goPage = "redirect:/mypageadmin/funcdetail?funcName=" + funcInfoVO.getFuncName();
				log.info("등록잘됨!!!!!!!!!!!!");
			} else {
				model.addAttribute("message", "서버오류입니다. 다시 시도해주세요!");
				goPage = "mainhome/funcForm";
				log.info("등록 서버오류~~~~~~~~~~~~~");
			}
			
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
		
	}
	
	// 기능 상세보기
	@RequestMapping(value = "/mypageadmin/funcdetail", method = RequestMethod.GET)
	public String funcDetail(String funcName, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("funcDetail() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");

		if(customer != null) {
			FuncInfoVO funcInfoVO = mainAdminService.selectFunc(funcName);
			model.addAttribute("funcInfo", funcInfoVO);
			log.info("상세 값 확인!!!!!!" + funcName);
			goPage = "mainhome/funcDetail";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	// 기능 수정 화면
	@RequestMapping(value = "/mypageadmin/funcupdate", method = RequestMethod.GET)
	public String funcUpdateForm(String funcName, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("funcUpdateForm() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			FuncInfoVO funcInfoVO = mainAdminService.selectFunc(funcName);
			model.addAttribute("funcInfo", funcInfoVO);
			model.addAttribute("status", "u");
			goPage = "mainhome/funcForm";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	// 기능 수정
	@RequestMapping(value = "/mypageadmin/funcupdate", method = RequestMethod.POST)
	public String funcUpdate(
			HttpServletRequest req,
			RedirectAttributes ra, 
			FuncInfoVO funcInfoVO, Model model) {
		log.info("funcUpdate() 실행~~~~~");
		String goPage = "";
		ServiceResult result = mainAdminService.updateFunc(req, funcInfoVO);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
			goPage = "redirect:/mypageadmin/funcdetail?funcName=" + funcInfoVO.getFuncName();
		} else {
			model.addAttribute("message", "수정에 실패하였습니다.");
			model.addAttribute("funcInfo", funcInfoVO);
			model.addAttribute("status", "u");
			goPage = "mainhome/funcForm";
		}
		return goPage;
	}
	
	// 기능 삭제
	@RequestMapping(value = "/mypageadmin/funcdelete", method = RequestMethod.POST)
	public String funcDelete(HttpServletRequest req, RedirectAttributes ra, String funcName, Model model) {
		log.info("funcDelete() 실행~~~~~");

		String goPage = "";
		ServiceResult result = mainAdminService.deleteFunc(req, funcName);
		log.info("삭제값확인!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@" + funcName);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다!");
			goPage = "redirect:/mypageadmin/funclist";
		} else {
			ra.addFlashAttribute("message", "삭제 권한이 없습니다.");
			goPage = "redirect:/mypageadmin/funcdetail?funcName=" + funcName;

		}

		return goPage;
	}

	// 레벨 리스트 화면(관리자)
	@RequestMapping(value = "/mypageadmin/levellist", method = RequestMethod.GET)
	public String levelList(Model model, HttpSession session, RedirectAttributes ra) {
		log.info("levelList() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			List<LevelInfoVO> levelInfoList = mainAdminService.selectLevelList();
			model.addAttribute("levelInfoList", levelInfoList);
			goPage = "mainhome/levelList";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}

	// 레벨 추가 양식
	@RequestMapping(value = "/mypageadmin/levelform", method = RequestMethod.GET)
	public String levelInsertForm(HttpSession session, RedirectAttributes ra) {
		log.info("levelInsertForm() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			goPage = "mainhome/levelForm";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}

	// 레벨 추가
	@RequestMapping(value = "/mypageadmin/levelinsert", method = RequestMethod.POST)
	public String levelInsert(
			HttpServletRequest req, 
			HttpSession session, 
			RedirectAttributes ra,
			LevelInfoVO levelInfoVO, Model model) {
		log.info("levelInsert() 실행~~~~~");
		String goPage = "";

		ServiceResult result = mainAdminService.insertLevel(req, levelInfoVO);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "기능이 추가되었습니다!");
			goPage = "redirect:/mypageadmin/leveldetail?levelName=" + levelInfoVO.getLevelName();
			log.info("등록잘됨!!!!!!!!!!!!");
		} else {
			model.addAttribute("message", "서버오류입니다. 다시 시도해주세요!");
			goPage = "mainhome/levelForm";
			log.info("등록 서버오류~~~~~~~~~~~~~");

		}
		return goPage;
	}
	
	// 레벨 상세보기
	@RequestMapping(value = "/mypageadmin/leveldetail", method = RequestMethod.GET)
	public String levelDetail(String levelName, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("levelDetail() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			LevelInfoVO levelInfoVO = mainAdminService.selectLevel(levelName);
			model.addAttribute("levelInfo", levelInfoVO);
			log.info("상세 값 확인!!!!!!" + levelName);
			goPage = "mainhome/levelDetail";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
	
	// 레벨 수정 화면
	@RequestMapping(value = "/mypageadmin/levelupdate", method = RequestMethod.GET)
	public String levelUpdateForm(String levelName, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("levelUpdateForm() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			LevelInfoVO levelInfoVO = mainAdminService.selectLevel(levelName);
			model.addAttribute("levelInfo", levelInfoVO);
			model.addAttribute("status", "u");
			goPage = "mainhome/levelForm";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}

	// 레벨 수정
	@RequestMapping(value = "/mypageadmin/levelupdate", method = RequestMethod.POST)
	public String levelUpdate(
			HttpServletRequest req,
			RedirectAttributes ra, 
			LevelInfoVO levelInfoVO, Model model) {
		log.info("levelUpdate() 실행~~~~~");
		String goPage = "";
		ServiceResult result = mainAdminService.updateLevel(req, levelInfoVO);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
			goPage = "redirect:/mypageadmin/leveldetail?levelName=" + levelInfoVO.getLevelName();
		} else {
			model.addAttribute("message", "수정에 실패하였습니다.");
			model.addAttribute("levelInfo", levelInfoVO);
			model.addAttribute("status", "u");
			goPage = "mainhome/levelForm";
		}
		return goPage;
	}
	
	// 레벨 삭제
	@RequestMapping(value = "/mypageadmin/leveldelete", method = RequestMethod.POST)
	public String levelDelete(HttpServletRequest req, RedirectAttributes ra, String levelName, Model model) {
		log.info("levelDelete() 실행~~~~~");

		String goPage = "";
		ServiceResult result = mainAdminService.deleteLevel(req, levelName);
		log.info("삭제값확인!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@" + levelName);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다!");
			goPage = "redirect:/mypageadmin/levellist";
		} else {
			ra.addFlashAttribute("message", "삭제 권한이 없습니다.");
			goPage = "redirect:/mypageadmin/leveldetail?levelName=" + levelName;

		}

		return goPage;
	}
	
	// 구매 회원 관리(관리자)
	@RequestMapping(value = "/mypageadmin/purchaselist", method = RequestMethod.GET)
	public String purchaseList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session, RedirectAttributes ra) {
		log.info("purchaseList() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			PaginationInfoVO<CustomerVO> pagingVO = new PaginationInfoVO<CustomerVO>();
			
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchType", searchType);
				model.addAttribute("searchWord", searchWord);
			}
			
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = mainAdminService.selectPaymentCount(pagingVO);
			
			pagingVO.setTotalRecord(totalRecord);
			List<CustomerVO> paymentList = mainAdminService.selectPaymentList(pagingVO);
			pagingVO.setDataList(paymentList);
			
			log.info("paymentList.size() => {}", paymentList.size());
			
			model.addAttribute("pagingVO", pagingVO);
			goPage = "mainhome/purchaseManageList";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
	
	// 구매 회원 관리 상세보기
	@RequestMapping(value = "/mypageadmin/purchasedetail", method = RequestMethod.GET)
	public String purchaseDetail(String payCode, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("purchaseDetail() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			CustomerVO customerVO = mainAdminService.selectPayment(payCode);
			model.addAttribute("customerVO", customerVO);
			model.addAttribute("funcLevelList", customerVO.getPaymentVO().getFuncLevelList());
			log.info("상세 값 확인!!!!!!" + payCode);
			goPage = "mainhome/purchaseManageDetail";
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}	
	
	// 통계내기
	@RequestMapping(value = "/mypageadmin/statsadmin", method = RequestMethod.GET)
	public String statsAdmin(Model model, HttpSession session, RedirectAttributes ra) {
		log.info("statsAdmin() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			List<PaymentVO> levelList = mainAdminService.selectLevelName();
			model.addAttribute("levelList", levelList);
			
			List<PaymentVO> funcList = mainAdminService.selectFuncName();
			model.addAttribute("funcList", funcList);
			
			List<PaymentVO> salesList = mainAdminService.selectSales();
			model.addAttribute("salesList", salesList);
			
			goPage = "mainhome/statsAdmin";
			
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
	
	
	// 차트
	@ResponseBody
	@RequestMapping(value = "/levelchart", method = RequestMethod.POST)
	public String levelChart(Model model) {
		log.info("levelChart() 실행~~~~~");
		
		List<PaymentVO> list = mainAdminService.selectLevelName();
		
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Iterator<PaymentVO> it = list.iterator();
		while(it.hasNext()) {
			PaymentVO paymentVO = it.next();
			JsonObject object = new JsonObject();
			String levelName = paymentVO.getLevelName();
			int cnt = paymentVO.getLevelCnt();
			int ratio = paymentVO.getLevelRatio();
			
//			Date dt = paymentVO.getPayDate();
//			String payDate = df.format(dt);
			
			object.addProperty("levelName", levelName);
			object.addProperty("cnt", cnt);
			object.addProperty("ratio", ratio);
//			object.addProperty("payDate", payDate);
			jArray.add(object);
			
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
		
	@ResponseBody
	@RequestMapping(value = "/funcchart", method = RequestMethod.POST)
	public String funcChart(Model model) {
		log.info("funcChart() 실행~~~~~");
		
		List<PaymentVO> list = mainAdminService.selectFuncName();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<PaymentVO> it = list.iterator();
		while(it.hasNext()) {
			PaymentVO paymentVO = it.next();
			JsonObject object = new JsonObject();
			String funcMemo = paymentVO.getFuncMemo();
			int cnt = paymentVO.getFuncCnt();
			int ratio = paymentVO.getFuncRatio();
			
			object.addProperty("funcMemo", funcMemo);
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
	@RequestMapping(value = "/saleschart", method = RequestMethod.POST)
	public String salesChart(Model model) {
		log.info("salesChart() 실행~~~~~");
		
		List<PaymentVO> list = mainAdminService.selectSales();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<PaymentVO> it = list.iterator();
		while(it.hasNext()) {
			PaymentVO paymentVO = it.next();
			JsonObject object = new JsonObject();
			long totalCnt = paymentVO.getTotalCnt();
			String month = paymentVO.getMonth();
			int salesCnt = paymentVO.getSalesCnt();
			
			object.addProperty("totalCnt", totalCnt);
			object.addProperty("month", month);
			object.addProperty("salesCnt", salesCnt);
			jArray.add(object);
			
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/cusempchart", method = RequestMethod.POST)
	public String cusEmpChart(Model model) {
		log.info("cusEmpChart() 실행~~~~~");
		
		List<CustomerVO> list = mainAdminService.selectCusEmp();
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
		Iterator<CustomerVO> it = list.iterator();
		while(it.hasNext()) {
			CustomerVO customerVO = it.next();
			JsonObject object = new JsonObject();
			
			String cusEmpRange = customerVO.getCusEmpRange();
			int empCnt = customerVO.getEmpCnt();
			int cusEmp = customerVO.getCusEmp();
			
			
			object.addProperty("cusEmpRange", cusEmpRange);
			object.addProperty("empCnt", empCnt);
			object.addProperty("cusEmp", cusEmp);
			jArray.add(object);
			
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	// 판매페이지 문의게시판 리스트
	@RequestMapping(value = "/mypageadmin/adminboard", method = RequestMethod.GET)
	public String adminBoard(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session, RedirectAttributes ra) {
		
		log.info("adminBoard() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			PaginationInfoVO<InqBoardVO> pagingVO = new PaginationInfoVO<InqBoardVO>();
			
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchType", searchType);
				model.addAttribute("searchWord", searchWord);
			}
			
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = mainAdminService.selectBoardCount(pagingVO);
			
			pagingVO.setTotalRecord(totalRecord);
			List<InqBoardVO> inqBoardList = mainAdminService.selectBoardList(pagingVO);
			pagingVO.setDataList(inqBoardList);
			
			model.addAttribute("pagingVO", pagingVO);
			goPage = "mainhome/adminBoard";
			
		}else {
			ra.addFlashAttribute("message", "관리자만 접근 가능합니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	
	
}
