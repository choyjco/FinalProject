<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>
	</c:if>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>문의글 ${name }</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="col-lg-12 justify-content-md-center spacer" style="margin-bottom: 100px;">
    <div class="col-lg-12" align="center">
<%--         <h3 class="mb-5" align="center">문의글 ${name }</h3> --%>
        <form action="/askinsert" class="p-5 col-lg-10 justify-content-md-center" method="post" id="inqBoardForm">
           	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
            <c:if test="${status eq 'u' }">
				<input type="hidden" name="inqNo" id="inqNo" value="${inqBoard.inqNo }"/>
			</c:if>
            <div class="col-lg-10 justify-content-md-center">
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">제목</label>
                    <div class="col-lg-10">
                        <input type="text" class="form-control" id="inqTitle" name="inqTitle" maxlength="33" value="${inqBoard.inqTitle }">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">내용</label>
                    <div class="col-lg-10">
                    	<textarea id="inqCont" name="inqCont" cols="30" rows="10" maxlength="666" class="form-control">${inqBoard.inqCont }</textarea>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">
$(function() {
	var submitBtn = $("#submitBtn");
	var cancelBtn = $("#cancelBtn");
	var listBtn = $("#listBtn");
	var inqBoardForm = $("#inqBoardForm");
	
	listBtn.on("click", function() {
		location.href = "askboard";
	});
	
	submitBtn.on("click", function() {
		var title = $("#inqTitle").val();
		var content = $("#inqCont").val();
		
		if(title == null || title == "") {
			alert("제목을 입력해주세요!");
			return false;
		}
		
		if(content == null || content == "") {
			alert("내용을 입력해주세요!");
			return false;
		}
		
		if($(this).val() == "수정") {
			inqBoardForm.attr("action", "/askupdate");
		}
		
		inqBoardForm.submit();
	});
	
	cancelBtn.on("click", function() {
		var inqNo = $("#inqNo").val();
		location.href = "/askdetail?inqNo=" + inqNo;		
	});
});
</script>