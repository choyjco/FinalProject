package kr.or.ddit.service.arm.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.arm.ArmMapper;
import kr.or.ddit.service.arm.IArmService;
import kr.or.ddit.vo.AlarmVO;

@Service
public class ArmServiceImpl implements IArmService {
	
	@Inject
	private ArmMapper armMapper;
	
	@Inject
	private WebApplicationContext context;
	
	@Override
	public List<AlarmVO> retrieveArmList(String armReceiver) {
		return armMapper.selectArmList(armReceiver);
	}

	@Override
	public ServiceResult removeArm(String armNo) {
		int rowcnt = armMapper.deleteArm(armNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
	}

	@Override
	public ServiceResult removeAllArm(String armReceiver) {
		int rowcnt = armMapper.deleteArmAll(armReceiver);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
	}

	@Override
	public ServiceResult createArm(AlarmVO alarmVO) {
		int rowcnt = armMapper.insertArm(alarmVO);
		
//		if(rowcnt > 0 ) {
//			NewArmEvent event = new NewArmEvent(armVO);
//			context.publishEvent(event);
//		}
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
	}

	@Override
	public ServiceResult modifyArm(String armNo) {
		int rowcnt = armMapper.updateArm(armNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
	}

	@Override
	public ServiceResult modifyAllArm(String armReceiver) {
		int rowcnt = armMapper.updateArmAll(armReceiver);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
	}

}
