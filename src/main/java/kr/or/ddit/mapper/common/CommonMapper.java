package kr.or.ddit.mapper.common;

import java.util.List;

import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.TreeVO;

public interface CommonMapper {

	public String selectCommon(String code);

	public List<TreeVO> selectCommonList(String upcode);

	public List<CommonVO> selectAllCommon();

}
