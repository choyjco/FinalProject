package kr.or.ddit.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	/*
	 * kr.or.ddit.security.CustomNoOpPasswordEncoder 위치에 해당하는 클래스를 customPasswordEncoder 아이디로 빈 등록 하고,
	 * security:authentication-manager 태그 내(인증 매니저)에 인증 제공자를 등록한다.
	 * > security:password-encoder ref="customPasswordEncoder"
	 * 
	 * JDBC를 이용한 인증/인가에 의해서 dataSource에 설정된 계정 정보 안에 들어있는 테이블 요소들을 스프링 시큐리티가 확인하여
	 * users, authorities테이블 정보를 활용해 인증을 진행한다.
	 */
	@Override
	public String encode(CharSequence rawPassword) {
		log.info("before encode : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.info("matches : " + rawPassword + " : " + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
