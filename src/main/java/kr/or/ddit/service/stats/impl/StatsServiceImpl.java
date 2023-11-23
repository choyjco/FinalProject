package kr.or.ddit.service.stats.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.stats.StatsMapper;
import kr.or.ddit.service.stats.IStatsService;
import kr.or.ddit.vo.StatsVO;

@Service
public class StatsServiceImpl implements IStatsService {

	@Inject
	private StatsMapper statsMapper;
	
	@Override
	public List<StatsVO> selectGenderRate() {
		return statsMapper.selectGenderRate();
	}

	@Override
	public List<StatsVO> selectRecruitYear() {
		return statsMapper.selectRecruitYear();
	}

	@Override
	public List<StatsVO> selectWorkInfo() {
		return statsMapper.selectWorkInfo();
	}

}
