package kr.or.ddit.mapper.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

public interface MainMapper {

	// 문의 게시판
	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO);

	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO);

	public int insertBoard(InqBoardVO inqBoardVO);

	public InqBoardVO selectBoard(int inqNo);

	public int updateBoard(InqBoardVO inqBoardVO);

	public int deleteBoard(int inqNo);

	public int replyBoard(InqBoardVO inqBoardVO);

	// 비밀번호 확인
	public CustomerVO userPwCheck(CustomerVO customerVO);

	// 구매
	public int insertPayment(PaymentVO paymentVO);

	public int insertPaymentDetail(PaymentVO paymentVO);

	public int insertFuncLevel(PaymentVO paymentVO);
	
	public int updatePrice(PaymentVO paymentVO);

	public PaymentVO paymentDetail(String payCode);

	public CustomerVO selectMemberImage(String cusRnum);

//	public CustomerVO selectCustomerEmail(String cusRnum);

//	public PaymentVO selectPayCode(String cusRnum);

//	public int updatePayStatus(HttpServletRequest req, PaymentVO paymentVO);

//	public int updatePayStatus(HttpServletRequest req, PaymentVO paymentVO);





}
