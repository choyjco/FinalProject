<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>관리자 페이지</h1>
			</div>
		</div>
	</div>
</div>

<div class="container pt-5 pb-5">
    <div class="row">
        <div class="col-lg-3 pt-5 pb-5">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuAdmin.jsp" %>
        </div>

        <div class="col-lg-9 pt-5 pb-5">
            <h3 class="mb-5">기능 수정하기</h3>
            <div class="col-lg-12" align="center">
        <form action="/mypageadmin/funcupdate" class="p-5 bg-light col-lg-10 justify-content-md-center" method="post" id="funcForm">
			<input type="hidden" id="funcName" name="funcName" value="${funcInfo.funcName }">
<%--            	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }"> --%>
            <div class="col-lg-12 justify-content-md-center">
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">기능 이름</label>
                    <div class="col-lg-8">${funcInfo.funcName }"</div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">기능 가격</label>
                    <div class="col-lg-8">
                        <input type="text" class="form-control" id="funcFee" name="funcFee" value="${funcInfo.funcFee }">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">기능 설명</label>
                    <div class="col-lg-8">
                    	<textarea id="funcMemo" name="funcMemo" cols="30" rows="10" class="form-control">${funcInfo.funcMemo }</textarea>
                    </div>
                </div>
				
				<div align="right">
					<button type="button" id="submitBtn" class="btn btn-primary">수정</button>
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
	var funcForm = $("#funcForm");
	
	submitBtn.on("click", function() {
		var fee = $("#funcFee").val();
		var memo = $("#funcMemo").val();
		
		if(fee == null || fee == "") {
			alert("기능 가격을 입력해주세요!");
			return false;
		}
		
		if(memo == null || memo == "") {
			alert("기능 설명을 입력해주세요!");
			return false;
		}
		funcForm.submit();
	});
	
	cancelBtn.on("click", function() {
		location.href = "/mypageadmin/funcdetail?funcName=" + funcName;
	});
	
});
</script>
