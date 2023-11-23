package kr.or.ddit.controller.library;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
import kr.or.ddit.controller.util.MediaUtils;
import kr.or.ddit.mapper.library.LibMapper;
import kr.or.ddit.service.library.ILibraryService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.LibraryVO;
import kr.or.ddit.vo.MenuVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/library")
public class LibraryController {
	
	@Inject
	private ILibraryService libService;
	
	@Inject
	private LibMapper libMapper;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value="/glibrary")
	public String glibrary(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "docClfName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<LibraryVO> pagingVO = new PaginationInfoVO<LibraryVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		List<LibraryVO> libList = libService.libList(pagingVO);
		int libCnt = libMapper.libListCnt(pagingVO);
		pagingVO.setDataList(libList);
		pagingVO.setTotalRecord(libCnt);
		MenuVO menu1 = new MenuVO("증명서 및 자료실", "/library/glibrary");
		
		List<MenuVO> menuList = Arrays.asList(menu1);
		model.addAttribute("menuList",menuList);
		int libSize = libMapper.libSize();
		MenuVO menu2 = new MenuVO("일반증명서 및 자료", "/library/glibrary");
		
		List<MenuVO> submenuList = Arrays.asList(menu2);
		
		model.addAttribute("currentURL","/library/glibrary");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("libSize",libSize);
		
		model.addAttribute("pagingVO", pagingVO);
		return "library/glibrary";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
	@RequestMapping(value="/mlibrary")
	public String mlibrary(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "docClfName") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model, HttpServletRequest request) {
		
		PaginationInfoVO<LibraryVO> pagingVO = new PaginationInfoVO<LibraryVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		
		MenuVO menu1 = new MenuVO("일반증명서 및 자료","/library/mlibrary");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		List<LibraryVO> libList = libService.libList(pagingVO);
		int libCnt = libMapper.libListCnt(pagingVO);
		
		pagingVO.setDataList(libList);
		pagingVO.setTotalRecord(libCnt);
		
		int libSize = libMapper.libSize();
		MenuVO menu2 = new MenuVO("일반증명서 및 자료", "/library/mlibrary");
		
		List<MenuVO> submenuList = Arrays.asList(menu2);
		
		model.addAttribute("currentURL","/library/mlibrary");
		model.addAttribute("submenuList", submenuList);
		model.addAttribute("libSize",libSize);
		model.addAttribute("menuList",menuList);
		model.addAttribute("pagingVO", pagingVO);
		return "library/mlibrary";
	}
	
//	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
//	@RequestMapping(value="/libraliydata", method = RequestMethod.GET)
//	public String libraliydata(Model model, String libNo) {
//		log.info("libNo : " + libNo);
//		LibraryVO libVO = libService.detail(libNo);
//		
//		MenuVO menu1 = new MenuVO("자료등록","/library/libraliydata");
//		List<MenuVO> menuList = Arrays.asList(menu1);
//		
//		model.addAttribute("menuList",menuList);
//		model.addAttribute("libVO", libVO);
//		return "library/libraliydata";
//	}
	
	
	@RequestMapping(value="/deletelib", method = RequestMethod.GET)
	public String deleteLib(@RequestParam String libNo, RedirectAttributes ra) {
		
		ServiceResult result = libService.deleteLib(libNo);
		if(result == ServiceResult.OK) {
			ra.addFlashAttribute("result", "성공");
		}else {
			
			ra.addFlashAttribute("result", "실패");
		}
		return "redirect:/library/mlibrary";
	}
	
	@RequestMapping(value="/download", method = RequestMethod.GET)
	public ResponseEntity<byte[]> libraryDownload(String libFileNo) throws IOException {
		log.info("libFileNo : " + libFileNo);
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName = null;
		AttachVO fileVO = libService.selectAttachInfo(libFileNo);
		
		if(fileVO != null) {
			fileName = fileVO.getFileOrgname();
			try {
				String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
				MediaType mType = MediaUtils.getMediaType(formatName);
				HttpHeaders headers = new HttpHeaders();
				in = new FileInputStream(fileVO.getFileSavepath());
				
//				if(mType != null) {		// 미디어타입일때 미리보기
//					headers.setContentType(mType);
//				}else {		// 미디어가 아니면 다운로드하려는 의도
					fileName = fileName.substring(fileName.indexOf("_") + 1);
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\"" +
							new String(fileName.getBytes("UTF-8"), "ISO-8859-1")  + "\"");
//				}
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				if(in != null) {
					in.close();
				}
			}
		}else {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String libRegisterForm(
			RedirectAttributes ra, 
			HttpServletRequest req, 
			Model model, LibraryVO libVO) throws Exception{
		log.info("libVO : " + libVO);
		String goPage = "";
		Long size = libVO.getAttachLib().getFileSize();
		log.info("파일 크기 : " + size);
		
		ServiceResult result = libService.libRegister(req,libVO);
		
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "자료 등록 완료!");
			goPage = "redirect:/library/mlibrary";
		}else {
			ra.addAttribute("message", "서버에러, 다시 시도해주세요.");
			goPage = "redirect:/library/mlibrary";
		}
		return goPage;
	}
	
}
