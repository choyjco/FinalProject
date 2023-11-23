package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AttachVO {
	
	private MultipartFile item;
	private String fileNo;				// 파일상세번호
	private String fileSavepath;		// 파일저장경로
	private String fileName;			// 파일명
	private String fileOrgname;			// 원본파일명
	private Long fileSize;				// 파일사이즈
	private String fileMime;			// 파일타입
	private Integer fileDowncount;		// 다운로드횟수
	private Date fileRegdate;			// 파일 등록일자
	private String fileUploader;		// 파일등록자
	private String fileDelConf = "N";	// 삭제여부
	private Date fileDelDate;			// 삭제일시
	private String fileCode;			// 공통코드
	
	public AttachVO() {}
	public AttachVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
	}
}
