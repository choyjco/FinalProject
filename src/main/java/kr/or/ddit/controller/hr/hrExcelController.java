package kr.or.ddit.controller.hr;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.hr.IHrService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hr")
public class hrExcelController {

	@Inject
	private IHrService hrService;
    
    /**
     * 관리자 이상 - 사원 전체 리스트의 엑셀
     * @param response
     * @throws IOException
     */
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
    @GetMapping(value = "/mhr1Excel")
    public void excelDownload(HttpServletResponse response) throws IOException{
    	
    	// workbook -> 엑셀 파일 객체
    	Workbook workbook = new HSSFWorkbook();
    	// 하나의 sheet 생성
    	Sheet sheet = workbook.createSheet("구성원 시트");
    	// row 갯수를 카운팅 하기 위한 변수
    	int rowNo = 0;
    	
    	// 엑셀 파일 최상위 행에 삽입될 변수명
    	Row headerRow = sheet.createRow(rowNo++);
    	headerRow.createCell(0).setCellValue("이름");
    	headerRow.createCell(1).setCellValue("재직 상태");
    	headerRow.createCell(2).setCellValue("사번");
    	headerRow.createCell(3).setCellValue("입사일");
    	headerRow.createCell(4).setCellValue("근속기간");
    	headerRow.createCell(5).setCellValue("근로유형");
    	
    	// DB에서 받아온 데이터들을 반복문을 이용해 각각의 row 작성
    	List<EmpVO> mhr1List = hrService.excelMhr1List();
    	for(EmpVO empVO : mhr1List) {
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		Date empDate = empVO.getEmpDate();
    		String formattedEmpDate = sdf.format(empDate);
    		// createRow 메소드를 통해 행을 생성하고, 해당 행의 지정된 열에 반복문을 통해 값을 넣어준다. 
    		Row row = sheet.createRow(rowNo++);
    		row.createCell(0).setCellValue(empVO.getEmpName());
    		row.createCell(1).setCellValue(empVO.getEmpStat());
    		row.createCell(2).setCellValue(empVO.getEmpNo());
    		row.createCell(3).setCellValue(formattedEmpDate);
    		row.createCell(4).setCellValue(empVO.getEmpKdate());
    		row.createCell(5).setCellValue(empVO.getEmpWork());
    		
    	}
    	
    	// 응답 컨텐츠와 헤더를 정해 주기
    	// header를 통해 파일명을 지정해주는 방식으로는 한글 파일명을 사용할 수 없음
    	response.setContentType("application/vnd.ms-excel");
    	response.setHeader("Content-Disposition", "attachment;filename=mhr1List.xls");
    	
    	// 다운로드
    	workbook.write(response.getOutputStream());
    	// 마무리로 close();
    	workbook.close();
    }
	
	
	
	/**
     * 사원 - 사원 전체 리스트의 엑셀
     * @param response
     * @throws IOException
     */
	@PreAuthorize("hasRole('ROLE_MEMBER')")
    @GetMapping(value = "/ghrExcel")
    public void excel2Download(HttpServletResponse response) throws IOException{
    	
    	Workbook workbook = new HSSFWorkbook();
    	Sheet sheet = workbook.createSheet("구성원 시트");
    	int rowNo = 0;
    	
    	Row headerRow = sheet.createRow(rowNo++);
    	headerRow.createCell(0).setCellValue("이름");
    	headerRow.createCell(1).setCellValue("부서");
    	headerRow.createCell(2).setCellValue("직책");
    	
    	List<EmpVO> ghrList = hrService.excelGhrList();
    	for(EmpVO empVO : ghrList) {

    		Row row = sheet.createRow(rowNo++);
    		row.createCell(0).setCellValue(empVO.getEmpName());
    		row.createCell(1).setCellValue(empVO.getEmpDept());
    		row.createCell(2).setCellValue(empVO.getEmpPos());
    		
    	}
    	response.setContentType("application/vnd.ms-excel");
    	response.setHeader("Content-Disposition", "attachment;filename=ghrList.xls");
    	
    	workbook.write(response.getOutputStream());
    	workbook.close();
    }
    
	
    
}
