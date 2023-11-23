package kr.or.ddit.service.document;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.DocVO;
import kr.or.ddit.vo.DocumentVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.WorkAplyVO;

public interface IDocService {

	public List<DocumentVO> docTypeList(PaginationInfoVO<DocumentVO> pagingVO);
	public List<DocumentVO> search(DocumentVO documentVO);
	public int countList(PaginationInfoVO<DocumentVO> pagingVO);
	public List<DocVO> docList(PaginationInfoVO<DocVO> docPagingVO);
	public List<DocVO> docListAll(PaginationInfoVO<DocVO> pagingVO);
	public int allCount(DocVO docVO);
	public List<DocVO> seachDoc(DocVO docVO);
	public DocumentVO detail(String docClfCode);
	public List<WorkAplyVO> workList(String empNo);
	public List<DocVO> selectDocList(PaginationInfoVO<DocVO> pagingVO);
	public List<DocVO> aprDocList(PaginationInfoVO<DocVO> docPagingVO);
	public ServiceResult docWorkRegister(DocVO docVO);
	public List<DocVO> selectClfCode(DocVO docVO);
	public List<DocumentVO> docType();
	public int docListCnt();
	public int myDocList(PaginationInfoVO<DocVO> docPagingVO);
	public ServiceResult aprUpdate(DocVO docVO);
	public ServiceResult aprReject(DocVO docVO);
	public ServiceResult deleteDoc(String docNo);
	public ServiceResult docSave(DocVO docVO);
	public ServiceResult docVacRegister(DocVO docVO);
	public ServiceResult docAbRegister(DocVO docVO);

}
