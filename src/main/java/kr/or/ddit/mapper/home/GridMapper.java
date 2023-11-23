package kr.or.ddit.mapper.home;

import java.util.List;

import kr.or.ddit.vo.GridVO;

public interface GridMapper {

	public List<GridVO> selectGrid(String empNo);

	public int updateGrid(GridVO gridVO);

}
