<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>결제완료</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="container pb-5">
    <div class="row">
        <div class="col-lg-12 p-5" align="center">
        	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
        	<input type="hidden" id="cusName" name="cusName" value="${SessionInfo.cusName }">
        	<input type="hidden" id="cusCom" name="cusCom" value="${SessionInfo.cusCom }">
        	<input type="hidden" id="cusEmail" name="cusEmail" value="${SessionInfo.cusEmail }">
        	<input type="hidden" id="payCode" name="payCode" value="${customerVO.paymentVO.payCode }">
        	<h4><b>${SessionInfo.cusName }님 결제완료 되었습니다!</b></h4><br>
        	<h6><b>${SessionInfo.cusEmail }</b> 로 이메일이 발송되었으니 메일을 확인해주세요!</h6>
        	
        	<br>
        	<div align="center" style="margin-bottom: 50px;">
			    <button type="button" id="mainBtn" class="btn btn-primary" style="width: 500px;">메인으로 가기</button>
<!-- 			    <button type="button" id="systemBtn" class="btn btn-primary">시스템으로 가기</button> -->
		    </div>
        </div>
    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">
$(function() {
	var mainBtn = $("#mainBtn");
	var systemBtn = $("#systemBtn");
	
	mainBtn.on("click", function() {
		location.href = "/main";
	});
	
	systemBtn.on("click", function() {
		location.href = "/home/feed";
	});
	
});
</script>