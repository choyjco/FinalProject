<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div>
	<div class="card">
		<div class="card-body">
			<div id="table-search" class="table">
				<div role="complementary" class="gridjs gridjs-container"
					style="width: 100%;">
					<div class="d-flex justify-content-end">
						<div class="gridjs-search">
							<form method="post" id="searchForm">
								<ul class="nav nav-pills">
									<li class="nav-item">
										<input type="hidden" name="page" id="page" />
										<select class="form-select" name="searchType">
											<option value="title"
												<c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
											<option value="empName"
												<c:if test="${searchType eq 'empName' }">selected</c:if>>기안자</option>
											<option value="docClfName"
												<c:if test="${searchType eq 'docClfName' }">selected</c:if>>문서분류</option>
									</select></li>
									<li class="nav-item">
									<input type="text" name="searchWord" id="searchWord" value="${searchWord }" class="form-control float-right" placeholder="문서제목을 입력하세요">
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
					<div id="table-pagination" class="table">
						<div role="complementary" class="gridjs gridjs-container" style="width: 100%;">
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table" id="gridjstable2"
									style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr text-center">
											<th data-column-id="title" class="gridjs-th">
												<div class="gridjs-th-content">제목</div>
											</th>
											<th data-column-id="gname" class="gridjs-th">
												<div class="gridjs-th-content">기안자</div>
											</th>
											<th data-column-id="mname" class="gridjs-th">
												<div class="gridjs-th-content">문서분류</div>
											</th>
											<th data-column-id="wdate" class="gridjs-th">
												<div class="gridjs-th-content">기안일자</div>
											</th>
											<th data-column-id="status" class="gridjs-th">
												<div class="gridjs-th-content">승인상태</div>
											</th>
											<th data-column-id="reason" class="gridjs-th">
												<div class="gridjs-th-content">반려사유</div>
											</th>
											<th data-column-id="reason" class="gridjs-th">
												<div class="gridjs-th-content">처리일자</div>
											</th>
											<th data-column-id="reason" class="gridjs-th">
												<div class="gridjs-th-content">내용</div>
											</th>
										</tr>
									</thead>
									<!-- foreach 시작 -->
									<tbody class="gridjs-tbody" id="tbody2">
									<c:set value="${pagingVO.dataList }" var="docListAll"/>
										<c:forEach items="${docListAll }" var="listAll">
		
											<tr class="gridjs-tr" id="tr${listAll.docNo }">
												<td data-column-id="title" class="gridjs-td text-left">${listAll.docTitle }</td>
												<td data-column-id="gname" class="gridjs-td text-center">${listAll.empName }</td>
												<td data-column-id="mname" class="gridjs-td text-center">${listAll.docClfName }</td>
												<td data-column-id="wdate" class="gridjs-td text-center"><fmt:formatDate value="${listAll.docDate }" pattern="yyyy-MM-dd(E)"/></td>
												<td data-column-id="status" class="gridjs-td text-center">
													<c:if test="${listAll.docStat eq '승인'}">
														<h5><span class="badge badge-soft-primary">${listAll.docStat }</span></h5>
													</c:if>
													<c:if test="${listAll.docStat eq '대기중'}">
													<h5><span class="badge badge-soft-warning">${listAll.docStat }</span></h5>
													</c:if>
													<c:if test="${listAll.docStat eq '반려'}">
													<h5><span class="badge badge-soft-danger">${listAll.docStat }</span></h5>
													</c:if>
												</td>
												<td data-column-id="reason" class="gridjs-td text-center">
												<c:choose>
												<c:when test="${listAll.docStat eq '반려'}">
													<div class="icon-demo-content align-item-center">
														<i class="uil-file-alt" data-bs-toggle="modal" data-bs-target="#rejRsn${listAll.docNo }"></i>
													</div>
												</c:when>
												<c:otherwise>
														<div class="d-flex flex-wrap align-items-center justify-content-md-center">
															<h5><span class="badge badge-soft-purple">없음</span></h5>
														</div>
												</c:otherwise>
												</c:choose>
												</td>
												<td data-column-id="reason" class="gridjs-td text-center">
													<c:if test="${listAll.docStat ne '대기중'}">
														<div class="d-flex flex-wrap align-items-center justify-content-md-center">
															<h5><span class="badge badge-soft-purple"><fmt:formatDate value="${listAll.docConfDate }" pattern="yyyy-MM-dd(E)"/></span></h5>
														</div>
													</c:if>
													<c:if test="${listAll.docStat eq '대기중'}">
														<h5><span class="badge badge-soft-warning">${listAll.docStat }</span></h5>
													</c:if>
												</td>
												<td data-column-id="status" class="gridjs-td text-center">
													<div class="icon-demo-content align-item-center">
														<i class="uil-file-alt" data-bs-toggle="modal" 
														data-bs-target="#info${listAll.docNo }"  onclick="javascript:fn_aprModal(${listAll.docNo})"></i>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- foreach 끝-->
								</table>
							</div>
							<div class="gridjs-footer">
								<nav aria-label="Page navigation example" id="pagingArea">
									${pagingVO.pagingHTML }
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
				<c:forEach items="${docListAll }" var="myDoc">
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
									<button type="button" class="btn btn-success" data-bs-dismiss="modal">확인</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:forEach items="${docListAll }" var="listAll">
				<c:if test="${listAll.docStat eq '반려' }">
				<div id="rejRsn${listAll.docNo }" class="modal fade bs-example-modal-center" role="dialog"
					tabindex="-1" aria-labelledby="myModalLabel"
					style="display: none;" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">반려사유</h5>
								<button type="button" class="btn-close"
									data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="row align-items-center">
									<div class="row">
										<div class="col-md-5">
											<textarea class="form-control" id="aprRejRsn" name="aprRejRsn" cols="30"  rows="10">${listAll.aprRejRsn }</textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-light" data-bs-dismiss="modal">확인</button>
							</div>
						</div>
					</div>
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>

<!-- gridjs js -->
<script
	src="${pageContext.request.contextPath }/resources/assets/libs/gridjs/gridjs.umd.js"></script>
<!-- Sweet Alerts js -->
<script
	src="${pageContext.request.contextPath }/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script type="text/javascript">
$(function(){

	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
});
function fn_aprModal(docNo){
	console.log(docNo)
	
	$.ajax({
		url : "/document/aprlist?${_csrf.parameterName}=${_csrf.token}",
		type : "post",
		data : {docNo : docNo},
		success : function(res){
			var table = $("#grid"+docNo);
			table.empty();
			
			var html = "";
			
			if(res.length == 2){
				
			
				html += "<table role='grid' class='gridjs-table' id='gridjstable' style='height: 200px;'>";
				html += "<thead class='gridjs-thead text-center'>";
				html += "<tr class='gridjs-tr'>";
				html += "<th data-column-id='title' class='gridjs-th' rowspan='3' style='width: 10%;'>";
				html += "<div class='gridjs-th-content'>수신</div>";
				html += "</th>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+res[0].empName+"</td>";
				html += "<th data-column-id='title' class='gridjs-th' rowspan='3' style='width: 10%;'>";
				html += "<div class='gridjs-th-content'>결재</div>";
				html += "</th>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+res[0].aprName+"</td>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+res[1].aprName+"</td>";
				html += "</tr>";
				html += "<tr>";
				html += "<td data-column-id='title' class='gridjs-td'>";
				if (res[0].docStat != "작성중" ){
					html += "<img alt='' src='/resources/stamp/doc.png' style='height: 100px; width: 150px;'>";
				}
				html += "</td>";
				html += "<td data-column-id='title' class='gridjs-td'>";
				if(res[0].aprStat == "승인" ){
					html += "<img alt='' src='/resources/stamp/approve.png' style='height: 100px; width: 150px;'>";
				}else if(res[0].aprStat == "대기중"){
					html += " ";
				}
				else {
					html += "<img alt='' src='/resources/stamp/failed.png' style='height: 90px; width: 130px;'>";
				}
				html += "</td>";
				html += "<td data-column-id='title' class='gridjs-td'>";
				if (res[1].aprStat == "승인"){
					html += "<img alt='' src='/resources/stamp/approve.png' style='height: 100px; width: 150px;'>";
				}else if(res[1].aprStat == "대기중"){
					html += " ";
				}
				else {
					html += "<img alt='' src='/resources/stamp/failed.png' style='height: 90px; width: 130px;'>";
				}
				html += "</td>";
				html += "</tr>";
				html += "<tr>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[0].docDate +"";
				html += "</td>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[0].aprDate +"";
				html += "</td>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[1].aprDate +"";
				html += "</td>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
		
				table.append(html);
			
			}else{
				html += "<table role='grid' class='gridjs-table' id='gridjstable' style='height: 200px;'>";
				html += "<thead class='gridjs-thead text-center'>";
				html += "<tr class='gridjs-tr'>";
				html += "<th data-column-id='title' class='gridjs-th' rowspan='3' style='width: 10%;'>";
				html += "<div class='gridjs-th-content'>수신</div>";
				html += "</th>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+res[0].empName+"</td>";
				html += "<th data-column-id='title' class='gridjs-th' rowspan='3' style='width: 10%;'>";
				html += "<div class='gridjs-th-content'>결재</div>";
				html += "</th>";
				html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+res[0].aprName+"</td>";
				html += "</tr>";
				html += "<tr>";
				html += "<td data-column-id='title' class='gridjs-td'>";
				if (res[0].docStat != "작성중" ){
					html += "<img alt='' src='/resources/stamp/doc.png' style='height: 100px; width: 150px;'>";
				}
				html += "</td>";
				html += "<td data-column-id='title' class='gridjs-td'>";
				if(res[0].aprStat == "승인" ){
					html += "<img alt='' src='/resources/stamp/approve.png' style='height: 100px; width: 150px;'>";
				}else if(res[0].aprStat == "대기중"){
					html += " ";
				}else {
					html += "<img alt='' src='/resources/stamp/failed.png' style='height: 90px; width: 130px;'>";
				}
				html += "</td>";
				html += "</tr>";
				html += "<tr>";
				if(res[0].docDate == null){
					html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'> </td>";
				}else{
					html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[0].docDate +"</td>";
				}
				if(res[0].aprDate == null){
					html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'> </td>";
				}else{
					html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[0].aprDate +"</td>";
				}
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
		
				table.append(html);
			}
		}
	});
}
</script>














