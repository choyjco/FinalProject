<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

	<div class="card">
		<div class="card-body">
			<div class="row">
				<c:forEach items="${vacList }" var="vac">
					<div class="col-xl-3 col-sm-6">
					    <div class="card shadow-lg">
					    	<a href="/document/documentwrite?docClfCode=3">
						        <div class="card-header">
							        <div class="fs-4 fw-bold">${vac.vacName }</div>
						        </div>
						        <div class="card-body">
						            <div class="card-text d-flex justify-content-between">
										<div>
							                <h5 class="mt-2 font-weight-bold mb-2 d-flex align-items-center">${vac.vacAmt }</h5>
							            </div>
						            </div>
						        </div>
					    	</a>
					    </div>
					</div>
				</c:forEach>
			</div>
			<hr>
			<h4>예정 휴가</h4>
			<!-- 원래 여기가 foreach -->
			<c:forEach items="${vacAplyList }" var="vacAply" varStatus="i">
				<ul class="list-group list-group-flush" id="vacUl">
					<li class="list-group-item">
						<c:if test="${empty vacAplyList }">
							예정 휴가 일정이 존재하지 않습니다.
						</c:if>
					</li>
			<!-- 바뀌면 여기에 foreach -->
						<li class="list-group-item">
							<div class="row">
								<div class="col-1"></div>
								<div class="col-1">
									<c:if test="${vacAply.docStat == '대기중' }">
										<h5>
											<div class="badge badge-soft-warning">승인 대기</div>
										</h5>
									</c:if>
									<c:if test="${vacAply.docStat == '승인' }">
										<h5>
											<div class="badge badge-soft-success">승인 완료</div>
										</h5>
									</c:if>
									<c:if test="${vacAply.docStat == '반려' }">
										<h5>
											<div class="badge badge-soft-danger">반려</div>
										</h5>
									</c:if>
									<c:if test="${vacAply.docStat == '취소' }">
										<h5>
											<div class="badge badge-soft-secondary">취소</div>
										</h5>
									</c:if>
								</div>
								<div class="col-5">
									<span class="p-2">${vacAply.vacName } | 
									<fmt:formatDate pattern="yyyy-MM-dd(E)" value="${vacAply.vaapStrtDate }"/>
									~
									<fmt:formatDate pattern="yyyy-MM-dd(E)" value="${vacAply.vaapEndDate }"/></span>
								</div>
								<div class="col-1">
									<h5>
										<button type="button" class="btn btn-soft-purple btn-rounded" disabled>${vacAply.vaapAmt }일</button>
									</h5>
								</div>
								<div class="col-1">
									<button type="button" class="btn btn-sm btn-soft-info p-2" data-bs-toggle="modal" data-bs-target="#myModal${i.index }">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots" viewBox="0 0 16 16">
							                <path d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"></path>
							            </svg>
									</button>
								</div>
								<div class="col-3"></div>
							</div>
						</li>
					</ul>
				<!-- 모달창 시작 -->
				<div id="myModal${i.index }" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
					<div class="modal-dialog">
						<!-- 모달 내용 시작 -->
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myModalLabel">휴가 신청 정보</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<span class="fs-5">${empName }님의 휴가 요청</span>
								<form action="/vacation/vacationapply" method="post" id="cancelForm">
									<input type="hidden" value="${vacAply.docNo }" id="docNo" name="docNo">
									<sec:csrfInput/>
								</form>
								<p><span class="fw-bold">승인 상태</span> : ${vacAply.docStat }</p>
								<p><span class="fw-bold">상세 사유</span> : ${vacAply.vaapRsn }</p>
								<p><span class="fw-bold">휴가 종류</span> : ${vacAply.vacName }
								<p>
									<span class="fw-bold">신청 기간</span> : <fmt:formatDate pattern="yyyy-MM-dd(E)" value="${vacAply.vaapStrtDate }"/>
									~
									<fmt:formatDate pattern="yyyy-MM-dd(E)" value="${vacAply.vaapEndDate }"/> 
								</p>
								<p><span class="fw-bold">사용 기간</span> :	 ${vacAply.vaapAmt }일</p>
							</div>
							<div class="modal-footer">
								<c:if test="${vacAply.docStat ne '승인' }">
									<button type="button" class="btn btn-soft-danger" id="delBtn">휴가취소하기</button>
								</c:if>
							</div>
						</div>
					</div>
				</div> 
			</c:forEach>
		</div>
	</div>
<script type="text/javascript">
$(function(){
    var delBtn = $("#delBtn");
    var closeBtn = $("#closeBtn");
    var docNo = $("#docNo");
    var cancelForm = $("#cancelForm");
    
//     closeBtn.on("click", function(){
//     	$(".modal").modal("hide");
//     });
    
    $(".card-body").on("click", "#delBtn", function(){
        if(confirm("휴가신청을 취소하시겠습니까?")){
        	var ele = $(this)[0];
        	$(ele).parents(".modal-content").find("#cancelForm").submit();
        }
    }); 
    
});

</script>