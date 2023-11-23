package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class PayVO {
	
	List<EmpVO> empVOList;
	//사원
	private String empNo;
	private String empName;
	private String empStat;
	private String empWork;
	private String empAcct;
	private String empBank;
	private String empProfile;
	private String empSignature;
	private String empDept;
	private String empPos;
	private String empRank;
	private String empJob;
	
	//급여관련
	private String incSupName;
	private String incSupAmt;
	private String incSupCode;
	private String incSupSet;
	private String incSupTax;
	private String incSupCal;
	private String incSupStat;
	private String incSupMemo;
	
	private String dedtName;
	private String dedtAmt;
	private String dedtCode;
	private String dedtInc;
	private String dedtFml;
	private String dedtMemo;
	private String dedtStat;
	
	private String incSetSdate;
	private String incSetEdate;
	private String incSetDate;
	private int incSetAmt;
	private int incSetDedt;
	private int incSetRes;
	private String incSetYear;
	private String incSetConf;
	private String incSetRdate;
	
	//임시
	private String gibonpay;
	private String jikpay;
	private String gitapay;
	private int sadae;
	private int sodeuk;
	private int workTime;
	private int yearAmt;
	private String month;
	private int threeMonthPay;
	private int workDays;
	private double oneDayAvgPay;
	private int outPay;
}
