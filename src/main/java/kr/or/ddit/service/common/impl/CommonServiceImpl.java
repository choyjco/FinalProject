package kr.or.ddit.service.common.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.common.CommonMapper;
import kr.or.ddit.service.common.ICommonService;
import kr.or.ddit.vo.CommonVO;
import kr.or.ddit.vo.TreeVO;

@Service
public class CommonServiceImpl implements ICommonService {

	@Inject
	private CommonMapper CommonMapper;
	
	@Override
	public String selectCommon(String code) {
		return CommonMapper.selectCommon(code);
	}

	@Override
	public List<TreeVO> selectCommonList(String Upcode) {
		return CommonMapper.selectCommonList(Upcode);
	}

	@Override
	public List<CommonVO> selectAllCommon() {
		return CommonMapper.selectAllCommon();
	}


}
