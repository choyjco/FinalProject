<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>로그인</h1>
			</div>
		</div>
	</div>
</div>


<div class="container pb-5">
    <div class="row">
        <div class="col-lg-12 p-5" align="center">
        	<form action="/mainlogincheck" method="post" id="mainLoginForm" onsubmit="return frm_check();">
        		<div class="form-group row">
					<label for="cusPw" class="col-lg-4 col-form-label" style="text-align: end;">아이디</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusRnum" name="cusRnum" maxlength="10" placeholder="아이디를 입력해주세요.">
					</div>
				</div>
        		<div class="form-group row">
					<label for="cusPw" class="col-lg-4 col-form-label" style="text-align: end;">비밀번호</label>
					<div class="col-lg-5">
						<input type="password" class="form-control" id="cusPw" name="cusPw" maxlength="16" placeholder="비밀번호를 입력해주세요.">
					</div>
				</div>
				<div class="logSave">
					<input type="checkbox" class="save_id" name="checkId" id="saveId" >
    				<label for="saveId" style="cursor:pointer;">&nbsp;아이디 저장</label>
				</div>
        	<br>
        	<div align="center" style="margin-bottom: 10px;">
			    <button type="button" class="btn btn-light" id="outoBtn" style="width: 500px;">자동완성</button>
		    </div>
        	<div align="center" style="margin-bottom: 10px;">
			    <button type="button" class="btn btn-light" id="adminBtn" style="width: 500px;">관리자</button>
		    </div>
        	<div align="center" style="margin-bottom: 50px;">
			    <button type="button" class="btn btn-primary" id="loginBtn" style="width: 500px;">로그인</button>
		    </div>
		    <div>
				<a href="/findpwform">비밀번호를 잊으셨나요?</a><br>
				<a href="/register">WSI 가입하기</a>
			</div>
        	<sec:csrfInput/>
        	</form>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">
$(function() {
	var loginBtn = $("#loginBtn");
	var outoBtn = $("#outoBtn");
	var adminBtn = $("#adminBtn");
	var mainLoginForm = $("#mainLoginForm");
	var cusRnum = $("#cusRnum");
	var cusPw = $("#cusPw");
	
	outoBtn.on("click", function() {
		cusRnum.val("7984300574");
		cusPw.val("aa1234**");
	});

	adminBtn.on("click", function() {
		cusRnum.val("admin");
		cusPw.val("aa1234**");
	});
	
	loginBtn.on("click", function() {
		var id = $("#cusRnum").val();
		var pw = $("#cusPw").val();
		
		if(id == null || id == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}

		if(pw == null || pw == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		mainLoginForm.submit();
	});
	
	fnInit();
});

function frm_check(){
    saveid();
}

function fnInit(){
   var cookieid = getCookie("saveid");
   console.log(cookieid);
   if(cookieid !=""){
       $("input:checkbox[id='saveId']").prop("checked", true);
       $('#cusRnum').val(cookieid);
   }
   
}    

function setCookie(name, value, expiredays) {
   var todayDate = new Date();
   todayDate.setTime(todayDate.getTime() + 0);
   if(todayDate > expiredays){
       document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expiredays + ";";
   }else if(todayDate < expiredays){
       todayDate.setDate(todayDate.getDate() + expiredays);
       document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
   }
   
   console.log(document.cookie);
}

function getCookie(Name) {
   var search = Name + "=";
   console.log("search : " + search);
   
   if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면 
       offset = document.cookie.indexOf(search);
       console.log("offset : " + offset);
       if (offset != -1) { // 쿠키가 존재하면 
           offset += search.length;
           // set index of beginning of value
           end = document.cookie.indexOf(";", offset);
           console.log("end : " + end);
           // 쿠키 값의 마지막 위치 인덱스 번호 설정 
           if (end == -1)
               end = document.cookie.length;
           console.log("end위치  : " + end);
           
           return unescape(document.cookie.substring(offset, end));
       }
   }
   return "";
}

function saveid() {
   var expdate = new Date();
   if ($("#saveId").is(":checked")){
       expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30);
       setCookie("saveid", $("#cusRnum").val(), expdate);
       }else{
      expdate.setTime(expdate.getTime() - 1000 * 3600 * 24 * 30);
       setCookie("saveid", $("#cusRnum").val(), expdate);
        
   }
}

</script>