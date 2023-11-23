package kr.or.ddit.controller.document;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.document.DocMapper;
import kr.or.ddit.service.document.IDocService;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DocVO;
import kr.or.ddit.vo.DocumentVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.InfoVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/document")
public class DocumentController {
	
	@Inject
	private IDocService docService;
	
	@Inject
	private DocMapper docMapper;
	
	
	// 일반사원 문서종류 화면
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/gdoctype")
	public String gdocType(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "docClfName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request
			) {
		PaginationInfoVO<DocumentVO> pagingVO = new PaginationInfoVO<DocumentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		
		int count = docService.countList(pagingVO);
		List<DocumentVO> docTypeList = docService.docTypeList(pagingVO);
		
		pagingVO.setTotalRecord(count);
		pagingVO.setDataList(docTypeList);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/gdoctype");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("기안작성", "/document/gdoctype");
		MenuVO menu3 = new MenuVO("내 신청내역", "/document/gmydoclist");
		MenuVO menu4 = new MenuVO("임시보관함", "/document/gmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4);
		model.addAttribute("currentURL","/document/gdoctype");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docTypeList", pagingVO);
		return "document/gdoctype";
	}
	
	
	

	// 일반사원 문서작성내역 화면
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/gmydoclist")
	public String gMyDocList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
//		List<PaginationInfoVO<Object>> pageList = new ArrayList<PaginationInfoVO<Object>>();
		
		PaginationInfoVO<DocVO> docPagingVO = new PaginationInfoVO<DocVO>();
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		if(StringUtils.isNotBlank(searchWord)) {
			docPagingVO.setSearchType(searchType);
			docPagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		docPagingVO.setCurrentPage(currentPage);
		
		docPagingVO.setBoardCate(empVO.getEmpNo());
		List<DocVO> mydocList = docService.docList(docPagingVO);
		int myDocList = docService.myDocList(docPagingVO);
		
		docPagingVO.setDataList(mydocList);
		docPagingVO.setTotalRecord(myDocList);
		
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/gmydoclist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("기안작성", "/document/gdoctype");
		MenuVO menu3 = new MenuVO("내 신청내역", "/document/gmydoclist");
		MenuVO menu4 = new MenuVO("임시보관함", "/document/gmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4);
		model.addAttribute("currentURL","/document/gmydoclist");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docPagingVO",docPagingVO);
		return "document/gmydoc";
	}

	// 일반사원 임시문서보관함 화면
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/gmydocstorage")
	public String gmydocStorage(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<DocVO> pagingVO = new PaginationInfoVO<DocVO>();
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();

		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> docList = docService.selectDocList(pagingVO);
		int cnt = docMapper.selectDocCnt(pagingVO);
		pagingVO.setTotalRecord(cnt);
		pagingVO.setDataList(docList);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/gmydocstorage");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("기안작성", "/document/gdoctype");
		MenuVO menu3 = new MenuVO("내 신청내역", "/document/gmydoclist");
		MenuVO menu4 = new MenuVO("임시보관함", "/document/gmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4);
		
		model.addAttribute("currentURL","/document/gmydocstorage");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("docPagingVO",pagingVO);
		model.addAttribute("menuList", menuList);
		return "document/gmydocstorage";
	}
	
	// 관리자 문서분류 화면
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value="/mdoctype")
	public String mdocType(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "docClfName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request
			) {
		PaginationInfoVO<DocumentVO> pagingVO = new PaginationInfoVO<DocumentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		
		int count = docService.countList(pagingVO);
		List<DocumentVO> docTypeList = docService.docTypeList(pagingVO);
		
		pagingVO.setTotalRecord(count);
		pagingVO.setDataList(docTypeList);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/mdoctype");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/updatedoc");
		MenuVO menu3 = new MenuVO("기안작성", "/document/mdoctype");
		MenuVO menu4 = new MenuVO("내 신청내역", "/document/mmydoclist");
		MenuVO menu5 = new MenuVO("임시보관함", "/document/mmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5);
		
		model.addAttribute("currentURL","/document/mdoctype");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docTypeList", pagingVO);
		return "document/mdoctype";
	}
	
	// 최고관리자 문서분류 화면
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/doctype")
	public String docType(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "docClfName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request
			) {
		PaginationInfoVO<DocumentVO> pagingVO = new PaginationInfoVO<DocumentVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		
		int count = docService.countList(pagingVO);
		List<DocumentVO> docTypeList = docService.docTypeList(pagingVO);
		
		pagingVO.setTotalRecord(count);
		pagingVO.setDataList(docTypeList);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/doctype");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/updatedoc");
		MenuVO menu3 = new MenuVO("전체내역", "/document/alldoclist");
		MenuVO menu4 = new MenuVO("기안작성", "/document/doctype");
		MenuVO menu5 = new MenuVO("내 신청내역", "/document/mydoclist");
		MenuVO menu6 = new MenuVO("임시보관함", "/document/mydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5,menu6);
		
		model.addAttribute("currentURL","/document/doctype");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docTypeList", pagingVO);
		return "document/mdoctype";
	}
	
	// 최고관리자 전체 문서내역 화면
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/alldoclist")
	public String allDocList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<DocVO> pagingVO = new PaginationInfoVO<DocVO>();
		
		

		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		
		
		List<DocVO> docListAll = docService.docListAll(pagingVO);
		
		int docListCnt = docService.docListCnt();
		pagingVO.setTotalRecord(docListCnt);
		pagingVO.setDataList(docListAll);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/alldoclist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/mupdatedoc");
		MenuVO menu3 = new MenuVO("전체내역", "/document/alldoclist");
		MenuVO menu4 = new MenuVO("기안작성", "/document/doctype");
		MenuVO menu5 = new MenuVO("내 신청내역", "/document/mydoclist");
		MenuVO menu6 = new MenuVO("임시보관함", "/document/mydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5,menu6);
		
		model.addAttribute("currentURL","/document/alldoclist");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList",menuList);
		model.addAttribute("pagingVO", pagingVO);
		return "document/alldoclist";
	}
	
	// 관리자 문서작성내역 화면
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value="/mmydoclist")
	public String mMyDocList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		PaginationInfoVO<DocVO> docPagingVO = new PaginationInfoVO<DocVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			docPagingVO.setSearchType(searchType);
			docPagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		docPagingVO.setCurrentPage(currentPage);
		
		docPagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> mydocList = docService.docList(docPagingVO);
		int mydocCnt = docMapper.myDocList(docPagingVO);
		
		docPagingVO.setDataList(mydocList);
		docPagingVO.setTotalRecord(mydocCnt);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/mmydoclist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/updatedoc");
		MenuVO menu3 = new MenuVO("기안작성", "/document/mdoctype");
		MenuVO menu4 = new MenuVO("내 신청내역", "/document/mmydoclist");
		MenuVO menu5 = new MenuVO("임시보관함", "/document/mmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5);
		
		model.addAttribute("currentURL","/document/mmydoclist");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docPagingVO",docPagingVO);
		return "document/mmydoc";
	}
	
	// 최고관리자 문서작성내역 화면
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/mydoclist")
	public String myDocList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		PaginationInfoVO<DocVO> docPagingVO = new PaginationInfoVO<DocVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			docPagingVO.setSearchType(searchType);
			docPagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		docPagingVO.setCurrentPage(currentPage);
		
		docPagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> mydocList = docService.docList(docPagingVO);
		int mydocCnt = docMapper.myDocList(docPagingVO);
		
		docPagingVO.setDataList(mydocList);
		docPagingVO.setTotalRecord(mydocCnt);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/mydoclist");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/mupdatedoc");
		MenuVO menu3 = new MenuVO("전체내역", "/document/alldoclist");
		MenuVO menu4 = new MenuVO("기안작성", "/document/doctype");
		MenuVO menu5 = new MenuVO("내 신청내역", "/document/mydoclist");
		MenuVO menu6 = new MenuVO("임시보관함", "/document/mydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5,menu6);
		
		model.addAttribute("currentURL","/document/mydoclist");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docPagingVO",docPagingVO);
		return "document/mmydoc";
	}
	
	
	// 관리자 받은문서 화면
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value="/updatedoc")
	public String updateDoc(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue = "대기중") String aprStat,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		PaginationInfoVO<DocVO> docPagingVO = new PaginationInfoVO<DocVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			docPagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		docPagingVO.setSearchType(searchType);
		model.addAttribute("searchType", searchType);
		
		docPagingVO.setAprStat(aprStat);
		model.addAttribute("aprStat", aprStat);
		docPagingVO.setCurrentPage(currentPage);
		docPagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> aprDocList = docService.aprDocList(docPagingVO);
		int aprDocCnt = docMapper.aprDocCnt(docPagingVO);
		
		docPagingVO.setDataList(aprDocList);
		docPagingVO.setTotalRecord(aprDocCnt);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/updatedoc");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/updatedoc");
		MenuVO menu3 = new MenuVO("기안작성", "/document/mdoctype");
		MenuVO menu4 = new MenuVO("내 신청내역", "/document/mmydoclist");
		MenuVO menu5 = new MenuVO("임시보관함", "/document/mmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5);
		
		model.addAttribute("currentURL","/document/updatedoc");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docPagingVO", docPagingVO);
		
		return "document/apprdoc";
	}
	
	// 최고관리자 받은문서 화면
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/mupdatedoc")
	public String mUpdateDoc(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false,  defaultValue = "2") String searchType,
			@RequestParam(required = false) String searchWord,
			@RequestParam(required = false, defaultValue = "대기중") String aprStat,
			Model model, HttpServletRequest request) {
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		PaginationInfoVO<DocVO> docPagingVO = new PaginationInfoVO<DocVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			docPagingVO.setSearchType(searchType);
			docPagingVO.setSearchWord(searchWord);
			docPagingVO.setAprStat(aprStat);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("aprStat", aprStat);
		}
		
		docPagingVO.setCurrentPage(currentPage);
		docPagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> aprDocList = docService.aprDocList(docPagingVO);
		int aprDocCnt = docMapper.aprDocCnt(docPagingVO);
		
		docPagingVO.setDataList(aprDocList);
		docPagingVO.setTotalRecord(aprDocCnt);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/mupdatedoc");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/mupdatedoc");
		MenuVO menu3 = new MenuVO("전체내역", "/document/alldoclist");
		MenuVO menu4 = new MenuVO("기안작성", "/document/doctype");
		MenuVO menu5 = new MenuVO("내 신청내역", "/document/mydoclist");
		MenuVO menu6 = new MenuVO("임시보관함", "/document/mydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5,menu6);
		
		model.addAttribute("currentURL","/document/mupdatedoc");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("menuList", menuList);
		model.addAttribute("docPagingVO", docPagingVO);
		
		return "document/apprdoc";
	}
	
	
	// 관리자 임시보관함 화면
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value="/mmydocstorage")
	public String mmydocStorage(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<DocVO> pagingVO = new PaginationInfoVO<DocVO>();
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> docList = docService.selectDocList(pagingVO);
		int cnt = docMapper.selectDocCnt(pagingVO);
		
		pagingVO.setTotalRecord(cnt);
		pagingVO.setDataList(docList);

		MenuVO menu1 = new MenuVO("기안·결재", "/document/mmydocstorage");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/updatedoc");
		MenuVO menu3 = new MenuVO("기안작성", "/document/mdoctype");
		MenuVO menu4 = new MenuVO("내 신청내역", "/document/mmydoclist");
		MenuVO menu5 = new MenuVO("임시보관함", "/document/mmydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5);
		
		model.addAttribute("currentURL","/document/mmydocstorage");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("docPagingVO",pagingVO);
		model.addAttribute("menuList", menuList);
		return "document/mmydocstorage";
	}
	
	
	// 최고관리자 임시보관함 화면
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value="/mydocstorage")
	public String mydocStorage(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<DocVO> pagingVO = new PaginationInfoVO<DocVO>();
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setBoardCate(empVO.getEmpNo());
		
		List<DocVO> docList = docService.selectDocList(pagingVO);
		int cnt = docMapper.selectDocCnt(pagingVO);
		
		pagingVO.setTotalRecord(cnt);
		pagingVO.setDataList(docList);
		
		MenuVO menu1 = new MenuVO("기안·결재", "/document/mydocstorage");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO menu2 = new MenuVO("결재할기안", "/document/mupdatedoc");
		MenuVO menu3 = new MenuVO("전체내역", "/document/alldoclist");
		MenuVO menu4 = new MenuVO("기안작성", "/document/doctype");
		MenuVO menu5 = new MenuVO("내 신청내역", "/document/mydoclist");
		MenuVO menu6 = new MenuVO("임시보관함", "/document/mydocstorage");
		
		List<MenuVO> submenuList = Arrays.asList(menu2,menu3,menu4,menu5,menu6);
		
		model.addAttribute("currentURL","/document/mydocstorage");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("docPagingVO",pagingVO);
		model.addAttribute("menuList", menuList);
		return "document/mmydocstorage";
	}
	
	@RequestMapping(value="/aprlist", method = RequestMethod.POST)
	public ResponseEntity<List<DocVO>> aprList(String docNo){
		log.info("기안처리상태 선택");
		log.info("aprStat : " + docNo);
		
		List<DocVO> docList = docMapper.selectAprList(docNo);
		
		
		return new ResponseEntity<List<DocVO>>(docList, HttpStatus.OK);
	}
	
	@RequestMapping(value="/storagelist", method = RequestMethod.POST)
	public ResponseEntity<List<DocVO>> storagelist(String docNo){
		log.info("기안처리상태 선택");
		log.info("aprStat : " + docNo);
		
		List<DocVO> docList = docMapper.selectStorageList(docNo);
		
		
		return new ResponseEntity<List<DocVO>>(docList, HttpStatus.OK);
	}
	
	// 문서작성 화면 (공통)
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/documentwrite", method = RequestMethod.GET)
	public String docRegisterForm(Model model, String docClfCode) {
		log.info("docClfFile : " + docClfCode);
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		DocumentVO documentVO = docService.detail(docClfCode);
		
		List<InfoVO> emp = docMapper.deptList(empVO.getEmpNo());
		
		MenuVO menu1 = new MenuVO("문서작성", "");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		model.addAttribute("documentVO", documentVO);
		model.addAttribute("menuList", menuList);
		model.addAttribute("deptList", emp);
		return "document/documentwrite";
	}
	
	// 새로운 문서 작성
//	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String docRegister(DocVO docVO, HttpServletRequest req, RedirectAttributes ra) {
		log.info("docVO : " + docVO);
		
		String goPage = "";
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		// 작성한 문서가 근무일 때 
		if(docVO.getDocClfCode().equals("2")) {
			ServiceResult result = docService.docWorkRegister(docVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("sendmessage","200101001, 결재함을 확인해주세요.");
				String auth = docMapper.selectAuth(empVO);
				
				if(auth.equals("ROLE_MEMBER")) {
					goPage = "redirect:/document/gmydoclist";
					ra.addFlashAttribute("result", result);
				}else {
					goPage = "redirect:/document/mmydoclist";
					ra.addFlashAttribute("result", result);
				}
			}
		}
		// 작성한 문서가 휴가일 때
		else if(docVO.getDocClfCode().equals("3")){
			ServiceResult result = docService.docVacRegister(docVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("sendmessage","200101001, 결재함을 확인해주세요.");
				String auth = docMapper.selectAuth(empVO);
			if(auth.equals("ROLE_MEMBER")) {
				goPage = "redirect:/document/gmydoclist";
				ra.addFlashAttribute("result", result);
			}else {
				goPage = "redirect:/document/mmydoclist";
				ra.addFlashAttribute("result", result);
			}
			}
		}
		// 작성한 문서가 출장일 때
		else if(docVO.getDocClfCode().equals("1")){
			ServiceResult result = docService.docAbRegister(docVO);
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("sendmessage","200101001, 결재함을 확인해주세요.");
				String auth = docMapper.selectAuth(empVO);
				if(auth.equals("ROLE_MEMBER")) {
					goPage = "redirect:/document/gmydoclist";
					ra.addFlashAttribute("result", result);
				}else {
					goPage = "redirect:/document/mmydoclist";
					ra.addFlashAttribute("result", result);
				}
			}
		}else {
			log.info("기안문서 분류코드 : " + docVO.getDocClfCode());
			log.debug("해당 기안문서 분류는 존재하지 않습니다");
		}
		return goPage;
		
		
	}
	
	@ResponseBody 
	@RequestMapping(value="/aprupdate", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<ServiceResult> aprUpdate(@RequestBody DocVO docVO){
		log.info("문서 번호 : " + docVO);
		log.info("문서번호 : " + docVO.getDocNo());
		log.info("반려사유 : " + docVO.getAprRejRsn());
		
		ServiceResult result = null;
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		docVO.setEmpNo(empVO.getEmpNo());
		
		if(docVO.getAprRejRsn() == null) {
			result = docService.aprUpdate(docVO);
		}else {
			result = docService.aprReject(docVO);
		}
		
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/selectDoc", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<List<DocVO>> selectMyDocList(@RequestBody String docClfCode){
		log.info("docClfCode : " + docClfCode);
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		DocVO docVO = new DocVO();
		docVO.setEmpNo(empVO.getEmpNo());
		docVO.setDocClfCode(docClfCode);
		List<DocVO> docList = docService.selectClfCode(docVO);
		
		return new ResponseEntity<List<DocVO>>(docList, HttpStatus.OK);
	}
	
	@RequestMapping(value="/deletemydoc", method = RequestMethod.GET)
	public String deleteMyDoc(@RequestParam String docNo){
		log.info("삭제할 문서번호 : " + docNo);
		String goPage = "";
		
		ServiceResult result = docService.deleteDoc(docNo);
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		if(result.equals(ServiceResult.OK)) {
			String auth = docMapper.selectAuth(empVO);
			
			if(auth.equals("ROLE_MEMBER")) {
				goPage = "redirect:/document/gmydocstorage";
			}else {
				goPage = "redirect:/document/mmydocstorage";
			}
		}
		return goPage;
	}
	
	
	@RequestMapping(value="/docfix", method = RequestMethod.GET)
	public String docFix(@RequestParam String docNo, Model model) {
		
		log.info("수정할 문서 번호 : " + docNo);
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		DocVO docVO = docMapper.selectDoc(docNo);
		List<InfoVO> emp = docMapper.deptList(empVO.getEmpNo());
		model.addAttribute("documentVO", docVO);
		model.addAttribute("status", "u");
		model.addAttribute("deptList", emp);
		return "document/documentwrite";
	}
	
	@RequestMapping(value="/docsave", method = RequestMethod.POST)
	public String gdocSave(DocVO docVO) {
		String goPage ="";
		log.info("수정완료한 문서 : " + docVO);
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		EmpVO empVO = user.getEmp();
		
		ServiceResult result = docService.docSave(docVO);
		
		if(result.equals(ServiceResult.OK)) {
			String auth = docMapper.selectAuth(empVO);
			
			if(auth.equals("ROLE_MEMBER")) {
				goPage = "redirect:/document/gmydocstorage";
			}else {
				goPage = "redirect:/document/mmydocstorage";
			}
		}
		return goPage;
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')")
	@ResponseBody
	@RequestMapping(value="/searchall", method = RequestMethod.POST, consumes = "application/json")
	public ResponseEntity<List<DocVO>> searchDocumentAll(@RequestBody Map<String, String> map){
		log.info("searchAll 실행");
		log.info("searchWord : " + map.get("searchWord").toString());
		String searchWord = map.get("searchWord").toString();
		DocVO docVO = new DocVO();
		List<DocVO> docList = new ArrayList<DocVO>();
		docVO.setEmpName(searchWord);
		int allCount = docService.allCount(docVO);
//		docVO.setCount(allCount);
		log.info("이미 오류");
		if(docService.seachDoc(docVO).size() == 0){
			log.info("결과 오류");
			docVO.setCount(allCount);
			docList.add(docVO);
		}else {
			docList = docService.seachDoc(docVO);
			docList.get(0).setCount(allCount);
			
		}
		
		
		return new ResponseEntity<List<DocVO>>(docList, HttpStatus.OK);
	}
	
	
}



















