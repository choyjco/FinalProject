package kr.or.ddit.controller.login;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.login.ILoginService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	
	private String authcode;
	private EmpVO empVO;
	
	@Inject
	private ILoginService loginService;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Autowired
    BCryptPasswordEncoder passwordEncoder;
	
	
	/**
	 * 로그인 폼 접속 메소드
	 */
	@RequestMapping(value="/signin", method = RequestMethod.GET)
	public String signIn() {
		log.info("signIn() 실행...!");
		
		return "login/signin";
	}
	
	/**
	 * 로그인하는 메소드
	 */
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(RedirectAttributes ra, EmpVO empVO, Model model) {
		log.info("login() 실행...!");
		
		String goPage = "";
		
		EmpVO emp = loginService.loginCheck(empVO);
		if(emp != null) {
			ra.addFlashAttribute("smessage", emp.getEmpName() + "님, 환영합니다!");
			goPage = "redirect:/home/feed";
		}else {
			model.addAttribute("emessage", "서버에러, 다시 시도해주세요.");
			model.addAttribute("empVO", empVO);
			goPage = "login/signin";
		}
			
		return goPage;
	}
	
	/**
	 * 아이디 찾기 폼 접속 메소드
	 */
	@RequestMapping(value="/forgotid", method = RequestMethod.GET)
	public String forgotIdForm() {
		log.info("forgotIdForm() 실행...!");
		
		return "login/forgot";
	}
	
	/**
	 * 정보 일치시 아이디 찾는 메소드
	 */
	@RequestMapping(value="/forgotid", method = RequestMethod.POST)
	public String forgotId(RedirectAttributes ra, EmpVO empVO, Model model) {
		log.info("forgotId() 실행...!");
		
		String goPage = "";
		
		EmpVO emp = loginService.findId(empVO);
		
		if(emp != null) {
			ra.addFlashAttribute("okmessage", "사번은 "+emp.getEmpNo()+" 입니다.");
			model.addAttribute("findId", emp.getEmpNo());
			goPage = "redirect:/signin";
		}else {
			model.addAttribute("wmessage", "일치하는 사원이 없습니다.");
			goPage = "login/forgot";
		}
		
		return goPage;
	}
	
	/**
	 * 패스워드 찾기 폼 접속 메소드
	 */
	@RequestMapping(value="/forgotpw", method = RequestMethod.GET)
	public String forgotPwForm(Model model) {
		log.info("forgotPwForm() 실행...!");
		
		model.addAttribute("status", "p");
		return "login/forgot";
	}
	
	/**
	 * 정보일치 시 이메일 전송하는 메소드
	 */
	@RequestMapping(value="/forgotpw", method = RequestMethod.POST)
	public String forgotPw(RedirectAttributes ra, EmpVO empVO, Model model) {
		log.info("forgotPw() 실행...!");
		
		String goPage = "";
		
		ServiceResult result = loginService.findPw(empVO);
		
		if(result.equals(ServiceResult.OK)) {
	        randomCode(); //랜덤 난수 
	        
	        StringBuilder sb = new StringBuilder();
	    
            String setFrom = "chlvm8911@gmail.com";	//발신자 이메일
            String tomail = empVO.getEmpEmail();	//수신자 이메일
            String title = "[원시인] 비밀번호 변경 인증 이메일입니다.";
            sb.append(String.format("안녕하세요 %s님\n", empVO.getEmpName()));
            sb.append(String.format("원시인 비밀번호 찾기(변경) 인증번호는 %s입니다.", this.authcode));
            String content = sb.toString();
            
            try {
                MimeMessage msg = mailSender.createMimeMessage();
                MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "UTF-8");
                
                msgHelper.setFrom(setFrom);
                msgHelper.setTo(tomail);
                msgHelper.setSubject(title);
                msgHelper.setText(content);
                
                //메일 전송
                mailSender.send(msg);
                
            }catch (Exception e) {
            	e.printStackTrace();
            }
            this.empVO = empVO;
			ra.addFlashAttribute("smessage", "이메일이 전송되었습니다.");
			goPage = "redirect:/authemail";
		}else {
			model.addAttribute("wmessage", "일치하는 사원이 없습니다.");
			model.addAttribute("status", "p");
			goPage = "login/forgot";
		}
		return goPage;
	}

	/**
	 * 이메일 전송 후 이동될 주소 메소드
	 */
	@RequestMapping(value="/authemail", method = RequestMethod.GET)
	public String authemailForm(Model model) {
		log.info("authemailForm() 실행...!");
		
		model.addAttribute("authcode", authcode);
		return "login/authemail";
	}
	
	/**
	 * 비밀번호찾기 접속 메소드
	 */
	@RequestMapping(value="/resetpw", method = RequestMethod.GET)
	public String resetpwForm(Model model) {
		log.info("resetpwForm() 실행...!");
		
		return "login/resetpw";
	}
	
	/**
	 * 비밀번호 재설정하는 메소드
	 */
	@RequestMapping(value="/resetpw", method = RequestMethod.POST)
	public String resetpw(RedirectAttributes ra, Model model, String password) {
		log.info("resetpw() 실행...!");
		
		String goPage = "";
		String encdoePassword = passwordEncoder.encode(password);
		this.empVO.setEmpPw(encdoePassword);
		
		ServiceResult result = loginService.resetPw(this.empVO);
		
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("smessage", "비밀번호가 성공적으로 변경되었습니다.");
			goPage = "redirect:/signin";
		}else {
			model.addAttribute("emessage", "비밀번호 변경을 실패했습니다.");
			goPage = "login/forgot";
		}
		
		return goPage;
	}
	
	/**
	 * 비밀번호찾기에 필요한 랜덤코드 생성 메소드
	 */
	public void randomCode() {
		Random rnd =new Random();
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < 6; i++) {
			// rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한
			// 숫자를 StringBuffer 에 append 한다.
			if (rnd.nextBoolean()) {
				buf.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		authcode = buf.toString();
	}
}
