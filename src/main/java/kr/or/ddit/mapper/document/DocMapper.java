package kr.or.ddit.mapper.document;

import java.util.List;

import kr.or.ddit.vo.DocVO;
import kr.or.ddit.vo.DocumentVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.WorkAplyVO;

public interface DocMapper {
	public List<DocumentVO> docTypeList(PaginationInfoVO<DocumentVO> pagingVO);
	public int countList(PaginationInfoVO<DocumentVO> pagingVO);
	public List<DocumentVO> search(DocumentVO documentVO);
	public List<DocVO> docList(PaginationInfoVO<DocVO> pagingVO);
	public List<DocVO> docListAll(PaginationInfoVO<DocVO> pagingVO);
	public int allCount(DocVO docVO);
	public List<DocVO> searchDoc(DocVO docVO);
	public DocumentVO detail(String docClfCode);
	public List<WorkAplyVO> workList(String empNo);
	public List<DocVO> selectDocList(PaginationInfoVO<DocVO> pagingVO);
	public List<DocVO> aprDocList(PaginationInfoVO<DocVO> pagingVO);
	public int docRegister(DocVO docVO);
	public String selectDocNo();
	public int aprRegister(DocVO aprVO);
	public List<DocVO> selectClfCode(DocVO docVO);
	public List<DocumentVO> docType();
	public int docListCnt();
	public int myDocList(PaginationInfoVO<DocVO> docPagingVO);
	public int aprDocCnt(PaginationInfoVO<DocVO> docPagingVO);
	public int aprUpdate(DocVO docVO);
	public DocVO selectApr(DocVO docVO);
	public int docUpdate(DocVO docVO);
	public int aprReject(DocVO docVO);
	public int docReject(DocVO docVO);
	public int selectDocCnt(PaginationInfoVO<DocVO> pagingVO);
	public List<InfoVO> deptList(String empNo);
	public int deleteDoc(String docNo);
	public DocVO selectDoc(String docNo);
	public int updateDoc(DocVO docVO);
	public int updateStorage(DocVO docVO);
	public int save(DocVO docVO);
	public String selectAuth(EmpVO empVO);
	public DocVO selectAprJob(DocVO docVO);
	public int workAplyRegister(DocVO docVO);
	public int updateAbDoc(DocVO docVO);
	public DocVO selectWorkAply(DocVO docVO);
	public DocVO selectVaap(DocVO docVO);
	public int updateVaapDoc(DocVO docVO);
	public int vaapRegister(DocVO docVO);
	public List<DocVO> selectAprList(String docNo);
	public List<DocVO> selectStorageList(String docNo);

}
