package kr.or.ddit.controller.main;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.main.IMainLoginService;
import kr.or.ddit.service.main.IMainUserService;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncLevelVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainUserController {
	
	@Inject
	private IMainUserService mainUserService;
	
	
	@Autowired
	private PasswordEncoder pe;		// 비밀번호 암호화

	
	// 구매 내역(회원) 
	@RequestMapping(value = "/mypageuser/purchasehistory", method = RequestMethod.GET)
	public String purchaseHistory(
			String cusRnum, Model model,
			HttpSession session, RedirectAttributes ra) {
		log.info("purchaseHistory() 실행~~~~~");
		
		String goPage = "";
		
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		if(customer != null) {
			CustomerVO customerVO = mainUserService.selectPaymentListU(cusRnum);
			log.info("purchaseHistory->customerVO : " + customerVO);
			
			if(customerVO != null) {
				model.addAttribute("customerVO", customerVO);
				model.addAttribute("funcLevelList", customerVO.getPaymentVO().getFuncLevelList());
				goPage = "mainhome/purchaseHistory";

			}else {
				ra.addFlashAttribute("message", "구매내역이 없습니다! 마이페이지 메인으로 돌아갑니다!");
				goPage = "redirect:/mypageuser/userpwcheck";
			}
			
		}else {
			ra.addFlashAttribute("message", "로그인 정보가 없습니다! 메인 화면으로 돌아갑니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	// 회원 정보 수정 전 비밀번호 확인(회원)
	@RequestMapping(value = "/mypageuser/userpwcheck", method = RequestMethod.GET)
	public String userPwCheckGet(
			CustomerVO customerVO,
			HttpSession session,
			Model model, RedirectAttributes ra) {
		log.info("userPwCheckGet() 실행~~~~~");
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		if(customer != null) {
			model.addAttribute("SessionInfo", customer);
			goPage = "mainhome/userPwCheck";
		}else {
			ra.addFlashAttribute("message", "로그인 정보가 없습니다! 메인 화면으로 돌아갑니다!");
			goPage = "redirect:/main";
		}
		return goPage;
	}
	
	@RequestMapping(value = "/mypageuser/userpwchecking", method = RequestMethod.POST)
	public String userPwCheckPost(
			@RequestParam("cusPw") String pw,
			RedirectAttributes ra,
			HttpSession session,
			CustomerVO customerVO, Model model) {
		log.info("userPwCheckPost() 실행~~~~~");
		String goPage = "";
		
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		model.addAttribute("SessionInfo", customer);
		
		String cusPw = customer.getCusPw();
		if(customer != null) {
			if(pe.matches(pw, cusPw)) {
				log.info("회원정보수정 전 비밀번호 확인 일치!!!!!");
				goPage = "redirect:/mypageuser/memberdetail?cusRnum=" + customer.getCusRnum();
			}else {
				ra.addFlashAttribute("message", "비밀번호가 일치하지 않습니다!");
				goPage = "redirect:/mypageuser/userpwcheck";
			}
		}
		
		return goPage;
	}
	
		
	// 회원 정보 상세(회원)
	@RequestMapping(value = "/mypageuser/memberdetail", method = RequestMethod.GET)
	public String memberDetail(
			HttpSession session, RedirectAttributes ra,
			String cusRnum, Model model) {
		log.info("memberDetail() 실행~~~~~");
		String goPage = "";
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");

		if(customer != null) {
			CustomerVO customerVO = mainUserService.selectMemberDetail(cusRnum);
			model.addAttribute("customer", customerVO);
			log.info("파일경로!!!!!!!!!!!" + customerVO.getCusImage());
			goPage = "mainhome/memberDetail";
		}else {
			ra.addFlashAttribute("message", "로그인 정보가 없습니다! 메인 화면으로 돌아갑니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
		
	// 판매페이지 문의게시판 리스트(회원)
	@RequestMapping(value = "/mypageuser/userboard", method = RequestMethod.GET)
	public String adminBoard(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpSession session, RedirectAttributes ra) {
		
		log.info("adminBoard() 실행~~~~~");
		
		String goPage = "";
		
		PaginationInfoVO<InqBoardVO> pagingVO = new PaginationInfoVO<InqBoardVO>();
		
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			if(StringUtils.isNotBlank(searchWord)) {
				pagingVO.setSearchType(searchType);
				pagingVO.setSearchWord(searchWord);
				model.addAttribute("searchType", searchType);
				model.addAttribute("searchWord", searchWord);
			}
			
			pagingVO.setCurrentPage(currentPage);
			int totalRecord = mainUserService.selectBoardCount(pagingVO);
			
			pagingVO.setTotalRecord(totalRecord);
			List<InqBoardVO> inqBoardList = mainUserService.selectBoardList(pagingVO);
			pagingVO.setDataList(inqBoardList);
			
			model.addAttribute("pagingVO", pagingVO);
			model.addAttribute("SessionInfo", customer);
			goPage = "mainhome/userBoard";
		}else {
			ra.addFlashAttribute("message", "로그인 정보가 없습니다! 메인 화면으로 돌아갑니다!");
			goPage = "redirect:/main";
		}
		
		return goPage;
	}
	
}
