<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
<!--         <h3 class="mb-5" align="center">비밀번호 찾기</h3> -->
        <form action="/findpw" class="pb-5 col-lg-10 justify-content-md-center" id="pwForm" method="post" enctype="multipart/form-data">
            <div class="col-lg-10 justify-content-md-center">
                <div class="form-group row">
                    <label for="cusRnum" class="col-lg-4 col-form-label" style="text-align: end;">아이디(사업자등록번호)</label>
                    <div class="col-lg-6">
                        <input type="text" class="form-control" id="cusRnum" placeholder="아이디(사업자등록번호)를 입력해주세요">
                    </div>
                </div>
				<div class="form-group row">
					<label for="cusEmail" class="col-lg-4 col-form-label" style="text-align: end;">이메일</label>
					<div class="col-lg-6">
						<input type="email" class="form-control" id="cusEmail" placeholder="이메일을 입력해주세요">
					</div>
				</div>
				<br><br>
		</div>
			<div class="form-group" align="center">
				<button type="button" id="submitBtn" class="btn btn-primary" style="width: 500px">비밀번호 찾기</button>
			</div>
		<sec:csrfInput/>
	</form>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function () {
	var submitBtn = $("#submitBtn");
	var pwForm = $("#pwForm");
	
	submitBtn.on("click", function() {
		var id = $("#cusRnum").val();
		var email = $("#cusEmail").val();
		
		if(id == null || id == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if(email == null || email == "") {
			alert("이메일을 입력해주세요.");
			return false;
		}
		pwForm.submit();
		
	});
});
</script>