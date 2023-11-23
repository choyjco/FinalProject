<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>레벨 관리</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuAdmin.jsp" %>
        </div>

        <div class="col-lg-10 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
<!--             <h3 class="mb-5">레벨 관리</h3> -->
            <div class="col-lg-12" align="center">
            
            <div class="col-lg-10" align="right">
            	<button type="button" id="addBtn" class="btn btn-outline-light" style="background-color: #D0DDF3;">레벨 추가하기</button>
            </div>
            <br>
		
        <table class="table table-hover col-lg-10">
        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
        		<th style="width: 20%;">레벨 코드</th>
        		<th style="width: 20%;">레벨 이름</th>
        		<th style="width: 40%;">레벨 설명</th>
        		<th style="width: 20%;">레벨 가격</th>
        	</tr>
        	<c:choose>
        		<c:when test="${empty levelInfoList }">
        			<tr>
        				<td colspan="4" align="center">조회할 레벨이 없습니다.</td>
        			</tr>
        		</c:when>
        		<c:otherwise>
        			<c:forEach items="${levelInfoList }" var="levelInfo">
			        	<tr onclick="location.href='/mypageadmin/leveldetail?levelName=${levelInfo.levelName }'" style="cursor:pointer;">
			        		<td align="center">${levelInfo.levelName }</td>
			        		<td align="center">${levelInfo.levelMemo }</td>
			        		<td align="left">${levelInfo.levelVol }</td>
			        		<td align="right">
			        			<fmt:formatNumber value="${levelInfo.levelFee }" pattern="#,###" />원
			        		</td>
			        	</tr>
        			</c:forEach>
        		</c:otherwise>
        	</c:choose>
        </table>
			</div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var addBtn = $("#addBtn");
	
	addBtn.on("click", function() {
		location.href = "/mypageadmin/levelform";
	});
});
</script>
