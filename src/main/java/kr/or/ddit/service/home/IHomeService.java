package kr.or.ddit.service.home;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.GridVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IHomeService {

	public int selctBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO);

	public ServiceResult registerBoard(HttpServletRequest req, BoardVO boardVO) throws Exception;

	public BoardVO selectBoard(String boardNo);

	public AttachVO selectFileInfo(String fileNo);

	public ServiceResult deleteBoard(String boardNo);

	public ServiceResult updateBoard(HttpServletRequest req, BoardVO boardVO);

	public List<GridVO> selectGrid();

	public ServiceResult updateGrid(List<GridVO> gridList);
}
