package kr.or.ddit.service.main.impl;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.main.MailHandler;
import kr.or.ddit.mapper.main.MainMapper;
import kr.or.ddit.service.main.IMainService;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

@Service
public class MainServiceImpl implements IMainService {

	@Inject
	private MainMapper mainMapper;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 문의게시판 페이징
	@Override
	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainMapper.selectBoardCount(pagingVO);
	}
	
	// 문의게시판 리스트
	@Override
	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainMapper.selectBoardList(pagingVO);
	}

	// 문의게시판 등록
	@Override
	public ServiceResult insertBoard(HttpServletRequest req, InqBoardVO inqBoardVO) {
		ServiceResult result = null;
		int status = mainMapper.insertBoard(inqBoardVO);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public InqBoardVO selectBoard(int inqNo) {
		return mainMapper.selectBoard(inqNo);
	}

	// 문의게시판 수정
	@Override
	public ServiceResult updateBoard(HttpServletRequest req, InqBoardVO inqBoardVO) {
		ServiceResult result = null;
		int status = mainMapper.updateBoard(inqBoardVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
			
			
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	// 문의게시판 삭제
	@Override
	public ServiceResult deleteBoard(HttpServletRequest req, int inqNo) {
		ServiceResult result = null;
		
		InqBoardVO inqBoardVO = mainMapper.selectBoard(inqNo);
		
		int status = mainMapper.deleteBoard(inqNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 문의게시판 답글 작성
	@Override
	public ServiceResult replyBoard(HttpServletRequest req, InqBoardVO inqBoardVO) {
		ServiceResult result = null;
		int status = mainMapper.replyBoard(inqBoardVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
			
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
//	@Override
//	public void sendReplyMail(InqBoardVO inqBoardVO) throws MessagingException, UnsupportedEncodingException {
//		
//		MailHandler sendMail = new MailHandler(mailSender);
//		sendMail.setSubject("[WSI] 문의하신 글에 답글이 달렸습니다!");
//		sendMail.setText(
//				"<h3>" + inqBoardVO.getCustomerVO().getCusName() + "님! 문의하신 글에 답글이 달렸습니다!</h3>" + 
//				"<br>답변을 확인해보세요!" + 
//				"<br><a href='http://localhost/askboard target='_blank'>문의게시판으로 바로가기</a>");
//		sendMail.setFrom("teamwsi404@gmail.com", "WSI 관리자");
//		sendMail.setTo("jinny17099@gmail.com");
//		sendMail.send();
//	}


	// 비밀번호 찾기
	@Override
	public CustomerVO userPwCheck(CustomerVO customerVO) {
		return mainMapper.userPwCheck(customerVO);
	}

	// 구매
	@Override
	public ServiceResult insertPayment(HttpServletRequest req, PaymentVO paymentVO) {
		ServiceResult result = null;
		int status = mainMapper.insertPayment(paymentVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
			// 추가
			String payCode = paymentVO.getPayCode();
			//
			mainMapper.insertPaymentDetail(paymentVO);
			mainMapper.insertFuncLevel(paymentVO);
			mainMapper.updatePrice(paymentVO);
			
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}


	@Override
	public PaymentVO paymentDetail(String payCode) {
		return mainMapper.paymentDetail(payCode);
	}

	@Async
	@Override
	public void sendMail(HttpServletRequest req, CustomerVO customer) throws MessagingException, UnsupportedEncodingException {
////		String setfrom = "teamwsi404@gmail.com";
//		String tomail = customer.getCusEmail();
//		String title = "WSI 시스템 구매 메일입니다!";
		String content = 
				"<h3>" + customer.getCusName() + "님! WSI 시스템을 구매해주셔서 감사합니다!</h3>" + 
				"<br><br>안녕하세요. 원시인 인사관리시스템 담당자입니다."+
				"<br><br>저희 시스템을 구매해주셔서 감사합니다! 시스템 이용 가이드와 초기 관리자 계정을 첨부문서와 같이 안내해 드리오니 참고하시어 시스템 이용에 불편 없으시길 바랍니다." + 
				"<br><br>문의사항은 WSI홈페이지 문의게시판을 이용하시거나 유선으로 연락주시면 신속하고 정확하게 도와드리겠습니다." +
				"<br><br>WSI 담당자 드림" + 
				"<br><br><a href='http://192.168.144.23/signin' target='_blank'>시스템으로 바로가기</a>";
		String fileName = req.getServletContext().getRealPath("/resources/images/example.pdf");
		String fileName1 = req.getServletContext().getRealPath("/resources/images/WSI_empInsert.xlsx");
		
//		String fileName = "D:\\99.JSP_SPRING\\02.SPRING2\\workspace_spring2\\WSIProject\\src\\main\\webapp\\resources\\images\\example.pdf";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom("teamwsi404@gmail.com", "WSI 관리자");
			messageHelper.setTo(customer.getCusEmail());
			messageHelper.setSubject("WSI 시스템 구매 메일입니다!");
			messageHelper.setText(content, true);
			
			FileSystemResource fsr = new FileSystemResource(fileName);
			messageHelper.addAttachment("시스템 안내서.pdf", fsr);
			
			FileSystemResource fsr1 = new FileSystemResource(fileName1);
			messageHelper.addAttachment("WSI_엑셀입력양식.xlsx", fsr1);
			
			mailSender.send(message);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
//		MailHandler sendMail = new MailHandler(mailSender);
//		sendMail.setSubject("WSI 시스템 구매 메일입니다!");
//		sendMail.setText(
//				"<h3>" + customer.getCusName() + "님! WSI 시스템을 구매해주셔서 감사합니다!</h3>" + 
//				"<br>시스템을 이용해보세요!" + 
//				"<br><a href='http://localhost/home/feed' target='_blank'>시스템으로 바로가기</a>");
//		sendMail.setFrom("teamwsi404@gmail.com", "WSI 관리자");
//		sendMail.setTo(customer.getCusEmail());
//		sendMail.send();
//		
		
	}

	@Override
	public CustomerVO selectMemberImage(String cusRnum) {
		return mainMapper.selectMemberImage(cusRnum);
	}

	

//	@Override
//	public CustomerVO selectCustomerEmail(String cusRnum) {
//		return mainMapper.selectCustomerEmail(cusRnum);
//	}

//	@Override
//	public PaymentVO selectPayCode(String cusRnum) throws Exception {
//		
////		MailHandler sendMail = new MailHandler(mailSender);
////		CustomerVO customerVO = new CustomerVO();
////		sendMail.setSubject("WSI 시스템 구매 메일입니다!");
////		sendMail.setText(
////				"<h3>" + customerVO.getCusName() + "님! WSI 시스템을 구매해주셔서 감사합니다!</h3>" + 
////				"<br>시스템을 이용해보세요!" + 
////				"<br><a href='http://localhost/home/feed' target='_blank'>시스템으로 바로가기</a>");
////		sendMail.setFrom("teamwsi404@gmail.com", "WSI 관리자");
////		sendMail.setTo("jinny17099@gmail.com");
////		sendMail.send();
////		
//		return mainMapper.selectPayCode(cusRnum);
//	}

//	@Override
//	public ServiceResult updatePayStatus(HttpServletRequest req, PaymentVO paymentVO) {
//		ServiceResult result = null;
//		
//		int status = mainMapper.updatePayStatus(req, paymentVO);
//		
//		if(status > 0) {
//			result = ServiceResult.OK;
//		}else {
//			result = ServiceResult.FAILED;
//		}
//		
//		return result;
//	}

//	@Override
//	public ServiceResult updatePayStatus(@Param("payCode") String payCode, HttpServletRequest req, PaymentVO paymentVO) {
//		ServiceResult result = null;
//		
//		int status = mainMapper.updatePayStatus(payCode, req, paymentVO);
//		
//		if(status > 0) {
//			result = ServiceResult.OK;
//		}else {
//			result = ServiceResult.FAILED;
//		}
//		
//		return result;
//		
//	}
	
}
