package kr.or.ddit.mapper.library;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface LibMapper {

	public List<LibraryVO> libList(PaginationInfoVO<LibraryVO> pagingVO);

	public int listCount();

	public int deleteLib(LibraryVO libVO);

	public List<LibraryVO> searchList(LibraryVO libVO);

	public LibraryVO detail(String libNo);

	public int libRegister(LibraryVO libVO);

	public void insertAttach(AttachVO libFile);

	public String selectLibNo();

	public int deleteAttach(LibraryVO libVO);

	public String selectFileNo();

	public int updateFileNo(LibraryVO libVO);

	public AttachVO selectAttachInfo(String libFileNo);

	public void downCountUpdate(String libFileNo);

	public int libSize();

	public int libListCnt(PaginationInfoVO<LibraryVO> pagingVO);

}
