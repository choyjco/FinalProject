<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>기능 관리</h1>
			</div>
		</div>
	</div>
</div>

<div class="container" style="max-width: 80%;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuAdmin.jsp" %>
        </div>

        <div class="col-lg-10 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
<!--             <h3 class="mb-5">기능 관리</h3> -->
            <div class="col-lg-12" align="center">
            
            
            
            <div class="col-lg-10" align="right">
            	<button type="button" id="addBtn" class="btn btn-outline-light" style="background-color: #D0DDF3;">기능 추가하기</button>
           		<!-- Button trigger modal -->
<!-- 				<button type="button" class="btn btn-outline-light" style="background-color: #D0DDF3;" data-toggle="modal" data-target="#exampleModal">기능 추가하기</button> -->
            </div>
            
            <br>
		
        <table class="table table-hover col-lg-10">
        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
        		<th style="width: 20%; text-align: left;">기능 코드</th>
        		<th style="width: 20%; text-align: left;">기능 이름</th>
        		<th style="width: 40%;">기능 설명</th>
        		<th style="width: 20%;">기능 가격</th>
        	</tr>
        	<c:choose>
        		<c:when test="${empty funcInfoList }">
        			<tr align="center">
        				<td colspan="3">조회할 기능이 없습니다.</td>
        			</tr>
        		</c:when>
        		<c:otherwise>
        			<c:forEach items="${funcInfoList }" var="funcInfo">
			        	<tr onclick="location.href='/mypageadmin/funcdetail?funcName=${funcInfo.funcName }'" style="cursor:pointer;">
			        		<td align="left">${funcInfo.funcName }</td>
			        		<td style="justify-content: center;" >${funcInfo.funcMemo }</td>
			        		<td style="justify-content: center;" >${funcInfo.funcExplain }</td>
			        		<td align="right">
			        			<c:if test="${funcInfo.funcFee eq '0' }">
			        				기본제공
			        			</c:if>
			        			<c:if test="${funcInfo.funcFee ne '0' }">
				        			<fmt:formatNumber value="${funcInfo.funcFee }" pattern="#,###" />원
			        			</c:if>
			        		</td>
<!-- 			        		<td><button type="button" class="btn btn-outline-light" style="padding-top: 5px; padding-bottom: 5px; padding-left: 15px; padding-right: 15px; background-color: #79A9F5;">수정</button></td> -->
<!-- 			        		<td><button type="button" class="btn btn-outline-light" style="padding-top: 5px; padding-bottom: 5px; padding-left: 15px; padding-right: 15px; background-color: #F57878;">삭제</button></td> -->
			        	</tr>
        			</c:forEach>
        		</c:otherwise>
        	</c:choose>
        </table>
			</div>
        </div>
    </div>
</div>



<!-- Modal -->
<!-- <div class="modal fade" id="exampleModal" tabindex="-1" -->
<!-- 	aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- 				<h5 class="modal-title" id="exampleModalLabel">기능 추가</h5> -->
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				<form action=""> -->
<!-- 					<div class="form-group row"> -->
<!-- 	                    <label class="col-lg-3 col-form-label">기능 이름</label> -->
<!-- 	                    <div class="col-lg-9"> -->
<!-- 	                        <input type="text" class="form-control" id="funcName" name="funcName" value=""> -->
<!-- 	                    </div> -->
<!--                 	</div> -->
<!-- 					<div class="form-group row"> -->
<!-- 	                    <label class="col-lg-3 col-form-label">가격</label> -->
<!-- 	                    <div class="col-lg-9"> -->
<!-- 	                        <input type="text" class="form-control" id="funcFee" name="funcFee" value=""> -->
<!-- 	                    </div> -->
<!--                 	</div> -->
<!-- 					<div class="form-group row"> -->
<!-- 	                    <label class="col-lg-3 col-form-label">기능 설명</label> -->
<!-- 	                    <div class="col-lg-9"> -->
<%-- 	                        <textarea id="funcMemo" name="funcMemo" cols="30" rows="10" class="form-control">${inqBoard.inqCont }</textarea> --%>
<!-- 	                    </div> -->
<!--                 	</div> -->
<!-- 				</form> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-primary">등록</button> -->
<!-- 				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var addBtn = $("#addBtn");
	
	addBtn.on("click", function() {
		location.href = "/mypageadmin/funcform";
	});
});
</script>
