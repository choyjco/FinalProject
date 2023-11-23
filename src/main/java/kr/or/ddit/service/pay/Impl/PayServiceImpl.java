package kr.or.ddit.service.pay.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.pay.PayMapper;
import kr.or.ddit.service.pay.IPayService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PayServiceImpl implements IPayService{

	@Inject
	private PayMapper mapper;
	
	@Override
	public List<EmpVO> list() {
		return mapper.list();
	}

	@Override
	public List<PayVO> inCalList() {
		return mapper.inCalList();
	}

	@Override
	public List<PayVO> searchList(PayVO pay) {
		return mapper.searchList(pay);
	}

	@Override
	public PayVO inCalIng(PayVO pay) {
		return mapper.inCalIng(pay);
	}

	@Override
	public void inPaying(PayVO pay) {
		mapper.inPaying(pay);
	}

	@Override
	public List<PayVO> newEmpList() {
		return mapper.newEmpList();
	}

	@Override
	public void insertNewMonth(PayVO vo) {
		mapper.insertNewMonth(vo);
	}

	@Override
	public int getWorkTime(PayVO pay) {
		return mapper.getWorkTime(pay);
	}

	@Override
	public PayVO thisMonthMyPay(PayVO vo) {
		return mapper.thisMonthMyPay(vo);
	}

	@Override
	public int thisYearMyPay(PayVO vo) {
		return mapper.thisYearMyPay(vo);
	}

	@Override
	public List<PayVO> outCalList() {
		return mapper.outCalList();
	}

	@Override
	public int get3monthPay(PayVO pay) {
		return mapper.get3monthPay(pay);
	}

	@Override
	public int getWorkDays(PayVO pay) {
		return mapper.getWorkDays(pay);
	}

	@Override
	public List<PayVO> middleCalList() {
		return mapper.middleCalList();
	}

	@Override
	public PayVO middleCalIng(PayVO vo) {
		return mapper.middleCalIng(vo);
	}

}
