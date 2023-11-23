package kr.or.ddit.service.hr.impl;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import kr.or.ddit.controller.util.FileuploadUtils;
import kr.or.ddit.mapper.hr.HrMapper;
import kr.or.ddit.service.hr.IHrService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.EmpAuth;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmptVO;
import kr.or.ddit.vo.HrDetailVO;
import kr.or.ddit.vo.HrHxVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class HrServiceImpl implements IHrService {
	
	@Resource(name="SLoadPath")
	private String uploadPath;
		
	
	@Inject
	private HrMapper hrMapper;

	/**
	 * ghr
	 * 사원 페이지 - 검색, 사원 count수
	 */
	@Override
	public int selectGhrCount(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectGhrCount(pagingVO);
	}
	
	/**
	 * ghr
	 * 사원 페이지 - 검색, 사원 전체 조회
	 */
	@Override
	public List<EmpVO> selectGhrList(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectGhrList(pagingVO);
	}

	/**
	 * mhr1
	 * 관리자 이상 - 검색, 사원 조회
	 */
	@Override
	public List<EmpVO> selectMhr1List(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectMhr1List(pagingVO);
	}

	/**
	 * mhr1
	 * 관리자 이상 - 검색, 사원 count수
	 */
	@Override
	public int selectMhr1Count(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectMhr1Count(pagingVO);
	}

	/**
	 * mhr1, ghr
	 * 조직도 선택하고 팀 별로 사원 조회
	 */
	@Override
	public int selectTreeTotal(String deptCode) {
		return hrMapper.selectTreeTotal(deptCode);
	}
	
	/**
	 * mhr1
	 * 관리자 이상 - 조직도 선택하고 팀 별로 사원 조회
	 */
	@Override
	public List<EmpVO> getAllEmployees(String deptCode) {
		return hrMapper.selectTreeList(deptCode);
	}

	/**
	 * 관리자 이상 - 재직상태 사원수 조회 x4
	 */
	@Override
	public List<EmpVO> countEmpStat() {
		return hrMapper.countEmpStat();
	}

	@Override
	public List<EmpVO> countEmpStat2() {
		return hrMapper.countEmpStat2();
	}

	@Override
	public List<EmpVO> countEmpStat3() {
		return hrMapper.countEmpStat3();
	}

	@Override
	public List<EmpVO> countEmpStat4() {
		return hrMapper.countEmpStat4();
	}
	
	/**
	 * ghr
	 * 사원 - 조직도 선택하고 팀 별로 사원 조회
	 */
	@Override
	public List<EmpVO> getAllEmployeesG(String deptCode) {
		return hrMapper.selectTreeListG(deptCode);
	}

	/**
	 * 관리자 이상 - 인사 발령 내역 페이징
	 */
	@Override
	public int selectMhr3Count(PaginationInfoVO<HrHxVO> pagingVO) {
		return hrMapper.selectMhr3Count(pagingVO);
	}

	/**
	 * 관리자 이상 - 인사 발령 내역
	 */
	@Override
	public List<HrHxVO> selectMhr3List(PaginationInfoVO<HrHxVO> pagingVO) {
		return hrMapper.selectMhr3List(pagingVO);
	}

	/**
	 * 관리자 이상 - 재직 상태 변경
	 */
	@Override
	public List<EmpVO> gridList() {
		return hrMapper.gridList();
	}

	/**
	 *  관리자 이상 - 사원 검색 + 카테고리
	 */
	@Override
	public List<EmpVO> searchMrh12List(EmpVO empVO) {
		log.info("empVO: ", empVO);
		return hrMapper.searchMrh12List(empVO);
	}

	/**
	 * 관리자 이상 - 재직 상태 변경
	 */
	@Override
	public void modifyMhr12(EmpVO empVO) {
		hrMapper.modifyMhr12(empVO);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
        UserDetails userDetails = (UserDetails)principal; 
        String empNo = userDetails.getUsername();

        HrHxVO hrHxVO = new HrHxVO();
        hrHxVO.setEmpNo(empVO.getEmpNo());
        hrHxVO.setHrResp(empNo);
        hrMapper.createHrHxStat(hrHxVO);
        String hrCode = hrMapper.selectHrCode();
        
        String empName = empVO.getEmpName();
        String empPos = empVO.getEmpPos();
        String empDept = empVO.getEmpDept();
        
        HrDetailVO hrDetailVO = new HrDetailVO();
        hrDetailVO.setEmpNo(empVO.getEmpNo());
        hrDetailVO.setHrName(empName);
        hrDetailVO.setHrDept(empDept);
        hrDetailVO.setHrPos(empPos);
        hrDetailVO.setHrStat(empVO.getEmpStat());
        hrDetailVO.setHrCode(hrCode);
        
        hrMapper.createHrHxDetail(hrDetailVO);
        
        EmptVO emptVO = new EmptVO();
        emptVO.setEmpNo(hrDetailVO.getEmpNo());
        emptVO.setEmptStat(hrDetailVO.getHrStat());
        emptVO.setEmptMemo(hrHxVO.getHrMemo());
        emptVO.setHrCode(hrCode);
        
        hrMapper.createEmpt(emptVO);
	}

	/**
	 * 관리자 이상 - 부서 이동을 위한 사원 조회  페이징
	 */
	@Override
	public int selectMhr2Count(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectMhr2Count(pagingVO);
	}

	/**
	 * 관리자 이상 - 부서 이동을 위한 사원 조회
	 */
	@Override
	public List<EmpVO> selectMhr2List(PaginationInfoVO<EmpVO> pagingVO) {
		return hrMapper.selectMhr2List(pagingVO);
	}

	/**
	 * 관리자 이상 - 채용 페이지를 위한 그리드 사원 조회
	 */
	@Override
	public List<EmpVO> mhr22grid() {
		return hrMapper.mhr22grid();
	}

	/**
	 * 관리자 이상 - 인사발령 - 채용
	 * 합격한 지원자 >>> 사원으로 변경
	 */
	@Override
	public int register(HttpServletRequest req, List<EmpVO> empList) throws Exception {
		int result = 0;
        
		for(EmpVO empVO : empList) {
			if(empVO != null && !empVO.getEmpWork().equals("")) {
				result += hrMapper.register(empVO);
				String empNo = hrMapper.selectEmpNo();
				empVO.setEmpNo(empNo);
				CustomerVO customerVO = hrMapper.selectCus();
				AttachVO attachVO = hrMapper.selectAttach(customerVO);
				
				FileuploadUtils.customerBasicFileUpload(attachVO, empVO.getEmpNo(), req, hrMapper, uploadPath);
//				String fileNo = hrMapper.selectFileNo();
//				empVO.setEmpProfile(fileNo);
//				hrMapper.empProfileUpdate(empVO);
				EmpVO emp = hrMapper.selectOne(empVO);
				EmpAuth empAuth = new EmpAuth();
				empAuth.setEmpNo(empVO.getEmpNo());
				if (emp.getEmpDept().equals("a011") || emp.getEmpDept().equals("a012")) {
		            empAuth.setAuth("ROLE_MANAGER");
		        } else {
		            empAuth.setAuth("ROLE_MEMBER");
		        }
				
				hrMapper.createAuth(empAuth);
			}
		}
		return result;
	}

	@Override
	public List<EmpVO> countEmp() {
		return hrMapper.countEmp();
	}

	/**
	 * 관리자 이상 - 부서 이동, 부서 변경
	 */
	@Override
	public int modifyEmpDept(List<EmpVO> empList, String hrMemo) {
	    int result = 0;
	    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
        UserDetails userDetails = (UserDetails)principal; 
        String empNo = userDetails.getUsername();

		HrHxVO hrHxVO = new HrHxVO();
        hrHxVO.setEmpNo(empNo);
        hrHxVO.setHrResp(empNo);
        hrHxVO.setHrMemo(hrMemo);
		hrMapper.createHrHxDept(hrHxVO);
		String hrCode = hrMapper.selectHrCode();
		
	    for (EmpVO empVO : empList) {
	        if (empVO != null && !empVO.getEmpDept().equals("")) {
	        	log.info("modifyEmpDept() 실행...!");
	        	
	            String empName = empVO.getEmpName();
	            String empPos = empVO.getEmpPos();
	            
	            HrDetailVO hrDetailVO = new HrDetailVO();
	            hrDetailVO.setEmpNo(empVO.getEmpNo());
	            hrDetailVO.setHrName(empName);
	            hrDetailVO.setHrDept(empVO.getEmpDept());
	            hrDetailVO.setHrPos(empPos);
	            hrDetailVO.setHrCode(hrCode);
	            hrMapper.insertHrHistory(hrDetailVO);
	            result += hrMapper.modifyEmpDept(empVO);
	            hrMapper.updateHrHxDetail(hrDetailVO);
	        }
	    }
	    return result;
	}

	/**
	 * 관리자 이상 - 승진, 직책 변경 
	 */
	@Override
	public int modifyEmpPos(List<EmpVO> empList, String hrMemo) {
		int result = 0;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
        UserDetails userDetails = (UserDetails)principal; 
        String empNo = userDetails.getUsername();
        
        HrHxVO hrHxVO = new HrHxVO();
        hrHxVO.setEmpNo(empNo);
        hrHxVO.setHrResp(empNo);
        hrHxVO.setHrMemo(hrMemo);
        hrMapper.createHrHxPos(hrHxVO);
        String hrCode = hrMapper.selectHrCode();
        
		for(EmpVO empVO : empList) {
			if(empVO != null && !empVO.getEmpPos().equals("")) {
				
				String empName = empVO.getEmpName();
				String empDept = empVO.getEmpDept();
	            
	            HrDetailVO hrDetailVO = new HrDetailVO();
	            hrDetailVO.setEmpNo(empVO.getEmpNo());
	            hrDetailVO.setHrName(empName);
	            hrDetailVO.setHrDept(empDept);
	            hrDetailVO.setHrPos(empVO.getEmpPos());
	            hrDetailVO.setHrCode(hrCode);
	            hrMapper.insertHrHistoryPos(hrDetailVO);
	            result += hrMapper.modifyEmpPos(empVO);
	            hrMapper.updateHrHxDetailPos(hrDetailVO);
			}
		}
		return result;
	}

	@Override
	public int selectMhr3DeptCount(PaginationInfoVO<HrHxVO> pagingVO) {
		return hrMapper.selectMhr3DeptCount(pagingVO);
	}

	/**
	 * 관리자 이상 - 인사 발령 내역에서 발령분류를 선택 후 모달로 상세보기
	 */
	@Override
	public List<HrDetailVO> selectMhr3DeptList(PaginationInfoVO<HrDetailVO> pagingVO) {
		return hrMapper.selectMhr3DeptList(pagingVO);
	}

	/**
	 * 메모 수정 모달
	 */
	@Override
	public int modifyMemo(HrHxVO hrHxVO) {
		return hrMapper.modifyMemo(hrHxVO);
	}

	/**
	 * 클릭 재직중 카드 
	 */
	@Override
	public List<EmpVO> gridStatList(EmpVO empVO) {
		return hrMapper.gridStatList(empVO);
	}

	/**
	 * 클릭 휴가중 카드 
	 */
	@Override
	public List<EmpVO> gridStatList2() {
		return hrMapper.gridStatList2();
	}

	/**
	 * 클릭 수습중 카드 
	 */
	@Override
	public List<EmpVO> gridStatList3() {
		return hrMapper.gridStatList3();
	}

	/**
	 * 클릭 퇴직 예정 카드 
	 */
	@Override
	public List<EmpVO> gridStatList4() {
		return hrMapper.gridStatList4();
	}

	@Override
	public List<EmpVO> selectAll() {
		return hrMapper.selectAll();
	}

	/**
     * 관리자 이상 - 사원 전체 리스트의 엑셀
     */
	@Override
	public List<EmpVO> excelMhr1List() {
		return hrMapper.excelMhr1List();
	}

	/**
     * 사원 - 사원 전체 리스트의 엑셀
     */
	@Override
	public List<EmpVO> excelGhrList() {
		return hrMapper.excelGhrList();
	}

	

	

	


	
	
	
}
