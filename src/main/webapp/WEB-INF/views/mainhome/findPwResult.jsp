<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>비밀번호 찾기</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="col-lg-12 justify-content-md-center" style="margin-bottom: 50px;">
    <div class="col-lg-12" align="center">
        <h3 class="mb-5" align="center">비밀번호 찾기 결과입니다.</h3>
            <div class="col-lg-10 justify-content-md-center">
<%--                 <c:choose> --%>
<%--                 	<c:when test="${count == 0 }"> --%>
<!--                 		등록된 가입 정보가 없습니다. <br> -->
<!--                 		입력한 정보를 다시 한 번 확인해주세요. -->
<%--                 	</c:when> --%>
                	
<%--                 	<c:otherwise> --%>
                		입력하신 이메일주소로 <b>임시 비밀번호</b>를 발송했습니다.<br>
                		로그인 후 비밀번호를 변경해주세요.
<%--                 	</c:otherwise> --%>
<%--                 </c:choose> --%>
				<br><br>
		</div>
			<div class="form-group" align="center">
				<button type="button" id="mainBtn" class="btn btn-primary">메인으로 가기</button>
				<button type="button" id="loginBtn" class="btn btn-primary">로그인하러 가기</button>
			</div>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$("#mainBtn").on("click", function() {
	location.href = "/main";
});
$("#loginBtn").on("click", function() {
	location.href = "/mainlogin";
});
</script>
