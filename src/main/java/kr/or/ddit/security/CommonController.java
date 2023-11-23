package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {

	@RequestMapping(value = "/accessError", method = RequestMethod.GET)
	public String accessDenied(Authentication auth, Model model) {
		log.info("accessDenied() 실행...!");
		log.info("access Denied : " + auth);
		/*
		 * auth 정보
		 * 스프링 시큐리티 동작으로 인해 만들어진 UserDetails 정보
		 * > org.springframework.security.authentication.UsernamePasswordAuthenticationToken@8ea115:
		 * 	 principal: org.springframework.security.core.userdetails.User@bfc27a2f:
		 * 
		 * > username : member
		 * > password : [PROTECTED] 비밀번호는 보안으로 묶여있기 때문에 콘솔로 확인이 불가능하다.
		 * > enabled : true
		 * > AccountNonExpired : true
		 * > credentialsNonExpired : true
		 * > AccountNonLocked : true
		 * > Granted Authorities : ROLE_MEMBER
		 * > Credentials : [PROTECTED]
		 * > Authenticated : true   인증정보 객체 생성 OK
		 * > Details : org.springframework.security.web.authentication.WebAuthenticationDetails@166c2
		 * 				RemoteIpAddress: 0:0:0:0:0:0:0:0:1
		 * > SessionId : B4686E368574F68768DE687486AG 브라우저 JSESSIONID
		 * > Granted Authorities : ROLE_MEMBER
		 * 
		 */
		model.addAttribute("msg", "Access Denied");
		return "accessError";
	}
}
