<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
#sidemenu ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 15%;
  background-color: white;
  position: fixed;
  height: 100%;
  overflow: auto;
}

#sidemenu li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}

#sidemenu li a:hover:not(.active) {
/*   background-color: #99D0F2; */
  background-color: #D0DDF3;
  color: white;
}
</style>

<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>	

<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>

<div class="w3-sidebar w3-bar-block">
	<h3><b>메뉴</b></h3>
	<hr>
		<ul id="sidemenu" class="list-unstyled">
		    <li><b><a href="/mypageadmin/adminboard"><i class="fi fi-rr-edit"></i>&nbsp;&nbsp;&nbsp;&nbsp;문의 답변</a></b></li>
		    <li><b><a href="/mypageadmin/purchaselist"><i class="fi fi-rs-coins"></i>&nbsp;&nbsp;&nbsp;&nbsp;구매 회원 관리</a></b></li>
		    <li><b><a href="/mypageadmin/customerlist"><i class="fi fi-rs-user"></i>&nbsp;&nbsp;&nbsp;&nbsp;회원 목록</a></b></li>
		    <li><b><a href="/mypageadmin/funclist"><i class="fi fi-rr-settings"></i>&nbsp;&nbsp;&nbsp;&nbsp;기능 관리</a></b></li>
		    <li><b><a href="/mypageadmin/levellist"><i class="fi fi-rr-settings"></i>&nbsp;&nbsp;&nbsp;&nbsp;레벨 관리</a></b></li>
<!-- 		    <li><b><a href="#">구독 정책 관리</a></b></li> -->
		    <li><b><a href="/mypageadmin/statsadmin"><i class="fi fi-sr-chart-line-up"></i>&nbsp;&nbsp;&nbsp;&nbsp;애널리틱스</a></b></li>
		</ul>
</div>
