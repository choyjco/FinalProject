package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EmptVO {
	private String emptNo; //재직상태변경번호
	private String empNo; //사원번호
	private String emptStat; //재직상태
	private String emptMemo; //메모
	private Date emptDate; //수정일자
	private Date emptEndDate; //퇴직일자
	private String hrCode; //인사발령코드
	
}
