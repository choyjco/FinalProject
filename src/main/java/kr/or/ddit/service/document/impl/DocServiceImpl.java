package kr.or.ddit.service.document.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.document.DocMapper;
import kr.or.ddit.service.document.IDocService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DocVO;
import kr.or.ddit.vo.DocumentVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.WorkAplyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DocServiceImpl implements IDocService {
	
	@Inject
	private DocMapper docMapper;

	@Override
	public List<DocumentVO> docTypeList(PaginationInfoVO<DocumentVO> pagingVO) {
		return docMapper.docTypeList(pagingVO);
	}

	@Override
	public List<DocumentVO> search(DocumentVO documentVO) {
		return docMapper.search(documentVO);
	}

	@Override
	public int countList(PaginationInfoVO<DocumentVO> pagingVO) {
		return docMapper.countList(pagingVO);
	}

	@Override
	public List<DocVO> docList(PaginationInfoVO<DocVO> pagingVO) {
		return docMapper.docList(pagingVO);
	}

	@Override
	public List<DocVO> docListAll(PaginationInfoVO<DocVO> pagingVO) {
		return docMapper.docListAll(pagingVO);
	}

	@Override
	public int allCount(DocVO docVO) {
		return docMapper.allCount(docVO);
	}

	@Override
	public List<DocVO> seachDoc(DocVO docVO) {
//		if(docMapper.searchDoc(docVO).size() > 1) {
//			List<DocVO> doc = new ArrayList<DocVO>();
//			docVO.setCount(0);
//			doc.add(docVO);
//			
//			return doc;
//		}
		
		return docMapper.searchDoc(docVO);
	}

	@Override
	public DocumentVO detail(String docClfCode) {
		return docMapper.detail(docClfCode);
	}

	@Override
	public List<WorkAplyVO> workList(String empNo) {
		return docMapper.workList(empNo);
	}

	@Override
	public List<DocVO> selectDocList(PaginationInfoVO<DocVO> pagingVO) {
		return docMapper.selectDocList(pagingVO);
	}

	@Override
	public List<DocVO> aprDocList(PaginationInfoVO<DocVO> pagingVO) {
		return docMapper.aprDocList(pagingVO);
	}

	@Override
	public ServiceResult docWorkRegister(DocVO docVO) {
		
		ServiceResult result = null;
		
		if(docVO.getDocNo() != null) {
			log.info("작성중 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			int cnt = docMapper.updateDoc(docVO);
			
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docVO.getDocNo());
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			
			if(cnt > 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
			
		}else {
			log.info("새로운 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmpVO empVO = user.getEmp();
			
			docVO.setEmpNo(empVO.getEmpNo());
			
			int count = docMapper.docRegister(docVO);
			
			String docNo = docMapper.selectDocNo();
			
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docNo);
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			if(count == 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
	}

	@Override
	public ServiceResult docVacRegister(DocVO docVO) {
		ServiceResult result = null;
		
		if(docVO.getDocNo() != null) {
			log.info("작성중 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			String[] date = docVO.getVaapDate().split("~");
			docVO.setVaapStrtDate(date[0]);
			docVO.setVaapEndDate(date[1]);
			
			int cnt = docMapper.updateDoc(docVO);
			DocVO doc = docMapper.selectVaap(docVO);
			
			if(doc != null) {
				
				cnt += docMapper.updateVaapDoc(docVO);
			}else {
				cnt += docMapper.vaapRegister(docVO);
			}
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docVO.getDocNo());
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			
			if(cnt > 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
			
		}else {
			log.info("새로운 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmpVO empVO = user.getEmp();
			
			docVO.setEmpNo(empVO.getEmpNo());
			String[] date = docVO.getVaapDate().split("~");
			docVO.setVaapStrtDate(date[0]);
			docVO.setVaapEndDate(date[1]);
			
			int count = docMapper.docRegister(docVO);
			count += docMapper.vaapRegister(docVO);
			String docNo = docMapper.selectDocNo();
			
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docNo);
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			if(count > 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
	}
	
	@Override
	public ServiceResult docAbRegister(DocVO docVO) {
		ServiceResult result = null;
		
		if(docVO.getDocNo() != null) {
			log.info("작성중 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			// 시간까지 작성되어야 함
			String[] date = docVO.getWorkDate().split("~");
			docVO.setWorkSdate(date[0]);
			docVO.setWorkEdate(date[1]);
			
			int cnt = docMapper.updateDoc(docVO);
			DocVO doc = docMapper.selectWorkAply(docVO);
			if(doc != null) {
				cnt += docMapper.updateAbDoc(docVO);
			}else {
				cnt += docMapper.workAplyRegister(docVO);
			}
			
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docVO.getDocNo());
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			
			if(cnt > 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
			
		}else {
			log.info("새로운 문서를 제출...!");
			String[] emp = docVO.getEmpNo().split(",");
			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmpVO empVO = user.getEmp();
			
			docVO.setEmpNo(empVO.getEmpNo());
			String[] date = docVO.getWorkDate().split("~");
			docVO.setWorkSdate(date[0]);
			docVO.setWorkEdate(date[1]);
			
			int count = docMapper.docRegister(docVO);
			count += docMapper.workAplyRegister(docVO);
			String docNo = docMapper.selectDocNo();
			
			for(int i = 0; i < emp.length; i++) {
				DocVO aprVO = new DocVO();
				aprVO.setAprEmpNo(emp[i]);
				aprVO.setDocNo(docNo);
				aprVO.setAprNo(i+1);
				docMapper.aprRegister(aprVO);
			}
			if(count > 1) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
	}
	
	@Override
	public List<DocVO> selectClfCode(DocVO docVO) {
		return docMapper.selectClfCode(docVO);
	}

	@Override
	public List<DocumentVO> docType() {
		return docMapper.docType();
	}

	@Override
	public int docListCnt() {
		return docMapper.docListCnt();
	}

	@Override
	public int myDocList(PaginationInfoVO<DocVO> pagingVO) {
		return docMapper.myDocList(pagingVO);
	}

	@Override
	public ServiceResult aprUpdate(DocVO docVO) {
		ServiceResult result = null;
		int cnt = 0;
		DocVO apr = docMapper.selectApr(docVO);
		
		if(apr.getAprJob() == "N") {
			cnt = docMapper.aprUpdate(docVO);
		}else {
			cnt = docMapper.aprUpdate(docVO);
			cnt += docMapper.docUpdate(docVO);
		}
		
		
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult aprReject(DocVO docVO) {
		ServiceResult result = null;
		int cnt = 0;
		DocVO apr = docMapper.selectApr(docVO);
		
		if(apr.getAprJob() == "N") {
			cnt = docMapper.aprReject(docVO);
		}else {
			cnt = docMapper.aprReject(docVO);
			cnt += docMapper.docReject(docVO);
		}
		
		
		if(cnt >= 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteDoc(String docNo) {
		ServiceResult result = null;
		
		int cnt = docMapper.deleteDoc(docNo);
		
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Override
	public ServiceResult docSave(DocVO docVO) {
		ServiceResult result = null;
		int cnt = 0;
		if(docVO.getDocNo() != null) {
			cnt = docMapper.updateStorage(docVO);
		}else {
			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmpVO empVO = user.getEmp();
			docVO.setEmpNo(empVO.getEmpNo());
			cnt = docMapper.save(docVO);
		}
		if(cnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
}
