<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="site-wrap">
	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close mt-3">
				<span class="icon-close2 js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>
</div>

<header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">

	<div class="container">
		<div class="row align-items-center">
			<div class="col-6 col-xl-2">
				<h1 class="mb-0 site-logo">
					<a href="/main" class="h2 mb-0">WSI<span class="text-primary">.</span>
					</a>
				</h1>
			</div>

			<div class="col-12 col-md-10 d-none d-xl-block">
				<nav class="site-navigation position-relative text-right" role="navigation">
					<ul class="site-menu main-menu js-clone-nav mr-auto d-none d-lg-block">
						<li><a href="/main" class="nav-link">Home</a></li>
<!-- 						<li><a href="/main#intro-section" class="nav-link">WSI 소개</a></li> -->
						<li class="has-children">
							<a href="/main#intro-section" class="nav-link">서비스 소개</a>
<!-- 							<a href="/main#about-section"class="nav-link">서비스</a> -->
							<ul class="dropdown">
								<li><a href="/main#intro-section" class="nav-link">WSI 소개</a></li>
								<li><a href="/main#basicfunction-section" class="nav-link">기본 기능 소개</a></li>
								<li><a href="/main#selectfunction-section" class="nav-link">선택 기능 소개</a></li>
								<li><a href="/main#team-section" class="nav-link">팀원 소개</a></li>
<!-- 								<li class="has-children"><a href="#">More Links</a> -->
<!-- 									<ul class="dropdown"> -->
<!-- 										<li><a href="#">Menu One</a></li> -->
<!-- 										<li><a href="#">Menu Two</a></li> -->
<!-- 										<li><a href="#">Menu Three</a></li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
							</ul>
						</li>

						<li><a href="/main#pricing-section" class="nav-link">가격 정책</a></li>
						<li><a href="/main#faq-section" class="nav-link">자주 묻는 질문</a></li>
						<!--                 <li><a href="/main#testimonials-section" class="nav-link">Testimonials</a></li> -->
						<!--                 <li><a href="/main#blog-section" class="nav-link">Blog</a></li> -->
						
						
						<c:if test="${SessionInfo == null }">
							<li><a href="/mainlogin" class="nav-link btn btn-primary btn-sm mr-2 mb-2">로그인</a></li>
							<li><a href="/register" class="nav-link btn btn-secondary btn-sm mr-2 mb-2">회원가입</a></li>
						</c:if>
						<c:choose>
							<c:when test="${SessionInfo.cusRnum eq 'admin' }">
								<li><a href="/mainlogout" class="nav-link btn btn-primary btn-sm mr-2 mb-2">로그아웃</a></li>
								<li><a href="/mypageadmin/adminboard" class="nav-link btn btn-secondary btn-sm mr-2 mb-2">관리자 페이지</a></li>
							</c:when>
							<c:when test="${SessionInfo != null }">
								<li><a href="/mainlogout" class="nav-link btn btn-primary btn-sm mr-2 mb-2">로그아웃</a></li>
								<li><a href="/mypageuser/userpwcheck" class="nav-link btn btn-secondary btn-sm mr-2 mb-2">${SessionInfo.cusName }님의 마이페이지</a></li>
							</c:when>
						</c:choose>
					</ul>
				</nav>
			</div>


			<div class="col-6 d-inline-block d-xl-none ml-md-0 py-3" style="position: relative; top: 3px;">
				<a href="#" class="site-menu-toggle js-menu-toggle float-right">
				<span class="icon-menu h3"></span></a>
			</div>
		</div>
	</div>
</header>