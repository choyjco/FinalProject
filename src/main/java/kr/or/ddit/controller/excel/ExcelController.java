package kr.or.ddit.controller.excel;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.vacation.IVacationService;
import kr.or.ddit.service.work.IWorkService;
import kr.or.ddit.vo.VacationPersonalVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/excel")
@Controller
public class ExcelController {

	@Inject
	private IWorkService workService;

	@Inject
	private IVacationService vacationService;
	
	/**
	 * 전체 구성원의 근무 내역을 엑셀로 다운로드 받을 수 있는 메소드
	 * @param firstDate
	 * @param lastDate
	 * @param selectDept
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/teamworklist")
    public void downloadTeamWorkListExcel(
    		@RequestParam("firDate") String firstDate,
    		@RequestParam("laDate") String lastDate,
    		@RequestParam("selDept") String selectDept,
    		HttpServletResponse response
    		) throws IOException {
		
		log.info("넘어온 날짜 : {} ", firstDate);
		log.info("넘어온 날짜 !: {}", lastDate);
		log.info("넘어온 부서이름 !!!: {}", selectDept);
		
		HashMap<String , String> map = new HashMap<String, String>();
		map.put("firstDate", firstDate);
		map.put("lastDate", lastDate);
		map.put("selectDept", selectDept);
		
		List<WorkVO> teamList = workService.teamWorkList(map);
        
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("전체 구성원 근무 기록");
		int rowNo = 0;
		
		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("사원 이름");
		headerRow.createCell(1).setCellValue("부서 이름");
		headerRow.createCell(2).setCellValue("근무 시작 시간");
		headerRow.createCell(3).setCellValue("근무 종료 시간");
		headerRow.createCell(4).setCellValue("하루 근무 시간");
		
		for(WorkVO work : teamList) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date workStime = work.getWorkStime();
			Date workEtime = work.getWorkEtime();
			String formattedStime = sdf.format(workStime);
			String formattedEtime = sdf.format(workEtime);
		    
			Row row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue(work.getEmpName());
			row.createCell(1).setCellValue(work.getComName());
			row.createCell(2).setCellValue(formattedStime);
			row.createCell(3).setCellValue(formattedEtime);
			row.createCell(4).setCellValue(work.getWorkTotal());
		}
		
		response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=teamWorkList.xlsx");
 
        workbook.write(response.getOutputStream());
        workbook.close();
		
    }

	/**
	 * 전체 구성원의 주차별 근무 내역을 엑셀로 다운로드 받을 수 있는 메소드
	 * @param firstDate
	 * @param lastDate
	 * @param selectDept
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/workmanagelist")
	public void downloadWorkManageListExcel(
			@RequestParam("firDate") String firstDate,
			@RequestParam("laDate") String lastDate,
			@RequestParam("selDept") String selectDept,
			HttpServletResponse response
			) throws IOException {
		
		log.info("넘어온 날짜 : {} ", firstDate);
		log.info("넘어온 날짜 !: {}", lastDate);
		log.info("넘어온 부서이름 !!!: {}", selectDept);
		
		HashMap<String , String> map = new HashMap<String, String>();
		map.put("firstDate", firstDate);
		map.put("lastDate", lastDate);
		map.put("selectDept", selectDept);
		
		List<WorkVO> workManageList = workService.workManageList(map);
		
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("전체 근무 기록");
		int rowNo = 0;
		
		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("사원 이름");
		headerRow.createCell(1).setCellValue("사번");
		headerRow.createCell(2).setCellValue("부서 이름");
		headerRow.createCell(3).setCellValue("기간 내 총 근무 시간");
		
		for(WorkVO work : workManageList) {
			Row row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue(work.getEmpName());
			row.createCell(1).setCellValue(work.getEmpNo());
			row.createCell(2).setCellValue(work.getComName());
			row.createCell(3).setCellValue(work.getWorkSum());
		}
		
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=workManageList.xlsx");
		
		workbook.write(response.getOutputStream());
		workbook.close();
		
	}

	
	@RequestMapping(value = "/annualmanagelist")
	public void downloadAnnualManageListExcel(
			@RequestParam("selYear") String selYear,
			HttpServletResponse response
			) throws IOException {
		
		log.info("넘어온 연도 엑셀 : {} ", selYear);
		
		HashMap<String , String> map = new HashMap<String, String>();
		map.put("year", selYear);
		
		List<VacationPersonalVO> annualManageList = vacationService.annualManageList(map);
		
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("전체 근무 기록");
		int rowNo = 0;
		
		Row headerRow = sheet.createRow(rowNo++);
		headerRow.createCell(0).setCellValue("사원 이름");
		headerRow.createCell(1).setCellValue("사번");
		headerRow.createCell(2).setCellValue("부서 이름");
		
		headerRow.createCell(3).setCellValue("잔여 연차");
		
		headerRow.createCell(4).setCellValue("1월");
		headerRow.createCell(5).setCellValue("2월");
		headerRow.createCell(6).setCellValue("3월");
		headerRow.createCell(7).setCellValue("4월");
		headerRow.createCell(8).setCellValue("5월");
		headerRow.createCell(9).setCellValue("6월");
		headerRow.createCell(10).setCellValue("7월");
		headerRow.createCell(11).setCellValue("8월");
		headerRow.createCell(12).setCellValue("9월");
		headerRow.createCell(13).setCellValue("10월");
		headerRow.createCell(14).setCellValue("11월");
		headerRow.createCell(15).setCellValue("12월");
		
		for(VacationPersonalVO vacation : annualManageList) {
			Row row = sheet.createRow(rowNo++);
			row.createCell(0).setCellValue(vacation.getEmpName());
			row.createCell(1).setCellValue(vacation.getEmpNo());
			row.createCell(2).setCellValue(vacation.getComName());
			// 잔여연차 계산
			int totalVacationDays = (vacation.getJan() != null ? Integer.parseInt(vacation.getJan()) : 0) +
				                    (vacation.getFeb() != null ? Integer.parseInt(vacation.getFeb()) : 0) +
				                    (vacation.getMar() != null ? Integer.parseInt(vacation.getMar()) : 0) +
				                    (vacation.getApr() != null ? Integer.parseInt(vacation.getApr()) : 0) +
				                    (vacation.getMay() != null ? Integer.parseInt(vacation.getMay()) : 0) +
				                    (vacation.getJun() != null ? Integer.parseInt(vacation.getJun()) : 0) +
				                    (vacation.getJul() != null ? Integer.parseInt(vacation.getJul()) : 0) +
				                    (vacation.getAug() != null ? Integer.parseInt(vacation.getAug()) : 0) +
				                    (vacation.getSep() != null ? Integer.parseInt(vacation.getSep()) : 0) +
				                    (vacation.getOct() != null ? Integer.parseInt(vacation.getOct()) : 0) +
				                    (vacation.getNov() != null ? Integer.parseInt(vacation.getNov()) : 0) +
				                    (vacation.getDec() != null ? Integer.parseInt(vacation.getDec()) : 0);
			row.createCell(3).setCellValue(totalVacationDays);	// 잔여연차
			row.createCell(4).setCellValue(vacation.getJan());
			row.createCell(5).setCellValue(vacation.getFeb());
			row.createCell(6).setCellValue(vacation.getMar());
			row.createCell(7).setCellValue(vacation.getApr());
			row.createCell(8).setCellValue(vacation.getMay());
			row.createCell(9).setCellValue(vacation.getJun());
			row.createCell(10).setCellValue(vacation.getJul());
			row.createCell(11).setCellValue(vacation.getAug());
			row.createCell(12).setCellValue(vacation.getSep());
			row.createCell(13).setCellValue(vacation.getOct());
			row.createCell(14).setCellValue(vacation.getNov());
			row.createCell(15).setCellValue(vacation.getDec());
		}
		
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=annualManageList.xlsx");
		
		workbook.write(response.getOutputStream());
		workbook.close();
		
	}
	
	
	
	
	
	
	
}
