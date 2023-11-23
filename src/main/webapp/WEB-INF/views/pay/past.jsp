<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.css" />
</head>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="row" style="padding-top: 15px;">			

					<!-- end col -->
					<div class="col-md-6">
						<div class="d-flex flex-wrap align-items-start">
							<div class="row d-flex flex-wrap align-items-start" style="text-align: right font-weight: normal; width: 340px;">
								<c:set var="today" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${today}" pattern="MM" var="start" />
									<span style="width: 110px; font-size: 17px; padding-top: 4px;">급여 조회 : </span> 
									<select class="form-select" style="width: 85px;" id="month">
										<c:forEach begin="1" end="5" var="idx" step="1">
											<option value="${start - idx}">
												${start - idx} 월
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="d-flex flex-wrap align-items-center justify-content-md-end" style="background-color: rgba(245, 246, 248, 0.25);">
								<input class="form-control" type="text" name="searchWord" id="searchWord" placeholder="  사원이름, 부서 검색" style="width: 184px;"/>
								<button type="submit" class="btn btn-primary">
									검색
								</button>
							</div>
						</div>
					</div><!-- end col -->
				</div>
				<!-- end row -->
					
				<div id="grid">
				</div>
				
				<div class="modal fade bs-example-modal-center" tabindex="-1" aria-labelledby="mySmallModalLabel" style="display: none;" aria-hidden="true" id="pastPayDetail">
					<div class="modal-dialog modal-dialog-centered modal-dialog modal-lg">
						<div class="modal-content" style="width: 1000px;">
							<div class="modal-header">
								<h5 class="modal-title"><span id="empName" ></span> 님의 <span id="empMonth" ></span> 급여 명세서 상세</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
								</button>
							</div>
							<div class="modal-body" style="padding-top: 0px;">
								<div class="row">
									<div class="card col-md-6">
										<div class="card-header justify-content-between d-flex align-items-center">
											<h4 class="card-title"><strong>지급내역</strong></h4>
										</div>
										<!-- end card header -->
										<div class="card-body">
											<div class="table-responsive">
												<table class="table mb-0">

													<thead class="table-light">
														<tr>
															<th>임금항목</th>
															<th>지급 금액</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>기본급</td>
															<td style="text-align: right;"><span id="gibonPay" ></span></td>
														</tr>
														<tr>
															<td>기타수당</td>
															<td style="text-align: right;"><span id="gitaPay" ></span></td>
														</tr>
														<tr>
															<td>직책수당</td>
															<td style="text-align: right;"><span id="jikPay" ></span></td>
														</tr>
													</tbody>
													<!-- end tbody-->
													<tfoot class="table-light">
														<tr>
															<td>지급 총액</td>
															<td style="text-align: right;"><span id="incSetAmt3" ></span></td>
														</tr>
													</tfoot>
												</table>
												<!-- end table-->
											</div>
											<!-- end table responsive -->
										</div>
										<!-- end card body -->
									</div>
									<!-- end card -->
									<div class="card col-md-6">
										<div class="card-header justify-content-between d-flex align-items-center">
											<h4 class="card-title"><strong>공제내역</strong></h4>
										</div>
										<!-- end card header -->
										<div class="card-body">
											<div class="table-responsive">
												<table class="table mb-0">

													<thead class="table-light">
														<tr>
															<th>공제항목</th>
															<th>지급 금액</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>사대보험</td>
															<td style="text-align: right;"><span id="sadae" ></span></td>
														</tr>
														<tr>
															<td>소득세</td>
															<td style="text-align: right;"><span id="sodeuk" ></span></td>
														</tr>
													</tbody>
													<!-- end tbody-->
													<tfoot class="table-light">
														<tr>
															<td>공제 총액</td>
															<td style="text-align: right;"><span id="incSetDedt3" ></span></td>
														</tr>
													</tfoot>
												</table>
												<!-- end table-->
											</div>
											<!-- end table responsive -->
										</div>
										<!-- end card body -->
									</div>
									<!-- end card -->
								</div>
								<!-- end modal body row -->
								
									<div class="alert alert-info">
								<div class="row">
										<div class="d-flex flex-wrap align-items-center justify-content-md-end col-md-6" style="color: black;">
											실 지급액
										</div>
											<div class="d-flex flex-wrap align-items-center justify-content-md-end alert-link col-md-6">
												<span id="incSetRes3" ></span>
											</div>
									</div>
								</div>
								
								<div class="modal-footer">
									<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
				
				
			</div>
		</div>
		<!-- end row -->
	</div>
	<!-- end card -->
</div>

<script src="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
$(function() {
	var search = $("#search");
	var grid = $("#grid");
	
	search.on("click", function() {
		var searchWord = $("#searchWord").val();
		var data = {
			searchWord : searchWord
		};
		$.ajax({
			method : "post",
			url : "/pay/searchList?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				if(result.length == 0) {
					alert("조회하신 사원이 존재하지 않습니다.");
				}else{
					grid.resetData(result);
				}
			}
		});
	});
	
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		columns : [ {
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true,
			resizeable : true
		}, {
			header : '사원명',
			name : 'empName',
			align : 'center',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
			sortable : true
		}, {
			header : '재직상태',
			name : 'empStat',
			align : 'center',
			sortable : true
		},],
			pageOptions : {
			useClient : true,
			perPage : 10
		}
	});
	$.ajax({
		url : "/pay/inCalList",
		method : "get",
		// 		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		//         data : JSON.stringify(form),
		success : function(result) {
			// 	     	   console.log(result);
			grid.resetData(result);

		}
	});
	
	var month = $("#month");
	
	month.on("change", function() {
		month = $("#month").val();
// 		console.log(month);
	});
	
	grid.on("click",ev => {
		let dataRow = grid.getRow(ev.rowKey);
		console.log(dataRow.empNo);
		$("#pastPayDetail").modal("show");
		
		month = $("#month").val();
		var data = {
				empNo : dataRow.empNo,
				month : month
		};
		console.log(data);

		document.getElementById('empName').innerHTML = dataRow.empName;
		document.getElementById('empMonth').innerHTML = month + "월";
		document.getElementById('gibonPay').innerHTML = 0;
		document.getElementById('gitaPay').innerHTML = 0;
		document.getElementById('jikPay').innerHTML = 0;
		document.getElementById('sadae').innerHTML = 0;
		document.getElementById('sodeuk').innerHTML = 0;
		document.getElementById('incSetRes3').innerHTML = 0;
		document.getElementById('incSetAmt3').innerHTML = 0;
		document.getElementById('incSetDedt3').innerHTML = 0;
		
		$.ajax({
			type : "POST",
			url : "/pay/pastDetail?${_csrf.parameterName}=${_csrf.token}",
			data :  JSON.stringify(data),
			contentType : "application/json",
			success : function(res) {
				
				document.getElementById('gibonPay').innerHTML = Number(res.gibonpay).toLocaleString();
				document.getElementById('gitaPay').innerHTML = Number(res.gitapay).toLocaleString();
				document.getElementById('jikPay').innerHTML = Number(res.jikpay).toLocaleString();
				document.getElementById('sadae').innerHTML = Number(res.sadae).toLocaleString();
				document.getElementById('sodeuk').innerHTML = Number(res.sodeuk).toLocaleString();
				document.getElementById('incSetRes3').innerHTML = Number(res.incSetRes).toLocaleString();
				document.getElementById('incSetAmt3').innerHTML = Number(res.incSetAmt).toLocaleString();
				document.getElementById('incSetDedt3').innerHTML = Number(res.incSetDedt).toLocaleString();
			}
		});
	});
});
</script>