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
            <h3 class="mb-5" align="center"><b>레벨 ${name }하기</b></h3>
            <div class="col-lg-12" align="center">
        <form action="/mypageadmin/levelinsert" class="p-5 bg-light col-lg-10 justify-content-md-center" method="post" id="levelForm">
           	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
            <c:if test="${status eq 'u' }">
           		<input type="hidden" id="levelName" name="levelName" value="${levelInfo.levelName }">
           	</c:if>
            <div class="col-lg-12 justify-content-md-center">
                <c:if test="${status ne 'u' }">
	                <div class="form-group row">
	                    <label class="col-lg-3 col-form-label">레벨 코드</label>
	                    <div class="col-lg-8">
	                        <input type="text" class="form-control" id="levelName" name="levelName">
	                    </div>
	                </div>
                </c:if>
                <c:if test="${status eq 'u' }">
	                <div class="form-group row">
	                    <label class="col-lg-3 col-form-label">레벨 코드</label>
	                    <div class="col-lg-8">
	                        <input type="text" class="form-control" id="levelName" name="levelName" value="${levelInfo.levelName }" disabled="disabled">
	                    </div>
	                </div>
                </c:if>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">레벨 이름</label>
                    <div class="col-lg-8">
                        <input type="text" class="form-control" id="levelMemo" name="levelMemo" value="${levelInfo.levelMemo }">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">레벨 가격</label>
                    <div class="col-lg-8">
                        <input type="text" class="form-control" id="levelFee" name="levelFee" value="${levelInfo.levelFee }">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">레벨 설명</label>
                    <div class="col-lg-8">
                    	<textarea id="levelVol" name="levelVol" cols="30" rows="10" class="form-control">${levelInfo.levelVol }</textarea>
                    </div>
                </div>
				
				<div align="right">
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
	var levelForm = $("#levelForm");
	
	listBtn.on("click", function() {
		location.href = "/mypageadmin/levellist";
	});
	
	submitBtn.on("click", function() {
		var levelName = $("#levelName").val();
		var fee = $("#levelFee").val();
		var memo = $("#levelMemo").val();
		var vol = $("#levelVol").val();
		
		if(levelName == null || levelName == "") {
			alert("레벨 이름을 입력해주세요!");
			return false;
		}
		
		if(fee == null || fee == "") {
			alert("레벨 가격을 입력해주세요!");
			return false;
		}
		
		if(memo == null || memo == "") {
			alert("레벨 설명을 입력해주세요!");
			return false;
		}
		
		if(vol == null || vol == "") {
			alert("자료실 용량을 입력해주세요!");
			return false;
		}
		
		if($(this).val() == "수정") {
			levelForm.attr("action", "/mypageadmin/levelupdate");
		}
		
		levelForm.submit();
	});
	
	cancelBtn.on("click", function() {
		var levelName = $("#levelName").val();
		location.href = "/mypageadmin/leveldetail?levelName=" + levelName;
	});
	
});
</script>
