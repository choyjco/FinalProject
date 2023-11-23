<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<head>
<style>
td {
	word-wrap: break-word;
	text-align: center;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.css" />
</head>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-lg-6">
					<!-- 회사 기본설정시작 -->
						<div class="card" style="background-color: #e6f4fc; border-radius: 10px;">
							<div class="card-body" style="background-color: #e6f4fc; border-radius: 10px;">
								<div class="accordion" id="accordionPanelsStayOpenExample" style="background-color: white; border-radius: 5px;">
									<div class="accordion-item">
										<h2 class="accordion-header" id="panelsStayOpen-headingOne">
											<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
												<i class="uil-building" style="padding-right: 10px;"></i>   
												<strong>회사 기본 정보 설정</strong>
											</button>
										</h2>
										<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne" style="">
											<div class="accordion-body">
												<ul class="list-unstyled mb-0">
													<ul>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightComp" aria-controls="offcanvasRight">회사 정보 설정</a></li>
													</ul>
												</ul>
												
                                    <!-- 회사 정보 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightComp" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>회사 정보</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-pen"> 회사 정보 설정</i>
																<p></p>
																<hr>
																<!-- class=" border-bottom" 사용해도 될듯 -->
															</div>
															<form action="/settings/uploadLogo" id="compForm" method="post" enctype="multipart/form-data">
															<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
																<div class="card" style="padding-bottom: 0px;">
																	<div class="card-body d-flex flex-wrap align-items-center justify-content-md-center" style="padding: 10px;">
																		<table style="width: 85%;">
																			<tr class="d-flex flex-wrap align-items-center justify-content-md-center">
																				<img class="rounded-circle header-profile-user header-item user text-start d-flex flex-wrap align-items-end" id="nowImg" src="/resources/images/about_1.jpg" alt="logo" style="height: 30%; width: 30%;">
																			</tr>
																			<tr>
																				<td style="width: 30%;">회사 로고</td>
																				<td style="width: 70%;">
																				<div class="d-flex flex-wrap align-items-center justify-content-md-center">
																					<input type="file" class="form-control" name="cusLogoFile" id="cusLogo" value="${settings.cusLogo }" placeholder=”이 곳에 이미지 파일을 입력하세요” style="height: 30px; padding-top: 3px;" disabled>
																				</div>
																				</td>
																			</tr>
																			<tr>
																				<td>사업자 등록번호</td>
																				<td>
																					<input type="text" class="form-control" name="cusRnum" id="cusRnum" value="${settings.cusRnum }" readonly="readonly" style="height: 33px;" requ>
																				</td>
																			</tr>
																			<tr>
																				<td>회사명</td>
																				<td>
																					<input type="text" class="form-control" name="cusCom" id="cusCom" value="${settings.cusCom }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>대표자</td>
																				<td>
																					<input type="text" class="form-control" name="cusName" id="cusName" value="${settings.cusName }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>회사 주소</td>
																				<td>
																					<input type="text" class="form-control" name="cusAddr" id="cusAddr" value="${settings.cusAddr }  ${settings.cusAddr2 }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>전화번호</td>
																				<td>
																					<input type="text" class="form-control" name="cusTel" id="cusTel" value="${settings.cusTel }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>이메일</td>
																				<td>
																					<input type="text" class="form-control" name="cusEmail" id="cusEmail" value="${settings.cusEmail }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>회사 설립일</td>
																				<td>
																					<input type="text" class="form-control" name="cusBirth" id="cusBirth" value="${settings.cusBirth }" readonly="readonly" style="height: 33px;">
																				</td>
																			</tr>
																			<tr>
																				<td>사원수</td>
																				<td>
																					<input type="text" class="form-control" name="cusEmp" id="cusEmp" value="${settings.cusEmp }" style="height: 33px;" placeholder="사원수를 입력해주세요." required="required" readonly="readonly">
																				</td>
																			</tr>
																			<tr>
																				<td>회사 직인</td>
																				<td>
																					<input type="file" class="form-control" name="cusSignatureFile" id="cusSignature" value="${settings.cusSignature }" style="height: 30px; padding-top: 3px;" disabled="disabled">
																					<span id="signValiRes"></span>
																				</td>
																			</tr>
																			<tr>
																				<td style="word-break:break-all;">신규회원 기본프로필 이미지</td>
																				<td>
																					<input type="file" class="form-control" name="cusImageFile" id="cusImage" value="${settings.cusImage }" style="height: 30px; padding-top: 3px;" disabled="disabled">
																					<span id="ImgValiRes"></span>
																				</td>
																			</tr>
																		</table>
																	</div>
																</div>
																<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-primary d-flex align-items-end" id="compModifyBtn">수정하기</button>	
																</div>
															</form>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 회사 정보 설정 오른쪽 offCanvas 끝 -->
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
				
				
				
				
					<div class="col-lg-6">
						<!-- 휴가설정시작 -->
						<div class="card" style="background-color: #e6f4fc; border-radius: 10px;">
							<div class="card-body" style="background-color: #e6f4fc; border-radius: 10px;">
								<div class="accordion" id="accordionPanelsStayOpenExample" style="background-color: white; border-radius: 5px;">
									<div class="accordion-item">
										<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
											<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
												<i class="uil-plane-departure" style="padding-right: 10px;"></i>   
												<strong>휴가 설정</strong>
											</button>
										</h2>
										<div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingTwo" style="">
											<div class="accordion-body">
												<ul class="list-unstyled mb-0">
													<ul>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightVac" aria-controls="offcanvasRight">휴가 조회 및 삭제</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightAddVac" aria-controls="offcanvasRight">휴가 추가</a></li>
													</ul>
												</ul>
												
												<!-- 휴가 정보 조회 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightVac" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>휴가 조회</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<form action="" id="HoliForm" method="post">
																<div class="row">
																	<i class="fas fa-folder">  간단히 보기</i>
																	<p></p>
																	<hr>
																	<!-- class=" border-bottom" 사용해도 될듯 -->
																</div>
																<div class="col-md-10 d-flex" style="position: relative; margin: auto;">
																	<p style="text-align: center;">
																		<c:forEach items="${vacList }" var="list">
																			<a role="button" id="${list.vacCode }-prev" class="btn btn-outline-primary" style="margin-top: 5px; margin-bottom: 5px; padding-right: 5px; padding-left: 5px;">
																				${list.vacName }
																			</a>
																		</c:forEach>
																	</p>
																</div>
																<p></p>
																<div class="row">
																	<div class="accordion" id="accordionPanelsStayOpenExample">
																		<div class="accordion-item">
																			<h2 class="accordion-header" id="panelsStayOpen-headingVac">
																				<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseVac" aria-expanded="true" aria-controls="panelsStayOpen-collapseVac">
																					<i class="fas fa-folder-open">  상세 보기</i>
																				</button>
																			</h2>
																		</div>
		  																<div id="panelsStayOpen-collapseVac" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingVac" style="">
																			<div class="accordion-body">
																				<div class="row">
																					<div class="col-md-4">
																						<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
																							<c:forEach items="${vacList }" var="list">
																								<a class="nav-link mb-2" id="v-pills-${list.vacCode }-tab" data-bs-toggle="pill" href="#v-pills-${list.vacCode }" role="tab" aria-controls="v-pills-${list.vacCode }" aria-selected="false" tabindex="-1">${list.vacName }</a>
																							</c:forEach>
																						</div>
																					</div>
																					<div class="col-md-8">
																						<div class="tab-content text-muted mt-4 mt-md-0" id="v-pills-tabContent">
																							<c:forEach items="${vacList }" var="list">
																								<div class="tab-pane fade" id="v-pills-${list.vacCode }" role="tabpanel" aria-labelledby="v-pills-${list.vacCode }-tab">
																									<div class="row" style="padding-top: 40px;">
																										<input type="hidden" name="vacCode" id="vacCode" value="${list.vacCode }">
																									</div>
																									<p>
																										 휴가명  : ${list.vacName }
																									</p>
																									<hr>
																									<p>
																										휴가내용 : ${list.vacCont }
																									</p>
																									<hr>
																									<p>
																										부여일수 : ${list.vacAmt }
																									</p>
																									<hr>
																									<p>
																										급여 지급 여부 : 
																											<c:if test="${list.vacWgPay eq 'Y' }">
																												<c:out value="유급" />
 																											</c:if> 
																											<c:if test="${list.vacWgPay eq 'N' }">
																												<c:out value="무급" />
 																											</c:if> 
																									</p>
																									<hr>
																									<p>
																										증빙자료 여부 : 
																											<c:if test="${list.vacWgPay eq 'Y' }">
																												<c:out value="필요" />
 																											</c:if> 
																											<c:if test="${list.vacWgPay eq 'N' }">
																												<c:out value="불요" />
 																											</c:if> 
																									</p>
																									<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																										<button type="button" id="delVacBtn" class="btn btn-danger d-flex flex-wrap align-items-end justify-content-md-end"  onclick="fn_delVac(${list.vacCode })">삭제</button>
																									</div>
																								</div>
																							</c:forEach>
																						</div>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-light d-flex align-items-end"  data-bs-dismiss="offcanvas" aria-label="Close">닫기</button>
																</div>
															</form>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 휴가 정보 조회 오른쪽 offCanvas 끝 -->
											
											<!-- 휴가 추가 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightAddVac" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>휴가 추가</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<form action="" id="registerHoliForm" method="post">
																<div class="row">
																	<i class="fas fa-pen">  기본 설정</i>
																	<p></p>
																	<hr>
																	<!-- class=" border-bottom" 사용해도 될듯 -->
																</div>
																<div class="row">
																	<input class="form-control" type="text" placeholder="휴가명을 입력하세요." id="vacName" name="vacName" required />
																	<p></p>
																	<textarea class="form-control" placeholder="휴가 정보를 입력하세요." rows="3" id="vacCont" required></textarea>
																	<p></p>
																</div>
																<p></p>
																<div class="row">
																	<i class="fas fa-cog">  상세 설정</i>
																	<p></p>
																	<hr>
																</div>
																<div class="card" style="padding-bottom: 0px;">
																	<div class="card-body">
																		<table style="width: 100%;">
																			<tr>
																				<td width="45%">휴가 부여 일수 및 방법</td>
																				<td width="55%" height="40px;">
<!-- 																					<div class="row" style="position:relative; justify-content: center;"> -->
																						<div class="col-md-12 d-flex flex-wrap align-items-center justify-content-md-center" style="padding-right: 0px; height: 25px;">
																							<input type="text" class="form-control" id="vacAmt" style="height: 25px;" required /> 
																						</div>
<!-- 																					</div> -->
																				</td>
																			</tr>
																			<tr>
																				<td>적용 성별</td>
																				<td style="position:relative; justify-content: center;" height="40px;">
																					<input class="form-check-input" type="checkbox" id="vacGenAll"/>
																					<label class="form-check-label" for="vacGenAll">모두</label>
																					<input class="form-check-input" type="checkbox" id="vacGenM" name="vacGen" />
																					<label class="form-check-label" for="vacGenM">남</label>
																					<input class="form-check-input" type="checkbox" id="vacGenF" name="vacGen" />
																					<label class="form-check-label" for="vacGenF">여</label>
																				</td>
																			</tr>
																			<tr>
																				<td>급여 지급 여부</td>
																				<td style="padding-top: 7px;" height="40px;">
																					<input type="checkbox" id="vacWgPay" switch="bool" />
																					<label for="vacWgPay" data-on-label="유급" data-off-label="무급" class="mb-0"></label>
																				</td>
																			</tr>
																			<tr>
																				<td>증빙자료 여부</td>
																				<td style="padding-top: 6px;" height="40px;">
																					<input type="checkbox" id="vacCert" switch="success" checked="checked"/>
																					<label for="vacCert" data-on-label="필요" data-off-label="불요" class="mb-0"></label>
																				</td>
																			</tr>
																		</table>
																		<p></p>
																		<hr>
																		<textarea class="form-control" placeholder="메모를 입력하세요."></textarea>
																	</div>
																</div>
																<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-light d-flex align-items-end" id="autoHoliBtn">자동완성</button>	
																	<button type="button" class="btn btn-primary d-flex align-items-end" id="registerHoliBtn">저장하기</button>	
																</div>
															</form>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 휴가 추가 오른쪽 offCanvas 끝 -->
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
				</div>
				
				
				
				
				<div class="row">
					<div class="col-lg-6">
					<!-- 인사정보설정시작 -->
						<div class="card" style="background-color: #e6f4fc; border-radius: 10px;">
							<div class="card-body" style="background-color: #e6f4fc; border-radius: 10px;">
								<div class="accordion" id="accordionPanelsStayOpenExample" style="background-color: white; border-radius: 5px;">
									<div class="accordion-item">
										<h2 class="accordion-header" id="panelsStayOpen-headingThree">
											<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree">
												<i class="uil-sitemap" style="padding-right: 10px;"></i>   
												<strong>인사 정보 설정</strong>
											</button>
										</h2>
										<div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingThree" style="">
											<div class="accordion-body">
												<ul class="list-unstyled mb-0">
													<ul>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightTree" aria-controls="offcanvasRight">조직도 설정</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightPos" aria-controls="offcanvasRight">직책 설정</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightRank" aria-controls="offcanvasRight">직급 설정</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightJob" aria-controls="offcanvasRight">직위 설정</a></li>
													</ul>
												</ul>
												
												<!-- 조직도 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightTree" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>내부 조직도</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-pen">  조직도 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="justify-content-between d-flex align-items-center">
																		<h4 class="card-title">
																			<button type="button" id="regBtn" class="btn btn-outline-primary btn-sm">부서 추가</button>
																			<button type="button" id="modBtn" class="btn btn-outline-success btn-sm">부서 이름 변경</button>
																			<button type="button" id="delBtn" class="btn btn-outline-danger btn-sm">부서 삭제</button>
																			<button type="button" id="openBtn" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder-open"></span></button>
																			<button type="button" id="closeBtn" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder"></span></button>
																		</h4>
																	</div>
																	<div></div>
																	<div id="ajax" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="a004" aria-busy="false">
																</div>
			
																</div>
															</div>
															<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																<button class="btn btn-primary d-flex align-items-end" id="saveAjaxBtn">저장하기</button>	
															</div>
														</div>
													</div>
												<!-- offCanvas Body 끝 -->
												</div>
											<!-- 조직도 설정 오른쪽 offCanvas 끝 -->
												<!-- 직책 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightPos" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>내부 직책</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-pen">  직책 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="justify-content-between d-flex align-items-center">
																		<h4 class="card-title">
																			<button type="button" id="regPosBtn" class="btn btn-outline-primary btn-sm">직책 추가</button>
																			<button type="button" id="modPosBtn" class="btn btn-outline-success btn-sm">직책 이름 변경</button>
																			<button type="button" id="delPosBtn" class="btn btn-outline-danger btn-sm">직책 삭제</button>
																			<button type="button" id="openPosBtn" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder-open"></span></button>
																			<button type="button" id="closePosBtn" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder"></span></button>
																		</h4>
																	</div>
																	<div></div>
																	<div id="ajaxPos" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="a004" aria-busy="false">
																</div>
			
																</div>
															</div>
															<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																<button class="btn btn-primary d-flex align-items-end">저장하기</button>	
															</div>
														</div>
													</div>
												<!-- offCanvas Body 끝 -->
												</div>
											<!-- 직책 설정 오른쪽 offCanvas 끝 -->
												<!-- 직급 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightRank" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>내부 직급</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-pen">  직급 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="justify-content-between d-flex align-items-center">
																		<h4 class="card-title">
																			<button type="button" id="regBtnRank" class="btn btn-outline-primary btn-sm">직급 추가</button>
																			<button type="button" id="modBtnRank" class="btn btn-outline-success btn-sm">직급 이름 변경</button>
																			<button type="button" id="delBtnRank" class="btn btn-outline-danger btn-sm">직급 삭제</button>
																			<button type="button" id="openBtnRank" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder-open"></span></button>
																			<button type="button" id="closeBtnRank" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder"></span></button>
																		</h4>
																	</div>
																	<div></div>
																	<div id="ajaxRank" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="a004" aria-busy="false">
																</div>
			
																</div>
															</div>
															<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																<button class="btn btn-primary d-flex align-items-end">저장하기</button>	
															</div>
														</div>
													</div>
												<!-- offCanvas Body 끝 -->
												</div>
											<!-- 직급 설정 오른쪽 offCanvas 끝 -->
												<!-- 직위 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightJob" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>내부 직위</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-pen">  직위 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="justify-content-between d-flex align-items-center">
																		<h4 class="card-title">
																			<button type="button" id="regBtnJob" class="btn btn-outline-primary btn-sm">직위 추가</button>
																			<button type="button" id="modBtnJob" class="btn btn-outline-success btn-sm">직위 이름 변경</button>
																			<button type="button" id="delBtnJob" class="btn btn-outline-danger btn-sm">직위 삭제</button>
																			<button type="button" id="openBtnJob" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder-open"></span></button>
																			<button type="button" id="closeBtnJob" class="btn btn-outline-secondary btn-sm"><span class="fas fa-folder"></span></button>
																		</h4>
																	</div>
																	<div></div>
																	<div id="ajaxJob" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="a004" aria-busy="false">
																</div>
			
																</div>
															</div>
															<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																<button class="btn btn-primary d-flex align-items-end">저장하기</button>	
															</div>
														</div>
													</div>
												<!-- offCanvas Body 끝 -->
												</div>
											<!-- 직위 설정 오른쪽 offCanvas 끝 -->
											
											</div>
										</div>
									</div>
									<!-- end acordian-->
								</div>
								<!-- end acordian-->
							</div>
							<!-- end card body -->
						</div>
						<!-- end card -->
					</div>
					<!-- end col -->
				
				
				
				
					<div class="col-lg-6">
					<!-- 계정설정시작 -->
						<div class="card" style="background-color: #e6f4fc; border-radius: 10px;">
							<div class="card-body" style="background-color: #e6f4fc; border-radius: 10px;">
								<div class="accordion" id="accordionPanelsStayOpenExample" style="background-color: white; border-radius: 5px;">
									<div class="accordion-item">
										<h2 class="accordion-header" id="panelsStayOpen-headingFour">
											<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="true" aria-controls="panelsStayOpen-collapseFour">
												<i class="uil-sitemap" style="padding-right: 10px;"></i>   
												<strong>시스템 관리 설정</strong>
											</button>
										</h2>
										<div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingFour" style="">
											<div class="accordion-body">
												<ul class="list-unstyled mb-0">
													<ul>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightSys" aria-controls="offcanvasRight">기능 / 레벨 조회</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightSetEmp" aria-controls="offcanvasRight" id="selectEmp">직원 계정 관리</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightDefault" aria-controls="offcanvasRight" id="selectDefault">기본 그룹 권한 설정</a></li>
														<li><a href="" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightCustom" aria-controls="offcanvasRight" id="selectCustom">맞춤 그룹 권한 설정</a></li>
													</ul>
												</ul>
												
												<!-- 기능 레벨 조회 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightSys" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>레벨 / 기능 관리</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<form action="" id="MyInfo" method="post">
																<div class="row">
																	<i class="fas fa-medal">  내 레벨</i>
																	<p></p>
																	<hr>
																</div>
																<div class="row">
																<h4>회원님은 현재 <span class="alert alert-primary" style="width: 100px; height: 50px; color: #0380c6; font-size: 20px;">LEVEL 3</span> 입니다.</h4>
																	<p></p>
																</div>
																<p></p>
																<div class="row">
																	<i class="fas fa-list">  현재 내가 사용하는 기능</i>
																	<p></p>
																	<hr>
																</div>
																<div class="card" style="padding-bottom: 0px;">
																	<div class="card-body">
																		<div class="alert alert-primary">
							                                                <i class="uil uil-check me-2">기본 기능 —— 인사관리, 채용관리, 경영관리, 자료실</i>
							                                            </div>
																		<div class="alert alert-warning">
							                                                <i class="uil uil-check me-2">유료 기능 —— 급여 정산</i>
							                                            </div>
																		<div class="alert alert-warning">
							                                                <i class="uil uil-check me-2">유료 기능 —— 휴가 관리</i>
							                                            </div>
																		<div class="alert alert-warning">
							                                                <i class="uil uil-check me-2">유료 기능 —— 문서함</i>
							                                            </div>
																		<div class="alert alert-warning">
							                                                <i class="uil uil-check me-2">유료 기능 —— 인사이트</i>
							                                            </div>
																		<p></p>
																	</div>
																</div>
																<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-light" data-bs-dismiss="offcanvas">닫기</button>	
																</div>
															</form>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 기능 레벨 조회 오른쪽 offCanvas 끝 -->
												
												<!-- 직원 계정 관리 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightSetEmp" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>직원 계정관리</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-cog">  상세 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px; margin-bottom: 5px;">
																<div class="card-body">
																	<input type="hidden" id="settingVO" value="${empList }"/>
																	<div id="grid">
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="d-flex col-md-9 flex-wrap" style="position: relative; margin-top: 0px;">
																	 <form id="frm" method="POST" enctype="multipart/form-data">
																		 <table>
																		 	<tr>
																		 		<td colspan="2" style="font-size: medium; font-weight: bold;"><i class="mdi mdi-arrow-down-bold"></i> 기존 사원 엑셀파일 등록하기 <i class="mdi mdi-arrow-down-bold"></i></td>
																		 	</tr>
																		 	<tr>
																		 		<td width="80%;">
																					<input type="file" class="form-control" id="empListFile" name="empListFile" style="height: 30px; padding-top: 3px;">
																				</td>
																		 		<td width="20%;">
																					<button class="d-flex flex-wrap btn btn-light" type="button" id="uploadBtn">제출</button>
																				</td>
																		 	</tr>
																		</table>
												        			</form>
																</div>
																<div class="d-flex col-md-3 flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-primary d-flex align-items-end" id="empModifyBtn">저장하기</button>	
																</div>
															</div>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 직원 계정 관리 오른쪽 offCanvas 끝 -->
												
												<!-- 기본 그룹 권한 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightDefault" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>기본 그룹 권한 설정</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="row">
																<i class="fas fa-cog">  상세 설정</i>
																<p></p>
																<hr>
															</div>
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="row" style="margin: 0px;">
																		<div class="d-flex flex-wrap alert alert-primary col-md-4" id="role_mem">
							                                                <i class="uil-users-alt"></i> 일반 사원
							                                            </div>
																		<div class="d-flex flex-wrap alert alert-primary col-md-4" id="role_man">
							                                                <i class="uil-user"></i> 중간 관리자
							                                            </div>
																		<div class="d-flex flex-wrap alert alert-primary col-md-4" id="role_adm">
							                                                <i class="uil-user"></i> 최고 관리자
							                                            </div>
																		<div class="col-md-4 d-flex flex-wrap align-items-center justify-content-md-center btn btn-outline-primary" style="text-align: center;">
																			출·퇴근, 기본 기능만<br/>갖춘 일반 사원
							                                            </div>
																		<div class="col-md-4 d-flex flex-wrap align-items-center justify-content-md-center btn btn-outline-primary" style="text-align: center;">
																			급여 및 휴가를<br/>관리하는 부서
							                                            </div>
																		<div class="col-md-4 d-flex flex-wrap align-items-center justify-content-md-center btn btn-outline-primary" style="text-align: center;">
																			회사의 모든 정보를<br/>열람 및 수정 가능
							                                            </div>
																	</div>
																	<p></p>
																	<hr>
																	<input type="hidden" id="settingVO" value="${empList }"/>
																	<div id="gridDefault">
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-light" data-bs-dismiss="offcanvas">닫기</button>
																</div>
															</div>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 기본 그룹 권한 설정 오른쪽 offCanvas 끝 -->
												
												<!-- 맞춤 그룹 권한 설정 오른쪽 offCanvas -->
												<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightCustom" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
													<div class="offcanvas-header">
													  <h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>맞춤 그룹 권한 설정</strong></h3>
													  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
													</div>
													<!-- offCanvas Body -->
													<div class="offcanvas-body" style="padding-top: 0px; padding-bottom: 10px;">
														<!-- 내부 하얗게 주려고 카드바디 사용함 -->
														<div class="card-body" style="background-color: white; border-radius: 5px;">
															<div class="card" style="padding-bottom: 0px;">
																<div class="card-body">
																	<div class="row">
																		<i class="mdi mdi-check-circle-outline" style="width: 22px;"></i>
																		<font size="4" style="width: 400px; font-weight: bold;">현재 설정 가능한 권한</font>
																		<p></p>
																		<hr>
																	</div>
																	<div id="customArray" class="row">
																		<c:forEach items="${selectCustom }" var="role">
																		</c:forEach>
						                                            </div>
																	<p></p>
																	<hr>
																	<form action="" id="registerAuthForm" method="post">
																		<div class="row" style="padding-top: 20px;">
																			<i class="mdi mdi-plus-thick" style="width: 22px;"></i>
																			<font size="4" style="width: 400px; font-weight: bold;">권한 변경하기</font>
																			<p></p>
																			<button class="btn btn-outline-primary" disabled style="margin-bottom: 20px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; font-size: 18px;">
																				특정 부서에 속해있는 구성원 모두의 권한을<br/><strong>일괄</strong>로 변경하고 싶을 때<br/>부서를 선택 후 권한을 눌러주세요.
																			</button>
																			<p></p>
																		</div>
																		<p></p>
																		<div class="row d-flex flex-wrap align-items-center justify-content-md-center">
																			<select class="form-select" style="width:180px; font-size: 17px;" id="empDept">
																				<option>부서</option>
																				<c:forEach items="${deptList }" var="deptList">
																					<option value="${deptList.comName }" id="empDept"> ${deptList.comName }
																					</option>
																				</c:forEach>
																			</select>
																			<i class="mdi mdi-arrow-right-bold d-flex flex-wrap align-items-center justify-content-md-center fa-2x" style="width: 50px;"></i>
																			<select class="form-select" style="width:180px; font-size: 17px;" id="empRole">
																				<option>권한</option>
																				<c:forEach items="${selectCustom }" var="selectCustom">
																					<option value="${selectCustom.empRole }">${selectCustom.empRole }
																					</option>
																				</c:forEach>
																			</select>
																			<p></p>
																		</div>
																		<p></p>
																		<div class="d-flex flex-wrap align-items-end justify-content-md-end">
																			<button type="button" class="btn btn-primary d-flex align-items-end" id="registerAuthBtn">변경하기</button>	
																		</div>
																	</form>
																</div>
															</div>
															<div class="row">
																<div class="d-flex  flex-wrap align-items-end justify-content-md-end">
																	<button type="button" class="btn btn-light d-flex align-items-end" data-bs-dismiss="offcanvas">닫기</button>	
																</div>
															</div>
														</div>
													</div>
													<!-- offCanvas Body 끝 -->
												</div>
												<!-- 맞춤 그룹 권한 설정 오른쪽 offCanvas 끝 -->
												
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- end card body -->
						</div>
						<!-- end card -->
					</div>
					<!-- end row -->
				</div>
				<!-- end row -->
			</div>
			<!-- end card body -->
		</div>
		<!-- end card -->
	</div>
	<!-- end col -->
</div>
<!-- end row -->
<%@include file="script.jsp" %>
