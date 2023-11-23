package kr.or.ddit.controller.search;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.common.ICommonService;
import kr.or.ddit.service.login.ILoginService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EmpSearch {

	@Inject
	private ILoginService loginService;
	
	@Inject
	private ICommonService commonService;
	
	@ResponseBody
	@RequestMapping(value = "/empSearch", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public List<EmpVO> empSearch(@RequestBody Map<String, String> map) {
		List<EmpVO> empList = loginService.empSearch(map.get("empName"));
		for(EmpVO emp : empList) {
			emp.setEmpDept(commonService.selectCommon(emp.getEmpDept()));
		}
		
		return empList;
	}
}
