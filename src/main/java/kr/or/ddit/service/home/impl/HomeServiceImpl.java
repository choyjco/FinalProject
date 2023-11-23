package kr.or.ddit.service.home.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.mapper.arm.ArmMapper;
import kr.or.ddit.mapper.board.BoardMapper;
import kr.or.ddit.mapper.home.GridMapper;
import kr.or.ddit.service.home.IHomeService;
import kr.or.ddit.vo.AlarmVO;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.GridVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HomeServiceImpl implements IHomeService {

	@Inject
	private BoardMapper boardMapper;
	@Inject
	private ArmMapper armMapper;
	@Inject
	private GridMapper gridMapper;

	/**
	 *	공지사항 게시글의 갯수를 구하는 메소드
	 */
	@Override
	public int selctBoardCount(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectBoardCount(pagingVO);
	}

	/**
	 *	검색어, 페이징을 적용한 리스트출력하는 메소드
	 */
	@Override
	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO) {
		return boardMapper.selectBoardList(pagingVO);
	}
	
	/**
	 *	공지사항을 작성하는 메소드
	 */
	@Override
	public ServiceResult registerBoard(HttpServletRequest req, BoardVO boardVO) throws Exception {
		ServiceResult result = null;
		int status = boardMapper.insertBoard(boardVO);
		boardVO.setBoardFile("a"+boardVO.getBoardNo());
		if(status > 0) {
			List<AttachVO> boardFileList = boardVO.getBoardFileList();
			FileuploadUtils.boardFileUpload(boardFileList, boardVO.getBoardFile(), boardVO.getBoardNo(), req, boardMapper);
			
			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			AlarmVO alarmVO = new AlarmVO();	
			alarmVO.setArmSender(boardVO.getBoardEmpno());
			alarmVO.setArmReceiver("200101001");	// 팜하니로 일단 테스트
			alarmVO.setArmCont("새로운 공지사항이 등록되었습니다.");
			alarmVO.setArmUrl("/notice/detail?boardNo=" + boardVO.getBoardNo());
			alarmVO.setArmSendername(user.getEmp().getEmpName());
			alarmVO.setArmSenderimg(user.getEmp().getSavePath());
			armMapper.insertArm(alarmVO);
			
			alarmVO.setArmReceiver("202101001");	// 강해린 일단 테스트
			armMapper.insertArm(alarmVO);
			
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *	게시판 상세보기를 위한 메소드
	 */
	@Override
	public BoardVO selectBoard(String boardNo) {
		return boardMapper.selectBoard(boardNo);
	}

	/**
	 *	게시판 상세보기의 파일을 위한 메소드
	 */
	@Override
	public AttachVO selectFileInfo(String fileNo) {
		boardMapper.downcountFileInfo(fileNo);
		return boardMapper.selectFileInfo(fileNo);
	}

	/**
	 *	공지사항 게시글을 삭제하는 메소드
	 */
	@Override
	public ServiceResult deleteBoard(String boardNo) {
		ServiceResult result = null;
		int status2 = boardMapper.deleteBoardFile(boardNo);
		log.info("{}", status2);
		
		int status = boardMapper.deleteBoard(boardNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result  = ServiceResult.FAILED;
		}
		return result;
	}

	/**
	 *	공지사항을 수정하는 메소드
	 */
	@Override
	public ServiceResult updateBoard(HttpServletRequest req, BoardVO boardVO) {
		ServiceResult result = null;
		int status = boardMapper.updateBoard(boardVO);
		boardVO.setBoardFile(boardVO.getBoardFile());
		if(status > 0) {
			List<AttachVO> boardFileList = boardVO.getBoardFileList();
			try {
				
				FileuploadUtils.boardFileUpload(boardFileList, boardVO.getBoardFile(), boardVO.getBoardNo(), req, boardMapper);
				
				Integer[] delBoardNo = boardVO.getDelBoardNo();
				if(delBoardNo != null) {
					boardMapper.deleteBoardFileList(delBoardNo);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	/**
	 *	포틀릿 적용정보를 가져오기 위한 메소드
	 */
	@Override
	public List<GridVO> selectGrid() {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<GridVO> gridList = gridMapper.selectGrid(user.getEmp().getEmpNo());
		return gridList;
	}

	@Override
	public ServiceResult updateGrid(List<GridVO> gridList) {
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ServiceResult result = null;
		
		for(GridVO gridVO : gridList) {
			gridVO.setEmpNo(user.getEmp().getEmpNo());
			int status = gridMapper.updateGrid(gridVO);
			if (status > 0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
				return result;
			}
		}
		return result;
	}

}
