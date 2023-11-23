<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<div class="row">
	<div>
		<div class="card">
			<div class="card-body">
				<div class="tab-content p-3 text-muted">
					<div id="table-search" class="table">
						<div role="complementary" class="gridjs gridjs-container"
							style="width: 100%;">
							<div class="row">
								<div class="col-md-3"></div>
								<div class="col-md-9">
									<div class="d-flex justify-content-end">
										<form method="post" id="searchForm">
											<ul class="nav nav-pills">
												<li class="nav-item"><input type="hidden" name="page"
													id="page" /> <select class="form-select" name="searchType">
														<option value="2"
															<c:if test="${searchType eq '2' }">selected</c:if>>근무</option>
														<option value="1"
															<c:if test="${searchType eq '1' }">selected</c:if>>출장</option>
														<option value="3"
															<c:if test="${searchType eq '3' }">selected</c:if>>휴가</option>
														<option value="4"
															<c:if test="${searchType eq '4' }">selected</c:if>>추가근무</option>
														<option value="5"
															<c:if test="${searchType eq '5' }">selected</c:if>>경비</option>
												</select></li>
												<li class="nav-item"><input type="text"
													name="searchWord" id="searchWord" value="${searchWord }"
													class="form-control float-right" placeholder="문서제목을 입력하세요">
												</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="submit" class="btn btn-primary">검색</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
								</div>
							</div>
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table text-center"
									style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr">
											<th data-column-id="title" class="gridjs-th">
												<div class="gridjs-th-content">기안제목</div>
											</th>
											<th data-column-id="gname" class="gridjs-th">
												<div class="gridjs-th-content">작성자</div>
											</th>
											<th data-column-id="mname" class="gridjs-th">
												<div class="gridjs-th-content">작성일자</div>
											</th>
											<th data-column-id="wdate" class="gridjs-th">
												<div class="gridjs-th-content">처리상태</div>
											</th>
											<th data-column-id="mdate" class="gridjs-th">
												<div class="gridjs-th-content">기안내용</div>
											</th>
										</tr>
									</thead>
									<c:set value="${docPagingVO.dataList }" var="myDocList" />
									<c:choose>
										<c:when test="${empty myDocList }">
											<tbody class="gridjs-tbody" id="docList">
												<tr class="gridjs-tr text-center">
													<td data-column-id="title" class="gridjs-td" colspan="5">해당
														정보가 존재하지 않습니다</td>
												</tr>
											</tbody>
										</c:when>
										<c:otherwise>
											<tbody class="gridjs-tbody" id="docList">
												<c:forEach items="${myDocList }" var="myDoc">
													<tr class="gridjs-tr text-center align-items-center">
														<td data-column-id="title" class="gridjs-td">${myDoc.docTitle }</td>
														<td data-column-id="gname" class="gridjs-td">${myDoc.empName }</td>
														<td data-column-id="wdate" class="gridjs-td"><fmt:formatDate
																value="${myDoc.docDate}" pattern="yyyy-MM-dd(E) HH:mm" /></td>
														<td data-column-id="mdate" class="gridjs-td"
															style="position: relative; margin: auto;">
															<div
																class="d-flex flex-wrap align-items-center justify-content-md-center">
																<div class="badge badge-soft-purple">${myDoc.docStat }</div>
															</div>
														</td>
														<td data-column-id="mname" class="gridjs-td text-center">
															<div class="icon-demo-content align-item-center">
																<i class="uil-file-alt" data-bs-toggle="modal"
																	data-bs-target="#info${myDoc.docNo }"></i>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
							<div class="row g-0 text-center text-sm-start">
								<div class="col-sm">
									<nav aria-label="Page navigation example" id="pagingArea">
										${docPagingVO.pagingHTML }</nav>
								</div>
							</div>
						</div>
					</div>
					<c:forEach items="${myDocList }" var="myDoc">
						<div class="modal fade exampleModalFullscreen"
							id="info${myDoc.docNo }" tabindex="-1"
							aria-labelledby="exampleModalFullscreenLabel"
							style="display: none;" aria-hidden="true">
							<div class="modal-dialog modal-fullscreen">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalFullscreenLabel">기안내용</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row d-flex justify-content-between">
											<div class="card col-md-5">
												<div class="card-body">
													<div id="table-pagination" class="table">
														<div role="complementary" class="gridjs gridjs-container">
															<div class="gridjs-wrapper" style="height: auto;">
																<table role="grid" class="gridjs-table"
																	id="gridjstable2" style="height: 200px;">
																	<thead class="gridjs-thead text-center">
																		<tr class="gridjs-tr">
																			<th data-column-id="title" class="gridjs-th">
																				<div class="gridjs-th-content">문서번호</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td">
																			<fmt:formatDate value="${myDoc.docDate }" pattern="yyyy_MM_dd"/>_doc${myDoc.docNo }</td>
																		</tr>
																		<tr>
																			<th data-column-id="gname" class="gridjs-th">
																				<div class="gridjs-th-content">기안자</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td">${myDoc.empName }</td>
																		</tr>
																		<tr>
																			<th data-column-id="mname" class="gridjs-th">
																				<div class="gridjs-th-content">문서분류</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td">${myDoc.docClfName }</td>
																		</tr>
																		<tr>
																			<th data-column-id="wdate" class="gridjs-th">
																				<div class="gridjs-th-content">기안일자</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td"><fmt:formatDate value="${myDoc.docDate }" pattern="yyyy-MM-dd(E)"/></td>
																		</tr>
																		<tr></tr>
																	</thead>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="card col-md-5 justify-content-center">
												<div class="card-body">
													<div id="table-pagination" class="table">
														<div role="complementary" class="gridjs gridjs-container">
															<div class="gridjs-wrapper" id="grid${myDoc.docNo }" style="height: auto;">
																<table role="grid" class="gridjs-table"
																	id="gridjstable" style="height: 200px;">
																	<thead class="gridjs-thead text-center">
																		<tr class="gridjs-tr">
																			<th data-column-id="title" class="gridjs-th" rowspan="3" style="width: 10%;">
																				<div class="gridjs-th-content">수신</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;">${myDoc.empName }</td>
																			<th data-column-id="title" class="gridjs-th" rowspan="3" style="width: 10%;">
																				<div class="gridjs-th-content">결재</div>
																			</th>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;">${myDoc.aprName }</td>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;"></td>
																		</tr>
																		<tr>
																			<td data-column-id="title" class="gridjs-td">
																				<c:if test="${myDoc.docStat ne '작성중' }">
																					<img alt="" src="/resources/stamp/doc.png" style="height: 100px; width: 150px;">
																				</c:if>
																			</td>
																			
																			<td data-column-id="title" class="gridjs-td">
																				<c:if test="${myDoc.aprStat eq '승인' }">
																					<img alt="" src="/resources/stamp/approve.png" style="height: 100px; width: 150px;">
																				</c:if>
																				<c:if test="${myDoc.aprStat eq '반려' }">
																					<img alt="" src="/resources/stamp/failed.png" style="height: 100px; width: 150px;">
																				</c:if>
																			</td>
																			<td data-column-id="title" class="gridjs-td">
																				<c:if test="${myDoc.docStat eq '승인' }">
																					<img alt="" src="/resources/stamp/approve.png" style="height: 100px; width: 150px;">
																				</c:if>
																				<c:if test="${myDoc.docStat eq '반려' }">
																					<img alt="" src="/resources/stamp/failed.png" style="height: 100px; width: 150px;">
																				</c:if>
																			</td>
																		</tr>
																		<tr>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;">
																				<fmt:formatDate value="${myDoc.aprDate }" pattern="yyyy-MM-dd(E)"/>
																			</td>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;">
																				<fmt:formatDate value="${myDoc.aprDate }" pattern="yyyy-MM-dd(E)"/>
																			</td>
																			<td data-column-id="title" class="gridjs-td" style="height: 20%;">
																				<fmt:formatDate value="${myDoc.aprDate }" pattern="yyyy-MM-dd(E)"/>
																			</td>
																		</tr>
																	</thead>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row d-flex justify-content-center">
											<div class="card" style="width: 80%;">
												<div class="card-body d-flex justify-content-center">
													<div>${myDoc.docCont }</div>
												</div>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
										<a href="/document/deletemydoc?docNo=${myDoc.docNo }">
											<button type="button" class="btn btn-danger" data-bs-dismiss="modal">삭제</button>
										</a>
										<a href="/document/docfix?docNo=${myDoc.docNo }">
											<button type="button" class="btn btn-success" data-bs-dismiss="modal">수정</button>
										</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});

});

function fn_cancel(docNo){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type : "post",
			url : "/document/deletemydoc",
			data : docNo,
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
			}
			
		});
	}
}

function fn_fix(docNo){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type : "post",
			url : "/document/deletemydoc",
			data : docNo,
			contentType : "application/json; charset=utf-8",
			success : function(res){
				console.log(res);
			}
			
		});
	}
}
</script>


