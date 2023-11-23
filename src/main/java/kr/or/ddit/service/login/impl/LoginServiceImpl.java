package kr.or.ddit.service.login.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.login.LoginMapper;
import kr.or.ddit.service.login.ILoginService;
import kr.or.ddit.vo.EmpVO;

@Service
public class LoginServiceImpl implements ILoginService {

	@Inject
	private LoginMapper loginMapper;
	
	@Override
	public List<EmpVO> empSearch(String empName) {
		List<EmpVO> empList = loginMapper.empSearch(empName);
		
		return empList;
	}
//	@Override
//	public ServiceResult signup(MemberVO memberVO) {
//		ServiceResult result = null;
//		int status = loginMapper.signup(memberVO);
//		if(status > 0) {
//			result = ServiceResult.OK;
//		}else {
//			result = ServiceResult.FAILED;
//		}
//		
//		return result;
//	}

	@Override
	public EmpVO loginCheck(EmpVO empVO) {
		return loginMapper.loginCheck(empVO);
	}

	@Override
	public EmpVO findId(EmpVO empVO) {
		
		return loginMapper.findId(empVO);
	}
	
	@Override
	public ServiceResult findPw(EmpVO empVO) {
		ServiceResult result = null;
		
		EmpVO status = loginMapper.findPw(empVO);
		
		if(status != null) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult resetPw(EmpVO empVO) {
		ServiceResult result = null;
		
		int status = loginMapper.resetPw(empVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}


}














