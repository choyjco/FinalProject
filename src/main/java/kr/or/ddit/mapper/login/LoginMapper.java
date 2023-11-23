package kr.or.ddit.mapper.login;

import java.util.List;

import kr.or.ddit.vo.EmpVO;

public interface LoginMapper {
	public EmpVO loginCheck(EmpVO empVO);
	public EmpVO readByUserId(String username);
	public List<EmpVO> empSearch(String empName);
	public EmpVO findId(EmpVO empVO);
	public EmpVO findPw(EmpVO empVO);
	public int resetPw(EmpVO empVO);
}
