<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<div class="row">
	<div>
		<div class="card">
			<div class="card-body">
				<div class="tab-content p-3 text-muted">
					<div id="table-search" class="table">
						<div role="complementary" class="gridjs gridjs-container"
							style="width: 100%;">
							<form method="post" id="searchForm">
								<div class="row d-flex justify-content-between">
									<div class="col-md-2">
										<select class="form-select" name="aprStat" id="aprStat">
											<option value="대기중"
												<c:if test="${aprStat eq '대기중' }">selected</c:if>>대기중</option>
											<option value="반려"
												<c:if test="${aprStat eq '반려' }">selected</c:if>>반려</option>
											<option value="승인"
												<c:if test="${aprStat eq '승인' }">selected</c:if>>승인</option>
										</select>
									</div>
									<div class="col-md-9">
										<div class="d-flex justify-content-end">
											<ul class="nav nav-pills">
												<li class="nav-item">
													<input type="hidden" name="page" id="page" />
													<select class="form-select" name="searchType" id="searchType">
														<option value="3"
															<c:if test="${searchType eq '3' }">selected</c:if>>휴가</option>
														<option value="2"
															<c:if test="${searchType eq '2' }">selected</c:if>>근무</option>
														<option value="1"
															<c:if test="${searchType eq '1' }">selected</c:if>>출장</option>
														<option value="4"
															<c:if test="${searchType eq '4' }">selected</c:if>>추가근무</option>
														<option value="5"
															<c:if test="${searchType eq '5' }">selected</c:if>>경비</option>
													</select>
												</li>
												<li>&nbsp;</li>
												<li class="nav-item"><input type="text"
													name="searchWord" id="searchWord" value="${searchWord }"
													class="form-control float-right" placeholder="문서제목을 입력하세요">
												</li>
												<li>&nbsp;</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="submit" class="btn btn-primary">검색</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</div>
									</div>
								</div>
							</form>
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table text-center"
									style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr">
											<th data-column-id="title" class="gridjs-th">
												<div class="gridjs-th-content">기안종류</div>
											</th>
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
											<th data-column-id="mdate" class="gridjs-th">
												<div class="gridjs-th-content">처리일자</div>
											</th>
										</tr>
									</thead>
									<c:set value="${docPagingVO.dataList }" var="myDocList" />
									<c:choose>
										<c:when test="${empty myDocList }">
											<tbody class="gridjs-tbody" id="docList">
												<tr class="gridjs-tr text-center">
													<td data-column-id="title" class="gridjs-td" colspan="7">해당
														정보가 존재하지 않습니다</td>
												</tr>
											</tbody>
										</c:when>
										<c:otherwise>
											<tbody class="gridjs-tbody" id="docList">
												<c:forEach items="${myDocList }" var="myDoc">
													<tr class="gridjs-tr text-center align-items-center">
														<td data-column-id="title" class="gridjs-td">${myDoc.docClfName}</td>
														<td data-column-id="title" class="gridjs-td">${myDoc.docTitle }</td>
														<td data-column-id="gname" class="gridjs-td">${myDoc.empName }</td>
														<td data-column-id="wdate" class="gridjs-td"><fmt:formatDate
																value="${myDoc.docDate}" pattern="yyyy-MM-dd(E) HH:mm" /></td>
														<td data-column-id="mdate" class="gridjs-td">
															<c:if test="${myDoc.aprStat eq '대기중' }">
																<h5><span class="badge badge-soft-warning">${myDoc.aprStat }</span></h5>
															</c:if>
															<c:if test="${myDoc.aprStat eq '승인' }">
																<h5><span class="badge badge-soft-primary">${myDoc.aprStat }</span></h5>
															</c:if>
															<c:if test="${myDoc.aprStat eq '반려' }">
																<h5><span class="badge badge-soft-danger">${myDoc.aprStat }</span></h5>
															</c:if>
														</td>
														<td data-column-id="mname" class="gridjs-td text-center">
															<div class="icon-demo-content align-item-center">
																<i class="uil-file-alt" data-bs-toggle="modal"
																	data-bs-target="#infoModify${myDoc.docNo }" onclick="javascript:fn_aprModal(${myDoc.docNo})"></i>
															</div>
														</td>
														<td data-column-id="wdate" class="gridjs-td"><fmt:formatDate
																value="${myDoc.aprDate}" pattern="yyyy-MM-dd(E) HH:mm" /></td>
													</tr>
												</c:forEach>
											</tbody>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
					</div>
					<c:forEach items="${myDocList }" var="myDoc">
						<div class="modal fade exampleModalFullscreen"
							id="infoModify${myDoc.docNo }" tabindex="-1"
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
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
										<c:if test="${myDoc.aprStat eq '대기중' }">
											<button type="button" class="btn btn-danger"
												data-bs-dismiss="modal"
												onclick="javascript:fn_diss('${myDoc.docNo}')">반려</button>
											<button type="button" class="btn btn-success"
												data-bs-dismiss="modal"
												onclick="javascript:fn_apr('${myDoc.docNo}')">승인</button>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="row g-0 text-center text-sm-start">
						<div class="col-sm">
							<nav aria-label="Page navigation example" id="pagingArea">
								${docPagingVO.pagingHTML }</nav>
						</div>
					</div>
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

	function fn_aprModal(docNo){
		
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
					if(res[1].aprDate == null){
						html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'> </td>";
					}else{
						html += "<td data-column-id='title' class='gridjs-td' style='height: 20%;'>"+ res[1].aprDate +"</td>";
					}
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
					html += "</thead>";
					html += "</table>";
			
					table.append(html);
				}
			}
		});
	}
	
	// 반려 시 처리될 핸들러 함수
	function fn_apr(docNo) {
		console.log(docNo);
		// 반려 사유를 작성할 modal 필요
		var aprRejRsn = $("#aprRejRsn").val();

		var data = {
			docNo : docNo,
			aprRejRsn : aprRejRsn
		};

		$.ajax({
			type : "post",
			url : "/document/aprupdate",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(res) {
				console.log(res);
				location.reload();
			}
		});
	}

	function fn_diss(docNo) {
		console.log(docNo);
		Swal.fire({
			  title: '반려사유',
			  input: 'text',
			  inputAttributes: {
			    autocapitalize: 'off'
			  },
			  showCancelButton: true,
			  cancelButtonText: '취소',
			  confirmButtonText: '제출',
			  confirmButtonColor: '#038edc',
			  showLoaderOnConfirm: true,
			  allowOutsideClick: () => !Swal.isLoading()
		}).then((result) => {
		  if (result.isConfirmed) {
			  var data = {
				docNo : docNo,
				aprRejRsn : result.value
			  };
			  $.ajax({
					type : "post",
					url : "/document/aprupdate",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					data : JSON.stringify(data),
					success : function(res) {
						console.log(res);
						
					}
				});
		    Swal.fire({
		      title: `반려처리 되었습니다!`,
		      imageUrl: result.value.avatar_url,
		      confirmButtonText: '제출',
			  confirmButtonColor: '#038edc'
		    });
		    setTimeout(() => location.reload(), 1000);
		  }
		});
// 		$.ajax({
// 			type : "post",
// 			url : "/document/aprupdate",
// 			beforeSend : function(xhr) {
// 				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 			},
// 			contentType : "application/json; charset=utf-8",
// 			dataType : "json",
// 			data : docNo,
// 			success : function(res) {
// 				console.log(res);
// 				location.reload();
// 			}
// 		});
	}
</script>


