package kr.or.ddit.service.login;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.EmpVO;

public interface ILoginService {
	public EmpVO loginCheck(EmpVO empVO);

	public List<EmpVO> empSearch(String empName);

	public EmpVO findId(EmpVO empVO);
	
	public ServiceResult findPw(EmpVO empVO);

	public ServiceResult resetPw(EmpVO empVO);

}
