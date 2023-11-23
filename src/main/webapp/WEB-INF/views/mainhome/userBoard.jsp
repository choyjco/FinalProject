<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>1:1 문의</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%; height: 500px;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuUser.jsp" %>
        </div>
		<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
        <div class="col-lg-10 pt-5" style="padding-left: 20px; padding-right: 20px;">
<!--         <h3 align="center"><b>내가 쓴 문의글</b></h3><br> -->
		<div class="col-lg-12" align="right">
			<div>
			<form id="searchForm" class="input-group input-group-sm" style="width: 440px;">
				<input type="hidden" name="page" id="page"/>
				<select class="form-control" id="searchType" name="searchType">
					<option value="inqTitle" <c:if test="${searchType eq 'inqTitle' }">selected</c:if>>제목</option>
					<option value="cusCom" <c:if test="${searchType eq 'cusCom' }">selected</c:if>>회사 이름</option>
					<option value="cusName" <c:if test="${searchType eq 'cusName' }">selected</c:if>>작성자</option>
					<option value="cusRnum" <c:if test="${searchType eq 'cusRnum' }">selected</c:if>>사업자등록번호</option>
				</select>
				<input type="text" class="form-control" name="searchWord" value="${searchWord }" placeholder="검색어를 입력해주세요.">
				<div class="input-group-append">
					<button type="submit" class="btn btn-default" style="background-color: #D0DDF3; color: black;">검색</button>
				</div>
				<sec:csrfInput/>
			</form>
			</div>
			<br>
        	<c:if test="${SessionInfo != null }">
		        <button type="button" id="writeBtn" class="btn btn-outline-light" style="background-color: #D0DDF3; color: black;">문의하기</button>
        	</c:if>
		</div>
		
        <br>
        <table class="table table-hover col-lg-12">
        	<tr style="background-color: #D0DDF3; color: black;">
        		<th style="width: 10%;">번호</th>
        		<th style="width: 30%;">제목</th>
        		<th style="width: 20%;">회사 이름</th>
        		<th style="width: 20%; text-align: center;">작성자(사업자등록번호)</th>
        		<th style="width: 10%; text-align: center;">작성일</th>
        		<th style="width: 10%; text-align: center;">답변여부</th>
        	</tr>
        	<c:set value="${pagingVO.dataList }" var="inqBoardList"/>
        	<c:choose>
        		<c:when test="${empty inqBoardList }">
        			<tr>
        				<td colspan="6" align="center">조회하실 게시글이 존재하지 않습니다.</td>
        			</tr>
        		</c:when>
        		<c:otherwise>
        			<c:forEach items="${inqBoardList }" var="inqBoard">
        				<c:if test="${inqBoard.cusRnum eq SessionInfo.cusRnum  }">
				        	<tr onclick="location.href='/askdetail?inqNo=${inqBoard.inqNo }'" style="cursor:pointer;">
				        		<td>${inqBoard.inqNo }</td>
				        		<td>${inqBoard.inqTitle }</td>
				        		<td>${inqBoard.customerVO.cusCom }</td>
				        		<td align="center">${inqBoard.customerVO.cusName }(${inqBoard.cusRnum })</td>
				        		<td align="center">
									<fmt:formatDate value="${inqBoard.inqDate }" pattern="yyyy-MM-dd"/>
								</td>
				        		<td align="center">
									<c:if test="${inqBoard.inqConf eq 'N' }">
										<span class="badge badge-danger" style="background-color: #F5899E;">답변대기</span>
									</c:if>
									<c:if test="${inqBoard.inqConf eq 'Y' }">
										<span class="badge badge-primary" style="background-color: #81B5F5;">답변완료</span>
									</c:if>
				        		</td>
				        	</tr>
				        </c:if>
        			</c:forEach>
        		</c:otherwise>
        	</c:choose>
        </table>
        <nav aria-label="Page navigation example" id="pagingArea">
			${pagingVO.pagingHTML }
		</nav>
	</div>
</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var writeBtn = $("#writeBtn");
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	writeBtn.on("click", function() {
		location.href = "/askform";
	});
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
});
</script>
