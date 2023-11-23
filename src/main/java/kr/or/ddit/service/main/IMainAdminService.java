package kr.or.ddit.service.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

public interface IMainAdminService {

	// 회원목록(관리자)
	public List<CustomerVO> selectCustomerList();

	public int selectCustomerCount(PaginationInfoVO<CustomerVO> pagingVO);

	public List<CustomerVO> selectCustomerList(PaginationInfoVO<CustomerVO> pagingVO);

	public CustomerVO selectCustomer(String cusRnum);

	// 기능 관리(관리자)
	public List<FuncInfoVO> selectFuncList();

	public FuncInfoVO selectFunc(String funcName);

	public ServiceResult insertFunc(HttpServletRequest req, FuncInfoVO funcInfoVO);

	public ServiceResult updateFunc(HttpServletRequest req, FuncInfoVO funcInfoVO);

	public ServiceResult deleteFunc(HttpServletRequest req, String funcName);

	// 레벨 관리(관리자)
	public ServiceResult insertLevel(HttpServletRequest req, LevelInfoVO levelInfoVO);

	public List<LevelInfoVO> selectLevelList();

	public LevelInfoVO selectLevel(String levelName);

	public ServiceResult updateLevel(HttpServletRequest req, LevelInfoVO levelinfoVO);

	public ServiceResult deleteLevel(HttpServletRequest req, String levelName);

	// 구매 회원 관리(관리자)
	public int selectPaymentCount(PaginationInfoVO<CustomerVO> pagingVO);

	public List<CustomerVO> selectPaymentList(PaginationInfoVO<CustomerVO> pagingVO);

	public CustomerVO selectPayment(String payCode);

	// 차트
	public List<PaymentVO> selectLevelName();

	public List<PaymentVO> selectFuncName();

	public List<PaymentVO> selectSales();

	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO);

	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO);

	public List<CustomerVO> selectCusEmp();

}
