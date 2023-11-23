package kr.or.ddit.service.main.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.main.MainLoginMapper;
import kr.or.ddit.service.main.IMainLoginService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainLoginServiceImpl implements IMainLoginService {
	
	@Inject
	private MainLoginMapper mainLoginMapper;
	
	/**
	 * 회원가입
	 */
	@Override
	public ServiceResult register(HttpServletRequest req, CustomerVO customerVO) {
		ServiceResult result = null;
//		String fileSavepath = "";
		AttachVO attachVO = new AttachVO();
		
		// 회사 로고
		String uploadPath1 = req.getServletContext().getRealPath("/resources/wsisite/logo");
		File file1 = new File(uploadPath1);
		if(!file1.exists()) {
			file1.mkdirs();
		}
		
		String logoImg = "";
		// 로고 이미지 경로
		try {
			
			MultipartFile logoImgFile = customerVO.getCusLogoImg();
			
			if(logoImgFile != null) {
				
				if(logoImgFile.getOriginalFilename() != null &&
						!logoImgFile.getOriginalFilename().equals("")) {
					String fileName1 = UUID.randomUUID().toString();	// UUID 파일명 생성
					fileName1 += "_" + logoImgFile.getOriginalFilename(); // UUID_원본파일명
					uploadPath1 += "/" + fileName1;	// 최종 업로드하기 위한 파일 경로
					logoImgFile.transferTo(new File(uploadPath1));	// 해당 위치 경로에 파일 복사
					logoImg = "/resources/wsisite/logo/" + fileName1;		// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
					
					attachVO.setFileSavepath(logoImg);
					attachVO.setFileName(fileName1);
					attachVO.setFileOrgname(logoImgFile.getOriginalFilename());
					attachVO.setFileSize(logoImgFile.getSize());
					attachVO.setFileMime(logoImgFile.getContentType());
					attachVO.setFileUploader(customerVO.getCusRnum());
					attachVO.setFileCode('E' + customerVO.getCusRnum());
					
					mainLoginMapper.registerFile(attachVO);
					
					customerVO.setCusLogo(attachVO.getFileNo());
				}
			
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		// 회사 프로필
		String uploadPath2 = req.getServletContext().getRealPath("/resources/wsisite/profile");
		File file2 = new File(uploadPath2);
		if(!file2.exists()) {
			file2.mkdirs();
		}
		
		String profileImg = "";
		// 프로필 이미지 경로
		try {
			
			MultipartFile profileImgFile = customerVO.getCusProfileImg();
			
			if(profileImg != null) {
				
				if(profileImgFile.getOriginalFilename() != null &&
						!profileImgFile.getOriginalFilename().equals("")) {
					String fileName2 = UUID.randomUUID().toString();	// UUID 파일명 생성
					fileName2 += "_" + profileImgFile.getOriginalFilename(); // UUID_원본파일명
					uploadPath2 += "/" + fileName2;	// 최종 업로드하기 위한 파일 경로
					profileImgFile.transferTo(new File(uploadPath2));	// 해당 위치 경로에 파일 복사
					profileImg = "/resources/wsisite/profile/" + fileName2;		// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
					
					attachVO.setFileSavepath(profileImg);
					attachVO.setFileName(fileName2);
					attachVO.setFileOrgname(profileImgFile.getOriginalFilename());
					attachVO.setFileSize(profileImgFile.getSize());
					attachVO.setFileMime(profileImgFile.getContentType());
					attachVO.setFileUploader(customerVO.getCusRnum());
					attachVO.setFileCode('E' + customerVO.getCusRnum());
					
					mainLoginMapper.registerFile(attachVO);
					
					customerVO.setCusImage(attachVO.getFileNo());
				}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		// 회사 직인
		String uploadPath3 = req.getServletContext().getRealPath("/resources/wsisite/signature");
		File file3 = new File(uploadPath3);
		if(!file3.exists()) {
			file3.mkdirs();
		}
		
		String signImg = "";
		// 회사 직인 이미지 경로
		try {
			MultipartFile signImgFile = customerVO.getCusSignImg();
			
			if(signImgFile != null) {
				
				if(signImgFile.getOriginalFilename() != null &&
						!signImgFile.getOriginalFilename().equals("")) {
					String fileName3 = UUID.randomUUID().toString();	// UUID 파일명 생성
					fileName3 += "_" + signImgFile.getOriginalFilename(); // UUID_원본파일명
					uploadPath3 += "/" + fileName3;	// 최종 업로드하기 위한 파일 경로
					signImgFile.transferTo(new File(uploadPath3));	// 해당 위치 경로에 파일 복사
					signImg = "/resources/wsisite/signature/" + fileName3;		// 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
					
					attachVO.setFileSavepath(signImg);
					attachVO.setFileName(fileName3);
					attachVO.setFileOrgname(signImgFile.getOriginalFilename());
					attachVO.setFileSize(signImgFile.getSize());
					attachVO.setFileMime(signImgFile.getContentType());
					attachVO.setFileUploader(customerVO.getCusRnum());
					attachVO.setFileCode('E' + customerVO.getCusRnum());
					
					mainLoginMapper.registerFile(attachVO);
					
					customerVO.setCusSignature(attachVO.getFileNo());
					
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String cusPw = customerVO.getCusPw();
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPw = encoder.encode(cusPw);
		customerVO.setCusPw(encodedPw);
		
		int status = mainLoginMapper.register(customerVO);
		if(status > 0) {	
			
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public CustomerVO loginCheck(CustomerVO customerVO) {
		return mainLoginMapper.loginCheck(customerVO);
	}

	@Override
	public ServiceResult idCheck(String cusRnum) {
		ServiceResult result = null;
		CustomerVO customer = mainLoginMapper.idCheck(cusRnum);
		if(customer != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}
	
	@Override
	public ServiceResult emailCheck(String cusEmail) {
		ServiceResult result = null;
		CustomerVO customer = mainLoginMapper.emailCheck(cusEmail);
		if(customer != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}


	

}
