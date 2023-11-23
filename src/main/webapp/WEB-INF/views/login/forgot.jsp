<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

    <!-- Bootstrap Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="${pageContext.request.contextPath }/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />

    <!-- <body data-layout="horizontal"> -->
<style>
.test4{background-size: auto; background-repeat: no-repeat; background-position: center;}

</style>
<div class = "test4" align="center" style="background-image: url('${pageContext.request.contextPath }/resources/assets/images/sss.png')">
    <div class="bg-secondary bg-opacity-10"></div>
    <div class="container">
        <div class="d-flex flex-column min-vh-100 px-3 pt-4">
            <div class="row justify-content-center my-auto">
                <div class="col-lg-5" style="padding-bottom: 300px">
	                    <div class="p-4 p-lg-4 d-flex align-items-center justify-content-center" >
	                        <div class="w-100">
	                            <div class="mb-4 mb-md-3">
	                                <a href="index.html" class="d-block auth-logo">
	                                    <img style="width: 200px;"  src="${pageContext.request.contextPath }/resources/assets/images/wwwssi.png" alt="">
	                                </a>
	                            </div>
	                            <div class="text-white-50 mb-4">
	                            	<c:if test="${status ne 'p'}"><h5 id="title" class="text-muted">사번 찾기</h5></c:if>
	                            	<c:if test="${status eq 'p'}"><h5 id="title" class="text-muted">비밀번호 찾기</h5></c:if>
	                                
	                                <p class="text-muted">아래의 정보를 입력하여 주세요.</p>
	                            </div>
	                            <form action="/forgotid" method="post" id="forgotForm">
	                            	<c:if test="${status eq 'p'}">                                         
	                                 <div class="form-floating form-floating-custom mb-3">
	                                     <input type="text" class="form-control" id="empNo" name="empNo" value="202101001" placeholder="Enter No">
	                                     <label for="input-id">사원번호</label>
	                                     <div class="form-floating-icon">
	                                         <i class="uil uil-padlock"></i>
	                                     </div>
	                                 </div>
	                                </c:if>     
	                           		<div class="form-floating form-floating-custom mb-3">
	                                    <input type="text" class="form-control" id="empName" name="empName" value="강해린" placeholder="Enter User Name">
	                                    <label for="input-username">이름</label>
	                                    <div class="form-floating-icon">
	                                        <i class="uil uil-user"></i>
	                                    </div>
	                                </div>
	                                <div class="form-floating form-floating-custom mb-3">
	                                    <input type="text" class="form-control" id="empEmail" name="empEmail" value="p_yb24@naver.com" placeholder="Enter Email">
	                                    <label for="input-email">이메일</label>
	                                    <div class="form-floating-icon">
	                                        <i class="uil uil-envelope-alt"></i>
	                                    </div>
	                                </div>
	                                <div class="mt-4">
	                                    <button class="text-white btn bg-purple w-100 fw-bold" type="button" id="okBtn">확인</button>
	                                </div>
	                                <sec:csrfInput/>
	                            </form><!-- end form -->
	                        </div>
	                    </div>
                        <div class="mt-3 mb-5 text-center text-muted">
                            <p>다시 로그인하러 가시겠습니까 ? <a href="${pageContext.request.contextPath }/signin" class="fw-medium text-decoration-underline"> 로그인 </a></p>
                        </div>
                </div><!-- end col -->
            </div><!-- end row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="text-center text-muted p-4">
                        <p class="mb-0"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end container -->
</div>
<!-- end authentication section -->

<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/feather-icons/feather.min.js"></script>

<script type="text/javascript">
$(function(){
	var forgotForm = $("#forgotForm");
	var okBtn = $("#okBtn");
	
	okBtn.on("click", function(){
		var empNo = $("#empNo").val();
		var empName = $("#empName").val();
		var empEmail = $("#empEmail").val();
		var title = $("#title").html();
		
		if(title == "비밀번호 찾기"){
			if(empNo == null || empNo == ""){
				alertify.warning("사번을 입력해주세요.");
				return false;
			}
			forgotForm.attr("action", "/forgotpw");
		}
		if(empName == null || empName == ""){
			alertify.warning("이름을 입력해주세요.");
			return false;
		}
		if(empEmail == null || empEmail == ""){
			alertify.warning("이메일을 입력해주세요.");
			return false;
		}
		
		forgotForm.submit();
	});
});

</script>
