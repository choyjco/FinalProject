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
</head>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
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
																<button class="btn btn-primary d-flex align-items-end" id="re">저장하기</button>	
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
																<button class="btn btn-primary d-flex align-items-end" id="re">저장하기</button>	
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
																<button class="btn btn-primary d-flex align-items-end" id="re">저장하기</button>	
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
																<button class="btn btn-primary d-flex align-items-end" id="re">저장하기</button>	
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
					
					<!-- 휴가설정시작 -->
					<div class="col-lg-6">
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
																			<a role="button" id="${list.vacCode }-prev" class="btn btn-outline-primary popover-test" data-bs-toggle="popover" data-bs-content="${list.vacAmt }" data-bs-container="body" style="margin-top: 5px; margin-bottom: 5px; padding-right: 5px; padding-left: 5px;">
																				${list.vacName }
																			</a>
																		</c:forEach>
																	</p>
																</div>
																<p></p>
																<div class="row">
																	<div class="accordion accordion-flush" id="accordionFlushExample">
																		<div class="accordion-item">
																			<h2 class="accordion-header" id="flush-headingOne">
																				<button class="accordion-button fw-medium collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
																					<i class="fas fa-folder-open">  상세 보기</i>
																				</button>
																			</h2>
																		</div>
																		<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample" style="">
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
																										급여 지급 여부 : <!-- ${list.vacWgPay } -->
																											<c:if test="${list.vacWgPay eq 'Y' }">
																												<c:out value="유급" />
 																											</c:if> 
																											<c:if test="${list.vacWgPay eq 'N' }">
																												<c:out value="무급" />
 																											</c:if> 
<!-- 																										<input type="checkbox" switch="bool"/> -->
<%-- 																										<c:if test="${list.vacWgPay eq 'Y' } "> --%>
<%-- 																											<c:out value="1번">2번</c:out> --%>
<%-- 																										</c:if> --%>
<%-- 																										<input type="checkbox" id="vacWgPay2" switch="bool" <c:if test="${list.vacWgPay eq 'Y'} ">여기냐</c:if>/> --%>
<%-- 																										<input type="checkbox" id="vacWgPay2" switch="bool" <c:if test="${list.vacWgPay eq 'Y'} ">true</c:if>/> --%>
<!-- 																										<label for="vacWgPay2" data-on-label="유급" data-off-label="무급" class="mb-0"></label> -->
																									</p>
																									<hr>
																									<p>
																										증빙자료 여부 : <!-- ${list.vacCert } -->
																											<c:if test="${list.vacWgPay eq 'Y' }">
																												<c:out value="필요" />
 																											</c:if> 
																											<c:if test="${list.vacWgPay eq 'N' }">
																												<c:out value="불요" />
 																											</c:if> 
<!-- 																									<input type="checkbox" switch="success" checked="checked"/> -->
<!-- 																									<input type="checkbox" id="vacCert2" switch="success" checked="checked"/> -->
<!-- 																									<label for="vacCert2" data-on-label="필요" data-off-label="불요" class="mb-0"></label> -->
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
																					<input type="checkbox" id="vacWgPay" switch="bool" checked="" />
																					<label for="vacWgPay" data-on-label="유급" data-off-label="무급" class="mb-0"></label>
																				</td>
																			</tr>
																			<tr>
																				<td>증빙자료 여부</td>
																				<td style="padding-top: 6px;" height="40px;">
																					<input type="checkbox" id="vacCert" switch="success"/>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- jstree cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<!-- 아이콘 스타일 cdn -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script type="text/javascript">
function fn_delVac(param) {
// 	console.log("@@@@@@@" + param);
	var vacCode = $("#vacCode").val();
	var data = {
			vacCode : param
	};
// 	console.log("@@@@@@@!!!!!!!!!!" + data);
	$.ajax({
		type : "post",
		url : "/settings/delVac?${_csrf.parameterName}=${_csrf.token}",
		//data : {memId : id},	//방법1) contentType 설정 안함 / data도 {id:1}과 같이 설정
//			beforeSend : function(xhr) {
//				xhr.setRequestHeader("${_csrf.parameterName}", "${_csrf.token}");
//			},
		data :  JSON.stringify(data),
		contentType : "application/json",
		success : function(res) {
// 			console.log("데이타아ㅏㅏㅏ" + data);
// 			console.log("데이타아ㅏㅏㅏvacCode" + data.vacCode);
			$("#" + data.vacCode + "-prev").remove();
			$("#v-pills-" + data.vacCode).remove();
			$("#v-pills-" + data.vacCode + "-tab").remove();
			$("#" + data.vacCode + "-prev").css("display", "block");
			$("#v-pills-" + data.vacCode).css("display", "block");
			$("#v-pills-" + data.vacCode + "-tab").css("display", "block");
		}
	});
}
$(function() {
	/////////////// 휴가 //////////////////////////
	
	var registerHoliForm = $("#registerHoliForm");
	var registerHoliBtn = $("#registerHoliBtn");
	var vacCheckFlag = false;
	

	// 일단 휴가 리스트를 컨트롤러 단에서 불러오고 불러온거에서 exist면 중복처리 하기
	registerHoliBtn.on("click", function() {
		
		var vacName = $("#vacName").val();
		
		var data = {
			vacName : vacName
		};
		
		$.ajax({
			type : "post",
			url : "/settings/vacCheck?${_csrf.parameterName}=${_csrf.token}",
			//data : {memId : id},	//방법1) contentType 설정 안함 / data도 {id:1}과 같이 설정
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success : function(res) {
// 				console.log("휴가명 중복확인 결과 : ", res);
				if(res == "NOTEXIST"){
					var vacCont = $("#vacCont").val();
					var vacAmt = $("#vacAmt").val();
					var vacGen = $("#vacGen").val();
					var vacWgPay = $("#vacWgPay");
					var vacCert = $("#vacCert");
					var registerHoliForm = $("#registerHoliForm");
					
					if ($("#vacGenM").is(":checked") == true){
						vacGen = "M";
					}else if($("#vacGenF").is(":checked") == true){
						vacGen = "F";
					}else if($("#vacGenAll").is(":checked") == true){
						vacGen = "all";
					}else {
						alert("휴가 설정중 오류 발생..? 왜....지?");
					}
					if ($("#vacWgPay").is(":checked") == true){
						vacWgPay = "Y";
					}else if($("#vacWgPay").is(":checked") == false){
						vacWgPay = "N";
					}else {
						alert("휴가 설정중 오류 발생..? 왜....지?");
					}
					if ($("#vacCert").is(":checked") == true){
						vacCert = "Y";
					}else if($("#vacCert").is(":checked") == false){
						vacCert = "N";
					}else {
						alert("휴가 설정중 오류 발생..? 왜....지?");
					}
// 					alert("체크박스 결과 : " + vacWgPay + "!!!!!!!!!!!!!" + vacCert);
// 						alert("휴가명 : " + vacName);
// 						alert("내용 : " + vacCont);
// 						alert("일수 : " + vacAmt);
// 						alert("성별남 : " + vacGenM);
// 						alert("성별여 : " + vacGenF);
// 						alert("성별? : " + vacGen);
// 						alert("월급 : " + vacWgPay);
// 						alert("서류 : " + vacCert);
					
					var data = {
							vacName : vacName,
							vacCont : vacCont,
							vacAmt : vacAmt,
							vacGen : vacGen,
							vacWgPay : vacWgPay,
							vacCert : vacCert
					}
					
					$.ajax({
						type : "post",
						url : "/settings/registerVac?${_csrf.parameterName}=${_csrf.token}",
						data :  data,
						success : function(res) {
						    alert("휴가가 등록되었습니다.");
						    setTimeout(() => location.href="/settings/middlelist", 1000);
						}
					});
					vacCheckFlag = true;
				} else {
					alert("중복된 휴가명입니다.");
				}
			}
		});
		
	});
	
	
	////////회사 조직도 트리///////////////// 부서 ////////////////////////////////////
	
	$('#ajax').jstree({
	'core' : {
		'data' : {
			"url" : "/settings/tree",
			"dataType": "json"
		},
		"check_callback" : true // 우클릭시 기본적인 메뉴 사용 가능
	},
	'plugins' : ["dnd", "search", "contextmenu", "state", "types", "wholerow", "changed"] // 우클릭 메뉴 활성화
	});

	// 해당 id의 노드를 open 상태로 바꿉니다.
	$("#ajax").on("ready.jstree", function() {
		$(this).jstree("open_node", "a"); // 이 경우 id가 1번인 root노드(DDIT)를 열린 상태로 로드함
	});


	//전체 열기 버튼
	$("#openBtn").on("click", function() {
		$('#ajax').jstree("open_all");
	});

	// 전체 닫기 버튼
	$("#closeBtn").on("click", function() {
		$('#ajax').jstree("close_all");
	});

	//클릭된 노드 정보출력
	$('#ajax').on('changed.jstree', function (e, data) {
	 var selectedNodeIDs = data.selected;
	 var dataTableBody = $('#data-table tbody');
	
	 dataTableBody.empty();
	
		selectedNodeIDs.forEach(function (nodeID) {
		  
			$.ajax({
				url: '/hr/selectTree',
				method: 'POST',
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				data: { comCode: nodeID },
				dataType: 'json',
				success: function (response) {
				
					for(let i = 0; i<response.length; i++) {
						var rowData = response[i];
						
						var row = $('<tr class="gridjs-tr">'); 
						var cell1 = $('<td data-column-id="empName" class="gridjs-td">').text(rowData.empName);
						var cell2 = $('<td data-column-id="empStat" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empStat + '</div></div>');
						var cell3 = $('<td data-column-id="empNo" class="gridjs-td">').text(rowData.empNo);
						var cell4 = $('<td data-column-id="empDate" class="gridjs-td">').text(rowData.empDate);
						var cell5 = $('<td data-column-id="caEndDate" class="gridjs-td">').text(rowData.caEndDate);
						var cell6 = $('<td data-column-id="empKdate" class="gridjs-td">').text(rowData.empKdate);
						var cell7 = $('<td data-column-id="empWork" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empWork + '</div></div>');
						
						row.append(cell1, cell2, cell3, cell4, cell5, cell6, cell7);
						console.log('row:', row)
						dataTableBody.append(row);
					
					}
				},
				error: function (error) {
					console.error('Error:', error);
				}
			});
		});
	});
	
	// 노드 추가버튼
	$("#regBtn").on("click", function(){
		var ref = $('#ajax').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { 
			ref.create_node(null, {"type":"file"}); 
		}else{
			console.log(sel[0]);
			sel = sel[0];
			sel = ref.create_node(sel, {"type":"file"});
		}
		if(sel) {
			ref.edit(sel);
		}
	});
	
	// 노드 수정버튼
	$("#modBtn").on("click", function(){
		var ref = $('#ajax').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		ref.edit(sel);
	});

	// 노드 삭제버튼
	$("#delBtn").on("click", function(){
		var ref = $('#ajax').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		
		console.log("삭제된 노드정보 : " + sel);
		
		ref.delete_node(sel);
	});
	
	///////////////////////직책/////////////////////////
	$('#ajaxPos').jstree({
	'core' : {
		'data' : {
			"url" : "/settings/pos",
			"dataType": "json"
		},
		"check_callback" : true // 우클릭시 기본적인 메뉴 사용 가능
	},
	'plugins' : ["dnd", "search", "contextmenu", "state", "types", "wholerow", "changed"] // 우클릭 메뉴 활성화
	});

	// 해당 id의 노드를 open 상태로 바꿉니다.
	$("#ajaxPos").on("ready.jstree", function() {
		$(this).jstree("open_node", "b"); // 이 경우 id가 1번인 root노드(DDIT)를 열린 상태로 로드함
	});


	//전체 열기 버튼
	$("#openPosBtn").on("click", function() {
		$('#ajaxPos').jstree("open_all");
	});

	// 전체 닫기 버튼
	$("#closePosBtn").on("click", function() {
		$('#ajaxPos').jstree("close_all");
	});

	//클릭된 노드 정보출력
	$('#ajaxPos').on('changed.jstree', function (e, data) {
	 var selectedNodeIDs = data.selected;
	 var dataTableBody = $('#data-table tbody');
	
	 dataTableBody.empty();
	
		selectedNodeIDs.forEach(function (nodeID) {
		  
			$.ajax({
				url: '/hr/selectTree',
				method: 'POST',
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				data: { comCode: nodeID },
				dataType: 'json',
				success: function (response) {
				
					for(let i = 0; i<response.length; i++) {
						var rowData = response[i];
						
						var row = $('<tr class="gridjs-tr">'); 
						var cell1 = $('<td data-column-id="empName" class="gridjs-td">').text(rowData.empName);
						var cell2 = $('<td data-column-id="empStat" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empStat + '</div></div>');
						var cell3 = $('<td data-column-id="empNo" class="gridjs-td">').text(rowData.empNo);
						var cell4 = $('<td data-column-id="empDate" class="gridjs-td">').text(rowData.empDate);
						var cell5 = $('<td data-column-id="caEndDate" class="gridjs-td">').text(rowData.caEndDate);
						var cell6 = $('<td data-column-id="empKdate" class="gridjs-td">').text(rowData.empKdate);
						var cell7 = $('<td data-column-id="empWork" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empWork + '</div></div>');
						
						row.append(cell1, cell2, cell3, cell4, cell5, cell6, cell7);
						console.log('row:', row)
						dataTableBody.append(row);
					
					}
				},
				error: function (error) {
					console.error('Error:', error);
				}
			});
		});
	});
	
	// 노드 추가버튼
	$("#regPosBtn").on("click", function(){
		var ref = $('#ajaxPos').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { 
			ref.create_node(null, {"type":"file"}); 
		}else{
			console.log(sel[0]);
			sel = sel[0];
			sel = ref.create_node(sel, {"type":"file"});
		}
		if(sel) {
			ref.edit(sel);
		}	
	});
	
	// 노드 수정버튼
	$("#modPosBtn").on("click", function(){
		var ref = $('#ajaxPos').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		ref.edit(sel);
	});

	// 노드 삭제버튼
	$("#delPosBtn").on("click", function(){
		var ref = $('#ajaxPos').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		
		console.log("삭제된 노드정보 : " + sel);
		
		ref.delete_node(sel);
	});
	
	/////////////////////직급///////////////////////////
	$('#ajaxRank').jstree({
	'core' : {
		'data' : {
			"url" : "/settings/rank",
			"dataType": "json"
		},
		"check_callback" : true // 우클릭시 기본적인 메뉴 사용 가능
	},
	'plugins' : ["dnd", "search", "contextmenu", "state", "types", "wholerow", "changed"] // 우클릭 메뉴 활성화
	});

	// 해당 id의 노드를 open 상태로 바꿉니다.
	$("#ajaxRank").on("ready.jstree", function() {
		$(this).jstree("open_node", "c"); // 이 경우 id가 1번인 root노드(DDIT)를 열린 상태로 로드함
	});


	//전체 열기 버튼
	$("#openBtnRank").on("click", function() {
		$('#ajaxRank').jstree("open_all");
	});

	// 전체 닫기 버튼
	$("#closeBtnRank").on("click", function() {
		$('#ajaxRank').jstree("close_all");
	});

	//클릭된 노드 정보출력
	$('#ajaxRank').on('changed.jstree', function (e, data) {
	 var selectedNodeIDs = data.selected;
	 var dataTableBody = $('#data-table tbody');
	
	 dataTableBody.empty();
	
		selectedNodeIDs.forEach(function (nodeID) {
		  
			$.ajax({
				url: '/hr/selectTree',
				method: 'POST',
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				data: { comCode: nodeID },
				dataType: 'json',
				success: function (response) {
				
					for(let i = 0; i<response.length; i++) {
						var rowData = response[i];
						
						var row = $('<tr class="gridjs-tr">'); 
						var cell1 = $('<td data-column-id="empName" class="gridjs-td">').text(rowData.empName);
						var cell2 = $('<td data-column-id="empStat" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empStat + '</div></div>');
						var cell3 = $('<td data-column-id="empNo" class="gridjs-td">').text(rowData.empNo);
						var cell4 = $('<td data-column-id="empDate" class="gridjs-td">').text(rowData.empDate);
						var cell5 = $('<td data-column-id="caEndDate" class="gridjs-td">').text(rowData.caEndDate);
						var cell6 = $('<td data-column-id="empKdate" class="gridjs-td">').text(rowData.empKdate);
						var cell7 = $('<td data-column-id="empWork" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empWork + '</div></div>');
						
						row.append(cell1, cell2, cell3, cell4, cell5, cell6, cell7);
						console.log('row:', row)
						dataTableBody.append(row);
					
					}
				},
				error: function (error) {
					console.error('Error:', error);
				}
			});
		});
	});
	
	// 노드 추가버튼
	$("#regBtnRank").on("click", function(){
		var ref = $('#ajaxRank').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { 
			ref.create_node(null, {"type":"file"}); 
		}else{
			console.log(sel[0]);
			sel = sel[0];
			sel = ref.create_node(sel, {"type":"file"});
		}
		if(sel) {
			ref.edit(sel);
		}	
	});
	
	// 노드 수정버튼
	$("#modBtnRank").on("click", function(){
		var ref = $('#ajaxRank').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		ref.edit(sel);
	});

	// 노드 삭제버튼
	$("#delBtnRank").on("click", function(){
		var ref = $('#ajaxRank').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		
		console.log("삭제된 노드정보 : " + sel);
		
		ref.delete_node(sel);
	});
	
	////////////////////////직위////////////////////////
	$('#ajaxJob').jstree({
	'core' : {
		'data' : {
			"url" : "/settings/job",
			"dataType": "json"
		},
		"check_callback" : true // 우클릭시 기본적인 메뉴 사용 가능
	},
	'plugins' : ["dnd", "search", "contextmenu", "state", "types", "wholerow", "changed"] // 우클릭 메뉴 활성화
	});

	// 해당 id의 노드를 open 상태로 바꿉니다.
	$("#ajaxJob").on("ready.jstree", function() {
		$(this).jstree("open_node", "d"); // 이 경우 id가 1번인 root노드(DDIT)를 열린 상태로 로드함
	});


	//전체 열기 버튼
	$("#openBtnJob").on("click", function() {
		$('#ajax').jstree("open_all");
	});

	// 전체 닫기 버튼
	$("#closeBtnJob").on("click", function() {
		$('#ajax').jstree("close_all");
	});

	//클릭된 노드 정보출력
	$('#ajaxJob').on('changed.jstree', function (e, data) {
	 var selectedNodeIDs = data.selected;
	 var dataTableBody = $('#data-table tbody');
	
	 dataTableBody.empty();
	
		selectedNodeIDs.forEach(function (nodeID) {
		  
			$.ajax({
				url: '/hr/selectTree',
				method: 'POST',
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				data: { comCode: nodeID },
				dataType: 'json',
				success: function (response) {
				
					for(let i = 0; i<response.length; i++) {
						var rowData = response[i];
						
						var row = $('<tr class="gridjs-tr">'); 
						var cell1 = $('<td data-column-id="empName" class="gridjs-td">').text(rowData.empName);
						var cell2 = $('<td data-column-id="empStat" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empStat + '</div></div>');
						var cell3 = $('<td data-column-id="empNo" class="gridjs-td">').text(rowData.empNo);
						var cell4 = $('<td data-column-id="empDate" class="gridjs-td">').text(rowData.empDate);
						var cell5 = $('<td data-column-id="caEndDate" class="gridjs-td">').text(rowData.caEndDate);
						var cell6 = $('<td data-column-id="empKdate" class="gridjs-td">').text(rowData.empKdate);
						var cell7 = $('<td data-column-id="empWork" class="gridjs-td">').html('<div class="d-flex gap-2"><div class="badge badge-soft-primary">'+ rowData.empWork + '</div></div>');
						
						row.append(cell1, cell2, cell3, cell4, cell5, cell6, cell7);
						console.log('row:', row)
						dataTableBody.append(row);
					
					}
				},
				error: function (error) {
					console.error('Error:', error);
				}
			});
		});
	});
	
	// 노드 추가버튼
	$("#regBtnJob").on("click", function(){
		var ref = $('#ajaxJob').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { 
			ref.create_node(null, {"type":"file"}); 
		}else{
			console.log(sel[0]);
			sel = sel[0];
			sel = ref.create_node(sel, {"type":"file"});
		}
		if(sel) {
			ref.edit(sel);
		}	
	});
	
	// 노드 수정버튼
	$("#modBtnJob").on("click", function(){
		var ref = $('#ajaxJob').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		ref.edit(sel);
	});

	// 노드 삭제버튼
	$("#delBtnJob").on("click", function(){
		var ref = $('#ajaxJob').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		
		console.log("삭제된 노드정보 : " + sel);
		
		ref.delete_node(sel);
	});
	
///////////////////////조직도 트리 끝 ///////////////////////////////////////////////////////////////
});
	
</script>
