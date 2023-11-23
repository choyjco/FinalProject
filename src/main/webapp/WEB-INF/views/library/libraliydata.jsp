<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="row">
    <div>
        <div class="card">
			<div class="card-body">
<!-- 				<p> -->
<!-- 					<h4 class="card-title-20">일반증명서 및 자료 등록</h4> -->
<!-- 				</p> -->
			    <form class="needs-validation" action="/library/register" method="post" id="libraryForm" enctype="multipart/form-data">
			    <input type="hidden" name="libWriter" value="${Sessioninfo.empNo }">
		            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
			            <div class="col-md-3">
			            	<div class="mb-3">
			                    제목 : <input type="text" class="form-control" name="libTitle" id="libTitle" placeholder="제목을 입력하세요" value="" required="">
			                	<div class="invalid-feedback">
			                        	제목을 입력하세요
			                    </div>
			                </div>
			            </div>
		            </div>
		            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
			            <div class="col-md-3">
			            	<div class="mb-3">
			                    <select class="form-select" name="libCategory" id="libCategory">
			                    	<option value="교육자료">교육자료</option>
			                    	<option value="부서공지">부서공지</option>
			                    	<option value="기안양식">기안양식</option>
			                    </select>
			                </div>
			            </div>
		            </div>
		            <div class="d-grid gap-2 d-md-flex justify-content-md-center">
			            <div class="col-md-3">
			                <div class="mb-3">
			                    파일 : <input type="file" class="form-control" name="libFile" id="libFile">
			                	<div class="invalid-feedback">
			                        	파일 선택하세요
			                    </div>
			                </div>
			            </div>
		            </div>
		            <br/>
					<div class="d-grid gap-2 d-md-flex justify-content-md-center">
					  <button class="btn btn-info" type="submit">등록하기</button>
					</div>
					<sec:csrfInput/>
			    </form>
			</div>
		</div>
	</div>
</div>
















