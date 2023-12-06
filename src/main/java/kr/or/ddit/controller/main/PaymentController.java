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
		log.info("imp_uid : {}", imp_uid);
		log.info("merchant_uid : {}", merchant_uid);
	}
	
	/**
	 * 결제 성공
	 * @param req
	 * @param paymentVO
	 * @return
	 */
	@PostMapping("/payment/succeed")
	@ResponseBody
	public Map<Object, Object> updateStatus(HttpServletRequest req, PaymentVO paymentVO){
		
		log.info("updateStatus() 실행~~~~~");
		
		Map<Object, Object> map = new HashMap<>();

		return map;
	}
	
	/**
	 * 결제 후 화면
	 * @param model
	 * @param req
	 * @param session
	 * @return
	 * @throws Exception
	 */
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
			
			goPage = "mainhome/paymentOrder";
		}else {
			
			goPage = "";
		}
		
		return goPage;
	}
	
}
