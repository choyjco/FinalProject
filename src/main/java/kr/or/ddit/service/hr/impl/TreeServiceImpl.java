package kr.or.ddit.service.hr.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.hr.TreeMapper;
import kr.or.ddit.service.hr.ITreeService;
import kr.or.ddit.vo.TreeVO;

@Service
public class TreeServiceImpl implements ITreeService{

	@Inject
	private TreeMapper treeMapper;
	
	@Override
	public List<TreeVO> getList() {
		List<TreeVO> treeList = treeMapper.treeList();
		
		for(TreeVO tree : treeList) {
			String temp = tree.getText();
			if ("전체 부서".equals(temp)||"개발 A팀".equals(temp)||"개발 B팀".equals(temp)||"개발 C팀".equals(temp)) {
				tree.setText(temp);
			}else {
				tree.setText(temp + " ("+tree.getEmpCount()+")");
				
			}
		}
		
		return treeList;
	}
	@Override
	public List<TreeVO> getList2() {
		List<TreeVO> treeList = treeMapper.treeList2();
		
		return treeList;
	}
	
	@Override
	public List<TreeVO> getPosList() {
		return treeMapper.posList();
	}

	@Override
	public List<TreeVO> getRankList() {
		return treeMapper.rankList();
	}

	@Override
	public List<TreeVO> getJobList() {
		return treeMapper.jobList();
	}

}
