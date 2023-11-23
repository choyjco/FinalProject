package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LibraryVO {

	private MultipartFile libFile;
	private String libNo;
	private String libTitle;
	private Date libRegdate; 
	private Date libUpddate;
	private String libFileNo;
	private String libCategory;
	private String libDowncount;
	private String libWriter;
	private String empName;
	private String empNo;
	private int count;
	private int libSize;

	private String fileNo;
	private String fileSavepath;
	private String fileName;
	private String fileOrgname;
	private Long fileSize;
	private String fileMime;
	private Integer fileDowncount;
	private Date fileRegdate;
	private String fileUploader;
	private String fileDelConf = "N";
	private Date fileDelDate;
	private String fileCode;
	
	private AttachVO attachLib;
	
	public void setLibFile(MultipartFile libFile) {
		this.libFile = libFile;
		if(libFile != null) {
			AttachVO libraryFile = new AttachVO(libFile); 
			this.attachLib = libraryFile;
		}
	}
	
}
