<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
        
	<meta charset="utf-8" />
	<title>Sign In</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- App favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/images/wsi.png">

	<!-- alertifyjs Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/css/alertify.min.css" rel="stylesheet" type="text/css" />
    <!-- alertifyjs default themes  Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/css/themes/default.min.css" rel="stylesheet" type="text/css" />
	
	<!-- Bootstrap Css -->
	<link href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
	<!-- Icons Css -->
	<link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
	<!-- App Css-->
	<link href="${pageContext.request.contextPath }/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>


<body>

	<tiles:insertAttribute name="content"/>

    <!-- JAVASCRIPT -->
    <script src="${pageContext.request.contextPath }/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/libs/feather-icons/feather.min.js"></script>

	<!-- alertify init -->
	<script src="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/alertify.min.js"></script>
	<!-- notification init -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/pages/notification.init.js"></script>
	
	<script src="${pageContext.request.contextPath }/resources/assets/js/app.js"></script>
	
<script type="text/javascript">
$(function(){
	alertify.set('notifier','position', 'top-center');
	alertify.set('notifier','delay', 2);
	
	var okmessage = `${okmessage}`;
	var messagee = `${messagee}`;
	var smessage = `${smessage}`;
	var wmessage = `${wmessage}`;
	var emessage = `${emessage}`;
	
	if(okmessage != null && okmessage != ""){
		alertify.alert("아이디ㆍ비밀번호 찾기", `${okmessage}`);
	}
	if(messagee != null && messagee != ""){
		alertify.message(messagee);
	}
	if(smessage != null && smessage != ""){
		alertify.success(smessage);
	}
	if(wmessage != null && wmessage != ""){
		alertify.warning(wmessage);
	}
	if(emessage != null && emessage != ""){
		alertify.error(emessage);
	}
	
});
</script>
</body>
</html>