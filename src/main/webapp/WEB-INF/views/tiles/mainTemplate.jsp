<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en">
<head>  
    <meta charset="utf-8" />
    <title>WSI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Pichforest" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/images/wsi.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/glightbox/css/glightbox.min.css">
    
<!--     fullcalendar css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/fullcalendar/main.min.css" rel="stylesheet" type="text/css" />
    
    <!-- dragula css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/dragula/dragula.min.css" rel="stylesheet" type="text/css" />
    
    <!-- alertifyjs Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/css/alertify.min.css" rel="stylesheet" type="text/css" />

    <!-- alertifyjs default themes  Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/css/themes/default.min.css" rel="stylesheet" type="text/css" />

    <!-- Sweet Alert-->
    <link href="${pageContext.request.contextPath }/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
    
	<!-- plugin css -->
	<link href="${pageContext.request.contextPath }/resources/assets/libs/choices.js/public/assets/styles/choices.min.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath }/resources/assets/libs/flatpickr/flatpickr.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/assets/libs/dropzone/min/dropzone.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath }/resources/assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />
	
	<!-- One of the following themes -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/@simonwep/pickr/themes/classic.min.css"/> <!-- 'classic' theme -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/@simonwep/pickr/themes/monolith.min.css"/> <!-- 'monolith' theme -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/@simonwep/pickr/themes/nano.min.css"/> <!-- 'nano' theme -->
	
	<!-- swiper css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/swiper/swiper-bundle.min.css">
    
    <!-- gridjs css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/libs/gridjs/theme/mermaid.min.css">
	
    <!-- Bootstrap Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="${pageContext.request.contextPath }/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="${pageContext.request.contextPath }/resources/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
    <!-- CKEditor -->
    <script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
	$(function(){
		alertify.set('notifier','position', 'top-center');
		alertify.set('notifier','delay', 2);
	});
	</script>
</head>



<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
<body>

<div id="layout-wrapper">

    <tiles:insertAttribute name="header"/>
    <tiles:insertAttribute name="aside"/>
   
    <div class="main-content" style="margin-top: 35px;">
    	<div class="page-content">
    		<div class="container-fluid">
				<tiles:insertAttribute name="content"/>
			</div>
		</div>
    </div>
       
    <tiles:insertAttribute name="footer"/>

</div>


<!-- JAVASCRIPT -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/moment/min/moment.min.js"></script>

<!-- apexcharts -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="https://apexcharts.com/samples/assets/stock-prices.js"></script>

<!-- file-manager js -->
<%-- <script src="${pageContext.request.contextPath }/resources/assets/js/pages/file-manager.init.js"></script> --%>

<!-- dragula plugins -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/dragula/dragula.min.js"></script>

<script src="${pageContext.request.contextPath }/resources/assets/js/pages/kanbanboard.init.js"></script>

<!-- two-step-verification js -->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/two-step-verification.init.js"></script>

<!-- for basic area chart -->
<script src="https://apexcharts.com/samples/assets/stock-prices.js"></script>

<!-- Sweet Alerts js -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<!-- Sweet alert init js-->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/sweet-alerts.init.js"></script>

<!-- plugins -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/choices.js/public/assets/scripts/choices.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/flatpickr/flatpickr.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/libs/dropzone/min/dropzone.min.js"></script>

<!-- Modern colorpicker bundle -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/@simonwep/pickr/pickr.min.js"></script>

<!-- init js -->
<%-- <script src="${pageContext.request.contextPath }/resources/assets/js/pages/form-advanced.init.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/form-validation.init.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/assets/js/pages/dashboard-sales.init.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath }/resources/assets/js/pages/user-settings.init.js"></script> --%>

<!-- swiper js -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/swiper/swiper-bundle.min.js"></script>
<!-- profile init -->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/profile.init.js"></script>

<!-- gridjs js -->
<%-- <script src="${pageContext.request.contextPath }/resources/assets/libs/gridjs/gridjs.umd.js"></script> --%>

<%-- <script src="${pageContext.request.contextPath }/resources/assets/js/pages/gridjs.init.js"></script> --%>

<!-- Calendar는  plugin js + Calendar init-->
<!-- plugin js -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/fullcalendar/main.min.js"></script>
<!-- Calendar init -->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/calendar.init.js"></script>

<script src="${pageContext.request.contextPath }/resources/assets/js/app.js"></script>

<!-- alertify init -->
<script src="${pageContext.request.contextPath }/resources/assets/libs/alertifyjs/build/alertify.min.js"></script>
<!-- notification init -->
<script src="${pageContext.request.contextPath }/resources/assets/js/pages/notification.init.js"></script>



<!-- areacharts init -->
<!-- <script src="assets/js/pages/apexcharts-area.init.js"></script> -->
<!-- barcharts init -->
<!-- <script src="assets/js/pages/apexcharts-bar.init.js"></script> -->
<!-- apexcharts init -->
<!-- <script src="assets/js/pages/apexcharts-column.init.js"></script> -->
<!-- linecharts init -->
<!-- <script src="assets/js/pages/apexcharts-line.init.js"></script> -->
<!-- mixed charts init -->
<!-- <script src="assets/js/pages/apexcharts-mixed.init.js"></script> -->
<!-- piecharts init -->
<!-- <script src="assets/js/pages/apexcharts-pie.init.js"></script> -->
<!-- scatter charts init -->
<!-- <script src="assets/js/pages/apexcharts-scatter.init.js"></script> -->





</body>
</html>
























