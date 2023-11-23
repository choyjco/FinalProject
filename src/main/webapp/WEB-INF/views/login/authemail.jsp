<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        
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
                                        <div class="p-4 p-lg-4 d-flex align-items-center justify-content-center" style="background-color: #ACD0FF;">
                                            <div class="w-100 text-center">
                                                <div class="mb-4 mb-md-5">
                                                    <a href="index.html" class="d-block auth-logo">
                                                        <img style="width: 200px;" src="${pageContext.request.contextPath }/resources/assets/images/wwwssi.png" alt="">
                                                    </a>
                                                </div>
                                                <div class="mb-4 mb-md-5">
                                                    <div class="avatar-lg mx-auto">
                                                        <div class="avatar-title bg-light text-primary display-5 rounded-circle">
                                                            <i class="uil uil-envelope-alt"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="text-muted-50 mb-4 mb-md-5">
                                                    <h4 class="text-muted">이메일을 확인해주세요!</h4>
                                                    <p>전송된 6자리 코드를 입력해주세요.</p>
                                                    <p>빠른 진행을 위해 이메일로 전송된 코드 [ <span id="authcode">${authcode }</span> ]</p>
                                                </div>
                                                <form action="/resetpw" method="get" id="authcodeForm">
                                                    <div class="row">
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit1-input" class="visually-hidden">Dight 1</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 2)" maxLength="1"
                                                                    id="digit1-input">
                                                            </div>
                                                        </div><!-- end col -->
                
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit2-input" class="visually-hidden">Dight 2</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 3)" maxLength="1"
                                                                    id="digit2-input">
                                                            </div>
                                                        </div><!-- end col -->
                
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit3-input" class="visually-hidden">Dight 3</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 4)" maxLength="1"
                                                                    id="digit3-input">
                                                            </div>
                                                        </div><!-- end col -->
                
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit4-input" class="visually-hidden">Dight 4</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 5)" maxLength="1"
                                                                    id="digit4-input">
                                                            </div>
                                                        </div><!-- end col -->
                                                        
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit5-input" class="visually-hidden">Dight 5</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 6)" maxLength="1"
                                                                    id="digit5-input">
                                                            </div>
                                                        </div><!-- end col -->
                
                                                        <div class="col-2">
                                                            <div class="mb-3">
                                                                <label for="digit6-input" class="visually-hidden">Dight 6</label>
                                                                <input type="text" style="width: 50px;"
                                                                    class="form-control form-control-lg text-center"
                                                                    onkeyup="moveToNext(this, 6)" maxLength="1"
                                                                    id="digit6-input">
                                                            </div>
                                                        </div><!-- end col -->
                                                    </div><!-- end row -->
	                                                <div class="mt-4">
	                                                	<button id="checkBtn" class="text-white btn bg-purple w-100 fw-bold">확인</button>
	                                                </div>
                                                </form><!-- end form -->
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                            <div class="mt-5 text-center text-muted">
                                <p>코드를 받지 못하셨나요? <a href="#" class="fw-medium text-decoration-underline">재전송</a></p>
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
            </div>
            <!-- end container -->
        </div>
        <!-- end authentication section -->
<script type="text/javascript">
$(function(){
	var checkBtn = $("#checkBtn");
	var authcodeForm = $("#authcodeForm");
	var authcode = $("#authcode").html();
	
	checkBtn.on("click", function(){
		var str = "";
		for(var i = 1; i < 7; i++){
			str += $("#digit"+i+"-input").val();
		}
		if(str == authcode){
			authcodeForm.submit();
		}else{
			alertify.warning("코드가 일치하지 않습니다.");
			return false;
		}
	});
	
});

</script>
<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/feather-icons/feather.min.js"></script>

<!-- two-step-verification js -->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/two-step-verification.init.js"></script>
