package kr.or.ddit.vo;

import lombok.Data;

@Data
public class DocumentVO {
	private String docClfCode;
	private String docClfName;
	private String docClfDate;
	private String docClfFile;
	private String docTitle;
	private int count;
}
