<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="row">
	<div>
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-2 text-center">
	                    <div class="position-relative d-inline-block mx-auto pt-3">
	                        <div class="avatar-xl">
								<img src="${pageContext.request.contextPath}${emp.empProfile}" alt="프로필이미지" id="profile" class="rounded-circle avatar-xl">
	                        </div>
	                    </div>

<!-- 							<div class="filebox avatar-title rounded-circle bg-light text-primary" style="width: 25px; height: 25px; align-self: flex-end;" > -->
<!-- 								<input type="hidden" name="empNo" id="empNo" class="inputfile inputfile-4"> -->
<!-- 								<input type="file" name="libFile" id="libFile" class="inputfile inputfile-4"> -->
<!-- 								<label for="libFile"><i class="mdi mdi-pencil" style="padding-top: 7px;"></i></label> -->
<!-- 							</div> -->
					</div>
					<div class="col-md-3">
						<div class="row">
							<h4 class="card-title">
								<span class="fw-bold px-4 py-2 fs-3">${emp.empName }</span>
							</h4>
						</div>
						<div class="row">
							<span class="fw-bold fs-5">${emp.empDept } <c:if test="${emp.empPos ne '직책 없음' }">${emp.empPos }</c:if></span>
						</div>
						&nbsp; &nbsp;
						<div class="row">
							<div class="gridjs-search">
								<button type="button" class="btn btn-info" onclick="telcopyBtn();">
									<svg id="telcopyBtn" xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-phone-call"><path d="M15.05 5A5 5 0 0 1 19 8.95M15.05 1A9 9 0 0 1 23 8.94m-1 7.98v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
								</button>
								<button type="button" class="btn btn-info" onclick="emailcopyBtn();">
									<svg id="emailcopyBtn" xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-mail"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
								</button>
								<button type="button" class="btn btn-info" id="empStat">
									${emp.empStat }
								</button>
							</div>
						</div>
					</div>
					<div class="col-md-1 ms-auto">
<!-- 						<i class="bx bx-x" id="close"></i> -->
					</div>
				</div>
				&nbsp; &nbsp;
				<ul class="nav nav-tabs nav-tabs-custom" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						data-bs-toggle="tab" href="#home1" role="tab"> <span
							class="d-block d-sm-none"><i class="fas fa-home"></i></span> <span
							class="d-none d-sm-block">인사정보</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
						href="#profile1" role="tab"> <span class="d-block d-sm-none"><i
								class="far fa-user"></i></span> <span class="d-none d-sm-block">개인정보</span>
					</a></li>
					<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
						href="#messages1" role="tab"> <span class="d-block d-sm-none"><i
								class="far fa-envelope"></i></span> <span class="d-none d-sm-block">경력＊학력</span>
					</a></li>
					</sec:authorize>
				</ul>
<%-- 				<c:set value="${empList }" var="emp"/> --%>
				
				<div class="tab-content p-3 text-muted">
					<div class="tab-pane active" id="home1" role="tabpanel">
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">인사정보</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-4">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-6">사번</p>
									<p class="fw-bold px-4 py-2 fs-6">입사일</p>
									<p class="fw-bold px-4 py-2 fs-6">입사유형</p>
									<p class="fw-bold px-4 py-2 fs-6">부서＊직책</p>
									<p class="fw-bold px-4 py-2 fs-6">직위</p>
									<p class="fw-bold px-4 py-2 fs-6">직급</p>
								</div>
							</div>
							<div class="col-md-4">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-6">${emp.empNo }</p>
									<p class="fw-bold px-4 py-2 fs-6"><fmt:formatDate value="${emp.empDate }" pattern="yyyy-MM-dd"/></p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empStat }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empDept }<c:if test="${emp.empPos ne '직책 없음' }">＊${emp.empPos }</c:if></p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empJob }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empRank }</p>
								</div>
							</div>
							<div class="col-md-3">
							<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
								<div style="padding: 30px;">
									<div class="card border border-2" style="max-width: 18rem;" id="workBtn1">
									  <div class="card-header"><b>근무시간</b></div>
									  <div class="card-body text-secondary">
									    <h5 class="card-title" align="right"><b>24시간</b></h5>
									  </div>
									</div>
									<div class="card border border-2" style="max-width: 18rem;" id="vacationBtn1">
									  <div class="card-header"><b>남은 연차</b></div>
									  <div class="card-body text-secondary">
									    <h5 class="card-title" align="right"><b>3일</b></h5>
									  </div>
									</div>
								</div>
								</sec:authorize>
							</div>
						</div>
					</div>
					<!-- work modal start -->
					<div id="workModal1" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="myExtraLargeModalLabel"><b>나의 근무시간</b></h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
								
								</div>
							</div>
						</div>
					</div>
					<!-- work modal end -->
					<!-- vacation modal start -->
					<div id="vacationModal1" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="myExtraLargeModalLabel"><b>나의 휴가</b></h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
								
								</div>
							</div>
						</div>
					</div>
					<!-- vacation modal end -->
					<div class="tab-pane" id="profile1" role="tabpanel">
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">개인정보</span>
							</div>
							<div class="col-md-1">
								<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
									<div class="row icon-demo-content">
										<div class=" col-xl-3 col-lg-4 col-sm-6">
											<i class="uil-pen" data-bs-toggle="modal" data-bs-target="#infoModify"></i>
										</div>
									</div>
								</sec:authorize>
							</div>
						</div>
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-4">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-6">이름</p>
									<p class="fw-bold px-4 py-2 fs-6">영문이름</p>
									<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
									<p class="fw-bold px-4 py-2 fs-6">연락처</p>
									<p class="fw-bold px-4 py-2 fs-6">이메일</p>
									<p class="fw-bold px-4 py-2 fs-6">주소</p>
								</div>
							</div>
							<div class="col-md-4">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-6">${emp.empName }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empEname }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empReg1 }-*******</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empTel }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empEmail }</p>
									<p class="fw-bold px-4 py-2 fs-6">${emp.empAddr1 }
										${emp.empAddr2 }</p>
								</div>
							</div>
							<div class="col-md-1 ms-auto">
							</div>
							<div class="col-md-3">
							</div>
						</div>
						<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">가족정보</span>
							</div>
							<div class="col-md-1">
								<div class="row icon-demo-content">
									<div class=" col-xl-3 col-lg-4 col-sm-6">
										<i class="uil-plus" data-bs-toggle="modal" data-bs-target="#famRegister"></i>
									</div>
								</div>
							</div>
						</div>
						<c:choose>
							<c:when test="${empty emp.famList}">
								<div class="row" id="noFamInfo">
									<div class="col-md-1">
									</div>
									<div class="col-md-8">
										<div style="padding: 30px;">
											<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${emp.famList }" var="empfam">
									<div class="row" id="famInfo">
										<div class="col-md-1">
										</div>
										<div class="col-md-4">
											<div style="padding: 30px;">
												<p class="fw-bold px-4 py-2 fs-6">이름</p>
												<p class="fw-bold px-4 py-2 fs-6">관계</p>
												<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
												<p class="fw-bold px-4 py-2 fs-6">연락처</p>
											</div>
										</div>
										<div class="col-md-4">
											<div style="padding: 30px;">
												<p class="fw-bold px-4 py-2 fs-6">${empfam.efName }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empfam.efRelation }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empfam.efReg1 }-${empfam.efReg2 }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empfam.efPhone }</p>
											</div>
										</div>
										<div class="col-md-1">
										<div class="row">
											<div class="icon-demo-content">
												<div class="col-xl-3 col-lg-4 col-sm-6">
													<i class="uil-pen" data-bs-toggle="modal" data-bs-target="#modifyfam${empfam.efNo }"></i>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="icon-demo-content">
												<div class="col-xl-3 col-lg-4 col-sm-6">
													<i class="bx bx-x" onclick="fn_delFam(${empfam.efNo})" data-bs-toggle="modal" data-bs-target="#deleteFam${empfam.efNo }"></i>
												</div>
											</div>
										</div>
										</div>
									</div>
									<form action="/mypage/famModify" method="post" id="famModifyForm${empfam.efNo }">
										<input type="hidden" value="${empfam.efNo }" name="efNo">
										<input type="hidden" value="${emp.empNo }" name="empNo">
										<div id="modifyfam${empfam.efNo }" class="modal fade bs-example-modal-center"
											role="dialog" tabindex="-1" aria-labelledby="myModalLabel"
											style="display: none;" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title">가족정보 수정</h5>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														<div class="row align-items-center">
															<div class="row">
																<div class="col-md-4 text-center">
																	<p class="fw-bold px-4 py-2 fs-6">이름</p>
																</div>
																<div class="col-md-5">
																	<input class="form-control" value="${empfam.efName }" type="text" name="efName"
																		placeholder="이름">
																</div>
															</div>
															<div class="row">
																<div class="col-md-4 text-center">
																	<p class="fw-bold px-4 py-2 fs-6">관계</p>
																</div>
																<div class="col-md-4">
																	<select name="efRelation" class="form-select">
																		<option value="부" <c:if test="${empfam.efRelation eq '부' }">selected</c:if>>부</option>
																		<option value="모" <c:if test="${empfam.efRelation eq '모' }">selected</c:if>>모</option>
																		<option value="형" <c:if test="${empfam.efRelation eq '형' }">selected</c:if>>형</option>
																	</select>
																</div>
															</div>
															<div class="row">
																<div class="col-md-4 text-center">
																	<p class="fw-bold px-4 py-2 fs-6">연락처</p>
																</div>
																<div class="col-md-5">
																	<input class="form-control" type="text" name="efPhone" value="${empfam.efPhone }"
																		placeholder="연락처">
																</div>
															</div>
															<div class="row">
																<div class="col-md-4 text-center">
																	<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
																</div>
																<div class="col-md-4">
																	<input class="form-control" type="text" name="efReg1" value="${empfam.efReg1 }"
																		placeholder="앞자리(6자리)">
																</div>
																<div class="col-md-4">
																	<input class="form-control" type="text" name="efReg2" value="${empfam.efReg2 }"
																		placeholder="뒷자리(7자리)">
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-light"
															data-bs-dismiss="modal">취소</button>
														<button type="button" class="btn btn-primary"
															id="famModifyBtn${empfam.efNo }">수정</button>
													</div>
												</div>
											</div>
										</div>
										<sec:csrfInput/>
									</form>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</sec:authorize>
					</div>
					<sec:authorize access="hasAnyRole('ROLE_MANAGER','ROLE_ADMIN')">
					<div class="tab-pane" id="messages1" role="tabpanel">
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">경력정보</span>
							</div>
							<div class="col-md-1">
								<div class="row icon-demo-content">
									<div class=" col-xl-3 col-lg-4 col-sm-6">
										<i class="uil-plus" data-bs-toggle="modal" data-bs-target="#carrRegister"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
								<c:choose>
									<c:when test="${empty emp.carrList }">
										<div class="row" id="noCarrInfo">
											<div class="col-md-1">
											</div>
											<div class="col-md-8">
												<div style="padding: 30px;">
													<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${emp.carrList }" var="empCarr">
											<div class="row" id="carrInfo">
												<div class="col-md-1">
												</div>
												<div class="col-md-4">
													<div style="padding: 30px;">
														<p class="fw-bold px-4 py-2 fs-6">회사명</p>
														<p class="fw-bold px-4 py-2 fs-6">회사분류</p>
														<p class="fw-bold px-4 py-2 fs-6">계약유형</p>
														<p class="fw-bold px-4 py-2 fs-6">입사일자</p>
														<p class="fw-bold px-4 py-2 fs-6">퇴사일자</p>
														<p class="fw-bold px-4 py-2 fs-6">부서</p>
														<p class="fw-bold px-4 py-2 fs-6">직책</p>
														<p class="fw-bold px-4 py-2 fs-6">직위</p>
													</div>
												</div>
												<div class="col-md-4">
													<div style="padding: 30px;">
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caComName }</p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caClf }</p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caType }</p>
														<p class="fw-bold px-4 py-2 fs-6"><fmt:formatDate value="${empCarr.caEntDate }" pattern="yyyy-MM-dd"/></p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caEndDate }</p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caDept }</p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caDut }</p>
														<p class="fw-bold px-4 py-2 fs-6">${empCarr.caPos }</p>
													</div>
												</div>
												<div class="col-md-1 ms-auto">
												<div class="row">
													<div class="icon-demo-content">
														<div class="col-xl-3 col-lg-4 col-sm-6">
															<i class="uil-pen" data-bs-toggle="modal" data-bs-target="#carrModfy${empCarr.caNo }"></i>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="icon-demo-content">
														<div class="col-xl-3 col-lg-4 col-sm-6">
															<i class="bx bx-x" onclick="fn_delCarr(${empCarr.caNo })"></i>
														</div>
													</div>
												</div>
												</div>
												<div class="col-md-3">
													<div class="card"></div>
												</div>
											</div>
											<!-- 경력정보 수정 modal 시작 -->
											<form action="/mypage/carrModify" method="post" id="carrModifyForm${empCarr.caNo }">
												<input type="hidden" value="${empCarr.caNo }" name="caNo"/>
												<input type="hidden" value="${emp.empNo }" name="empNo"/>
												<div id="carrModify${empCarr.caNo}"
													class="modal fade bs-example-modal-center" role="dialog"
													tabindex="-1" aria-labelledby="myModalLabel"
													style="display: none;" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title">경력정보 수정</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">
																<div class="row align-items-center">
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">회사이름</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="text" name="efName" value="${empCarr.caComName }"
																				placeholder="회사이름">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">회사분류</p>
																		</div>
																		<div class="col-md-4">
																			<input class="form-control" type="text" value="${empCarr.caClf }"
																				name="efRelation" placeholder="회사분류">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">근로유형</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="text" name="efPhone" value="${empCarr.caType }"
																				placeholder="근로유형">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">입사일자</p>
																		</div>
																		<div class="col-md-4">
																			<input class="form-control" type="date" name="efReg1" value="<fmt:formatDate value='${empCarr.caEntDate }' pattern='yyyy-MM-dd'/>"/>
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">퇴사일자</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="date" name="efPhone" value="<fmt:formatDate value='${empCarr.caEndDate }' pattern='yyyy-MM-dd'/>"/>
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">부서</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="text" name="efPhone" value="${empCarr.caDept }"
																				placeholder="부서">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">직책</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="text" name="efPhone" value="${empCarr.caDut }"
																				placeholder="직책">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col-md-4 text-center">
																			<p class="fw-bold px-4 py-2 fs-6">직급</p>
																		</div>
																		<div class="col-md-5">
																			<input class="form-control" type="text" name="efPhone" value="${empCarr.caPos }"
																				placeholder="직급">
																		</div>
																	</div>
																</div>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-light"
																	data-bs-dismiss="modal">취소</button>
																<button type="button" class="btn btn-primary"
																	id="carrModifyBtn${empCarr.caNo }">수정</button>
															</div>
														</div>
													</div>
												</div>
												<sec:csrfInput/>
											</form>
											<!-- 경력정보 수정 modal 끝 -->
										</c:forEach>
									</c:otherwise>
								</c:choose>
						</div>
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">학력</span>
							</div>
							<div class="col-md-1">
								<div class="row icon-demo-content">
									<div class=" col-xl-3 col-lg-4 col-sm-6">
										<i class="uil-plus" data-bs-toggle="modal" data-bs-target="#acadRegister"></i>
									</div>
								</div>
							</div>
						</div>
							<c:choose>
								<c:when test="${empty emp.acadList }">
									<div class="row" id="noAcadInfo">
										<div class="col-md-1">
										</div>
										<div class="col-md-8">
											<div style="padding: 30px;">
												<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
											</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${emp.acadList }" var="empAcad">
									<div class="row" id="acadInfo">
										<div class="col-md-4">
											<div style="padding: 30px;">
												<p class="fw-bold px-4 py-2 fs-6">학교명</p>
												<p class="fw-bold px-4 py-2 fs-6">학교구분</p>
												<p class="fw-bold px-4 py-2 fs-6">입학일자</p>
												<p class="fw-bold px-4 py-2 fs-6">졸업일자</p>
												<p class="fw-bold px-4 py-2 fs-6">졸업구분</p>
												<p class="fw-bold px-4 py-2 fs-6">전공</p>
											</div>
										</div>
										<div class="col-md-4">
											<div style="padding: 30px;">
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadName }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadClf }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadEntDate }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadEndDate }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadStat }</p>
												<p class="fw-bold px-4 py-2 fs-6">${empAcad.acadMaj }</p>
											</div>
										</div>
										<div class="col-md-1 ms-auto">
										<div class="row">
											<div class="icon-demo-content">
												<div class="col-xl-3 col-lg-4 col-sm-6">
													<i class="uil-pen" data-bs-toggle="modal" data-bs-target="#acadModify${empAcad.acadNo }"></i>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="icon-demo-content">
												<div class="col-xl-3 col-lg-4 col-sm-6">
													<i class="bx bx-x" onclick="fn_delAcad(${empAcad.acadNo })"></i>
												</div>
											</div>
										</div>
										</div>
										<div class="col-md-3">
										</div>
									</div>
									<!-- 학력 수정 modal 시작 -->
										<form action="/mypage/acadModify" method="post" id="acadModifyForm${empAcad.acadNo }">
											<input type="hidden" value="${empAcad.acadNo }" name="acadNo"/>
											<input type="hidden" value="${emp.empNo }" name="empNo"/>
											<div id="acadModify${empAcad.acadNo }" class="modal fade bs-example-modal-lg"
												role="dialog" tabindex="-1" aria-labelledby="myModalLabel"
												style="display: none;" aria-hidden="true">
												<div class="modal-dialog modal-dialog-centered">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">학력정보 수정</h5>
															<button type="button" class="btn-close"
																data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															<div class="row align-items-center">
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">학교구분</p>
																	</div>
																	<div class="col-md-5">
																		<input class="form-control" type="text"
																			value="${empAcad.acadClf }" name="acadClf"
																			placeholder="학교구분">
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">학교이름</p>
																	</div>
																	<div class="col-md-5">
																		<input class="form-control" type="text"
																			value="${empAcad.acadName }" name="acadName"
																			placeholder="학교이름">
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">입학일자</p>
																	</div>
																	<div class="col-md-4">
																		<input class="form-control" type="date" value="<fmt:formatDate value='${empAcad.acadEntDate }' pattern='yyyy-MM-dd'/>" name="acadEntDate"/>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">졸업일자</p>
																	</div>
																	<div class="col-md-5">
																		<input class="form-control" type="date"value="<fmt:formatDate value='${empAcad.acadEndDate }' pattern='yyyy-MM-dd'/>" name="acadEndDate"/>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">졸업여부</p>
																	</div>
																	<div class="col-md-6">
																		<input class="form-control" type="text"
																			value="${empAcad.acadStat }" name="acadStat"
																			placeholder="졸업여부">
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-4 text-center">
																		<p class="fw-bold px-4 py-2 fs-6">전공</p>
																	</div>
																	<div class="col-md-8">
																		<input class="form-control" type="text"
																			value="${empAcad.acadMaj }" name="acadMaj"
																			placeholder="전공">
																	</div>
																</div>
															</div>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-light"
																data-bs-dismiss="modal">취소</button>
															<button type="button" class="btn btn-primary" onclick="fn_acadmod('${empAcad.acadNo}')"
																id="acadModifyBtn${empAcad.acadNo }">수정</button>
														</div>
													</div>
												</div>
											</div>
											<sec:csrfInput/>
										</form>
										<!-- 학력 수정 modal 끝 -->
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<!-- work modal start -->
						<div id="workModal3" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="myExtraLargeModalLabel"><b>나의 근무시간</b></h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
									
									</div>
								</div>
							</div>
						</div>
						<!-- work modal end -->
						<!-- vacation modal start -->
						<div id="vacationModal3" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="myExtraLargeModalLabel"><b>나의 휴가</b></h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
									
									</div>
								</div>
							</div>
						</div>
						<!-- vacation modal end -->
						<!-- pay modal start -->
						<div id="payModal3" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="myExtraLargeModalLabel"><b>나의 급여</b></h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
									
									</div>
								</div>
							</div>
						</div>
						<!-- pay modal end -->
					</div>
					</sec:authorize>
				</div>
				<!-- 개인정보 수정 modal 시작 -->
				<form action="/mypage/infoModify" method="post" id="infoModifyForm">
					<input type="hidden" value="${emp.empNo }">
					<div id="infoModify" class="modal fade bs-example-modal-lg" role="dialog" tabindex="-1" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title">개인정보 수정</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					                </button>
					            </div>
					            <div class="modal-body">
						            <div class="row align-items-center">
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">이름</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" value="${emp.empName }" name="empName" placeholder="이름">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">영문이름</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" value="${emp.empEname }" name="empEname" placeholder="영문이름">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" value="${emp.empReg1 }" name="empReg1" placeholder="앞자리(6자리)">
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" value="${emp.empReg2 }" name="empReg2" placeholder="뒷자리(7자리)">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">연락처</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" value="${emp.empTel }" name="empTel" placeholder="연락처">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">이메일</p>
								            </div>
								            <div class="col-md-6">
								            	<input class="form-control" type="text" value="${emp.empEmail }" name="empEmail" placeholder="이메일">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">주소</p>
								            </div>
								            <div class="col-md-8">
								            	<input class="form-control" type="text" value="${emp.empAddr1 }" name="empAddr1" placeholder="주소">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">상세주소</p>
								            </div>
								            <div class="col-md-8">
								            	<input class="form-control" type="text" value="${emp.empAddr2 }" name="empAddr2" placeholder="상세주소">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">급여계좌</p>
								            </div>
								            <div class="col-md-3">
								            <select name="empBank" class="form-select">
								            	<option value="국민" <c:if test="${emp.empBank eq '국민' }">selected</c:if>>국민은행</option>
								            	<option value="농협" <c:if test="${emp.empBank eq '농협' }">selected</c:if>>농협은행</option>
								            	<option value="우리" <c:if test="${emp.empBank eq '우리' }">selected</c:if>>우리은행</option>
								            	<option value="기업" <c:if test="${emp.empBank eq '기업' }">selected</c:if>>IBK기업은행</option>
								            	<option value="신한" <c:if test="${emp.empBank eq '신한' }">selected</c:if>>신한은행</option>
								            </select>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" value="${emp.empAcct }" name="empAcct" placeholder="계좌번호">
								            </div>
							            </div>
						            </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="infoModifyBtn">수정</button>
					            </div>
					        </div>
					    </div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 개인정보 수정 modal 끝 -->
				<!-- 가족정보 추가 modal 시작 -->
				<form action="/mypage/famRegister" method="post" id="famRegisterForm">
					<input type="hidden" value="${emp.empNo }" id="famRegisterNo" name="empNo"/>
					<div id="famRegister" class="modal fade bs-example-modal-center"
						role="dialog" tabindex="-1" aria-labelledby="myModalLabel"
						style="display: none;" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">가족정보 추가</h5>
									<button type="button" class="btn-close"
										data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="row align-items-center">
										<div class="row">
											<div class="col-md-4 text-center">
												<p class="fw-bold px-4 py-2 fs-6">이름</p>
											</div>
											<div class="col-md-5">
												<input class="form-control" type="text" id="efName" name="efName"
													placeholder="이름">
											</div>
										</div>
										<div class="row">
											<div class="col-md-4 text-center">
												<p class="fw-bold px-4 py-2 fs-6">관계</p>
											</div>
											<div class="col-md-4">
												<select name="efRelation" id="efRelation" class="form-select">
													<option value="부" <c:if test="${efRelation eq '부' }">selected</c:if>>부</option>
													<option value="모" <c:if test="${efRelation eq '모' }">selected</c:if>>모</option>
													<option value="형" <c:if test="${efRelation eq '형' }">selected</c:if>>형</option>
												</select>
											</div>
										</div>
										<div class="row">
											<div class="col-md-4 text-center">
												<p class="fw-bold px-4 py-2 fs-6">연락처</p>
											</div>
											<div class="col-md-5">
												<input class="form-control" type="text" id="efPhone" name="efPhone" placeholder="연락처">
											</div>
										</div>
										<div class="row">
											<div class="col-md-4 text-center">
												<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
											</div>
											<div class="col-md-4">
												<input class="form-control" type="text" id="efReg1" name="efReg1" placeholder="앞자리(6자리)">
											</div>
											<div class="col-md-4">
												<input class="form-control" type="text" id="efReg2" name="efReg2" placeholder="뒷자리(7자리)">
											</div>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">취소</button>
									<button type="button" class="btn btn-primary"
										id="famRegisterBtn">추가</button>
								</div>
							</div>
						</div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 가족정보 추가 modal 끝 -->
				<!-- 경력정보 추가 modal 시작 -->
				<form action="/mypage/carrRegister" method="post" id="carrRegisterForm">
					<input type="hidden" value="${emp.empNo }" id="carrRegisterNo" name="empNo"/>
					<div id="carrRegister" class="modal fade bs-example-modal-center" role="dialog" tabindex="-1" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title">경력정보 추가</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					                </button>
					            </div>
					            <div class="modal-body">
						            <div class="row align-items-center">
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">회사이름</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" id="caComName" name="caComName" placeholder="회사이름">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">회사구분</p>
								            </div>
								            <div class="col-md-4">
								            	<select name="caClf" id="caClf" class="form-select">
								            	<option value="중소기업">중소기업</option>
								            	<option value="중견기업">중견기업</option>
								            	<option value="대기업">대기업</option>
								            	<option value="기타">기타</option>
								            </select>
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">근로유형</p>
								            </div>
								            <div class="col-md-5">
								            	<select name="caType" id="caType" class="form-select">
								            	<option value="정규직">정규직</option>
								            	<option value="계약직">계약직</option>
								            </select>
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">입사일자</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" id="caEntDate" type="date" name="caEntDate">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">퇴사일자</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" id="caEndDate" type="date" name="caEndDate" >
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">부서</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" id="caDept" type="text" name="caDept" placeholder="부서">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">직책</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" id="caDut" name="caDut" placeholder="직책">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">직위</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" id="caPos" name="caPos" placeholder="직위">
								            </div>
							            </div>
						            </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="carrRegisterBtn">추가</button>
					            </div>
					        </div>
					    </div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 경력정보 추가 modal 끝 -->
				<!-- 학력정보 추가 modal 시작 -->
				<form action="/mypage/acadRegister" method="post" id="acadRegisterForm">
					<input type="hidden" value="${emp.empNo }" id="acadRegisterNo" name="empNo">
					<div id="acadRegister" class="modal fade bs-example-modal-center" role="dialog" tabindex="-1" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title">학력정보 추가</h5>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
					                </button>
					            </div>
					            <div class="modal-body">
						            <div class="row align-items-center">
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">학교구분</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" id="acadClf" name="acadClf" placeholder="학교구분">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">학교명</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" id="acadName" name="acadName" placeholder="학교명">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">입학일자</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="date" id="acadEntDate" name="acadEntDate"/>
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">졸업일자</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="date" id="acadEndDate" name="acadEndDate"/>
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">졸업여부</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" id="acadStat" name="acadStat" placeholder="졸업여부">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">전공</p>
								            </div>
								            <div class="col-md-4">
								            	<input class="form-control" type="text" id="acadMaj" name="acadMaj" placeholder="전공">
								            </div>
							            </div>
						            </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="acadRegisterBtn">추가</button>
					            </div>
					        </div>
					    </div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 학력정보 추가 modal 끝 -->
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function telcopyBtn() {
	var copyText = document.createElement("textarea");
	var empTel = "${emp.empTel}"; 
	document.body.appendChild(copyText);
	copyText.value = empTel;
	copyText.select();
	document.execCommand('copy');
	document.body.removeChild(copyText);
	alert(copyText.value + '\n전화번호 복사 완료!');
}

function emailcopyBtn() {
	var copyText = document.createElement("textarea");
	var empEmail = "${emp.empEmail}"; 
	document.body.appendChild(copyText);
	copyText.value = empEmail;
	copyText.select();
	document.execCommand('copy');
	document.body.removeChild(copyText);
	alert(copyText.value + '\n이메일 주소 복사 완료!');
}

$("#workBtn1").on("click", function() {
	//alert("보이나...?");
	$("#workModal1").modal("show");
			
});
$("#vacationBtn1").on("click", function() {
	//alert("보이나...?");
	$("#vacationModal1").modal("show");
			
});

$("#workBtn2").on("click", function() {
	//alert("보이나...?");
	$("#workModal2").modal("show");
			
});
$("#vacationBtn2").on("click", function() {
	//alert("보이나...?");
	$("#vacationModal2").modal("show");
			
});
$("#payBtn2").on("click", function() {
	//alert("보이나...?");
	$("#payModal2").modal("show");
			
});

$("#workBtn3").on("click", function() {
	//alert("보이나...?");
	$("#workModal3").modal("show");
			
});
$("#vacationBtn3").on("click", function() {
	//alert("보이나...?");
	$("#vacationModal3").modal("show");
			
});
$("#payBtn3").on("click", function() {
	//alert("보이나...?");
	$("#payModal3").modal("show");
			
});

$(function(){
	
	// 가족정보 추가
	var famRegisterForm = $("#famRegisterForm");
	var famRegisterBtn = $("#famRegisterBtn");
	
	famRegisterBtn.on("click", function(){
		
		var data = {
			empTel : famRegisterForm.find("#telcopyBtn").val(),
			empEmail : famRegisterForm.find("#emailcopyBtn").val(),
			empStat : famRegisterForm.find("#empStat").val(),
			empNo : famRegisterForm.find("#famRegisterNo").val(),
			efName : famRegisterForm.find("#efName").val(),
			efRelation : famRegisterForm.find("#efRelation").val(),
			efPhone : famRegisterForm.find("#efPhone").val(),
			efReg1 : famRegisterForm.find("#efReg1").val(),
			efReg2 : famRegisterForm.find("#efReg2").val()
		};
		
		$.ajax({
			
			type : "post",
			url : "/mypage/famRegister?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				
				var html = "";
				
				html += "<div class='row' id='famInfo"+result.efNo+"'>";
				html += "<div class='col-md-1'>";
				html += "</div>";
				html += "<div class='col-md-4'>";
				html += "<div style='padding: 30px;'>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>이름</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>관계</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>주민등록번호</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>연락처</p>";
				html += "</div>";
				html += "</div>";
				html += "<div class='col-md-4'>";
				html += "<div style='padding: 30px;'>";
				html += "<p class='fw-bold px-4 py-2 fs-6' id='efName"+result.efNo+"'>"+result.efName +"</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6' id='efRelation"+result.efNo+"'>"+result.efRelation +"</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6' id='efReg"+result.efNo+"'>"+result.efReg1+"-"+result.efReg2+"</p>";
				html += "<p class='fw-bold px-4 py-2 fs-6' id='efPhone"+result.efNo+"'>"+result.efPhone+"</p>";
				html += "</div>";
				html += "</div>";
				html += "<div class='col-md-1'>";
				html += "<div class='row'>";
				html += "<div class='icon-demo-content'>";
				html += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				html += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#modifyfam"+result.efNo+"'></i>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "<div class='row'>";
				html += "<div class='icon-demo-content'>";
				html += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				html += "<i id='' class='bx bx-x' onclick=\"fn_famDel('"+result.efNo+"')\"></i>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "<div class='col-md-3'></div>";
				html += "</div>";
				html += "<form action='/mypage/famModify' method='post' id='famModifyForm"+result.efNo+"'>";
				html += "<input type='hidden' value='"+result.efNo+"' id='efNo' name='efNo'>";
				html += "<input type='hidden' value='"+result.empNo+"' name='empNo' id='empNo'>";
				html += "<div id='modifyfam"+result.efNo+"' class='modal fade bs-example-modal-center' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
				html += "<div class='modal-dialog modal-dialog-centered'>";
				html += "<div class='modal-content'>";
				html += "<div class='modal-header'>";
				html += "<h5 class='modal-title'>가족정보 수정</h5>";
				html += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>";
				html += "</div>";
				html += "<div class='modal-body'>";
				html += "<div class='row align-items-center'>";
				html += "<div class='row'>";
				html += "<div class='col-md-4 text-center'>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>이름</p>";
				html += "</div>";
				html += "<div class='col-md-5'>";
				html += "<input class='form-control' id='efName' value='"+result.efName+"' type='text' name='efName' placeholder='이름'>";
				html += "</div>";
				html += "</div>";
				html += "<div class='row'>";
				html += "<div class='col-md-4 text-center'>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>관계</p>";
				html += "</div>";
				html += "<div class='col-md-4'>";
				html += "<select name='efRelation' id='efRelation' class='form-select'>";
				html += "<option value='부'>부</option>";
				html += "<option value='모'>모</option>";
				html += "<option value='형'>형</option>";
				html += "</select>";
				html += "</div>";
				html += "</div>";
				html += "<div class='row'>";
				html += "<div class='col-md-4 text-center'>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>연락처</p>";
				html += "</div>";
				html += "<div class='col-md-5'>";
				html += "<input class='form-control' id='efPhone' type='text' name='efPhone' value='"+result.efPhone+"' placeholder='연락처'>";
				html += "</div>";
				html += "</div>";
				html += "<div class='row'>";
				html += "<div class='col-md-4 text-center'>";
				html += "<p class='fw-bold px-4 py-2 fs-6'>주민등록번호</p>";
				html += "</div>";
				html += "<div class='col-md-4'>";
				html += "<input class='form-control' id='efReg1' type='text' name='efReg1' value='"+result.efReg1+"' placeholder='앞자리(6자리)'>";
				html += "</div>";
				html += "<div class='col-md-4'>";
				html += "<input class='form-control' id='efReg2' type='text' name='efReg2' value='"+result.efReg2+"' placeholder='뒷자리(7자리)'>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "<div class='modal-footer'>";
				html += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
				html += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_fammod('"+result.efNo+"')\">수정</button>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				$("#famInfo").prepend(html);
				alert("추가가 완료되었습니다!");
				$("#noCarrInfo").css("display","none");
				$("#carrInfo").css("display","block");
			}
		});
	});
	
	
	// 경력정보 추가
	var carrRegisterForm = $("#carrRegisterForm");
	var carrRegisterBtn = $("#carrRegisterBtn");
	
	carrRegisterBtn.on("click", function(){
		var data = {
			empNo : carrRegisterForm.find("#carrRegisterNo").val(),
			caComName : carrRegisterForm.find("#caComName").val(),
			caClf : carrRegisterForm.find("#caClf").val(),
			caType : carrRegisterForm.find("#caType").val(),
			caEntDate : carrRegisterForm.find("#caEntDate").val(),
			caEndDate : carrRegisterForm.find("#caEndDate").val(),
			caDept : carrRegisterForm.find("#caDept").val(),
			caDut : carrRegisterForm.find("#caDut").val(),
			caPos : carrRegisterForm.find("#caPos").val(),
		};
		
		$.ajax({
			
			type : "post",
			url : "/mypage/carrRegister?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				
				var carrhtml = "";
				var carrInfo = "";
				
				carrInfo += "<div class='row' id='carrInfo"+result.caNo+"'>";
				carrInfo += "<div class='col-md-1'>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-4'>";
				carrInfo += "<div style='padding: 30px;'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>회사명</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>회사분류</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>계약유형</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>입사일자</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>퇴사일자</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>부서</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직책</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직위</p>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-4'>";
				carrInfo += "<div style='padding: 30px;'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caComName"+result.caNo+"'>"+result.caComName+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caClf"+result.caNo+"'>"+result.caClf+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caType"+result.caNo+"'>"+result.caType+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caEntDate"+result.caNo+"'>"+result.caEntDate+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caEndDate"+result.caNo+"'>"+result.caEndDate+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caDept"+result.caNo+"'>"+result.caDept+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caDut"+result.caNo+"'>"+result.caDut+"</p>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caPos"+result.caNo+"'>"+result.caPos+"</p>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-1'>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='icon-demo-content'>";
				carrInfo += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				carrInfo += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#carrModify"+result.caNo+"'></i>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='icon-demo-content'>";
				carrInfo += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				carrInfo += "<i class='bx bx-x' onclick=\"fn_carrDel('"+result.caNo+"')\"></i>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<form  method='post' id='carrModifyForm"+result.caNo+"'>";
				carrInfo += "<input type='hidden' value='"+result.caNo+"' id='caNo' name='caNo'/>";
				carrInfo += "<input type='hidden' value='"+result.empNo+"' id='empNo' name='empNo'/>";
				carrInfo += "<div id='carrModify"+result.caNo+"' class='modal fade bs-example-modal-center' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
				carrInfo += "<div class='modal-dialog modal-dialog-centered'>";
				carrInfo += "<div class='modal-content'>";
				carrInfo += "<div class='modal-header'>";
				carrInfo += "<h5 class='modal-title'>경력정보 수정</h5>";
				carrInfo += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>";
				carrInfo += "</div>";
				carrInfo += "<div class='modal-body'>";
				carrInfo += "<div class='row align-items-center'>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>회사이름</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' type='text' id='caComName' value='"+result.caComName+"' name='caComName' placeholder='회사이름'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>회사분류</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-4'>";
				carrInfo += "<input class='form-control' type='text' id='caClf' value='"+result.caClf+"' name='caClf' placeholder='회사분류'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>근로유형</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' type='text' id='caType' value='"+result.caType+"' name='caType' placeholder='근로유형'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>입사일자</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-4'>";
				carrInfo += "<input class='form-control' type='date' id='caEntDate' value='"+result.caEntDate+"' name='caEntDate'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>퇴사일자</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' id='caEndDate' value='"+result.caEndDate+"' type='date' name='caEndDate'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>부서</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' id='caDept' value='"+result.caDept+"' type='text' name='caDept'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직책</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' id='caDut' value='"+result.caDut+"' type='text' name='caDut'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='row'>";
				carrInfo += "<div class='col-md-4 text-center'>";
				carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직급</p>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-5'>";
				carrInfo += "<input class='form-control' id='caPos' value='"+result.caPos+"' type='text' name='caPos'>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "<div class='modal-footer'>";
				carrInfo += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
				carrInfo += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_carrmod('"+result.caNo+"')\">수정</button>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</form>";

				$("#carrInfo").prepend(carrInfo);
				alert("추가가 완료되었습니다!");
				$("#noCarrInfo").css("display","none");
				$("#carrInfo").css("display","block");
				$("#carrInfo").show();

			}
		});
// 		carrRegisterForm.submit();
	});
	
	
	// 학력정보 추가
	var acadRegisterForm = $("#acadRegisterForm");
	var acadRegisterBtn = $("#acadRegisterBtn");
	
	acadRegisterBtn.on("click", function(){
		var data = {
			empNo : acadRegisterForm.find("#acadRegisterNo").val(),
			acadClf : acadRegisterForm.find("#acadClf").val(),
			acadName : acadRegisterForm.find("#acadName").val(),
			acadEntDate : acadRegisterForm.find("#acadEntDate").val(),
			acadEndDate : acadRegisterForm.find("#acadEndDate").val(),
			acadStat : acadRegisterForm.find("#acadStat").val(),
			acadMaj : acadRegisterForm.find("#acadMaj").val()
		};
		
		$.ajax({
			
			type : "post",
			url : "/mypage/acadRegister?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				
				var acadHtml = "";
				
				acadHtml += "<div class='row' id='acadInfo"+result.acadNo+"'>";
				acadHtml += "<div class='col-md-1'>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-4'>";
				acadHtml += "<div style='padding: 30px;'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>학교명</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>학교구분</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>입학일자</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업일자</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업구분</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>전공</p>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-4'>";
				acadHtml += "<div style='padding: 30px;'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadName"+result.acadNo+"'>"+result.acadName+"</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadClf"+result.acadNo+"'>"+result.acadClf+"</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadEntDate"+result.acadNo+"'>"+result.acadEntDate+"</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadEndDate"+result.acadNo+"'>"+result.acadEndDate+"</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadStat"+result.acadNo+"'>"+result.acadStat+"</p>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadMaj"+result.acadNo+"'>"+result.acadMaj+"</p>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-1'>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='icon-demo-content'>";
				acadHtml += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				acadHtml += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#acadModify"+result.acadNo+"'></i>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='icon-demo-content'>";
				acadHtml += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
				acadHtml += "<i class='bx bx-x' onclick=\"fn_acadDel('"+result.acadNo+"')\"></i>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-3'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<form method='post' id='acadModifyForm"+result.acadNo+"' novalidate='novalidate'>";
				acadHtml += "<input type='hidden' id='acadNo' value='"+result.acadNo+"' name='acadNo'/>";
				acadHtml += "<input type='hidden' id='empNo' value='"+result.empNo+"' name='empNo'/>";
				acadHtml += "<div id='acadModify"+result.acadNo+"' class='modal fade bs-example-modal-lg' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
				acadHtml += "<div class='modal-dialog modal-dialog-centered'>";
				acadHtml += "<div class='modal-content'>";
				acadHtml += "<div class='modal-header'>";
				acadHtml += "<h5 class='modal-title'>학력정보 수정</h5>";
				acadHtml += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>";
				acadHtml += "</div>";
				acadHtml += "<div class='modal-body'>";
				acadHtml += "<div class='row align-items-center'>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>학교구분</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-5'>";
				acadHtml += "<input class='form-control' type='text' id='acadClf' value='"+result.acadClf+"' name='acadClf' placeholder='학교구분'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>학교이름</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-5'>";
				acadHtml += "<input class='form-control' type='text' id='acadName' value='"+result.acadName+"' name='acadName' placeholder='학교이름'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>입학일자</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-4'>";
				acadHtml += "<input class='form-control' type='date' id='acadEntDate' value='"+result.acadEntDate+"' name='acadEntDate'/>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업일자</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-5'>";
				acadHtml += "<input class='form-control' type='date' id='acadEndDate' value='"+result.acadEndDate+"' name='acadEndDate'/>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업여부</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-6'>";
				acadHtml += "<input class='form-control' type='text' id='acadStat' value='"+result.acadStat+"' name='acadStat' placeholder='졸업여부'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>전공</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-8'>";
				acadHtml += "<input class='form-control' type='text' id='acadMaj' value='"+result.acadMaj+"' name='acadMaj' placeholder='전공'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='modal-footer'>";
				acadHtml += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
				acadHtml += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_acadmod('"+result.acadNo+"')\">수정</button>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</form>";
				
				$("#acadInfo").prepend(acadHtml);
				alert("추가가 완료되었습니다!");
				$("#noAcadInfo").css("display","none");
				$("#acadInfo").css("display","block");
				$("#acadInfo").show();
			}
		});
	});
	
});
	// 가족정보 삭제
	function fn_delFam(efNo){
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "/mypage/famDel?${_csrf.parameterName}=${_csrf.token}",
				data : {efNo : efNo},
				success : function(){
					console.log("성공");
					$("#famInfo"+no).remove();
					$("#famModifyForm"+no).remove();
					if($("#famInfo").length == 0){
//			 			alert("있음");
						$("#noFamInfo").css("display","block");
					}else{
						alert("있음");
					}
				}
			});
		}
	}
	
	// 경력정보 삭제
	function fn_delCarr(caNo){
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "/mypage/carrDel?${_csrf.parameterName}=${_csrf.token}",
				data : {caNo : caNo},
				success : function(){
					console.log("성공");
					$("#carrInfo"+caNo).remove();
					$("#carrModifyForm"+caNo).remove();
					if($("#carrInfo").length == 0){
	// 					alert("있음");
						$("#noCarrInfo").css("display","block");
					}else{
						alert("있음");
					}
				}
			});
		}
	}
	
	// 학력정보 삭제
	function fn_delAcad(acadNo){
		alert(acadNo);
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "/mypage/acadDel?${_csrf.parameterName}=${_csrf.token}",
				data : {acadNo : acadNo},
				success : function(){
					console.log("성공");
					$("#acadInfo"+acadNo).remove();
					$("#acadModifyForm"+acadNo).remove();
					if($("#acadInfo").length == 0){
//			 			alert("있음");
						$("#noAcadInfo").css("display","block");
					}else{
						alert("있음");
						$("#noAcadInfo").css("display","none");
					}
				}
			});
		}
	}
	
	function fn_acadmod(acadNo){
		var modifyForm = $("#acadModifyForm"+acadNo);
		console.log(modifyForm.find("input[name=empNo]").val());
		
		var data = {
			empNo : modifyForm.find("#empNo").val(),
			acadNo : modifyForm.find("#acadNo").val(),
			acadClf : modifyForm.find("#acadClf").val(),
			acadName : modifyForm.find("#acadName").val(),
			acadEntDate : modifyForm.find("#acadEntDate").val(),
			acadEndDate : modifyForm.find("#acadEndDate").val(),
			acadStat : modifyForm.find("#acadStat").val(),
			acadMaj : modifyForm.find("#acadMaj").val()
		};
	
	
		$.ajax({
			type : "post",
			url : "/mypage/acadModify?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				$("#acadName"+acadNo).text(result.acadName);
				$("#acadClf"+acadNo).text(result.acadClf);
				$("#acadEntDate"+acadNo).text(result.acadEntDate);
				$("#acadEndDate"+acadNo).text(result.acadEndDate);
				$("#acadStat"+acadNo).text(result.acadStat);
				$("#acadMaj"+acadNo).text(result.acadMaj);
			}
		});
	}
	
	function fn_fammod(efNo){
		var modifyForm = $("#famModifyForm"+efNo);
		var data = {
				empNo : modifyForm.find("#empNo").val(),
				efNo : modifyForm.find("#efNo").val(),
				efPhone : modifyForm.find("#efPhone").val(),
				efName : modifyForm.find("#efName").val(),
				efRelation : modifyForm.find("#efRelation").val(),
				efReg1 : modifyForm.find("#efReg1").val(),
				efReg2 : modifyForm.find("#efReg2").val()
		};
		
		$.ajax({
			type : "post",
			url : "/mypage/famModify?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				$("#efName"+efNo).text(result.efName);
				$("#efPhone"+efNo).text(result.efPhone);
				$("#efReg"+efNo).text(result.efReg1 + "-" + result.efReg2);
				$("#efRelation"+efNo).text(result.efRelation);
			}
		});
	}
	
	function fn_carrmod(caNo){
		var carrModifyForm = $("#carrModifyForm"+caNo);
		
		var data = {
				empNo : carrModifyForm.find("#empNo").val(),
				caNo : carrModifyForm.find("#caNo").val(),
				caClf : carrModifyForm.find("#caClf").val(),
				caType : carrModifyForm.find("#caType").val(),
				caComName : carrModifyForm.find("#caComName").val(),
				caEntDate : carrModifyForm.find("#caEntDate").val(),
				caEndDate : carrModifyForm.find("#caEndDate").val(),
				caDept : carrModifyForm.find("#caDept").val(),
				caDut : carrModifyForm.find("#caDut").val(),
				caPos : carrModifyForm.find("#caPos").val()
		};
		
		$.ajax({
			type : "post",
			url : "/mypage/carrModify?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				$("#caClf"+caNo).text(result.caClf);
				$("#caType"+caNo).text(result.caType);
				$("#caComName"+caNo).text(result.caComName);
				$("#caEntDate"+caNo).text(result.caEntDate);
				$("#caEndDate"+caNo).text(result.caEndDate);
				$("#caDept"+caNo).text(result.caDept);
				$("#caDut"+caNo).text(result.caDut);
				$("#caPos"+caNo).text(result.caPos);
			}
		});
		
	}
	
</script>