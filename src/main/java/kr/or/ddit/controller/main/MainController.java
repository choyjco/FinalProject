package kr.or.ddit.controller.main;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;
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
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	
	@Inject
	private IMainService mainService;
	
	@Inject
	private IMainAdminService mainAdminService;
	
	// 판매페이지 문의게시판 리스트
	@RequestMapping(value = "/askboard", method = RequestMethod.GET)
	public String askBoard(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		
		log.info("askBoard() 실행~~~~~");
		
		PaginationInfoVO<InqBoardVO> pagingVO = new PaginationInfoVO<InqBoardVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = mainService.selectBoardCount(pagingVO);
		
		pagingVO.setTotalRecord(totalRecord);
		List<InqBoardVO> inqBoardList = mainService.selectBoardList(pagingVO);
		pagingVO.setDataList(inqBoardList);
		
		model.addAttribute("pagingVO", pagingVO);
		
//		model.addAttribute("inqBoardList", inqBoardList);
		return "mainhome/askBoard";
	}

	// 판매페이지 문의게시판 등록 화면
	@RequestMapping(value = "/askform", method = RequestMethod.GET)
	public String askInsertForm(HttpSession session, RedirectAttributes ra) {
		
		log.info("askInsertForm() 실행~~~~~");
		
		String goPage = "";
		
		CustomerVO customerVO = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customerVO != null) {
			goPage = "mainhome/askForm";
		}else {
			ra.addFlashAttribute("message", "로그인 후에 이용해주세요!");
			goPage = "redirect:/mainlogin";
		}
		return goPage;
	}
	
	// 판매페이지 문의게시판 등록
	@RequestMapping(value = "/askinsert", method = RequestMethod.POST)
	public String askInsert(
			HttpServletRequest req,
			HttpSession session,
			RedirectAttributes ra,
			InqBoardVO inqBoardVO, Model model) {
		
		log.info("askInsert() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customerVO = (CustomerVO) session.getAttribute("SessionInfo");
		
		session.setAttribute("cusRnum", customerVO.getCusRnum());
		
		if(customerVO != null) {
			customerVO.setCusRnum(customerVO.getCusRnum());
			log.info("문의게시판 등록등록!!!!!!!!!!!!");
			
			ServiceResult result = mainService.insertBoard(req, inqBoardVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "문의글이 등록되었습니다!");
				goPage = "redirect:/askdetail?inqNo=" + inqBoardVO.getInqNo();
				log.info("등록잘됨!!!!!!!!!!!!");
			}else {
				model.addAttribute("message", "서버오류입니다. 다시 시도해주세요!");
				goPage = "mainhome/askForm";
				log.info("등록 서버오류~~~~~~~~~~~~~");
				
			}
		}
		return goPage;
	}

	// 판매페이지 문의게시판 상세
	@RequestMapping(value = "/askdetail", method = RequestMethod.GET)
	public String askDetail(int inqNo, Model model) {
		log.info("askDetail() 실행~~~~~");
		InqBoardVO inqBoardVO = mainService.selectBoard(inqNo);
		model.addAttribute("inqBoard", inqBoardVO);
		return "mainhome/askDetail";
	}
	
	// 판매페이지 문의게시판 수정 화면
	@RequestMapping(value = "/askupdate", method = RequestMethod.GET)
	public String askUpdateForm(int inqNo, Model model) {
		log.info("askUpdateForm() 실행~~~~~");
		InqBoardVO inqBoardVO = mainService.selectBoard(inqNo);
		model.addAttribute("inqBoard", inqBoardVO);
		model.addAttribute("status", "u");
		return "mainhome/askForm";
	}
	
	// 판매페이지 문의게시판 수정
	@RequestMapping(value = "/askupdate", method = RequestMethod.POST)
	public String askUpdate(
			HttpServletRequest req,
			RedirectAttributes ra,
			InqBoardVO inqBoardVO, Model model) {
		log.info("askUpdate() 실행~~~~~");
		String goPage = "";
		ServiceResult result = mainService.updateBoard(req, inqBoardVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
			goPage = "redirect:/askdetail?inqNo=" + inqBoardVO.getInqNo();
		}else {
			model.addAttribute("message", "수정에 실패하였습니다.");
			model.addAttribute("inqBoard", inqBoardVO);
			model.addAttribute("status", "u");
			goPage = "mainhome/askForm";
		}
		return goPage;
	}
	
	// 판매페이지 문의게시판 답글
	@RequestMapping(value = "/askreply", method = RequestMethod.POST)
	public String askReply(
			HttpServletRequest req,
			RedirectAttributes ra,
			HttpSession session,
			InqBoardVO inqBoardVO, Model model) throws UnsupportedEncodingException, MessagingException {
		log.info("askReply() 실행~~~~~");
		String goPage = "";
		CustomerVO customerVO = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customerVO.getCusRnum().equals("admin")) {
			ServiceResult result = mainService.replyBoard(req, inqBoardVO);
			ra.addFlashAttribute("message", "답변 등록이 완료되었습니다!");
			goPage = "redirect:/askdetail?inqNo=" + inqBoardVO.getInqNo();
//			mainService.sendReplyMail(inqBoardVO);
			log.info("문의게시판 답글 inqBoardVO 값!!!!!!!!!" + inqBoardVO);
			
		}else {
			model.addAttribute("message", "답변 등록에 실패하였습니다.");
			model.addAttribute("inqBoard", inqBoardVO);
			goPage = "redirect:/askdetail?inqNo=" + inqBoardVO.getInqNo();
		}
	
		return goPage;
	}
	
	// 판매페이지 문의게시판 삭제
	@RequestMapping(value = "/askdelete", method = RequestMethod.POST)
	public String askDelete(HttpServletRequest req, RedirectAttributes ra, int inqNo, Model model) {
		log.info("askDelete() 실행~~~~~");

		String goPage = "";
		ServiceResult result = mainService.deleteBoard(req, inqNo);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "삭제가 완료되었습니다!");
			goPage = "redirect:/askboard";
		} else {
			ra.addFlashAttribute("message", "삭제 권한이 없습니다.");
			goPage = "redirect:/askdetail?inqNo=" + inqNo;

		}

		return goPage;
	}

	// 레벨, 기능 선택 페이지
	@RequestMapping(value = "/subscribeform", method = RequestMethod.GET)
	public String subscribeForm(
			HttpSession session, HttpServletRequest req,
			RedirectAttributes ra, Model model) {
		
		log.info("subscribeForm() 실행~~~~~");
	
		String goPage = "";
		
		try {
		    CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		    if (customer != null) {
		    	log.info("구매 페이지 세션 아이디 값!!!!!" + customer.getCusRnum());
		        goPage = "mainhome/subscribeForm";
		    } else {
		    	ra.addFlashAttribute("message", "로그인 후에 이용해주세요!");
		        goPage = "redirect:/mainlogin";
//		        String referer = req.getHeader("Referer");
//		        goPage = "redirect:" + referer;
		    }
		} catch (NullPointerException e) {
		    log.error("NullPointerException occurred: " + e.getMessage());
		}
		
		return goPage;
	}
	
	// 레벨, 기능 선택 페이지
	@RequestMapping(value = "/subscribe", method = RequestMethod.POST)
	public String subscribe(
			HttpServletRequest req, HttpSession session,
			RedirectAttributes ra, PaymentVO paymentVO, Model model) {
		log.info("subscribe() 실행~~~~~");
		log.info("paymentVO!!!!!!!!!!!!!!!" + paymentVO);

		String goPage = "";

		// 세션
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		log.info("구매 페이지 세션 아이디 값!!!!!" + customer.getCusRnum());

		if (customer != null) {
			paymentVO.setCusRnum(customer.getCusRnum());

			ServiceResult result = mainService.insertPayment(req, paymentVO);

			if (result.equals(ServiceResult.OK)) {
				goPage = "redirect:/subscribe2?cusRnum=" + customer.getCusRnum() + "&payCode=" + paymentVO.getPayCode();
			}else {
				model.addAttribute("message", "서버에러, 다시 시도해주세요!");
				goPage = "mainhome/subscribeForm";
			}

		}

		return goPage;
	}
	
	// 레벨, 기능 선택 페이지2
	@RequestMapping(value = "/subscribe2", method = RequestMethod.GET)
	public String subscribe2(
			HttpServletRequest req,
			RedirectAttributes ra,
			HttpSession session, Model model, String payCode) {
		log.info("subscribe2() 실행~~~~~");
		
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		if(customer != null) {
			
			PaymentVO paymentVO = mainService.paymentDetail(payCode);
			CustomerVO customerVO = mainService.selectMemberImage(customer.getCusRnum());
			goPage = "mainhome/subscribe2";
			model.addAttribute("paymentVO", paymentVO);
			model.addAttribute("funcLevelList", paymentVO.getFuncLevelList());
			model.addAttribute("customer", customerVO);
			
		}else {
			goPage = "redirect:/mainlogin";
			ra.addFlashAttribute("message", "로그인하고 이용해주세요!");
		}
		return goPage;
	}
	
	@ResponseBody
	@RequestMapping(value = "/funcchart1", method = RequestMethod.POST)
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
	
	// 차트
	@ResponseBody
	@RequestMapping(value = "/levelchart1", method = RequestMethod.POST)
	public String levelChart(Model model) {
		log.info("levelChart() 실행~~~~~");
		
		List<PaymentVO> list = mainAdminService.selectLevelName();
		
		
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		
//			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Iterator<PaymentVO> it = list.iterator();
		while(it.hasNext()) {
			PaymentVO paymentVO = it.next();
			JsonObject object = new JsonObject();
			String levelName = paymentVO.getLevelName();
			int cnt = paymentVO.getLevelCnt();
			int ratio = paymentVO.getLevelRatio();
			
//				Date dt = paymentVO.getPayDate();
//				String payDate = df.format(dt);
			
			object.addProperty("levelName", levelName);
			object.addProperty("cnt", cnt);
			object.addProperty("ratio", ratio);
//				object.addProperty("payDate", payDate);
			jArray.add(object);
			
		}
		
		String json = gson.toJson(jArray);
		model.addAttribute("json", json);
		log.info("json 변환!!!!!" + json);
		
		return json;
	}
	
	
}
