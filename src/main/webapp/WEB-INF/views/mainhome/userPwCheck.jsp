<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>회원정보 수정</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%; height: 500px;" >
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
        	<input type="hidden" id="cusRnum" name="cusRnum" value="${payment.customerVO.cusRnum }">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuUser.jsp" %>
        </div>

        <div class="col-lg-10 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <h3 class="mb-5" align="center"><b>비밀번호 확인</b></h3>
            <p align="center">정보 수정을 위해 비밀번호를 확인합니다. 비밀번호를 입력해주세요!</p>
            <div class="col-lg-12" align="center">
        <input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
        <form action="/mypageuser/userpwchecking" class="p-5 col-lg-8 justify-content-md-center" method="post" id="checkForm">
            <div class="col-lg-12 justify-content-md-center">
                <div class="form-group row">
                	
                    <label class="col-lg-3 col-form-label">비밀번호 확인</label>
                    <div class="col-lg-8">
                        <input type="password" class="form-control" id="cusPw" name="cusPw">
                    </div>
                </div>
				<div align="right">
					<button type="button" class="btn btn-primary" id="submitBtn">확인</button>
					<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
				</div>
			</div>
		<sec:csrfInput/>
		</form>
        	</div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var submitBtn = $("#submitBtn");
	var cancelBtn = $("#cancelBtn");
	var checkForm = $("#checkForm");
	
	submitBtn.on("click", function() {
		var pw = $("#cusPw").val();
// // 		var cusPw = $("#cusPw").val();
// 		var cusRnum = $("#cusRnum").val();
// 		var cusRnum1 = $("#cusRnum1").val();
// 		var cusPw1 = $("#cusPw1").val();
		
		if(pw == null || pw == "") {
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		
// 		if(cusRnum == cusRnum1) {
// 			if(pw.trim() == cusPw1.trim()) {
// 				checkForm.submit();
// 			}else {
// 				alert("비밀번호가 일치하지 않습니다!");
// 			}
// 		}
		checkForm.submit();
	
	});
	
	cancelBtn.on("click", function() {
		location.href = "/mypageuser";
	});
});



var msg = '${msg}';
if(msg === '비밀번호를 다시 확인해 주세요.') {
    alert("비밀번호를 다시 확인해 주세요.");
}




</script>