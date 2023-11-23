package kr.or.ddit.service.arm;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.AlarmVO;


public interface IArmService {

	/**
	 * 개인 알람 목록 조회
	 * @param empNo - 수신자 사원번호
	 * @return 수신 알람목록
	 */
	public List<AlarmVO> retrieveArmList(String armReceiver);

	/**
	 * 특정 알람 삭제
	 * @param armNo - 알람번호 
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult removeArm(String armNo);
	
	/**
	 * 개인의 알람 모두 삭제
	 * @param armRcvr - 수신자 사원번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult removeAllArm(String armReceiver);
	
	/**
	 * 알람 추가
	 * @param alarmVO - 알람 정보
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult createArm(AlarmVO alarmVO);

	/**
	 * 알람 읽음 처리
	 * @param armNo - 알람번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyArm(String armNo);
	
	/**
	 * 알람 모두 읽음 처리
	 * @param armRcvr - 수신자 사원번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyAllArm(String armReceiver);

	
}
