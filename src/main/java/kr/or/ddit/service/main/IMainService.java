package kr.or.ddit.service.main;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;


import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

public interface IMainService {

	// 문의게시판
	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO);

	public ServiceResult insertBoard(HttpServletRequest req, InqBoardVO inqBoardVO);

	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO);

	public InqBoardVO selectBoard(int inqNo);

	public ServiceResult updateBoard(HttpServletRequest req, InqBoardVO inqBoardVO);

	public ServiceResult deleteBoard(HttpServletRequest req, int inqNo);

	public ServiceResult replyBoard(HttpServletRequest req, InqBoardVO inqBoardVO);

//	public void sendReplyMail(InqBoardVO inqBoardVO) throws MessagingException, UnsupportedEncodingException;
	
	// 비밀번호 확인
	public CustomerVO userPwCheck(CustomerVO customerVO);

	// 구매
	public ServiceResult insertPayment(HttpServletRequest req, PaymentVO paymentVO);

	public PaymentVO paymentDetail(String payCode);

	public void sendMail(HttpServletRequest req, CustomerVO customer) throws MessagingException, UnsupportedEncodingException;

	public CustomerVO selectMemberImage(String cusRnum);



//	public CustomerVO selectCustomerEmail(String cusRnum);

//	public PaymentVO selectPayCode(String cusRnum) throws Exception;

//	public ServiceResult updatePayStatus(HttpServletRequest req, PaymentVO paymentVO);

//	public ServiceResult updatePayStatus(@Param("payCode") String payCode, HttpServletRequest req, PaymentVO paymentVO);

	









}
