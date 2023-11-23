package kr.or.ddit.service.hr;

import java.util.List;


import kr.or.ddit.vo.TreeVO;

public interface ITreeService {

	public List<TreeVO> getList();

	public List<TreeVO> getPosList();

	public List<TreeVO> getRankList();

	public List<TreeVO> getJobList();

	List<TreeVO> getList2();

}
