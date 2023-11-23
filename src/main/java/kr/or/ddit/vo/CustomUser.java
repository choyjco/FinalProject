package kr.or.ddit.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {
	
	private EmpVO emp;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(EmpVO emp) {
		// Java 스트림을 사용한 경우 (람다표현식)
		// - 자바 버전 8부터 추가된 기능
		// map : 컬렉션(List, Map, Set 등), 배열 등의 설정되어 있는 각 타입의 값들을 하나씩 참조하여 람다식으로 반복 처리 할 수 있게 해준다.
		// collect : Stream()을 돌려 발생하는 데이터를 가공 처리하고 원하는 형태의 자료형으로 변환을 돕는다.
		// 회원정보 안에 들어있는 역할 명들을 컬렉션 형태의 스트림으로 만들어서 보내준다.
		super(emp.getEmpNo(), emp.getEmpPw(),
				emp.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		// 람다 표현식에는 전처리와 후처리가 존재한다.
		// 전처리에 해당하는 로직으로 .map이 컬렉션 데이터를 활용하고
		// 후처리에 해당하는 로직으로 .collect가 돌아 마지막으로 데이터를 가공 처리 후 마무리되어야 하는 데이터 타입으로 변환을 마무리한다.
		this.emp = emp;
	}
	
	public EmpVO getEmp() {
		return emp;
	}

	public void setEmp(EmpVO emp) {
		this.emp = emp;
	}
	
}
