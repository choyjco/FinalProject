package kr.or.ddit.mapper.main;

import java.util.List;

import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

public interface MainAdminMapper {

	// 회원 목록(관리자)
	public List<CustomerVO> selectCustomerList();

	public int selectCustomerCount(PaginationInfoVO<CustomerVO> pagingVO);

	public List<CustomerVO> selectCustomerList(PaginationInfoVO<CustomerVO> pagingVO);

	public CustomerVO selectCustomer(String cusRnum);

	// 기능 관리(관리자)
	public List<FuncInfoVO> selectFuncList();

	public FuncInfoVO selectFunc(String funcName);

	public int insertFunc(FuncInfoVO funcInfoVO);

	public int updateFunc(FuncInfoVO funcInfoVO);

	public int deleteFunc(String funcName);
	
	// 레벨 관리(관리자)
	public List<LevelInfoVO> selectLevelList();

	public int insertLevel(LevelInfoVO levelInfoVO);

	public LevelInfoVO selectLevel(String levelName);

	public int updateLevel(LevelInfoVO levelinfoVO);

	public int deleteLevel(String levelName);

	// 구매 회원 관리(관리자)
	public int selectPaymentCount(PaginationInfoVO<CustomerVO> pagingVO);

	public List<CustomerVO> selectPaymentList(PaginationInfoVO<CustomerVO> pagingVO);

	public CustomerVO selectPayment(String payCode);

	// 차트
	public List<PaymentVO> selectLevelName();

	public List<PaymentVO> selectFuncName();

	public List<PaymentVO> selectSales();

	public List<CustomerVO> selectCusEmp();

	// 게시판
	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO);

	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO);


}
