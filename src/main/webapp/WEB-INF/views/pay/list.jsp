<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<!-- end col -->

					<div class="col-md-6">
						<div class="d-flex flex-wrap align-items-start">
							<div class="row d-flex flex-wrap align-items-start" style="text-align: right font-weight: normal; width: 340px;">
								<c:set var="today" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${today}" pattern="MM" var="start" />
									<span style="width: 110px; font-size: 17px; padding-top: 4px;">급여 조회 : </span> 
								<select class="form-select" style="width: 85px;" id="month">
									<c:forEach begin="1" end="5" var="idx" step="1">
										<option value="<c:out value="${start - idx}" />">
											<c:out value="${start - idx}" /> 월
										</option>
									</c:forEach>
								</select>
								<input type="hidden" id="paramMonth"/>
							</span>
						</div>
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->
				
				<div class="tab-content" style="padding-top: 20px;">
					<div class="tab-pane active" id="overview" role="tabpanel">
							<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6">
										<div class="card border shadow-none">
											<div class="card-body">
												<div class="d-flex align-items-center">
													<div class="flex-grow-1 overflow-hidden">
														<div class="row">
															<div class="col-md-6">
																<div class="mb-3">
																	<h4 class="card-title">
																		<h3>
																			<c:set var="today" value="<%=new java.util.Date()%>" />
																			<fmt:formatDate value="${today}" pattern="yyyy년"/>
																			<span id="typedMonth1"></span>
																			 월 급여
																		</h3>
																	</h4>
																</div>
															</div>
															<!-- end col -->

															<div class="col-md-6">
																<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
																	<!-- center modal -->
																</div>
															</div>
															<!-- end col -->
														</div>
														<!-- end row -->
														<div class="d-flex flex-wrap align-items-center justify-content-md-end">
															<div class="row" style="padding-top: 10px;">
																<h4 class="text-truncate d-flex flex-wrap align-items-center justify-content-md-end mb-2 gap-3">
																실 지급액 <span id="incSetRes"></span> 원</h4>
																<h5 class="text-truncate text-muted d-flex flex-wrap align-items-center justify-content-md-end mb-2 gap-3">
																	지급 <span id="incSetAmt" ></span>원<br/>
																</h5>
																<h5 class="text-truncate text-muted d-flex flex-wrap align-items-center justify-content-md-end mb-2 gap-3">
																	공제 <span id="incSetDedt" ></span>원
																</h5>
															</div>
														</div>
													</div>
												</div>
											</div>
											<!-- end card body -->
										</div>
										<!-- end card -->
									</div>
									<!-- end col -->
									<div class="col-md-6">
										<div class="card border shadow-none">
											<div class="card-body">
												<div class="d-flex align-items-center">
													<div class="flex-shrink-0 me-3"></div>

													<div class="flex-grow-1 overflow-hidden">
														<h5 class="text-truncate text-muted d-flex flex-wrap align-items-center mb-2 gap-3">
															<c:set var="today" value="<%=new java.util.Date()%>" />
															<fmt:formatDate value="${today}" pattern="yyyy"/>년 누적 수령액
														</h5>
														<h3 class="text-truncate d-flex flex-wrap align-items-center mb-2 gap-3" style="padding-top: 10px; padding-bottom: 10px;">
														<span id="yearAmt" ></span> 원</h3>
														<hr>
														<!-- 아코디언 시작 -->
														<div class="custom-accordion">
															<a class="text-body fw-medium py-1 d-flex align-items-center collapsed font-size-17" data-bs-toggle="collapse" href="#categories-collapse" role="button" aria-expanded="false" aria-controls="categories-collapse">
																<i class="fas fa-folder text-warning me-2"></i>
																	근로소득 원천징수 영수증
																<i class="mdi mdi-chevron-up accor-down-icon ms-auto"></i>
															</a>
															<div class="collapse" id="categories-collapse" style="">
																<div class="card border-0 shadow-none ps-2 font-size-17 mb-0">
																	<ul class="list-unstyled mb-0">
																		<li>
																			<a href="https://www.nts.go.kr/nts/cm/cntnts/cntntsView.do?mi=6467&cntntsId=7903" class="d-flex align-items-center font-size-14">
																				<span class="me-auto">근로소득 원천징수 영수증 발급하기</span>
																			</a>
																		</li>
																	</ul>
																</div>
															</div>
														</div>
														<!-- 아코디언 끝 -->
													</div>
												</div>
											</div>
										</div>
										<!-- end card body -->
									</div>
									<!-- end card -->
									</div>
								</div>
							</div>
							<!-- end tab pane -->
							<div class="card" style="border-radius: 10px;">
								<div class="card-body" style="border-radius: 10px;">
									<div class="accordion" id="accordionPanelsStayOpenExample" style="background-color: white; border-radius: 5px;">
										<div class="accordion-item">
											<h2 class="accordion-header" id="panelsStayOpen-headingOne">
												<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne" style="color: white; background-color: white;">
													<h5><strong>급여 명세서</strong></h5>
												</button>
											</h2>
											<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne" style="">
												<div class="accordion-body">
													<div class="accordion-body">
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
																	<span id="incSetRes3" ></span> 원
																</div>
															</div>
														</div>
													</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6">
										<div class="mt-3">
											<h5 class="text-truncate text-muted mb-2 gap-3">
												<c:set var="today" value="<%=new java.util.Date()%>"/>
												<fmt:formatDate value="${today}" pattern="yyyy년"/>
												<span id="typedMonth2"></span>
												 월 급여명세서 다운로드
												<button type="button" class="btn btv-light" id="myDetailDownload">
													<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-download icon nav-icon"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
												</button>
											</h5>
										</div>
									</div>
										<!-- end col -->
									<div class="col-md-6">
										<div class="mt-3">
											<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-3 mb-3 font-size-16">
												지급 <span id="incSetAmt2" ></span>   공제 <span id="incSetDedt2" ></span>   <strong>   총지급액 <span id="incSetRes2"></span>원</strong>
											</div>
										</div>
									</div>
								</div>
								<!-- end row -->
							</div>
							
						</div>
						<!-- end card body -->
					</div>
					<!-- end card -->
				</div>
				<!-- end card body -->
			</div>
			<!-- end card -->
		</div>
	</div>
	<!-- end card -->
</div>
<script>
$(function() {
	var incSetRes = ${vo.incSetRes};
	var yearAmt = ${vo.yearAmt};
	var incSetAmt = ${vo.incSetAmt};
	var incSetDedt = ${vo.incSetDedt};
	var gibonPay = ${vo.gibonpay};
	var gitaPay = ${vo.gitapay};
	var jikPay = ${vo.jikpay};
	var sadae = ${vo.sadae};
	var sodeuk = ${vo.sodeuk};
	
	document.getElementById('incSetRes').innerHTML = Number(incSetRes).toLocaleString();
	document.getElementById('incSetRes2').innerHTML = Number(incSetRes).toLocaleString();
	document.getElementById('incSetRes3').innerHTML = Number(incSetRes).toLocaleString();
	document.getElementById('yearAmt').innerHTML = Number(yearAmt).toLocaleString();
	document.getElementById('incSetAmt').innerHTML = Number(incSetAmt).toLocaleString();
	document.getElementById('incSetDedt').innerHTML = Number(incSetDedt).toLocaleString();
	document.getElementById('incSetAmt2').innerHTML = Number(incSetAmt).toLocaleString();
	document.getElementById('incSetDedt2').innerHTML = Number(incSetDedt).toLocaleString();
	document.getElementById('incSetAmt3').innerHTML = Number(incSetAmt).toLocaleString();
	document.getElementById('incSetDedt3').innerHTML = Number(incSetDedt).toLocaleString();
	document.getElementById('gibonPay').innerHTML = Number(gibonPay).toLocaleString();
	document.getElementById('gitaPay').innerHTML = Number(gitaPay).toLocaleString();
	document.getElementById('jikPay').innerHTML = Number(jikPay).toLocaleString();
	document.getElementById('sadae').innerHTML = Number(sadae).toLocaleString();
	document.getElementById('sodeuk').innerHTML = Number(sodeuk).toLocaleString();

	var month = $("#month");
	
	month.on("change", function() {
		var month = $("#month").val();
		var data = {
				month : month
		}
		console.log(data);
		$.ajax({
			type : "POST",
			url : "/pay/list3?${_csrf.parameterName}=${_csrf.token}",
			data :  JSON.stringify(data),
			contentType : "application/json",
			success : function(res) {
// 				console.log("dshfjkdshfkjsdh : "+res.month);
				
				let today = new Date(); 
				let month = today.getMonth() +1;
				console.log("today : "+month);
// 				var jsonStr = JSON.stringify(res);
// 				console.log("asdasd : "+res.gibonpay);
// 				console.log("asdasd : "+res.gitapay);
// 				console.log("asdasd : "+res.jikpay);
// 				console.log(incSetRes+", " +incSetAmt+", "+ incSetDedt);
			
				document.getElementById('incSetRes').innerHTML = Number(res.incSetRes).toLocaleString();
				document.getElementById('incSetRes2').innerHTML = Number(res.incSetRes).toLocaleString();
				document.getElementById('incSetRes3').innerHTML = Number(res.incSetRes).toLocaleString();
// 				document.getElementById('yearAmt').innerHTML = Number(yearAmt).toLocaleString();
				document.getElementById('incSetAmt').innerHTML = Number(res.incSetAmt).toLocaleString();
				document.getElementById('incSetDedt').innerHTML = Number(res.incSetDedt).toLocaleString();
				document.getElementById('incSetAmt2').innerHTML = Number(res.incSetAmt).toLocaleString();
				document.getElementById('incSetDedt2').innerHTML = Number(res.incSetDedt).toLocaleString();
				document.getElementById('incSetAmt3').innerHTML = Number(res.incSetAmt).toLocaleString();
				document.getElementById('incSetDedt3').innerHTML = Number(res.incSetDedt).toLocaleString();
				document.getElementById('gibonPay').innerHTML = Number(res.gibonpay).toLocaleString();
				document.getElementById('gitaPay').innerHTML = Number(res.gitapay).toLocaleString();
				document.getElementById('jikPay').innerHTML = Number(res.jikpay).toLocaleString();
				document.getElementById('sadae').innerHTML = Number(res.sadae).toLocaleString();
				document.getElementById('sodeuk').innerHTML = Number(res.sodeuk).toLocaleString();
				
				fn_setMonth(res.month);
				
			}
		});
	});
	var myDetailDownload = $("#myDetailDownload");
// 	var paramMonth
	myDetailDownload.on("click", function() {
		console.log("@@@ : " + month.val());
		var paramMonth = month.val();
// 		console.log("paramMonth : " + $("#paramMonth").val());
		window.open("myDetailDownload?paramMonth="+paramMonth,"_blank", "fullscreen");

// 		$("#paramMonth").val(month.val());
// 		window.open('', "_blank", "fullscreen");
// 		$("#form").attr("action", "myDetailDownload");
// 		$("#form").attr("target", "_blank");
// 		$("#form").submit();
	});
});
function fn_setMonth(mon){
	if(mon == null){
		let today = new Date();   
		let month = today.getMonth();
		document.getElementById('typedMonth1').innerHTML = month;
		document.getElementById('typedMonth2').innerHTML = month;
	}else{
		document.getElementById('typedMonth1').innerHTML = mon;
		document.getElementById('typedMonth2').innerHTML = mon;
	}
}
window.onload = fn_setMonth(null);
</script>