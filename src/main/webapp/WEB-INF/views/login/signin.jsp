<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
.test4{background-size: auto; background-repeat: no-repeat; background-position: center;}

</style>
<div class = "test4" align="center" style="background-image: url('${pageContext.request.contextPath }/resources/assets/images/sss.png')">
<div class="bg-secondary bg-opacity-10">
<div class="container">
    <div class="d-flex flex-column min-vh-100 px-3 pt-4">
        <div class="row justify-content-center my-auto">
	        <%-- <div class="col-lg-5" style="width: 73%">
	        	<img alt="" src="${pageContext.request.contextPath }/resources/images/login.svg">
	        </div> --%>
            <div class="col-lg-5" style="padding-bottom: 350px">
	            <div class="p-4 p-lg-4 d-flex align-items-center justify-content-center">
	                <div class="w-100">
	                    <div class="mb-4 mb-md-3">
	                    	<img style="height: 70px;" src="${pageContext.request.contextPath }/resources/assets/images/wwwssi.png" alt="">
	                    </div>
	
	                    <form action="/login" method="post">
	                        <div class="form-floating form-floating-custom mb-3">
	                            <input type="text" class="form-control" id="username" placeholder="Enter User name" name="username">
	                            <label for="input-username">아이디</label>
	                            <div class="form-floating-icon">
	                                <i class="uil uil-users-alt"></i>
	                            </div>
	                        </div>
	                        <div class="form-floating form-floating-custom mb-3">
	                            <input type="password" class="form-control" id="password" placeholder="Enter Password" name="password">
	                            <label for="input-password">비밀번호</label>
	                            <div class="form-floating-icon">
	                                <i class="uil uil-padlock"></i>
	                            </div>
	                        </div>
	
	                        <div class="form-check form-check-info font-size-16">
	                            <input class="form-check-input bg-soft-primary" type="checkbox" id="remember-check" name="remember-me">
	                            <label class="form-check-label font-size-14" for="remember-check">
	                                아이디 저장
	                            </label>
	                        </div>
	
	                        <div class="mt-3">
	                            <input class="text-white btn bg-purple w-100 fw-bold" type="submit" value="로그인">
	                        </div>
							
	                        <div class="mt-4 text-center">
<!-- 	                        	 style="color: #551a8b; opacity: 0.8;" -->
	                            <a href="/forgotid" class="text-decoration-underline">아이디를 잊으셨나요?</a> /
	                            <a href="/forgotpw" class="text-decoration-underline">비밀번호를 잊으셨나요?</a>
	                        	<p></p>
	                        	<div>
					                <button id="adminBtn" type="button" class="text-white btn bg-purple fw-bold">최고관리자</button>
					                <button id="managerBtn" type="button" class="text-white btn bg-purple fw-bold">중간관리자</button>
					                <button id="userBtn" type="button" class="text-white btn bg-purple fw-bold">일반사원</button>
				                </div> 
				                <div class="mt-2">
					                <button id="testBtn" type="button" class="text-white btn bg-purple fw-bold">테스트계정</button>
				                </div> 
	                        </div>
	                        <sec:csrfInput/>
	                    </form><!-- end form -->
	                </div>
	            </div>
	            
<!--                 <div class="mt-5 text-center text-muted"> -->
<!--                     <p>Don't have an account ? <a href="/signup" class="fw-medium text-decoration-underline"></a></p> -->
<!--                 </div> -->
            </div><!-- end col -->
        </div><!-- end row -->
		<%-- <div class="mb-4 mb-md-5 d-flex justify-content-end">
	        <a href="index.html" class="d-block auth-logo">
	            <img style="height: 400px;" src="${pageContext.request.contextPath}/resources/images/loginrob.png" alt="">
	        </a>
	    </div> --%>
<!--         <div class="row"> -->
<!--             <div class="col-lg-12"> -->
<!--                 <div class="text-center text-muted p-4"> -->
<!--                     <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script></p> -->
<!--                 </div> -->
<!--             </div>end col -->
<!--         </div>end row -->
    </div>
</div>
<!-- end container -->
</div>
</div>
<!-- end authentication section -->
<script type="text/javascript">

//==============================================================================	
//시연용 자동입력 버튼
var empNo = $('#username');
var empPw = $('#password');
var adminBtn = $('#adminBtn');
var managerBtn = $('#managerBtn');
var userBtn = $('#userBtn');
var testBtn = $('#testBtn');

adminBtn.on('click', function(){
	empNo.val('199404001');
	empPw.val('1234');
});

managerBtn.on('click', function(){
	empNo.val('200101001');
	empPw.val('1234');
});

userBtn.on('click', function(){
	empNo.val('202101001');
	empPw.val('1234');
});

testBtn.on('click', function(){
	empNo.val('2310260176');
	empPw.val('1234');
});
//==============================================================================	
	
// $(function(){
// 	var loginBtn = $("#loginBtn");
// 	var loginForm = $("#loginForm");
	
// 	loginBtn.on("click", function(){
// 		var id = $("#memId").val();
// 		var pw = $("#memPw").val();
// // 		var id = $(memId).val();		// 아이디 값을 가져오는 방법2
// // 		var pw = $(memPw).val();		// 비밀번호 값을 가져오는 방법2

// 		if(id == null || id == ""){
// 			alert("아이디를 입력해주세요.");
// 			return false;
// 		}

// 		if(pw == null || pw == ""){
// 			alert("비밀번호를 입력해주세요.");
// 			return false;
// 		}
		
// 		loginForm.submit();
// 	});
// });
</script>





















