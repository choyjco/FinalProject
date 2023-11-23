package kr.or.ddit.service.mypage.impl;


import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.mapper.mypage.MyPageMapper;
import kr.or.ddit.service.mypage.IMyPageService;
import kr.or.ddit.vo.AcadVO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FamilyVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.LibraryVO;

@Service
public class MypageServiceImpl implements IMyPageService {

	@Inject
	private MyPageMapper mypageMapper; 
	
	@Override
	public InfoVO detail(EmpVO empVO) {
		return mypageMapper.detail(empVO);
	}

	@Override
	public List<FamilyVO> famdetail(EmpVO emp) {
		return mypageMapper.famDetail(emp);
	}

	@Override
	public List<CareerVO> carrDetail(EmpVO emp) {
		return mypageMapper.carrDetail(emp);
	}

	@Override
	public List<AcadVO> acadDetail(EmpVO emp) {
		return mypageMapper.acadDetail(emp);
	}


	@Override
	public AcadVO acadselect(AcadVO acadVO) {
		mypageMapper.acadModify(acadVO);
		return mypageMapper.acadSelect(acadVO);
	}

	@Override
	public CareerVO carrselect(CareerVO carrerVO) {
		mypageMapper.carrModify(carrerVO);
		return mypageMapper.carrSelect(carrerVO);
	}

	@Override
	public FamilyVO famSelect(FamilyVO familyVO) {
		mypageMapper.famModify(familyVO);		
		return mypageMapper.famSelect(familyVO);
	}

	@Override
	public String acadDelete(String acadNo) {
		String result = "";
		int del = mypageMapper.acadDelete(acadNo);
		if(del > 0) {
			result = "성공";
		}else {
			result = "실패";
		}
		return result;
	}

	@Override
	public String carrDelete(String caNo) {
		String result = "";
		int del = mypageMapper.carrDelete(caNo);
		if(del > 0) {
			result = "성공";
		}else {
			result = "실패";
		}
		return result;
	}

	@Override
	public String famdDelete(String efNo) {
		String result = "";
		int del = mypageMapper.famDelete(efNo);
		if(del > 0) {
			result = "성공";
		}else {
			result = "실패";
		}
		return result;
	}

	@Override
	public FamilyVO famRegister(FamilyVO familyVO) {
		int cnt = mypageMapper.famRegister(familyVO);
		
		if(cnt > 0) {
			String efNo = mypageMapper.efNoSelect(familyVO);
			familyVO.setEfNo(efNo);
		}
		return familyVO;
	}

	@Override
	public CareerVO carrRegister(CareerVO careerVO) {
		int cnt = mypageMapper.carrRegister(careerVO);
		if(cnt > 0) {
			String caNo = mypageMapper.caNoSelect(careerVO);
			careerVO.setCaNo(caNo);
		}
		return careerVO;
	}

	@Override
	public AcadVO acadRegister(AcadVO acadVO) {
		int cnt = mypageMapper.acadRegister(acadVO);
		if(cnt > 0) {
			String acadNo = mypageMapper.acadNoSelect(acadVO);
			acadVO.setAcadNo(acadNo);
		}
		return acadVO;
	}

	@Override
	public EmpVO selectEmpOne(EmpVO empVO) {
		return mypageMapper.selectEmpOne(empVO);
	}
	
	
	/**
	 * attach : 새로운 파일정보를 받은 객체
	 * emp : 이미지를 변경할 사원
	 * attachVO : 기존의 사원의 프로필 객체
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@Override
	public ServiceResult imgUpdate(LibraryVO attach, EmpVO emp, AttachVO attachVO, HttpServletRequest req) throws IllegalStateException, IOException {
		ServiceResult result = null;
		int status = 0;
		status += mypageMapper.updateDeleteConf(attachVO);
		FileuploadUtils.imgUpdate(attach.getAttachLib(),emp, req, mypageMapper);
		status += mypageMapper.updateEmpProfile(emp);
		if(status > 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

//	@Override
//	public EmpVO selectEmpProfileOne(String empNo) {
//		return mypageMapper.selectEmpProfileOne(empNo);
//	}
//
//	@Override
//	public AttachVO selectAttachOne(String fileNo) {
//		return mypageMapper.selectAttachOne(fileNo);
//	}
//
//	@Override
//	public ServiceResult updateProfile(HttpServletRequest req, EmpVO empVO) {
//		ServiceResult result = null;
//		int status = mypageMapper.updateBoard(empVO);
//		empVO.setImgFile(empVO.getImgFile());
//		if(status > 0) {
//			List<AttachVO> boardFileList = empVO.getBoardFileList();
//			try {
//				
//				FileuploadUtils.boardFileUpload(boardFileList, empVO.getBoardFile(), empVO.getBoardNo(), req, mypageMapper);
//				
//				Integer[] delBoardNo = boardVO.getDelBoardNo();
//				if(delBoardNo != null) {
//					boardMapper.deleteBoardFileList(delBoardNo);
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			result = ServiceResult.OK;
//		}else {
//			result = ServiceResult.FAILED;
//		}
//		
//		return result;
//	}
//	

	

	
	


}
