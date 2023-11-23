package kr.or.ddit.mapper.stats;

import java.util.List;

import kr.or.ddit.vo.StatsVO;

public interface StatsMapper {

	public List<StatsVO> selectGenderRate();

	public List<StatsVO> selectRecruitYear();

	public List<StatsVO> selectWorkInfo();

}
