package kr.or.ddit.service.settings;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PayVO;
import kr.or.ddit.vo.SettingsVO;
import kr.or.ddit.vo.TreeVO;

public interface ISettingsService {

	ServiceResult vacCheck(String vacName);

	List<SettingsVO> vacList();

	SettingsVO selectCus(String string);

	ServiceResult updateCus(HttpServletRequest req, SettingsVO vo);

	ServiceResult registerVac(HttpServletRequest req, SettingsVO settingsVO);

	ServiceResult deleteVac(String vacCode);

	List<SettingsVO> empList();

	int empModifyAuth(SettingsVO settingsVO);

	List<TreeVO> deptList();

	List<TreeVO> searchList(TreeVO tree);

	List<TreeVO> posList();

	List<TreeVO> rankList();

	List<TreeVO> jobList();

	int insertEmpExcel(SettingsVO settingsVO,HttpServletRequest req);

	List<SettingsVO> empMemList();

	List<SettingsVO> empManList();

	List<SettingsVO> empAdmList();

	List<SettingsVO> roleList();

	ServiceResult roleCheck(String empRole);

	ServiceResult registerRole(HttpServletRequest req, SettingsVO settingsVO);

	ServiceResult treeUpdate(List<TreeVO> treeVO);

}
