package kr.or.ddit.controller.main;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.or.ddit.service.main.IMainService;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PaymentController {
	
	// Iamport
	private IamportClient iamportClient;
	
	@Inject
	private IMainService mainService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@PostMapping("/payment/verify/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session
									, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
		
		return iamportClient.paymentByImpUid(imp_uid);
	}
	
	@GetMapping("/payment/verify/")
	@ResponseBody
	public void PaymentVerify(String imp_uid, String merchant_uid) throws Exception{

		log.info("결제 성공");
		log.info("imp_uid : " + imp_uid);
		log.info("merchant_uid : " + merchant_uid);
	}
	
	@PostMapping("/payment/succeed")
	@ResponseBody
	public Map<Object, Object> updateStatus(HttpServletRequest req, PaymentVO paymentVO){
		
		log.info("updateStatus() 실행~~~~~");
		
//		String imp_uid = req.getParameter("imp_uid");
//		int order_no = Integer.parseInt(req.getParameter("merchant_uid"));
//		String payCode = paymentVO.getPayCode();
//		String payStatus = "Y";

		Map<Object, Object> map = new HashMap<>();

//		//주문번호, 결제고유번호, 결제상태를 인자로 넘겨준다
//		int res = mainMapper.updateStatus(payCode, payStatus);
//		if (res > 0) {
//			map.put("cnt", "Y");
//		}else {
//			map.put("cnt", "N");
//		}
		
//		//장바구니 지우기
//		HttpSession session = req.getSession();
//		session.removeAttribute("cart");
		
		return map;
	}
	
	@RequestMapping(value = "/payment/order", method = RequestMethod.GET)
	public String paymentOrder(
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		log.info("paymenetOrder() 실행~~~~~");
		
		String goPage = "";
		
		CustomerVO customer = (CustomerVO) session.getAttribute("SessionInfo");
		
		if(customer != null) {
			model.addAttribute("SessionInfo", customer);
			
			mainService.sendMail(req, customer);
			
//			MailHandler sendMail = new MailHandler(mailSender);
//			sendMail.setSubject("WSI 시스템 구매 메일입니다!");
//			sendMail.setText(
//					"<h3>" + customer.getCusName() + "님! WSI 시스템을 구매해주셔서 감사합니다!</h3>" + 
//					"<br>시스템을 이용해보세요!" + 
//					"<br><a href='http://localhost/home/feed' target='_blank'>시스템으로 바로가기</a>");
//			sendMail.setFrom("teamwsi404@gmail.com", "WSI 관리자");
//			sendMail.setTo(customer.getCusEmail());
//			sendMail.send();
//			
			
//			PaymentVO paymentVO = mainService.selectPayCode(customer.getCusRnum());
//			log.info("결제 이후 customer 값!!!!!!!!!!!" + customerVO );
//			model.addAttribute("customerVO", customerVO);
			
//			ServiceResult result = mainService.updatePayStatus(req, paymentVO);
//			String payCode = paymentVO.getPayCode();
//			log.info("payCode 값!!!!!!!!!!" + payCode);
			
//			CustomerVO customerVO = mainService.selectCustomerEmail(cusRnum);
//			model.addAttribute("customerVO", customerVO);
			goPage = "mainhome/paymentOrder";
		}else {
			
			goPage = "";
		}
		
		return goPage;
	}
	
}
