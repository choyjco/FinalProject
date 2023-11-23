package kr.or.ddit.service.pay;

import java.util.List;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PayVO;

public interface IPayService {

	List<EmpVO> list();

	List<PayVO> inCalList();

	List<PayVO> searchList(PayVO pay);

	PayVO inCalIng(PayVO pay);

	void inPaying(PayVO pay);

	List<PayVO> newEmpList();

	void insertNewMonth(PayVO vo);

	int getWorkTime(PayVO pay);

	PayVO thisMonthMyPay(PayVO vo);

	int thisYearMyPay(PayVO vo);

	List<PayVO> outCalList();

	int get3monthPay(PayVO pay);

	int getWorkDays(PayVO pay);

	List<PayVO> middleCalList();

	PayVO middleCalIng(PayVO vo);

}
