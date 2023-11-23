<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="kr.or.ddit.vo.CustomUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<style>
input.transparent-focus {
    background-color: transparent; /* 배경색을 투명으로 설정 */
    border: 2px solid transparent; /* 테두리를 투명으로 설정 */
    color: black; /* 텍스트 색상을 검은색으로 설정 */
    outline: none; /* 포커스 시 테두리 제거 */
    transition: background-color 0.3s ease, border 0.3s ease; /* 전환 효과 추가 */
}

input.transparent-focus:focus {
    background-color: transparent; /* 포커스 시 배경색을 투명으로 유지 */
    border: 2px solid transparent; /* 포커스 시 테두리를 투명으로 유지 */
}

#seachTable tr:hover {
      background-color: #e9e9e9;
    }
    
</style>

<!-- ========== Left Sidebar Start ========== -->
<div class="vertical-menu" style="z-index: 10;">

    <!-- LOGO -->
    <div class="navbar-brand-box">
        <a href="/home/feed" class="logo logo-dark">
            <!-- 메뉴바 접었을 때 보이는 로고 -->
            <span class="logo-sm">
                <img src="${pageContext.request.contextPath }/resources/assets/images/wsiii.png" alt="" height="40" >
            </span>
            <!-- 메뉴바 펼쳤을 때 보이는 로고 -->
            <span class="logo-lg">
                <%-- <img src="${pageContext.request.contextPath }/resources/assets/images/wsi.png" alt="" height="40">
                <img src="${pageContext.request.contextPath }/resources/assets/images/WSILOGO.PNG" alt="" height="50"> --%>
                <img src="${pageContext.request.contextPath }/resources/assets/images/wwwssi.png" alt="" height="60">
            </span>
        </a>

        <a href="/home/feed" class="logo logo-light">
            <span class="logo-lg">
                <img src="${pageContext.request.contextPath }/resources/assets/images/logo-light.png" alt="" height="22">
            </span>
            <span class="logo-sm">
                <img src="${pageContext.request.contextPath }/resources/assets/images/logo-sm-light.png" alt="" height="22">
            </span>
        </a>
    </div>

	<button type="button" class="btn btn-sm px-3 font-size-16 header-item vertical-menu-btn">
<!--         <i class="fa fa-fw fa-bars"></i> -->
		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
    </button>
    <%
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	%>
<!--- Sidemenu -->
	<div data-simplebar="init" class="sidebar-menu-scroll">
		<div class="simplebar-wrapper" style="margin: 0px;">
			<div class="simplebar-height-auto-observer-wrapper">
				<div class="simplebar-height-auto-observer"></div>
			</div>
			<div class="simplebar-mask">
				<div class="simplebar-offset" style="right: -16.8px; bottom: 0px;">
					<div class="simplebar-content-wrapper"
						style="height: 100%; overflow: hidden scroll;">
						<div class="simplebar-content" style="padding: 0px;">

							<!--- Sidemenu -->
							<div id="sidebar-menu">
								<!-- Left Menu Start -->
								<ul class="metismenu list-unstyled" id="side-menu">
									<li>
										<a href="/mypage/main"> 
											<img class="rounded-circle header-profile-user" style="width: 40px; height: 40px;" src="${pageContext.request.contextPath }<%=user.getEmp().getSavePath() %>"
											alt="Header Avatar"> 
											<span class="row" style="padding-left: 10px"> 
											    <span class="user-name"><b><%=user.getEmp().getEmpName()%></b></span>
											    <span class="user-sub-title"> <%
											    if(user.getEmp().getDeptName() == null ){
											    	out.print(" ");
											    }else{
											    	out.print(user.getEmp().getDeptName());
											    } %> <%
											    if(user.getEmp().getJobName().startsWith("직") ){
											    	out.print(" ");
											    }else{
											    	out.print(user.getEmp().getJobName());
											    }
											    %></span>
											</span>

									</a></li>

									<li class="menu-title" data-key="t-applications">MENU</li>
											
									<li>
				                        <a href="javascript: void(0);" class="has-arrow">
				                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
<!-- 				                            <i class="icon nav-icon" data-feather="home"></i> -->
				                            <span class="menu-item" data-key="t-multi-level">홈</span>
				                        </a>
				                        <ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/home/feed" data-key="t-home-feed">메인</a></li>
												<li><a href="/full-calendar/schedule" data-key="t-schedule">일정</a></li>
												<li><a href="/notice/list" data-key="t-notice-list">공지사항</a></li>
											</sec:authorize>
										</ul>
				                    </li>
									
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
											<span class="menu-item" data-key="t-settings">인사</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<sec:authorize access="hasRole('ROLE_MEMBER')">
												<li><a href="/hr/ghr" data-key="t-document-gdoctype">목록</a></li>
											</sec:authorize>
											<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/hr/mhr1" class="has-arrow" data-key="t-pay-home" aria-expanded="false">목록</a>
													<ul class="sub-menu mm-collapse" aria-expanded="true">
														<li><a href="/hr/mhr1" data-key="t-pay-inCal">사원조회</a></li>
														<li><a href="/hr/mhr12" data-key="t-pay-inCal">재직 상태</a></li>
													</ul>
												</li>
												<li><a href="/hr/mhr2" class="has-arrow" data-key="t-pay-home" aria-expanded="false">인사발령</a>
													<ul class="sub-menu mm-collapse" aria-expanded="true">
														<li><a href="/hr/mhr2" data-key="t-pay-inCal">부서 이동</a></li>
														<li><a href="/hr/mhr21" data-key="t-pay-inCal">승진</a></li>
														<li><a href="/hr/mhr22" data-key="t-pay-inCal">채용</a></li>
														<li><a href="/hr/mhr3" data-key="t-pay-inCal">발령 내역</a></li>
													</ul>
												</li>
											</sec:authorize>
										</ul>
									</li>
									<c:set var="empName" value="<%=user.getEmp().getEmpName() %>" />

									<c:if test="${empName ne '테스트' }">

									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
											<span class="menu-item" data-key="t-settings">기안·결재</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<sec:authorize access="hasRole('ROLE_MEMBER')">
												<li><a href="/document/gdoctype" data-key="t-document-gdoctype">기안작성</a></li>
												<li><a href="/document/gmydoclist" data-key="t-document-gmydoclist">내 신청내역</a></li>
												<li><a href="/document/gmydocstorage" data-key="t-document-gmydocstorage">임시보관함</a></li>
											</sec:authorize>
											<sec:authorize access="hasRole('ROLE_MANAGER')">
												<li><a href="/document/updatedoc" data-key="t-document-updatedoc">결재할 기안</a></li>
												<li><a href="/document/mdoctype" data-key="t-document-mdoctype">기안작성</a></li>
												<li><a href="/document/mmydoclist" data-key="t-document-mmydoclist">내 신청내역</a></li>
												<li><a href="/document/mmydocstorage" data-key="t-document-mmydocstorage">임시보관함</a></li>
											</sec:authorize>
											<sec:authorize access="hasRole('ROLE_ADMIN')">
												<li><a href="/document/mupdatedoc" data-key="t-document-updatedoc">결재할기안</a></li>
												<li><a href="/document/alldoclist" data-key="t-document-alldoclist">전체내역</a></li>
												<li><a href="/document/doctype" data-key="t-document-mdoctype">기안작성</a></li>
												<li><a href="/document/mydoclist" data-key="t-document-mmydoclist">내 신청내역</a></li>
												<li><a href="/document/mydocstorage" data-key="t-document-mmydocstorage">임시보관함</a></li>
											</sec:authorize>
										</ul>
									</li>
									</c:if>
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
											<span class="menu-item" data-key="t-settings">근무</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li><a href="/work/myworklist" data-key="t-work-myworklist">나의 근무</a></li>
											<sec:authorize access="hasRole('ROLE_MEMBER')">
												<li><a href="/work/myteamworklist" data-key="t-work-myteamworklist">우리 부서 근무</a></li>
											</sec:authorize>
											<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/work/teamworklist" data-key="t-work-teamworklist">구성원 근무</a></li>
												<li><a href="/work/workmanagelist" class="has-arrow" data-key="t-work-workmanagelist" aria-expanded="false">근무 관리</a>
													<ul class="sub-menu mm-collapse" aria-expanded="true">
														<li><a href="/work/workmanagelist" data-key="t-work-workmanagelist">근무기록 조회</a></li>
														<li><a href="/work/workmanage" data-key="t-work-workmanage">근무 신청 처리</a></li>
													</ul>
												</li>
											</sec:authorize>
										</ul>
									</li>

									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
											<span class="menu-item" data-key="t-settings">급여</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li><a href="/pay/list" data-key="t-pay-list">내급여</a></li>
											<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/pay/home" class="has-arrow" data-key="t-pay-home" aria-expanded="false">급여정산</a>
													<ul class="sub-menu mm-collapse" aria-expanded="true">
														<li><a href="/pay/home" data-key="t-pay-inCal">정산 메뉴</a></li>
														<li><a href="/pay/inCal" data-key="t-pay-inCal">중간 정산</a></li>
														<li><a href="/pay/outCal" data-key="t-pay-outCal">퇴직금 정산</a></li>
														<li><a href="/pay/middleCal" data-key="t-pay-outCal">중간 정산자 목록</a></li>
													</ul>
												</li>
												<li><a href="/pay/past" data-key="t-pay-past">지난 정산 내역</a></li>
											</sec:authorize>
										</ul>
									</li>
									
									<c:if test="${empName ne '테스트' }">
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
											<span class="menu-item" data-key="t-settings">휴가</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li>
												<a href="/vacation/vacationapply" data-key="t-vacation-vacationapply" class="has-arrow" aria-expanded="false">나의 휴가</a>
												<ul class="sub-menu mm-collapse" aria-expanded="true">
													<li><a href="/vacation/vacationapply" data-key="t-vacation-annuallist">휴가 신청</a></li>
													<li><a href="/vacation/annuallist" data-key="t-vacation-annuallist">내 연차 상세</a></li>
												</ul>
											</li>
											<sec:authorize access="hasRole('ROLE_MEMBER')">
												<li><a href="/vacation/myteamvacation" data-key="t-vacation-myteamvacation">우리 팀 휴가 보유 현황</a></li>
											</sec:authorize>
											<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/vacation/teamvacationlist" data-key="t-vacation-teamvacationlist" class="has-arrow" aria-expanded="false">휴가 관리</a>
													<ul class="sub-menu mm-collapse" aria-expanded="true">
														<li><a href="/vacation/teamvacationlist" data-key="t-vacation-teamvacationlist">구성원 휴가 보유 현황</a></li>
														<li><a href="/vacation/teamvacationusinglist" data-key="t-vacation-teamvacationlist">구성원 휴가 신청 내역</a></li>
														<li><a href="/vacation/annualmanage" data-key="t-vacation-annualmanage">구성원 연차 관리</a></li>
													</ul>
												</li>
											</sec:authorize>
										</ul>
									</li>
									</c:if>
									
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-download"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
											<span class="menu-item" data-key="t-settings">자료실</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<sec:authorize access="hasRole('ROLE_MEMBER')">
												<li><a href="/library/glibrary" data-key="t-library-glibrary">증명서 및 자료실</a></li>
											</sec:authorize>
											<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
												<li><a href="/library/mlibrary" data-key="t-library-mlibrary">증명서 및 자료실</a></li>
											</sec:authorize>
										</ul>
									</li>

												<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-settings icon-sm"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
											<span class="menu-item" data-key="t-settings">시스템 관리</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li><a href="/settings/list" data-key="t-user-settings">설정</a></li>
										</ul>
									</li>
								</sec:authorize>
								
								<sec:authorize access="hasAnyRole('ROLE_MANAGER')">
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-settings icon-sm"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
											<span class="menu-item" data-key="t-settings">시스템 관리</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li><a href="/settings/middlelist" data-key="t-user-settings">설정</a></li>
										</ul>
									</li>
								</sec:authorize>
								
								<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
									<li class="">
										<a href="javascript: void(0);" class="has-arrow mm-collapsed" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-zap"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
											<span class="menu-item" data-key="t-settings">경영관리</span>
										</a>
										<ul class="sub-menu mm-collapse" aria-expanded="false" style="">
											<li><a href="/stats/list" data-key="t-user-settings">경영지표</a></li>
										</ul>
									</li>
								</sec:authorize>

								</ul>
							</div><!-- Sidebar -->
						</div>
					</div>
				</div>
			</div>
			<div class="simplebar-placeholder"
				style="width: auto; height: 1319px;"></div>
		</div>
		<div class="simplebar-track simplebar-horizontal"
			style="visibility: hidden;">
			<div class="simplebar-scrollbar"
				style="transform: translate3d(0px, 0px, 0px); display: none;"></div>
		</div>
		<div class="simplebar-track simplebar-vertical"
			style="visibility: visible;">
			<div class="simplebar-scrollbar"
				style="height: 347px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
		</div>
	</div>
</div>