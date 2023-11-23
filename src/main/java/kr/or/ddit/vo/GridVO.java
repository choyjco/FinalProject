package kr.or.ddit.vo;

import lombok.Data;

@Data
public class GridVO {
	private String gridNo;
	private String empNo;
	private int x;
	private int y;
	private int w;
	private int h;
	private String content;
	private String id;
	private String noMove;
	
}
