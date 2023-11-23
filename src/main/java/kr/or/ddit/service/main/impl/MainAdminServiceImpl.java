package kr.or.ddit.service.main.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.main.MainAdminMapper;
import kr.or.ddit.service.main.IMainAdminService;
import kr.or.ddit.vo.CustomerVO;
import kr.or.ddit.vo.FuncInfoVO;
import kr.or.ddit.vo.InqBoardVO;
import kr.or.ddit.vo.LevelInfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.PaymentVO;

@Service
public class MainAdminServiceImpl implements IMainAdminService {

	@Inject
	private MainAdminMapper mainAdminMapper;
	
	// 회원 목록(관리자)
	@Override
	public List<CustomerVO> selectCustomerList() {
		return mainAdminMapper.selectCustomerList();
	}

	@Override
	public int selectCustomerCount(PaginationInfoVO<CustomerVO> pagingVO) {
		return mainAdminMapper.selectCustomerCount(pagingVO);
	}

	@Override
	public List<CustomerVO> selectCustomerList(PaginationInfoVO<CustomerVO> pagingVO) {
		return mainAdminMapper.selectCustomerList(pagingVO);
	}

	@Override
	public CustomerVO selectCustomer(String cusRnum) {
		return mainAdminMapper.selectCustomer(cusRnum);
	}

	// 기능 관리(관리자)
	@Override
	public List<FuncInfoVO> selectFuncList() {
		return mainAdminMapper.selectFuncList();
	}

	@Override
	public FuncInfoVO selectFunc(String funcName) {
		return mainAdminMapper.selectFunc(funcName);
	}
	
	@Override
	public ServiceResult insertFunc(HttpServletRequest req, FuncInfoVO funcInfoVO) {
		ServiceResult result = null;
		int status = mainAdminMapper.insertFunc(funcInfoVO);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult updateFunc(HttpServletRequest req, FuncInfoVO funcInfoVO) {
		ServiceResult result = null;
		int status = mainAdminMapper.updateFunc(funcInfoVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteFunc(HttpServletRequest req, String funcName) {
		ServiceResult result = null;
		
		FuncInfoVO funcInfoVO = mainAdminMapper.selectFunc(funcName);
		
		int status = mainAdminMapper.deleteFunc(funcName);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 레벨 관리(관리자)
	@Override
	public List<LevelInfoVO> selectLevelList() {
		return mainAdminMapper.selectLevelList();
	}
	
	@Override
	public ServiceResult insertLevel(HttpServletRequest req, LevelInfoVO levelInfoVO) {
		ServiceResult result = null;
		int status = mainAdminMapper.insertLevel(levelInfoVO);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public LevelInfoVO selectLevel(String levelName) {
		return mainAdminMapper.selectLevel(levelName);
	}

	@Override
	public ServiceResult updateLevel(HttpServletRequest req, LevelInfoVO levelinfoVO) {
		ServiceResult result = null;
		int status = mainAdminMapper.updateLevel(levelinfoVO);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteLevel(HttpServletRequest req, String levelName) {
		ServiceResult result = null;
		
		LevelInfoVO levelInfoVO = mainAdminMapper.selectLevel(levelName);
		
		int status = mainAdminMapper.deleteLevel(levelName);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	// 구매 회원 관리(관리자)
	@Override
	public int selectPaymentCount(PaginationInfoVO<CustomerVO> pagingVO) {
		return mainAdminMapper.selectPaymentCount(pagingVO);
	}

	@Override
	public List<CustomerVO> selectPaymentList(PaginationInfoVO<CustomerVO> pagingVO) {
		return mainAdminMapper.selectPaymentList(pagingVO);
	}

	@Override
	public CustomerVO selectPayment(String payCode) {
		return mainAdminMapper.selectPayment(payCode);
	}

	@Override
	public List<PaymentVO> selectLevelName() {
		return mainAdminMapper.selectLevelName();
	}

	@Override
	public List<PaymentVO> selectFuncName() {
		return mainAdminMapper.selectFuncName();
	}

	@Override
	public List<PaymentVO> selectSales() {
		return mainAdminMapper.selectSales();
	}

	@Override
	public List<CustomerVO> selectCusEmp() {
		return mainAdminMapper.selectCusEmp();
	}

	@Override
	public int selectBoardCount(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainAdminMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<InqBoardVO> selectBoardList(PaginationInfoVO<InqBoardVO> pagingVO) {
		return mainAdminMapper.selectBoardList(pagingVO);
	}


}
