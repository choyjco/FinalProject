<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- Bootstrap Css -->
<link href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
<!-- Icons Css -->
<link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<!-- App Css-->
<link href="${pageContext.request.contextPath }/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />


<style>
.test4{background-size: 100%; background-repeat: no-repeat; background-position: center;}

</style>
<div class = "test4" align="center" style="background-image: url('${pageContext.request.contextPath }/resources/assets/images/iii.png')">
    <div class="bg-secondary bg-opacity-10"></div>
    <div class="container">
        <div class="d-flex flex-column min-vh-100 px-3 pt-4">
            <div class="row justify-content-center my-auto">
            
	            <div class="col-lg-6">
	                <div class="p-4 p-lg-5 h-100 d-flex align-items-center justify-content-center" style="background-color: #ACD0FF;">
	                    <div class="w-100">
	                        <div class="mb-4 mb-md-5">
	                            <a href="index.html" class="d-block auth-logo">
	                                <img style="width: 100px;" src="${pageContext.request.contextPath }/resources/assets/images/images/wsi.png" alt="">
	                            </a>
	                        </div>
	                        <div class="text-muted-50 mb-4">
	                            <h5 class="text-muted">비밀번호 재설정</h5>
	                            <p>원하는 4자리 이상 비밀번호를 재설정해주세요!</p>
	                        </div>
	                        <form action="/resetpw" method="post" id="resetForm" >
	                            <div class="form-floating form-floating-custom mb-3">
	                                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
	                                <label for="input-newpassword">새로운 비밀번호</label>
	                                <div class="form-floating-icon">
	                                    <i class="uil uil-padlock"></i>
	                                </div>
	                            </div>
	                            <div class="form-floating form-floating-custom mb-3">
	                                <input type="password" class="form-control" id="password2" name="password2" placeholder="Password">
	                                <label for="input-confirmpassword">비밀번호 확인</label>
	                                <div class="form-floating-icon">
	                                    <i class="uil uil-check-circle"></i>
	                                </div>
	                            </div>
	
	                            <div class="mt-4">
	                                <button class="text-white btn bg-purple w-100 fw-bold" type="button" id="resetPw">재설정</button>
	                            </div>
	                            <sec:csrfInput/>
	                        </form><!-- end form -->
	                    </div>
	                </div>
	            </div><!-- end col -->
	            
			    <div class="mt-1 mb-5 text-center text-muted">
			        <p>비밀번호가 기억 나시나요 ? <a href="${pageContext.request.contextPath }/signin" class="fw-medium text-decoration-underline"> 로그인 </a></p>
			    </div>
                   
           	</div><!-- end row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="text-center text-muted p-4">
                        <p class="mb-0"></p>
                    </div>
                </div><!-- end col -->
            </div><!-- end row -->
        </div>
    </div><!-- end container -->
</div>
<!-- end authentication section -->

<script type="text/javascript">
$(function(){
	var resetForm = $("#resetForm");
	var resetPw = $("#resetPw");
	
	resetPw.on("click", function(){
		var password = $("#password").val();
		var password2 = $("#password2").val();

    	if(password.length < 4){
    		alertify.warning("비밀번호가 4자리 이상이여야 합니다.");
    		return false;
    	}else{
			if(password == password2){
				resetForm.submit();
			}else{
				alertify.warning("비밀번호가 일치하지 않습니다.");
				return false;
			}
    	}
	});
});
</script>

<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/feather-icons/feather.min.js"></script>

	