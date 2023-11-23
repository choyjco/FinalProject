package kr.or.ddit.controller.week;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.service.week.IHolidayService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HolidayController {
	
	@Inject
	private IHolidayService holService;
	
	// 공휴일 가져오기
	@RequestMapping(value = "/holiday", method = RequestMethod.GET)
	public ResponseEntity<?> getHolidayController() throws IOException { 
		log.info("공휴일 가져와");
		return new ResponseEntity<Object>(holService.getHolidayService("2023", "10"), HttpStatus.OK);
	}
	

}
