package kr.or.ddit;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.or.ddit.mapper.board.BoardMapper;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;


public class TestApp {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				new String[] {"/kr/or/ddit/board_SQL"});
		
		
		BoardMapper BoardMapper = (BoardMapper)context.getBean("noticeBoardMapper");
		
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<BoardVO>();
		
		List<BoardVO> boardList = BoardMapper.selectBoardList(pagingVO);
	}
}
