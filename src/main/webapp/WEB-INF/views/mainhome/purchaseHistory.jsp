<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>구매 내역</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%; height: 700px;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuUser.jsp" %>
        </div>
        <div class="col-lg-10 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;" align="left">
        	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
            <div class="col-lg-12">
            	<div class="col-lg-10" style="margin-left: 100px; margin-right: 100px;">
					<div class="card">
						<div class="card-header" style="background-color: #D0DDF3;"></div>
						<div class="card-body">
							<h4 class="card-title" align="center"><b>현재 이용중인 인사시스템 정보</b></h4>
							<hr>
							<div style="padding-left: 200px; padding-right: 100px;" align="left">
					    		<li>현재 이용중인 레벨 : <span>${customerVO.paymentVO.levelName }(${customerVO.paymentVO.levelVol })</span></li>
					    		<br>
								<li>현재 이용중인 기능 : </li>
					    		<c:forEach items="${customerVO.paymentVO.funcLevelList }" var="funcLevelList" >
					    			<span style="padding-left: 30px;">- ${funcLevelList.funcName }(${funcLevelList.funcMemo })</span><br>
					    		</c:forEach>
					    		<br>
					    		<li>구독 기간 : <fmt:formatDate value="${customerVO.paymentVO.payDate }" pattern="yyyy-MM-dd"/> ~
	    								 <fmt:formatDate value="${customerVO.paymentVO.payEdate }" pattern="yyyy-MM-dd"/></li>
	    						<br>
	    						<li>결제 금액 : <fmt:formatNumber value="${customerVO.paymentVO.payAmt }" pattern="#,###" />원</li>
							</div>
							<br>
							<div align="center">
				            	<button type="button" id="systemBtn" class="btn btn-primary">시스템으로 가기</button>
							</div>
						</div>
					</div>
            	</div>
            	
            	
<!--             <h3 class="mb-5" align="center"><b>현재 이용중인 인사시스템 정보</b></h3> -->
        	
<!--         	<hr style="margin-left: 200px; margin-right: 200px;"> -->
<!--         	<div class="col-lg-8" style="margin-left: 350px; margin-right: 300px;"> -->
<!-- 	    		<li> -->
<!-- 		    		이용중인 기능 :  -->
<%-- 		    		<c:forEach items="${customerVO.paymentVO.funcLevelList }" var="funcLevelList" > --%>
<%-- 		    			${funcLevelList.funcName }(${funcLevelList.funcMemo })&nbsp; --%>
<%-- 		    		</c:forEach> --%>
<!-- 	    		</li> -->
<!-- 	    			<br> -->
<%--     			<li>현재 이용중인 레벨 : ${customerVO.paymentVO.levelName }</li> --%>
<%--     			<li>구독 기간 : <fmt:formatDate value="${customerVO.paymentVO.payDate }" pattern="yyyy-MM-dd"/> ~ --%>
<%--     					<fmt:formatDate value="${customerVO.paymentVO.payEdate }" pattern="yyyy-MM-dd"/></li> --%>
<%-- 	    		<li>결제 금액 : <fmt:formatNumber value="${customerVO.paymentVO.payAmt }" pattern="#,###" />원</li> --%>
<!--             	<li>다음 결제 예정일 : </li> -->
<!--             </div> -->
<!--             	<br> -->
<!-- 				<div align="center"> -->
<!-- 	            	<button type="button" id="systemBtn" class="btn btn-primary">시스템으로 가기</button> -->
<!-- 				</div> -->
			</div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">
$(function() {
	var systemBtn = $("#systemBtn");
	
	systemBtn.on("click", function() {
		location.href = "/home/feed";
	});
	
});
</script>
