package kr.or.ddit.service.library.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.mapper.library.LibMapper;
import kr.or.ddit.service.library.ILibraryService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class LibServiceImpl implements ILibraryService{

	@Inject
	private LibMapper libMapper; 
	
	@Override
	public List<LibraryVO> libList(PaginationInfoVO<LibraryVO> pagingVO) {
		return libMapper.libList(pagingVO);
	}

	@Override
	public int listCount() {
		return libMapper.listCount();
	}

	@Override
	public ServiceResult deleteLib(String libNo) {
		ServiceResult result = null;
		LibraryVO libVO = libMapper.detail(libNo);
		int att = libMapper.deleteAttach(libVO);
		int lib = libMapper.deleteLib(libVO);
		if(att + lib > 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<LibraryVO> seachList(LibraryVO libVO) {
		return libMapper.searchList(libVO);
	}

	@Override
	public LibraryVO detail(String libNo) {
		return libMapper.detail(libNo);
	}

	@Override
	public ServiceResult libRegister(HttpServletRequest req, LibraryVO libVO) throws Exception {
		ServiceResult result = null;
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		libVO.setLibWriter(user.getEmp().getEmpNo());
		int status = libMapper.libRegister(libVO);
		String libNo = libMapper.selectLibNo();
		
		AttachVO libFile = libVO.getAttachLib();
		String fileNo = libMapper.selectFileNo();
		
		libFile.setFileCode(libNo);
		FileuploadUtils.libFileUpload(libFile, libVO, req, libMapper);
		
		libVO.setLibNo(libNo);
		libVO.setLibFileNo(fileNo);
		status += libMapper.updateFileNo(libVO);
		
		if(status > 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public AttachVO selectAttachInfo(String libFileNo) {
		libMapper.downCountUpdate(libFileNo);
		return libMapper.selectAttachInfo(libFileNo);
	}
	
}
