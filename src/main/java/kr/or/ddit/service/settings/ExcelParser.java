package kr.or.ddit.service.settings;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.SettingsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ExcelParser {

	public List<EmpVO> getExcelData(AttachVO vo, HttpServletRequest req) {
		List rtnList = new ArrayList();
		try {
			String filePath = FileuploadUtils.excelFileUpload(vo, req);
			FileInputStream fin = new FileInputStream(filePath);
			Workbook wb = new XSSFWorkbook(fin);
			Sheet sh = wb.getSheetAt(0);
			
			for (Row i : sh) {
				Map emp = new HashMap();
				if(i.getRowNum() < 1) continue;
				
//				for(int j=0;j<15;j++) {
//					emp.add(i.getCell(j).toString());
//				}
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
				EmpVO empVO = new EmpVO();
				empVO.setEmpNo(i.getCell(0).toString());
				empVO.setEmpName(i.getCell(1).toString());
				empVO.setEmpEname(i.getCell(2).toString());
				empVO.setEmpGen(i.getCell(3).toString());
				empVO.setEmpReg1(i.getCell(4).toString());
				empVO.setEmpReg2(i.getCell(5).toString());
				empVO.setEmpTel(i.getCell(6).toString());
				empVO.setEmpAddr1(i.getCell(7).toString());
				empVO.setEmpAddr2(i.getCell(8).toString());
				empVO.setEmpEmail(i.getCell(9).toString());
				empVO.setEmpDate(formatter.parse(i.getCell(10).toString()));
				empVO.setEmpStat(i.getCell(11).toString());
				empVO.setEmpWork(i.getCell(12).toString());
				empVO.setEmpAcct(i.getCell(13).toString());
				empVO.setEmpBank(i.getCell(14).toString());
				
				rtnList.add(empVO);
			}
			log.info("rtnList : "+ rtnList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rtnList;
	}
}
