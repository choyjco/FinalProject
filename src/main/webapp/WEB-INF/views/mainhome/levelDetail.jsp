<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


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
            <h3 class="mb-5" align="center"><b>레벨 상세보기</b></h3>
            <div class="col-lg-12" align="center">
        <div>
	        <table class="table col-lg-10">
	        	<tr style="background-color: #D0DDF3; color: black;">
	        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	        	</tr>
	        	<tr>
	        		<th>레벨 코드</th>
	        		<td>${levelInfo.levelName }</td>
	        	</tr>
	        	<tr>
	        		<th>레벨 이름</th>
	        		<td>${levelInfo.levelMemo }</td>
	        	</tr>
	        	<tr>
	        		<th>레벨 가격</th>
	        		<td>
	        			<fmt:formatNumber value="${levelInfo.levelFee }" pattern="#,###" />원
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>레벨 설명</th>
	        		<td>${levelInfo.levelVol }</td>
	        	</tr>
	        </table>
	        <form action="/mypageadmin/leveldelete" method="post" id=levelForm>
				<input type="hidden" name="levelName" value="${levelInfo.levelName }" />
				<sec:csrfInput />
			</form>
        	<div align="right" style="margin-right: 100px;">
				<button type="button" class="btn btn-light" id="listBtn">목록</button>
				<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
				<button type="button" class="btn btn-secondary" id="deleteBtn">삭제</button>
			</div>
        </div>
    </div>
</div>
</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var listBtn = $("#listBtn");
	var updateBtn = $("#updateBtn");
	var deleteBtn = $("#deleteBtn");
	var levelForm = $("#levelForm");
	
	listBtn.on("click", function() {
		location.href = "/mypageadmin/levellist";
	});
	
	updateBtn.on("click", function() {
		levelForm.attr("method", "get");
		levelForm.attr("action", "/mypageadmin/levelupdate");
		levelForm.submit();
	})
	
	deleteBtn.on("click", function() {
		if(confirm("정말 삭제하시겠습니까?")) {
			levelForm.submit();
		}
	});
});
</script>
