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
            <h3 class="mb-5" align="center"><b>구매 회원 상세보기</b></h3>
            <div class="col-lg-12" align="center">
        <div>
	        <table class="table col-lg-10">
	        	<tr style="background-color: #D0DDF3; color: black;">
	        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	        		<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
	        	</tr>
	        	<tr>
	        		<th>결제 번호</th>
	        		<td>${customerVO.paymentVO.payCode }</td>
	        	</tr>
	        	<tr>
	        		<th>회사명(사업자번호)</th>
	        		<td>${customerVO.cusCom }(${customerVO.cusRnum })</td>
	        	</tr>
	        	<tr>
	        		<th>대표자 이름</th>
	        		<td>${customerVO.cusName }</td>
	        	</tr>
	        	<tr>
	        		<th>구독 기간</th>
	        		<td>
			        	<fmt:formatDate value="${customerVO.paymentVO.payDate }" pattern="yyyy-MM-dd"/> ~ 
			        	<fmt:formatDate value="${customerVO.paymentVO.payEdate }" pattern="yyyy-MM-dd"/>
	        		</td>
	        	</tr>	
	        	<tr>
	        		<th>선택한 레벨</th>
	        		<td>${customerVO.paymentVO.levelName }(${customerVO.paymentVO.levelMemo }) : ${customerVO.paymentVO.levelVol }</td>
	        	</tr>
	        	<tr>
	        		<th>선택한 기능</th>
	        		<td>
		        		<c:forEach items="${customerVO.paymentVO.funcLevelList }" var="funcLevelList" >
			        		${funcLevelList.funcMemo }(${funcLevelList.funcName })<br>
		        		</c:forEach>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>결제 금액</th>
	        		<td>
	        			<fmt:formatNumber value="${customerVO.paymentVO.payAmt }" pattern="#,###" />원
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>결제 방법(결제 시간)</th>
	        		<td>
	        			${customerVO.paymentVO.payMethod } 결제(<fmt:formatDate value="${customerVO.paymentVO.payDate }" pattern="yyyy-MM-dd HH:mm:ss"/>)
	        		</td>
	        	</tr>
	        </table>
	        <form action="/mypageadmin/leveldelete" method="post" id=levelForm>
				<input type="hidden" id="levelName" name="levelName" value="${customerVO.paymentVO.levelName }" />
				<sec:csrfInput />
			</form>
        	<div align="right" style="margin-right: 100px;">
				<button type="button" class="btn btn-light" style="background-color: #D0DDF3;" id="listBtn">목록</button>
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
	var levelForm = $("#levelForm");
	
	listBtn.on("click", function() {
		location.href = "/mypageadmin/purchaselist";
	});
	
});
</script>
