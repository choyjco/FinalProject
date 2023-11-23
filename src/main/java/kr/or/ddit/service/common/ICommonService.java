package kr.or.ddit.service.common;

import java.util.List;

import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.TreeVO;

public interface ICommonService {

	public String selectCommon(String code);	// 코드명 단일 추출
	
	public List<TreeVO> selectCommonList(String Upcode);	// 상위코드명 리스트  추출

	public List<CommonVO> selectAllCommon();	// 파라미터 없이 코드테이블 정보 모두 추출
	

}
