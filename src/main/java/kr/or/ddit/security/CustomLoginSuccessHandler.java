package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("onAuthenticationSuccess() 실행...!");
		User customUser = (User) authentication.getPrincipal();
		log.info("username : " + customUser.getUsername());
		log.info("password : " + customUser.getPassword());
		
		clearAuthenticationAttribute(request);
		
		// 로그아웃한 뒤 나타나는 로그인 폼에서 로그인할 때 제대로 로그인 처리가 이루어지도록 한다.
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = request.getContextPath() + "/home/feed";
		if(savedRequest != null) {		// 널체킹
			targetUrl = savedRequest.getRedirectUrl();
		}
				
		
		log.info("Login Success targetUrl : " + targetUrl);
		response.sendRedirect(targetUrl);	// 로그인 성공시 리다이렉트 함.
	}
	
	public void clearAuthenticationAttribute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		if(session == null) {
			return;
		}
		
		// SPRING_SECURITY_LAST_EXCEPTION 값
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);	// 로그인 성공했으니까 인증과 관련된 에러정보를 지운다.
	}
	
}
