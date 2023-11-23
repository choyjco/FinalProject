package kr.or.ddit.service.main.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.main.MainUserMapper;
import kr.or.ddit.service.main.IMainUserService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncLevelVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class MainUserServiceImpl implements IMainUserService {

	@Inject
	private MainUserMapper mainUserMapper;
	
	// 구매 내역(회원)
	@Override
	public CustomerVO selectPaymentListU(String cusRnum) {
		return mainUserMapper.selectPaymentListU(cusRnum);
	}

	// 회원 정보 상세(회원)
	@Override
	public CustomerVO selectMemberDetail(String cusRnum) {
		return mainUserMapper.selectMemberDetail(cusRnum);
	}

	@Override
	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainUserMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainUserMapper.selectBoardList(pagingVO);
	}




}
