package kr.or.ddit.service.main;

import java.util.List;

import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IMainUserService {

	// 구매 내역(회원)
	public CustomerVO selectPaymentListU(String cusRnum);

	// 회원 정보 상세(회원)
	public CustomerVO selectMemberDetail(String cusRnum);

	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO);

	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO);




}
