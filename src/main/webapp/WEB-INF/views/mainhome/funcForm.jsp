<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>
	</c:if>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>기능 관리</h1>
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
            <h3 class="mb-5" align="center"><b>기능 ${name }하기</b></h3>
            <div class="col-lg-12" align="center">
        <form action="/mypageadmin/funcinsert" class="p-5 bg-light col-lg-10 justify-content-md-center" method="post" id="funcForm">
<%--            	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }"> --%>
            <c:if test="${status eq 'u' }">
           		<input type="hidden" id="funcName" name="funcName" value="${funcInfo.funcName }">
           	</c:if>
            <div class="col-lg-12 justify-content-md-center">
            	<c:if test="${status ne 'u' }">
	                <div class="form-group row">
	                    <label class="col-lg-3 col-form-label">기능 코드</label>
	                    <div class="col-lg-8">
	                        <input type="text" class="form-control" id="funcName" name="funcName" value="${funcInfo.funcName }">
	                    </div>
	                </div>
                </c:if>
                <c:if test="${status eq 'u' }">
	                <div class="form-group row">
	                    <label class="col-lg-3 col-form-label">기능 코드</label>
	                    <div class="col-lg-8">
	                        <input type="text" class="form-control" id="funcName" name="funcName" value="${funcInfo.funcName }" disabled="disabled">
	                    </div>
	                </div>
                </c:if>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">기능 이름</label>
                    <div class="col-lg-8">
                    	<input type="text" class="form-control" id="funcMemo" name="funcMemo" value="${funcInfo.funcMemo }">
                    </div>
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
                    	<textarea id="funcExplain" name="funcExplain" cols="30" rows="10" class="form-control">${funcInfo.funcExplain }</textarea>
                    </div>
                </div>
				
				<div align="right">
					<button type="button" id="autoBtn" class="btn btn-light">자동완성</button>
					<input type="button" value="${name }" id="submitBtn" class="btn btn-primary">
					<c:if test="${status eq 'u' }">
						<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
					</c:if>
					<c:if test="${status ne 'u' }">
						<button type="button" class="btn btn-secondary" id="listBtn">목록</button>
					</c:if>
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
	var listBtn = $("#listBtn");
	var submitBtn = $("#submitBtn");
	var cancelBtn = $("#cancelBtn");
	var funcForm = $("#funcForm");
	var autoBtn = $("#autoBtn"); // 자동완성
	var funcName = $("#funcName"); // 코드
	var funcMemo = $("#funcMemo"); // 기능 이름
	var funcFee = $("#funcFee"); // 가격
	var funcExplain = $("#funcExplain"); // 설명
	
	listBtn.on("click", function() {
		location.href = "/mypageadmin/funclist";
	});

	autoBtn.on("click", function() {
		funcName.val("10");
		funcMemo.val("테스트 기능");
		funcFee.val("1000");
		funcExplain.val("테스트 기능입니다.");
	});
	
	submitBtn.on("click", function() {
		var funcName = $("#funcName").val();
		var fee = $("#funcFee").val();
		var memo = $("#funcMemo").val();
		
		if(funcName == null || funcName == "") {
			alert("기능 이름을 입력해주세요!");
			return false;
		}
		
		if(fee == null || fee == "") {
			alert("기능 가격을 입력해주세요!");
			return false;
		}
		
		if(memo == null || memo == "") {
			alert("기능 설명을 입력해주세요!");
			return false;
		}
		
		if($(this).val() == "수정") {
			funcForm.attr("action", "/mypageadmin/funcupdate");
		}
		
		funcForm.submit();
	});
	
	cancelBtn.on("click", function() {
		var funcName = $("#funcName").val();
		location.href = "/mypageadmin/funcdetail?funcName=" + funcName;
	});
	
});
</script>
