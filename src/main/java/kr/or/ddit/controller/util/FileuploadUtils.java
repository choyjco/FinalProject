package kr.or.ddit.controller.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.board.BoardMapper;
import kr.or.ddit.mapper.hr.HrMapper;
import kr.or.ddit.mapper.library.LibMapper;
import kr.or.ddit.mapper.mypage.MyPageMapper;
import kr.or.ddit.mapper.settings.SettingMapper;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.SettingsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileuploadUtils {

	public static void boardFileUpload(
			List<AttachVO> boardFileList, String boardFile, String boardNo, HttpServletRequest req, BoardMapper mapper
			) throws Exception {
		String savePath = "/resources/notice/";
		
		if (boardFileList != null && boardFileList.size() > 0) {
			for(AttachVO AttachVO : boardFileList) {
				String saveName = UUID.randomUUID().toString();
				AttachVO.setFileOrgname(AttachVO.getFileName());
				AttachVO.setFileName(saveName);
				saveName = saveName + "_" + AttachVO.getFileOrgname().replace(" ", "_");
				
				String saveLocate = req.getServletContext().getRealPath(savePath + boardNo);
				File file = new File(saveLocate);
				if (!file.exists()) {
					file.mkdirs();
				}
				
				CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				
				saveLocate += "/" + saveName;
				AttachVO.setFileNo(boardNo);
				AttachVO.setFileSavepath(saveLocate);
				AttachVO.setFileCode(boardFile);
				AttachVO.setFileUploader(user.getEmp().getEmpNo());
				mapper.insertBoardFile(AttachVO);
				
				File savaFile = new File(saveLocate);
				AttachVO.getItem().transferTo(savaFile);	// 파일 복사
			}
		}
		
	}
	
	public static void customerBasicFileUpload(AttachVO attachVO, String empNo, HttpServletRequest req, HrMapper hrMapper, String uploadPath)
			throws Exception {

		// 이미지로 저장할 file
//		MultipartFile imgFile = AttachVO.getItem();
		String upload = "C:/99.JSP_SPRING/02.SPRING2/workspace_spring2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/WSIProject"+attachVO.getFileSavepath();
		upload = req.getServletContext().getRealPath("/resources/images/profile.jpg");
		log.debug("upload 경로 :" + upload);
//		Resource resource = new ClassPathResource(upload);
//		File imageFile = resource.getFile();
		File imageFile = new File(upload);
		// 프로필 이미지를 저장할 기본 경로
		String savePath = "/resources/profile";
		
//		String saveName = UUID.randomUUID().toString();
		String saveName = imageFile.getName();

		// profile 폴더 안에 사번을 이름으로 생성한 폴더 안에 이미지 파일 upload
		String saveLocate = req.getServletContext().getRealPath(savePath + "/" + empNo);
		
		
		// 경로가 없을 경우 디렉토리 생성
		File file = new File(saveLocate);
		if (!file.exists()) {
			file.mkdirs();
		}
		
//		saveLocate += "\\" + saveName;
//		log.debug("저장할 경로 : " + saveLocate);
//		
//		AttachVO AttachVO = new AttachVO();
//		AttachVO.setFileOrgname(imageFile.getName().toString());
//		AttachVO.setFileSavepath(savePath + "/" + empNo +  "\\" + saveName);
//		AttachVO.setFileUploader(empNo);
//		AttachVO.setFileName(saveName);
//		AttachVO.setFileSize(imageFile.length());
//		
//		log.info("Attach insert 시작...!");
//		hrMapper.insertProfile(AttachVO);
//		log.info("Attach insert 완료...!");
//		File saveFile = new File(saveLocate);
//		FileCopyUtils.copy(imageFile, saveFile); // 파일 복사
	}

	public static void libFileUpload(AttachVO libFile, LibraryVO libVO, HttpServletRequest req, LibMapper libMapper) throws Exception {
		String savePath = "/resources/library";
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO emp = user.getEmp();
		
		String saveLocate = req.getServletContext().getRealPath(savePath + "/" + emp.getEmpNo());
		libVO.setLibWriter(emp.getEmpNo());;
		
		String saveName = libFile.getFileName();
		File file = new File(saveLocate);
		if (!file.exists()) {
			file.mkdirs();
		}
		
		saveLocate += "\\"+UUID.randomUUID().toString()+"_" + saveName;
		libFile.setFileOrgname(libFile.getFileName());
		libFile.setFileName(saveName);
		
		libFile.setFileSavepath(saveLocate);
		libFile.setFileUploader(emp.getEmpNo());
		
		libMapper.insertAttach(libFile);
		File saveFile = new File(saveLocate);
		libFile.getItem().transferTo(saveFile);
	}

	public static void cusFileUpload(List<AttachVO> cusFileList, MultipartFile[] image, String cusRnum,
			HttpServletRequest req, SettingMapper mapper) throws Exception {
	
		String savePath = "/resources/settings/";
		
		if (cusFileList != null && cusFileList.size() > 0) {
			for(AttachVO AttachVO : cusFileList) {
				String saveName = UUID.randomUUID().toString();
				AttachVO.setFileOrgname(AttachVO.getFileName());
				AttachVO.setFileName(saveName);
				saveName = saveName + "_" + AttachVO.getFileOrgname().replace(" ", "_");
				
				String saveLocate = req.getServletContext().getRealPath(savePath + cusRnum);
				File file = new File(saveLocate);
				if (!file.exists()) {
					file.mkdirs();
				}
				
				CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				
				saveLocate += "/" + saveName;
				AttachVO.setFileNo(cusRnum);
				AttachVO.setFileSavepath(saveLocate);
				AttachVO.setFileCode(cusRnum);
				AttachVO.setFileUploader(user.getEmp().getEmpNo());
				mapper.insertCompFile(AttachVO);
				
				File savaFile = new File(saveLocate);
				AttachVO.getItem().transferTo(savaFile);	// 파일 복사
			}
		}
	}

	public static void cusFileUpload(List<AttachVO> cusFileList, String cusLogo, String cusImage, String cusSignature,
			String cusRnum, HttpServletRequest req, SettingMapper mapper) throws Exception {
		String savePath = "/resources/settings/";
		
		if (cusFileList != null && cusFileList.size() > 0) {
			for(AttachVO AttachVO : cusFileList) {
				String saveName = UUID.randomUUID().toString();
				AttachVO.setFileOrgname(AttachVO.getFileName());
				AttachVO.setFileName(saveName);
				saveName = saveName + "_" + AttachVO.getFileOrgname().replace(" ", "_");
				
				String saveLocate = req.getServletContext().getRealPath(savePath + cusRnum);
				File file = new File(saveLocate);
				if (!file.exists()) {
					file.mkdirs();
				}
				
				CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				
				saveLocate += "/" + saveName;
				AttachVO.setFileNo(cusRnum);
				AttachVO.setFileSavepath(saveLocate);
				AttachVO.setFileCode("cus");
				AttachVO.setFileUploader(user.getEmp().getEmpNo());
				mapper.insertCompFile(AttachVO);
				
				File savaFile = new File(saveLocate);
				AttachVO.getItem().transferTo(savaFile);	// 파일 복사
			}
		}
		
	}
	
	public static String excelFileUpload(AttachVO excelFile, HttpServletRequest req) throws Exception {
		String savePath = "/resources/excel";
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO emp = user.getEmp();
		
		String saveLocate = req.getServletContext().getRealPath(savePath + "/" + emp.getEmpNo());
//		settingsVO.setLibWriter(emp.getEmpNo());
		
		String saveName = excelFile.getFileName();
		File file = new File(saveLocate);
		if (!file.exists()) {
			file.mkdirs();
		}
		
		saveLocate += "\\"+UUID.randomUUID().toString()+"_" + saveName;
		excelFile.setFileOrgname(excelFile.getFileName());
		excelFile.setFileName(saveName);
		
		excelFile.setFileSavepath(saveLocate);
		excelFile.setFileUploader(emp.getEmpNo());
		
//		libMapper.insertAttach(excelFile);
		File saveFile = new File(saveLocate);
		excelFile.getItem().transferTo(saveFile);

//		String filePath = savePath +"\\"+ saveName;
		
		return saveLocate;
	}

	/**
	 * @param attachVO - 파일객체
	 * @param emp - 이미지를 변경할 사원
	 * @param req
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public static void imgUpdate(AttachVO attachVO, EmpVO emp, HttpServletRequest req, MyPageMapper mypageMapper) throws IllegalStateException, IOException {
		
		// 새로운 파일 정보를 담을 객체
		
		String empNo = emp.getEmpNo();
		
		String savePath = "/resources/profile";
		String saveLocate = req.getServletContext().getRealPath(savePath + "/" + empNo);
		String saveName = attachVO.getFileName().replace(" ", "_");
		
		attachVO.setFileSavepath(savePath + "\\" + empNo + "\\" + attachVO.getFileName().replace(" ", "_"));
		attachVO.setFileName(attachVO.getFileName().replace(" ", "_"));
		attachVO.setFileUploader(empNo);
		attachVO.setFileCode("e" + empNo);
		attachVO.setFileOrgname(attachVO.getFileName());
		
		int imgUpdate = mypageMapper.insertProfile(attachVO);
		
		if(imgUpdate > 0) {
			File file = new File(saveLocate);
			if (!file.exists()) {
				file.mkdirs();
			}
			
			File input = new File(attachVO.getFileSavepath());
			File saveFile = new File(saveLocate + "\\" + saveName);
			FileCopyUtils.copy(input, saveFile);
		}else {
			log.debug("이미지 upload 실패...!");
		}
		
	}

}
