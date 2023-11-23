package kr.or.ddit.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MenuVO {
	
	private String menuName;
	private String menuUrl;
	private String tab;
	
	public MenuVO(String menuName, String menuUrl) {
		super();
		this.menuName = menuName;
		this.menuUrl = menuUrl;
	}
	
	public MenuVO(String menuName, String menuUrl, String tab) {
		super();
		this.menuName = menuName;
		this.menuUrl = menuUrl;
		this.tab = tab;
	}
	
}
