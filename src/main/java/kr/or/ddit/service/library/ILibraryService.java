package kr.or.ddit.service.library;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface ILibraryService {

	public List<LibraryVO> libList(PaginationInfoVO<LibraryVO> pagingVO);

	public int listCount();

	public ServiceResult deleteLib(String libNo);

	public List<LibraryVO> seachList(LibraryVO libVO);

	public LibraryVO detail(String libNo);

	public ServiceResult libRegister(HttpServletRequest req, LibraryVO libVO) throws Exception;

	public AttachVO selectAttachInfo(String libFileNo);

}
