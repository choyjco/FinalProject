package kr.or.ddit.controller.arm;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.arm.IArmService;
import kr.or.ddit.vo.AlarmVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value="/arm", produces = "application/json;charset=utf-8")
public class AlarmController {
	
	@Inject
	private IArmService armService;
	
	/**
	 * 알림내역을 가져오는 컨트롤러
	 * @return 알림내역
	 */
	@GetMapping("/List")
	@ResponseBody
	public List<AlarmVO> notifyList(){
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    String empNo = user.getEmp().getEmpNo();
	    
	    log.info("armList 비동기 요청 empNo : {}",empNo);
	    
		return armService.retrieveArmList(empNo);
	}
	
	/**
	 * 모든 알림을 읽음처리하는 컨트롤러 
	 * @return
	 */
	@GetMapping("/AllRead")
	@ResponseBody
	public ServiceResult notifyAllRead(){
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    String empNo = user.getEmp().getEmpNo();
	    
	    log.info("AllRead 비동기 요청 empNo : {}", empNo);
	    
		ServiceResult result = armService.modifyAllArm(empNo);
		return result;
	}
	
	/**
	 * 메세지를 읽음처리하는 컨트롤러
	 * @param armNo 알림번호
	 * @return 처리결과
	 */
	@PostMapping("/Read")
	@ResponseBody
	public ServiceResult notifyRead(@RequestParam String armNo){
		ServiceResult result = armService.modifyArm(armNo);
		return result;
	}
	
//	//알림 하나 제거
//	@PostMapping("/Delete")
//	@ResponseBody
//	public ServiceResult notifyDelete(@RequestParam String armNo){
//    	ServiceResult result = armService.removeArm(armNo);
//		return result;
//	}
//	
//	//알림 전부 제거
//	@PostMapping("/AllDelete")
//	@ResponseBody
//	public ServiceResult notifyAllDelete(HttpServletRequest request){
//		HttpSession session = request.getSession();
//	    String empNo = (((EmpVO)session.getAttribute("authEmp")).getEmpNo());
//	    
//    	ServiceResult result = armService.removeAllArm(empNo);
//		return result;
//	}
}
