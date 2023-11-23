package kr.or.ddit.service.stats;

import java.util.List;

import kr.or.ddit.vo.StatsVO;

public interface IStatsService {

	public List<StatsVO> selectGenderRate();

	public List<StatsVO> selectRecruitYear();

	public List<StatsVO> selectWorkInfo();

}
