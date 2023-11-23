package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class HrHxFormVO {
	
	private String hrMemo; //메모
	
	private List<EmpVO> hrHxVOList; //HrHxVO의List
	

}
