<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>회원 목록</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%;">
    <div class="row" style="margin: 0; padding: 0;" >
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuAdmin.jsp" %>
        </div>

        <div class="col-lg-10 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <h3 class="mb-5" align="center"><b>회원 정보 상세보기</b></h3>
            <div class="col-lg-12" align="center">
        <table class="table col-lg-10">
        	<tr style="background-color: #D0DDF3; color: black;">
        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
        	</tr>
        	<tr>
        		<th class="col-lg-4">아이디(사업자등록번호)</th>
        		<td class="col-lg-6">${customer.cusRnum }</td>
        	</tr>
        	<tr>
        		<th>회사 이름</th>
        		<td>${customer.cusCom }</td>
        	</tr>
        	<tr>
        		<th>이름(대표자)</th>
        		<td>${customer.cusName }</td>
        	</tr>
        	<tr>
        		<th>우편 번호</th>
        		<td>${customer.cusZip }</td>
        	</tr>
        	<tr>
        		<th>회사 주소</th>
        		<td>${customer.cusAddr }</td>
        	</tr>
        	<tr>
        		<th>상세주소</th>
        		<td>${customer.cusAddr2 }</td>
        	</tr>
        	<tr>
        		<th>회사 번호</th>
        		<td>${customer.cusTel }</td>
        	</tr>
        	<tr>
        		<th>회사 인원수</th>
        		<td>
        			<fmt:formatNumber value="${customer.cusEmp }" pattern="#,###" />명
        		</td>
        	</tr>
        	<tr>
        		<th>이메일</th>
        		<td>${customer.cusEmail }</td>
        	</tr>
        	<tr>
        		<th>창립일</th>
        		<td>${customer.cusBirth }</td>
        	</tr>
        	<tr>
        		<th>회사 로고</th>
       			<td>
	       			<img src="${pageContext.request.contextPath }${customer.cusLogo }" style="width: 300px;">
       			</td>
        	</tr>
        	<tr>
        		<th>프로필 이미지</th>
        		<td>
       				<img src="${pageContext.request.contextPath }${customer.cusImage }" style="width: 300px;">
				</td>
        	</tr>
        	<tr>
        		<th>회사 직인</th>
        		<td>
       				<img src="${pageContext.request.contextPath }${customer.cusSignature }" style="width: 300px;">
				</td>
        	</tr>
        </table>
	        	<div align="right" style="margin-right: 100px;">
					<button type="button" class="btn btn-light" id="listBtn">목록</button>
					<button type="button" class="btn btn-primary">수정</button>
					<button type="button" class="btn btn-secondary">삭제</button>
				</div>
        	</div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var listBtn = $("#listBtn");
	
	listBtn.on("click", function() {
		location.href = "/mypageadmin/customerlist";
	});
});
</script>
