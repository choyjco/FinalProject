<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="col-lg-12">
    <div class="card">
        <div class="card justify-content-between d-flex align-items-center">
		</div><!-- end card header -->
        <div class="card-body">
        
	    	<!-- Right Sidebar -->
	            <div class="card-body">
	                <div class="d-flex align-items-start mb-4">
	                    <div class="flex-shrink-0 me-3">
	                    	<c:choose>
								<c:when test="${board.boardEmpno eq '199404001'}">
									<img class="rounded-circle avatar-sm" src="${pageContext.request.contextPath }/resources/profile/199404001\CY.jpg" alt="Generic placeholder image">
								</c:when>
								<c:otherwise>
									<img class="rounded-circle avatar-sm" src="${pageContext.request.contextPath }/resources/profile\200101001\hani.jpg" alt="Generic placeholder image">
								</c:otherwise>
							</c:choose>
	                    </div>
	                    
	                    <div class="flex-grow-1">
	                        <h5 class="font-size-14 my-1">${board.boardWriter }</h5>
	                        <small class="text-muted"><fmt:formatDate value="${board.boardRegdate }" pattern="yyyy-MM-dd HH:mm"/></small>
	                    </div>
	                </div>
					<hr>
	                <h4 class="mt-0 mb-4 font-size-16">${board.boardTitle }</h4>
	
	                <p class="text-muted">${board.boardCont }</p>
	                
					<c:set value="${board.boardFileList }" var="boardFileList"/>
					<c:if test="${not empty boardFileList }">
					<hr/>
	                <div class="row">
	                
	                	<c:forEach items="${boardFileList }" var="boardFile">
							<div class="col-md-2">
								<div class="card shadow-lg">
									<div
										class="card-header mt-n4 mx-3 p-0 bg-transparent position-relative z-index-2">
										<a class="d-block blur-shadow-image text-center"> 
											<img src="${pageContext.request.contextPath}/resources/assets/images/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
										</a>
										<div class="colored-shadow" style="background-image: url(&quot;https://images.unsplash.com/photo-1536321115970-5dfa13356211?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=934&amp;q=80&quot;);"></div>
									</div>
									<div class="card-body text-center bg-white border-radius-lg p-3 pt-0">
										<h6 class="mt-3 mb-1 d-md-block d-none">
											${boardFile.fileOrgname } (${boardFile.fileSize }KB)
										</h6>
										<p class="mb-0 text-xs font-weight-bolder text-info text-uppercase">
											<button type="button" class="btn btn-primary btn-sm fileDownload"
												data-file-no="${boardFile.fileNo }">
												download 
											</button>
										</p>
									</div>
								</div>
							</div>
						</c:forEach>
	                </div>
					</c:if>
	                <form action="/notice/delete" method="post" id="procForm">
						<input type="hidden" name="boardNo" value="${board.boardNo }">
						<sec:csrfInput/>
					</form>
					
					<div class="card-footer p-3">
						<c:if test="${status eq 'writer'}">
							<button type="button" class="btn btn-outline-primary" id="delBtn">삭제</button>
							<button type="button" class="btn btn-outline-secondary" id="udtBtn">수정</button>
						</c:if>
						<button type="button" class="btn btn-outline-success" onclick="javascript:location.href='/notice/list'">목록</button>
					</div>
	
	        </div><!-- end card-body -->
        </div><!-- end card body -->
     </div><!--end card -->
</div><!-- end card -->
            
<!-- ==================================================================================== -->

<script type="text/javascript">
$(function(){
	var procForm = $("#procForm");
	var delBtn = $("#delBtn");
	var udtBtn = $("#udtBtn");
	
	delBtn.on("click", function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			procForm.submit();
		}
	});
	
	udtBtn.on("click", function(){
		procForm.attr("method", "get");
		procForm.attr("action", "/notice/update");
		procForm.submit();
	});
	
	$(".fileDownload").on("click", function(){
		var fileNo = $(this).data("file-no");
		location.href = "/notice/download?fileNo=" + fileNo;
	});
});
</script>