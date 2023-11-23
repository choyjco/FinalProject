<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>회원 마이페이지</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%; height: 500px;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
<%--         	<input type="text" id="cusRnum1" name="cusRnum1" value="${SessionInfo.cusRnum }"> --%>
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuUser.jsp" %>
        </div>

        <div class="col-lg-10 pt-5" style="padding-left: 20px; padding-right: 20px;">
            <h3 class="mb-5">회원 마이페이지</h3>
            <p>회원 마이페이지입니다~!</p>
<%--             <input type="text" id="cusRnum" name="cusRnum" value="${customerVO.cusRnum }"> --%>
<%--         	<input type="text" id="cusRnum1" name="cusRnum1" value="${SessionInfo.cusRnum }"> --%>
        </div>
    </div>
</div>
