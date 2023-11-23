package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private String boardNo;			// 게시판번호
	private String boardCate;		// 카테고리
	private String boardTitle;		// 제목
	private String boardCont;		// 내용
	private String boardFile;		// 첨부파일번호
	private String boardWriter;		// 작성자
	private Date boardRegdate;		// 작성일자
	private Date boardUpddate;		// 수정일자
	private String boardUpdater;	// 수정자
	private String boardEmpno;		// 사원번호
	
	private Integer[] delBoardNo;
	private MultipartFile[] boFile;
	private List<AttachVO> boardFileList;
	
	public void setBoFile(MultipartFile[] boFile) {
		this.boFile = boFile;
		if(boFile != null) {
			List<AttachVO> boardFileList = new ArrayList<AttachVO>();
			for(MultipartFile item : boFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				AttachVO AttachVO = new AttachVO(item);
				boardFileList.add(AttachVO);
			}
			this.boardFileList = boardFileList;
		}
	}
}
