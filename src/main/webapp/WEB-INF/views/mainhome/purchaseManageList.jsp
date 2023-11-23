<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>구매 회원 관리</h1>
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
<!--             <h3 class="mb-5">구매 회원 관리</h3> -->
            <div class="col-lg-12" align="center">
		<div class="col-lg-10" align="right">
			<div>
			<form id="searchForm" class="input-group input-group-sm" style="width: 440px;">
				<input type="hidden" name="page" id="page"/>
				<select class="form-control" id="searchType" name="searchType">
					<option value="cusRnum" <c:if test="${searchType eq 'cusRnum' }">selected</c:if>>아이디(사업자등록번호)</option>
					<option value="cusCom" <c:if test="${searchType eq 'cusCom' }">selected</c:if>>회사이름</option>
					<option value="cusName" <c:if test="${searchType eq 'cusName' }">selected</c:if>>이름</option>
				</select>
				<input type="text" class="form-control" name="searchWord" value="${searchWord }" placeholder="검색어를 입력해주세요.">
				<div class="input-group-append">
					<button type="submit" class="btn btn-default" style="background-color: #D0DDF3; color: black;">검색</button>
				</div>
				<sec:csrfInput/>
			</form>
			</div>
		</div>
		
        <br>
        <table class="table table-hover col-lg-10">
        	<tr style="background-color: #D0DDF3; color: black;">
        		<th style="width: 10%;">결제 번호</th>
        		<th style="width: 20%;">회사 이름</th>
        		<th style="width: 12%; text-align: center;">결제 날짜</th>
        		<th style="width: 12%; text-align: center;">구독 만료일</th>
        		<th style="width: 12%; text-align: center;">선택한 레벨</th>
        		<th style="width: 12%; text-align: center;">결제 금액</th>
        		<th style="width: 12%; text-align: center;">결제 방식</th>
        	</tr>
        	<c:set value="${pagingVO.dataList }" var="paymentList"/>
        	<c:choose>
        		<c:when test="${empty paymentList }">
        			<tr>
        				<td colspan="7" align="center">조회할 결제 내역이 존재하지 않습니다.</td>
        			</tr>
        		</c:when>
        		<c:otherwise>
        			<c:forEach items="${paymentList }" var="paymentList">
        				<c:if test="${customer.cusRnum ne 'admin' }">
				        	<tr onclick="location.href='/mypageadmin/purchasedetail?payCode=${paymentList.paymentVO.payCode }'" style="cursor:pointer;">
				        		<td>${paymentList.paymentVO.payCode }</td>
				        		<td>${paymentList.cusCom }</td>
				        		<td align="center">
				        			<fmt:formatDate value="${paymentList.paymentVO.payDate }" pattern="yyyy-MM-dd"/>
				        		</td>
				        		<td align="center">
				        			<fmt:formatDate value="${paymentList.paymentVO.payEdate }" pattern="yyyy-MM-dd"/>
				        		</td>
				        		<td align="center">${paymentList.paymentVO.levelName }</td>
				        		<td align="center">
					        		<fmt:formatNumber value="${paymentList.paymentVO.payAmt }" pattern="#,###" />원
				        		</td>
				        		<td align="center">${paymentList.paymentVO.payMethod }</td>
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
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});
</script>