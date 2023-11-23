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
  list-style-type: none;
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
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<%-- <input type="text" id="cusRnum1" name="cusRnum1" value="${SessionInfo.cusRnum }"> --%>

<h3><b>메뉴</b></h3>
	<hr>
	<ul id="sidemenu" class="list-unstyled">
	    <li><b><a href="/mypageuser/userpwcheck"><i class="fi fi-rs-user"></i>&nbsp;&nbsp;&nbsp;&nbsp;회원 정보 수정</a></b></li>
	    <li><b><a href="/mypageuser/purchasehistory?cusRnum=${SessionInfo.cusRnum }"><i class="fi fi-rr-shopping-cart"></i>&nbsp;&nbsp;&nbsp;&nbsp;구매 내역</a></b></li>
	    <li><b><a href="/mypageuser/userboard"><i class="fi fi-rs-interrogation"></i>&nbsp;&nbsp;&nbsp;&nbsp;1:1 문의</a></b></li>
<!-- 	    <li><b><a href="/mypageuser/statsuser"><i class="fi fi-sr-chart-line-up"></i>&nbsp;&nbsp;&nbsp;&nbsp;애널리틱스</a></b></li> -->
	</ul>
