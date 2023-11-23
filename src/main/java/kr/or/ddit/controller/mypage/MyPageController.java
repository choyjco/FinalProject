package kr.or.ddit.controller.mypage;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.mypage.MyPageMapper;
import kr.or.ddit.service.mypage.IMyPageService;
import kr.or.ddit.vo.AcadVO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FamilyVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.SettingsVO;
import kr.or.ddit.vo.TreeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {

	@Inject
	private IMyPageService mypageService;
	
	@Inject
	private MyPageMapper mypageMapper;
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public String main(Model model) {
		log.info("main 페이지 실행...!");
		
		MenuVO menu1 = new MenuVO("마이페이지", "");
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList", menuList);
		
		return "mypage/main";
	}
	
	
	@RequestMapping(value="/page", method = RequestMethod.GET, consumes = "application/json")
	public ResponseEntity<InfoVO> infoPage(Model model){
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		InfoVO infoVO = mypageService.detail(empVO);
		List<FamilyVO> famList = mypageService.famdetail(empVO);
		List<CareerVO> carrList = mypageService.carrDetail(empVO);
		List<AcadVO> acadList = mypageService.acadDetail(empVO);
		
		infoVO.setFamList(famList);
		infoVO.setCarrList(carrList);
		infoVO.setAcadList(acadList);
		
		log.info("infoVO : " + infoVO);
		return new ResponseEntity<InfoVO>(infoVO, HttpStatus.OK);
	}
	
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/other", method = RequestMethod.GET)
	public String myPage(Model model, @RequestParam String empNo, HttpServletRequest request) {
		
		MenuVO menu1 = new MenuVO("마이페이지", "");
		List<MenuVO> menuList = Arrays.asList(menu1);
		EmpVO empVO = new EmpVO();
		empVO.setEmpNo(empNo);
		EmpVO empVO2 = mypageService.selectEmpOne(empVO);
		
		// 사원정보
		InfoVO emp = mypageService.detail(empVO2);
		
        List<FamilyVO> empFam = mypageService.famdetail(empVO2);
        List<AcadVO> empAcad = mypageService.acadDetail(empVO2);
        List<CareerVO> empCarr = mypageService.carrDetail(empVO2);
        
		
		
        emp.setFamList(empFam);
        emp.setAcadList(empAcad);
        emp.setCarrList(empCarr);
//		String currentURL = "#home1";
		log.info("emp : " + emp);
		// 가족정보 필요함
//		request.setAttribute("currentURL", currentURL);
		model.addAttribute("emp", emp);
		model.addAttribute("menuList", menuList);
		return "mypage/other";
	}
	
	@ResponseBody
	@RequestMapping(value="/famRegister", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<FamilyVO> famRegister(@RequestBody FamilyVO familyVO) {
		log.info("famRegister 실행!");
		log.info("familyVO : " + familyVO);
		FamilyVO fam = mypageService.famRegister(familyVO);
		return new ResponseEntity<FamilyVO>(fam,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/famModify", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<FamilyVO> famModify(@RequestBody FamilyVO familyVO) {
		log.info("famModify 실행!");
		log.info("familyVO : " + familyVO);
		
		FamilyVO famVO = mypageService.famSelect(familyVO);
		
		return new ResponseEntity<FamilyVO>(famVO, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/carrRegister", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<CareerVO> carrRegister(@RequestBody CareerVO careerVO) {
		log.info("carrRegister 실행!");
		log.info("careerVO : " + careerVO);
		CareerVO carr = mypageService.carrRegister(careerVO);
		return new ResponseEntity<CareerVO>(carr, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/carrModify", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<CareerVO> acadModify(@RequestBody CareerVO careerVO) {
		log.info("carrModify 실행!");
		log.info("carrerVO : " + careerVO);
		CareerVO career = mypageService.carrselect(careerVO);
		return new ResponseEntity<CareerVO>(career, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/acadRegister", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<AcadVO> acadRegister(@RequestBody AcadVO acadVO) {
		log.info("acadRegister 실행!");
		log.info("acadVO : " + acadVO);
		AcadVO acad = mypageService.acadRegister(acadVO);
		return new ResponseEntity<AcadVO>(acad, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/acadModify", method = RequestMethod.POST, consumes = "application/json; charset=utf-8")
	public ResponseEntity<AcadVO> acadModify(@RequestBody AcadVO acadVO) {
		
		log.info("acadModify 실행!");
		log.info("acadVO : " + acadVO);
		AcadVO acad = mypageService.acadselect(acadVO);
		return new ResponseEntity<AcadVO>(acad, HttpStatus.OK);
	}
	
	@RequestMapping(value="/infoModify", method = RequestMethod.POST)
	public void infoModify(FamilyVO familyVO) {
		log.info("infoModify 실행!");
	}
	
	@RequestMapping(value="/acadDel", method = RequestMethod.POST)
	public ResponseEntity<String> acadDelete(String acadNo){
		log.info("acadNo : " + acadNo);
		String result = mypageService.acadDelete(acadNo);
		return new ResponseEntity<String>(result,HttpStatus.OK);
	}
	
	@RequestMapping(value="/carrDel", method = RequestMethod.POST)
	public ResponseEntity<String> carrDelete(String caNo){
		log.info("acadNo : " + caNo);
		String result = mypageService.carrDelete(caNo);
		return new ResponseEntity<String>(result,HttpStatus.OK);
	}
	
	@RequestMapping(value="/famDel", method = RequestMethod.POST)
	public ResponseEntity<String> famDelete(String efNo){
		log.info("acadNo : " + efNo);
		String result = mypageService.famdDelete(efNo);
		return new ResponseEntity<String>(result,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/profileupdate", method = RequestMethod.POST)
	public String updateForm(LibraryVO attach, Model model, RedirectAttributes ra, HttpServletRequest req) throws IllegalStateException, IOException {
		ServiceResult result = null; 
		
		EmpVO emp = mypageMapper.selectEmpProfileOne(attach.getEmpNo());
		
		AttachVO attachVO = mypageMapper.selectAttachOne(emp.getEmpProfile());
		
		result = mypageService.imgUpdate(attach, emp, attachVO, req);
		ra.addFlashAttribute("result", result);
		return "redirect:/mypage/main";
	}
	
	
//	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
//	public String updateProfile(
//			HttpServletRequest req,
//			RedirectAttributes ra,
//			EmpVO empVO, Model model) {
//		log.info("update() 실행...!");
//		
//		String goPage = "";
//		ServiceResult result = mypageService.updateProfile(req, empVO);
//		if(result.equals(ServiceResult.OK)) {
//			ra.addFlashAttribute("message", "수정이 완료되었습니다.");
//			goPage = "redirect:/mypage/main?empNo=" + empVO.getEmpNo();
//		}else {
//			model.addAttribute("message", "수정에 실패했습니다...");
//			model.addAttribute("profile", empVO);
//			goPage = "mypage/main";
//		}
//		return goPage;
//	}
	
	
	
	
	
	
	
	
}
