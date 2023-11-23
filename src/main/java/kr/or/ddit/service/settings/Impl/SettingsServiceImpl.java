package kr.or.ddit.service.settings.Impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.mapper.settings.SettingMapper;
import kr.or.ddit.service.settings.ExcelParser;
import kr.or.ddit.service.settings.ISettingsService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PayVO;
import kr.or.ddit.vo.SettingsVO;
import kr.or.ddit.vo.TreeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SettingsServiceImpl implements ISettingsService {

	@Inject
	private SettingMapper mapper;
	
	@Override
	public ServiceResult vacCheck(String vacName) {
		ServiceResult result = null;
		SettingsVO settingsVO = mapper.vacCheck(vacName);
		if(settingsVO != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}	

	@Override
	public List<SettingsVO> vacList() {
		return mapper.vacList();
	}

	@Override
	public SettingsVO selectCus(String string) {
		return mapper.selectCus(string);
	}

	@Override
	public ServiceResult updateCus(HttpServletRequest req, SettingsVO settingsVO) {
		ServiceResult result = null;
		if(settingsVO.getCusLogoFile() != null && !settingsVO.getCusLogoFile().getOriginalFilename().equals("")) {
			settingsVO = uploadFileImage("logo",settingsVO,settingsVO.getCusLogoFile(),req);
		}
		if(settingsVO.getCusImageFile() != null && !settingsVO.getCusImageFile().getOriginalFilename().equals("")) {
			settingsVO = uploadFileImage("image",settingsVO,settingsVO.getCusImageFile(),req);
		}
		if(settingsVO.getCusSignatureFile() != null && !settingsVO.getCusSignatureFile().getOriginalFilename().equals("")) {
			settingsVO = uploadFileImage("signature",settingsVO,settingsVO.getCusSignatureFile(),req);
		}
		
		int status = mapper.updateCus(settingsVO);
		
		settingsVO.setCusLogo(settingsVO.getCusLogo());
		settingsVO.setCusImage(settingsVO.getCusImage());
		settingsVO.setCusSignature(settingsVO.getCusSignature());
		if(status > 0) {
			List<AttachVO> cusFileList = settingsVO.getCusFileList();
			try {
				FileuploadUtils.cusFileUpload(cusFileList, settingsVO.getCusLogo(), settingsVO.getCusImage(), settingsVO.getCusSignature(),settingsVO.getCusRnum(), req, mapper);
			} catch (Exception e) {
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	private SettingsVO uploadFileImage(String type, SettingsVO settingsVO, MultipartFile file, HttpServletRequest req) {
		String uploadPath = "/resources/settings/";
		String savePath = req.getServletContext().getRealPath(uploadPath);
		File sfile = new File(savePath);
		
		if(!sfile.exists()) {
			sfile.mkdirs();
		}
		
		AttachVO attach = null;
		String uuidFileName = UUID.randomUUID().toString();
		String fileName = uuidFileName + "_" + file.getOriginalFilename();
		String saveLocate = savePath + fileName;
		attach = new AttachVO();
		attach.setFileSavepath(saveLocate);
		attach.setFileName(fileName);
		attach.setFileOrgname(file.getOriginalFilename());
		attach.setFileSize(file.getSize());
		attach.setFileMime(file.getContentType());
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // 시큐리티에 담긴 로그인된 유저 정보
		attach.setFileUploader(user.getEmp().getEmpNo());
		attach.setFileCode("cus");
		
		File newFile = new File(saveLocate);
		try {
			file.transferTo(newFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mapper.insertCompFile(attach);
//		int stat = mapper.delCusFile(attach);

		if(type.equals("logo")) {
			settingsVO.setCusLogo(attach.getFileNo());
		}else if(type.equals("image")) {
			settingsVO.setCusImage(attach.getFileNo());
		}else {
			settingsVO.setCusSignature(attach.getFileNo());
		}
		return settingsVO;
	}

	@Override
	public ServiceResult registerVac(HttpServletRequest req, SettingsVO settingsVO) {
		ServiceResult result = null;
		int status = mapper.registerVac(settingsVO);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult deleteVac(String vacCode) {
		ServiceResult result = null;
		int status = mapper.deleteVac(vacCode);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<SettingsVO> empList() {
		return mapper.empList();
	}

	@Override
	public int empModifyAuth(SettingsVO settingsVO) {
		return mapper.empModifyAuth(settingsVO);
	}

	@Override
	public List<TreeVO> deptList() {
		return mapper.deptList();
	}

	@Override
	public List<TreeVO> searchList(TreeVO tree) {
		return mapper.searchList(tree);
	}

	@Override
	public List<TreeVO> posList() {
		return mapper.posList();
	}


	@Override
	public List<TreeVO> rankList() {
		return mapper.rankList();
	}


	@Override
	public List<TreeVO> jobList() {
		return mapper.jobList();
	}

	@Override
	public int insertEmpExcel(SettingsVO settingsVO, HttpServletRequest req) {
		ExcelParser parser = new ExcelParser();
		int iinsertCnt = 0;
		try {

			AttachVO aVO = new AttachVO(settingsVO.getEmpListFile());
			
			List<EmpVO> empList= parser.getExcelData(aVO,req);
			for(EmpVO vo : empList) {
				mapper.insertEmp(vo);
				iinsertCnt++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return iinsertCnt;
	}

	@Override
	public List<SettingsVO> empMemList() {
		return mapper.empMemList();
	}

	@Override
	public List<SettingsVO> empManList() {
		return mapper.empManList();
	}

	@Override
	public List<SettingsVO> empAdmList() {
		return mapper.empAdmList();
	}

	@Override
	public List<SettingsVO> roleList() {
		return mapper.roleList();
	}

	@Override
	public ServiceResult roleCheck(String empRole) {
		ServiceResult result = null;
		SettingsVO settingsVO = mapper.roleCheck(empRole);
		if(settingsVO != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public ServiceResult registerRole(HttpServletRequest req, SettingsVO settingsVO) {
		
		List<SettingsVO> setList;
		int status=0;
		setList = mapper.empNoList(settingsVO);
		for(SettingsVO vo : setList) {
			vo.setEmpRole(settingsVO.getEmpRole());
			status += mapper.registerRole(vo);
		}
		
		ServiceResult result = null;
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult treeUpdate(List<TreeVO> treeVO) {
		int status = 0;
		ServiceResult result = null;
		try {
			mapper.initTree();
			for(TreeVO vo : treeVO) {
				if(vo.getParent() == "#" || vo.getParent().equals("#")) continue;
				status = mapper.treeUpdate(vo);
				result = ServiceResult.OK;
			}
		}catch(Exception e) {
			mapper.rollbackTree();
			e.printStackTrace();
			result  = ServiceResult.FAILED;
		}
		
		return result;
	}
	
}
