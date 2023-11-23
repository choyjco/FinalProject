package kr.or.ddit.mapper.main;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;

public interface MainLoginMapper {

	public int register(CustomerVO customerVO);

	public CustomerVO loginCheck(CustomerVO customerVO);

	public CustomerVO idCheck(String cusRnum);

	public CustomerVO emailCheck(String cusEmail);

	public void registerFile(AttachVO attachVO);

	public void updateFileCode(CustomerVO customerVO);
	

}
