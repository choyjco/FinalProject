package kr.or.ddit.controller.main;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.main.IMainLoginService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainLoginController {
	
	@Inject
	private IMainLoginService mainLoginService;
	
	/**
	 * 판매페이지 메인 화면
	 * @return
	 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		log.info("main() 실행~~~~~");
		
		return "mainhome/mainPage";
	}

	/**
	 * 판매페이지 로그인 화면
	 * @return
	 */
	@RequestMapping(value = "/mainlogin", method = RequestMethod.GET)
	public String mainLogin() {
		log.info("mainLogin() 실행~~~~~");
		return "mainhome/mainLogin";
	}
	
	/**
	 * 판매페이지 로그인 체크
	 * @param req
	 * @param ra
	 * @param session
	 * @param customerVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mainlogincheck", method = RequestMethod.POST)
	public String mainLoginCheck(
			HttpServletRequest req,
			RedirectAttributes ra,
			HttpSession session,
			CustomerVO customerVO, Model model) {
		log.info("mainLoginCheck() 실행~~~~~");
		String goPage = "";
		boolean isValid = false;
		Map<String, String> errors = new HashMap<String, String>();
		
		if(StringUtils.isBlank(customerVO.getCusRnum())) {
			errors.put("cusRnum", "아이디(사업자등록번호)를 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusPw())) {
			errors.put("cusPw", "비밀번호를 입력해주세요.");
		}
		
		if(errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("customerVO", customerVO);
			goPage = "mainhome/mainLogin";
			log.info("메인페이지 로그인 에러!!!!!");
		}else {
			// 회원 정보 가져오기
			CustomerVO customer = mainLoginService.loginCheck(customerVO);
			if(customer != null) {
				// 입력된 비밀번호를 암호화하고 db에 있는 비밀번호와 일치하는지 확인
				isValid = BCrypt.checkpw(customerVO.getCusPw(), customer.getCusPw());
				if(isValid) {
					session = req.getSession();
					session.setAttribute("SessionInfo", customer);
					session.setMaxInactiveInterval(1800);	// 세션 유지 시간(30분)
					ra.addFlashAttribute("message", customer.getCusName() + "님, 환영합니다!");
					goPage = "redirect:/main";
					log.info("메인페이지 로그인 성공!!!!!");
				}
			}else {
				model.addAttribute("message", "정보가 일치하지 않습니다!");
				model.addAttribute("customerVO", customerVO);
				goPage = "mainhome/mainLogin";
				log.info("메인페이지 로그인 정보 불일치!!!!!");
			}
		}
		return goPage;
	}

	/**
	 * 판매페이지 회원가입 폼
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String mainSignUpForm() {
		log.info("mainSignUpForm() 실행~~~~~");
		return "mainhome/register";
	}
	
	/**
	 * 판매페이지 회원가입
	 * @param req
	 * @param ra
	 * @param customerVO
	 * @param attachVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String mainSignUp(
			HttpServletRequest req,
			RedirectAttributes ra,
			CustomerVO customerVO,
			AttachVO attachVO,
			Model model) {
		log.info("mainSignUp() 실행~~~~~");
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(customerVO.getCusRnum())) {
			errors.put("cusRnum", "아이디(사업자등록번호)를 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusPw())) {
			errors.put("cusPw", "비밀번호를 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusCom())) {
			errors.put("cusCom", "회사명을 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusName())) {
			errors.put("cusName", "대표자(이름)을 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusAddr())) {
			errors.put("cusAddr", "회사 주소를 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusTel())) {
			errors.put("cusTel", "회사 전화번호를 입력해주세요.");
		}
		if(StringUtils.isBlank(customerVO.getCusEmail())) {
			errors.put("cusEmail", "이메일을 입력해주세요.");
		}
		
		
		if(errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("customerVO", customerVO);
			log.info("메인페이지 회원가입 에러!!!!!");
			goPage = "mainhome/register";
		}else {
			ServiceResult result = mainLoginService.register(req, customerVO);
			attachVO.setFileUploader(customerVO.getCusRnum());
			log.info("메인페이지 회원가입 cusRnum값 : {}", customerVO.getCusRnum());
			
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "회원가입이 완료되었습니다!");
				log.info("메인페이지 회원가입 성공!!!!!");
				goPage = "redirect:/mainlogin";
			}else {
				model.addAttribute("message", "서버에러입니다. 다시 시도해주세요!");
				model.addAttribute("customerVO", customerVO);
				log.info("메인페이지 회원가입 서버 에러!!!!!");
				goPage = "mainhome/register";
			}
		}
		return goPage;
	}
	
	/**
	 * 아이디 중복 확인(AJAX)
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> idCheck(@RequestBody Map<String, String> map) {
		
		String id = map.get("cusRnum").toString();
		log.info("넘겨받은 아이디 : {}", id);
		ServiceResult result = mainLoginService.idCheck(map.get("cusRnum"));
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	/**
	 * 이메일 중복 확인(AJAX)
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> emailCheck(@RequestBody Map<String, String> map) {

		String email = map.get("cusEmail").toString();
		log.info("넘겨받은 이메일 : {}", email);
		ServiceResult result = mainLoginService.emailCheck(map.get("cusEmail"));
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	/**
	 * 판매페이지 로그아웃
	 * @param session
	 * @param ra
	 * @return
	 */
	@RequestMapping(value = "/mainlogout", method = RequestMethod.GET)
	public String mainLogout(
			HttpSession session,
			RedirectAttributes ra) {
		log.info("mainLogout() 실행~~~~~");
		session.invalidate();
		ra.addFlashAttribute("message", "로그아웃 되었습니다!");
		return "redirect:/main";
	}
	
	/**
	 * 판매페이지 비밀번호 찾기 화면
	 * @return
	 */
	@RequestMapping(value = "/findpwform", method = RequestMethod.GET)
	public String findpwForm() {
		log.info("findpwform() 실행~~~~~");
		return "mainhome/findPwForm";
	}
	
	/**
	 * 판매페이지 비밀번호 찾기
	 * @param customerVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findpw", method = RequestMethod.POST)
	public String findpw(CustomerVO customerVO, Model model) throws Exception {
		log.info("findpw() 실행~~~~~");
		return "mainhome/findPwResult";
	}
	
	
	
}
