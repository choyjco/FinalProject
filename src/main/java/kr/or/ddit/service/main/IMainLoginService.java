package kr.or.ddit.service.main;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CustomerVO;

public interface IMainLoginService {

	public ServiceResult register(HttpServletRequest req, CustomerVO customerVO);

	public CustomerVO loginCheck(CustomerVO customerVO);

	public ServiceResult idCheck(String cusRnum);

	public ServiceResult emailCheck(String cusEmail);


}
