package kr.or.ddit.mapper.board;

import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface BoardMapper {

	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO);
	
	public int insertBoard(BoardVO boardVO);

	public void insertBoardFile(AttachVO attachVO);

	public BoardVO selectBoard(String boardNo);

	public AttachVO selectFileInfo(String fileNo);

	public int deleteBoardFile(String fileCode);

	public int deleteBoard(String boardNo);

	public int updateBoard(BoardVO boardVO);

	public void deleteBoardFileList(Integer[] delBoardNo);

	public void downcountFileInfo(String fileNo);

}
