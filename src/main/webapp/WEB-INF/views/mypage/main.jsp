<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>

.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>

<div class="row">
	<div>
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-2 text-center">
<!-- 						<div style="display: flex; align-items: center; justify-content: flex-center;"> -->
						<form action="/mypage/profileupdate" id="proModifyForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="empNo" id="empNo" class="inputfile inputfile-4">
                            <div class="position-relative d-inline-block mx-auto pt-3">
                                <div class="avatar-xl">
			   				 <img src="${pageContext.request.contextPath}${emp.empProfile}" alt="프로필이미지" id="profile" class="rounded-circle avatar-xl">
                                </div>
                                <div class="d-block position-absolute bottom-0 end-0">
                                    <div class="avatar-sm">
                                        <div class="avatar-title rounded-circle bg-light text-primary">
                                        	<input type="file" name="libFile" id="libFile" class="inputfile inputfile-4" style="display: none;"/>
                                            <label for="libFile"><i class="mdi mdi-pencil"></i></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

<!-- 							<div class="filebox avatar-title rounded-circle bg-light text-primary" style="width: 25px; height: 25px; align-self: flex-end;" > -->
<!-- 								<input type="hidden" name="empNo" id="empNo" class="inputfile inputfile-4"> -->
<!-- 								<input type="file" name="libFile" id="libFile" class="inputfile inputfile-4"> -->
<!-- 								<label for="libFile"><i class="mdi mdi-pencil" style="padding-top: 7px;"></i></label> -->
<!-- 							</div> -->
							<sec:csrfInput/>
						</form>
<!-- 						</div> -->
					</div>
					<div class="col-md-3">
						<div class="row">
							<h4 class="card-title">
								<span class="fw-bold px-4 py-2 fs-3" id="name"></span>
							</h4>
						</div>
						<div class="row align-items-center">
							<span class="fw-bold fs-4" id="dept"></span>
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
								<button type="button" class="btn btn-info" >
									<div id="empStat"></div>
								</button>
							</div>
						</div>
					</div>
					<div class="col-md-1 ms-auto">
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
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
						href="#messages1" role="tab"> <span class="d-block d-sm-none"><i
								class="far fa-envelope"></i></span> <span class="d-none d-sm-block">경력＊학력</span>
					</a></li>
				</ul>
				
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
							<div class="col-md-3">
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
								<div style="padding: 30px;" id="empInfo">
								</div>
							</div>
							
							<div class="col-md-3">
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
									    <h5 class="card-title" align="right"><b>2일</b></h5>
									  </div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="profile1" role="tabpanel">
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">개인정보</span>
							</div>
							<div class="col-md-1">
								<div class="row icon-demo-content">
									<div class=" col-xl-3 col-lg-4 col-sm-6">
										<i class="uil-pen" data-bs-toggle="modal" data-bs-target="#infoModify"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-1">
							</div>
							<div class="col-md-3">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-6">이름</p>
									<p class="fw-bold px-4 py-2 fs-6">영문이름</p>
									<p class="fw-bold px-4 py-2 fs-6">주민등록번호</p>
									<p class="fw-bold px-4 py-2 fs-6">연락처</p>
									<p class="fw-bold px-4 py-2 fs-6">이메일</p>
									<p class="fw-bold px-4 py-2 fs-6">주소</p>
									<p class="fw-bold px-4 py-2 fs-6">급여계좌</p>
								</div>
							</div>
							<div class="col-md-4">
								<div style="padding: 30px;" id="empInfo2">
								</div>
							</div>
							<div class="col-md-1 ms-auto">
							</div>
						</div>
						<!-- 가족정보 시작 -->
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
								<div class="row" id="noFamInfo">
									<div class="col-md-1">
									</div>
									<div class="col-md-7">
										<div style="padding: 30px;">
											<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
										</div>
									</div>
								</div>
									<div id="famInfo"></div>
									<!-- 가족정보 끝 -->
					</div>
					<!-- 경력정보 시작 -->
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
								<div class="row" id="noCarrInfo">
								<div class="col-md-1"></div>
									<div class="col-md-7">
										<div style="padding: 30px;">
											<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
										</div>
									</div>
								</div>
								<div id="carrInfo"></div>
								<!-- 경력정보 끝 -->
								<!-- 학력정보 시작 -->

						<div class="row">
							<div class="col-md-1"></div>
							<div class="col-md-7" style="padding: 30px;">
								<span class="fw-bold px-4 py-2 fs-3">학력정보</span>
							</div>
							<div class="col-md-1">
								<div class="row icon-demo-content">
									<div class=" col-xl-3 col-lg-4 col-sm-6">
										<i class="uil-plus" data-bs-toggle="modal"
											data-bs-target="#acadRegister"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="row" id="noAcadInfo">
							<div class="col-md-1">
							</div>
							<div class="col-md-7">
								<div style="padding: 30px;">
									<p class="fw-bold px-4 py-2 fs-5">해당 정보가 존재하지 않습니다</p>
								</div>
							</div>
						</div>
						<div id="acadInfo"></div>
						<!-- 학력정보 끝 -->
					</div>
				</div>
				<img alt="" src="">
				<!-- 개인정보 수정 modal 시작 -->
				<div id="infoModal"></div>
				
				<!-- 개인정보 수정 modal 끝 -->
				<!-- 가족정보 추가 modal 시작 -->
				<form method="post" id="famRegisterForm">
					<input type="hidden" name="empNo" id="famRegisterNo"/>
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
											<div class="col-md-5">
												<select name="efRelation" id="efRelation" class="form-select">
													<option value="부">부</option>
													<option value="모">모</option>
													<option value="형">형</option>
													<option value="동생">동생</option>
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
										data-bs-dismiss="modal" id="famRegisterBtn">추가</button>
								</div>
							</div>
						</div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 가족정보 추가 modal 끝 -->
				<!-- 경력정보 추가 modal 시작 -->
				<form action="/mypage/carrRegister" method="post" id="carrRegisterForm">
					<input type="hidden" value="${emp.empNo }" name="empNo" id="carrRegisterNo"/>
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
								            <div class="col-md-5">
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
								            <div class="col-md-5">
								            	<input class="form-control" id="caEntDate" type="date" name="caEntDate">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">퇴사일자</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="date" id="caEndDate" name="caEndDate" >
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">부서</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" id="caDept" name="caDept" placeholder="부서">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">직책</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" id="caDut" name="caDut" placeholder="직책">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">직위</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" id="caPos" name="caPos" placeholder="직위">
								            </div>
							            </div>
						            </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="carrRegisterBtn">추가</button>
					            </div>
					        </div>
					    </div>
					</div>
					<sec:csrfInput/>
				</form>
				<!-- 경력정보 추가 modal 끝 -->
				<!-- 학력정보 추가 modal 시작 -->
				<form action="/mypage/acadRegister" method="post" id="acadRegisterForm">
					<input type="hidden" value="${emp.empNo }" name="empNo" id="acadRegisterNo">
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
								            	<input class="form-control" type="text" name="acadClf" id="acadClf" placeholder="학교구분">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">학교명</p>
								            </div>
								            <div class="col-md-5">
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
								            <div class="col-md-5">
								            	<input class="form-control" type="date" id="acadEndDate" name="acadEndDate"/>
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">졸업여부</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" name="acadStat" id="acadStat" placeholder="졸업여부">
								            </div>
							            </div>
							            <div class="row">
								            <div class="col-md-4 text-center">
								            	<p class="fw-bold px-4 py-2 fs-6">전공</p>
								            </div>
								            <div class="col-md-5">
								            	<input class="form-control" type="text" name="acadMaj" id="acadMaj" placeholder="전공">
								            </div>
							            </div>
						            </div>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary"  data-bs-dismiss="modal" id="acadRegisterBtn">추가</button>
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
$(function(){
	var libFile = $("#libFile");
	libFile.on("change", function(event){
		var file = event.target.files[0];
		
		if(isImageFile(file)){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#profile").attr("src", e.target.result);
				
				
			}
			reader.readAsDataURL(file);
			confirm("저장 하시겠습니까?");
			proModifyForm.submit();
		}else{
			alert("이미지 파일 선택하세요!");
		}
	});
});
/* proModifyForm.submit();
location.href="/mypage/main";

$(function(){
    var imgFile = $("#imgFile");
    imgFile.on("change", function(event){
        var file = event.target.files[0];
        
        if(isImageFile(file)){
            // 이미지 파일 선택 시 확인 메시지를 표시
            if (confirm("저장 하시겠습니까?")) {
                var reader = new FileReader();
                reader.onload = function(e){
                    $("#profile").attr("src", e.target.result);
                    
                }
                reader.readAsDataURL(file);
            }
        } else {
            alert("이미지 파일을 선택하세요!");
        }
    });
}); */




//이미지 파일인지 체크
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();
	return ($.inArrayIext, ["jpg", "jpeg", "gif", "png"] === -1 ? false : true);
}


function telcopyBtn() {
	var copyText = document.createElement("textarea");
	var telcopyBtn = $("#telcopyBtn").val();
	document.body.appendChild(copyText);
	copyText.value = telcopyBtn;
	copyText.select();
	document.execCommand('copy');
	document.body.removeChild(copyText);
	alert(copyText.value + '\n전화번호 복사 완료!');
}
function emailcopyBtn() {
	var copyText = document.createElement("textarea");
	var emailcopyBtn = $("#emailcopyBtn").val();
	document.body.appendChild(copyText);
	copyText.value = emailcopyBtn;
	copyText.select();
	document.execCommand('copy');
	document.body.removeChild(copyText);
	alert(copyText.value + '\n이메일 주소 복사 완료!');
}


$(function(){
	
	$.ajax({
		url : "/mypage/page?${_csrf.parameterName}=${_csrf.token}",
		method : "get",
		contentType : "application/json; charset=utf-8",
		success : function(result){
			
			$("#proModifyForm").find("#empNo").val(result.empNo);
			$("#telcopyBtn").val(result.empTel);
			$("#emailcopyBtn").val(result.empEmail);
			$("#empStat").text(result.empStat);
			$("#profile").attr("src", result.empProfile);
			$("#famRegisterNo").val(result.empNo);
			$("#carrRegisterNo").val(result.empNo);
			$("#acadRegisterNo").val(result.empNo);
			$("#name").text(result.empName);
			if(result.empPos == "직책 없음"){
				$("#dept").text(result.empDept);
			}else if(result.empDept == null){
				$("#dept").text(result.empPos);
			}else{
				$("#dept").text(result.empDept + " " + result.empPos);
			}
			
			var famCount = result.famList.length;
			var carrCount = result.carrList.length;
			var acadCount = result.acadList.length;
			
			var htmlInfo = "";
			htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empNo+"</p>";
			htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empDate+"</p>";
			htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empStat+"</p>";
			if(result.empPos == "직책 없음"){
				htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empDept+"</p>";
			}else if(result.empDept == null){
				htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empPos+"</p>";
			}
			else{
				htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empDept+"＊"+result.empPos+"</p>";
			}
			if(result.empJob != null){
				htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empJob+"</p>";
			}else{
				htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>사장</p>";
			}
			htmlInfo += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empRank+"</p>";
			$("#empInfo").html(htmlInfo);
			
			var htmlInfo2 = "";
			
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empName+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empEname+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empReg1+"-"+result.empReg2+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empTel+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empEmail+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empAddr1+" "+result.empAddr2+"</p>";
			htmlInfo2 += "<p class='fw-bold px-4 py-2 fs-6'>"+result.empBank+" "+result.empAcct+"</p>";
			
			$("#empInfo2").html(htmlInfo2);
			
			var infomodal = "";
			
			infomodal += "<form id='infoModifyForm'>";
			infomodal += "<input type='hidden' value='"+result.empNo+"'>";
			infomodal += "<div id='infoModify' class='modal fade bs-example-modal-lg' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
			infomodal += "<div class='modal-dialog modal-dialog-centered'>";
			infomodal += "<div class='modal-content'>";
			infomodal += "<div class='modal-header'>";
			infomodal += "<h5 class='modal-title'>개인정보 수정</h5>";
			infomodal += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'>";
			infomodal += "</button>";
			infomodal += "</div>";
			infomodal += "<div class='modal-body'>";
			infomodal += "<div class='row align-items-center'>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>이름</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-5'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empName+"' name='empName' placeholder='이름'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>영문이름</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-5'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empEname+"' name='empEname' placeholder='영문이름'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>주민등록번호</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-4'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empReg1+"' name='empReg1' placeholder='앞자리(6자리)'>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-4'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empReg2+"' name='empReg2' placeholder='뒷자리(7자리)'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>연락처</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-5'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empTel+"' name='empTel' placeholder='연락처'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>이메일</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-6'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empEmail+"' name='empEmail' placeholder='이메일'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>주소</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-8'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empAddr1+"' name='empAddr1' placeholder='주소'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>상세주소</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-8'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empAddr2+"' name='empAddr2' placeholder='상세주소'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='row'>";
			infomodal += "<div class='col-md-4 text-center'>";
			infomodal += "<p class='fw-bold px-4 py-2 fs-6'>급여계좌</p>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-3'>";
			infomodal += "<select name='empBank' class='form-select'>";
			if(result.empBank == "국민"){
				infomodal += "<option value='국민' selected='selected'>국민은행</option>";
				infomodal += "<option value='농협'>농협은행</option>";
				infomodal += "<option value='우리'>우리은행</option>";
				infomodal += "<option value='기업'>IBK기업은행</option>";
				infomodal += "<option value='새마을'>새마을은행</option>";
				infomodal += "<option value='신한'>신한은행</option>";
				
				
			}else if(result.empBank == "농협"){
				infomodal += "<option value='국민'>국민은행</option>";
				infomodal += "<option value='농협' selected='selected'>농협은행</option>";
				infomodal += "<option value='우리'>우리은행</option>";
				infomodal += "<option value='기업'>IBK기업은행</option>";
				infomodal += "<option value='새마을'>새마을은행</option>";
				infomodal += "<option value='신한'>신한은행</option>";
				
			}else if(result.empBank == "우리"){
				infomodal += "<option value='국민'>국민은행</option>";
				infomodal += "<option value='농협'>농협은행</option>";
				infomodal += "<option value='우리' selected='selected'>우리은행</option>";
				infomodal += "<option value='기업'>IBK기업은행</option>";
				infomodal += "<option value='새마을'>새마을은행</option>";
				infomodal += "<option value='신한'>신한은행</option>";
				
			}else if(result.empBank == "기업"){
				infomodal += "<option value='국민'>국민은행</option>";
				infomodal += "<option value='농협'>농협은행</option>";
				infomodal += "<option value='우리'>우리은행</option>";
				infomodal += "<option value='기업' selected='selected'>IBK기업은행</option>";
				infomodal += "<option value='새마을'>새마을은행</option>";
				infomodal += "<option value='신한'>신한은행</option>";
				
			}else if(result.empBank == "새마을"){
				infomodal += "<option value='국민'>국민은행</option>";
				infomodal += "<option value='농협'>농협은행</option>";
				infomodal += "<option value='우리'>우리은행</option>";
				infomodal += "<option value='기업'>기업은행</option>";
				infomodal += "<option value='새마을' selected='selected'>새마을</option>";
				infomodal += "<option value='신한'>신한은행</option>";
				
			}else if(result.empBank == "신한"){
				infomodal += "<option value='국민'>국민은행</option>";
				infomodal += "<option value='농협'>농협은행</option>";
				infomodal += "<option value='우리'>우리은행</option>";
				infomodal += "<option value='기업'>기업은행</option>";
				infomodal += "<option value='새마을'>새마을은행</option>";
				infomodal += "<option value='신한' selected='selected'>신한은행</option>";
				
			}
			infomodal += "</select>";
			infomodal += "</div>";
			infomodal += "<div class='col-md-5'>";
			infomodal += "<input class='form-control' type='text' value='"+result.empAcct+"' name='empAcct' placeholder='계좌번호'>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "<div class='modal-footer'>";
			infomodal += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
			infomodal += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' id='infoModifyBtn'>수정</button>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "</div>";
			infomodal += "</form>";
			
			$("#infoModal").html(infomodal);
			
			if(famCount == 0){
				$("#noFamInfo").css("display","block");
				
			}
			else{
				$("#noFamInfo").css("display","none");
				$("#famInfo").css("display","block");
				var html = "";
				
				
				for(let i = 0; i < famCount; i++){
					html += "<div class='row' id='famInfo"+result.famList[i].efNo+"'>";
					html += "<div class='col-md-1'>";
					html += "</div>";
					html += "<div class='col-md-3'>";
					html += "<div style='padding: 30px;'>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>이름</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>관계</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>주민등록번호</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>연락처</p>";
					html += "</div>";
					html += "</div>";
					html += "<div class='col-md-4'>";
					html += "<div style='padding: 30px;'>";
					html += "<p class='fw-bold px-4 py-2 fs-6' id='efName"+result.famList[i].efNo+"'>"+result.famList[i].efName +"</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6' id='efRelation"+result.famList[i].efNo+"'>"+result.famList[i].efRelation +"</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6' id='efReg"+result.famList[i].efNo+"'>"+result.famList[i].efReg1+"-"+result.famList[i].efReg2+"</p>";
					html += "<p class='fw-bold px-4 py-2 fs-6' id='efPhone"+result.famList[i].efNo+"'>"+result.famList[i].efPhone+"</p>";
					html += "</div>";
					html += "</div>";
					html += "<div class='col-md-1'>";
					html += "<div class='row'>";
					html += "<div class='icon-demo-content'>";
					html += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					html += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#modifyfam"+result.famList[i].efNo+"'></i>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "<div class='row'>";
					html += "<div class='icon-demo-content'>";
					html += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					html += "<i id='' class='bx bx-x' onclick=\"fn_famDel('"+result.famList[i].efNo+"')\" ></i>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "<div class='col-md-3'></div>";
					html += "</div>";
					html += "<form action='/mypage/famModify' method='post' id='famModifyForm"+result.famList[i].efNo+"'>";
					html += "<input type='hidden' value='"+result.famList[i].efNo+"' id='efNo' name='efNo'>";
					html += "<input type='hidden' value='"+result.empNo+"' name='empNo' id='empNo'>";
					html += "<div id='modifyfam"+result.famList[i].efNo+"' class='modal fade bs-example-modal-center' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
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
					html += "<input class='form-control' id='efName' value='"+result.famList[i].efName+"' type='text' name='efName' placeholder='이름'>";
					html += "</div>";
					html += "</div>";
					html += "<div class='row'>";
					html += "<div class='col-md-4 text-center'>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>관계</p>";
					html += "</div>";
					html += "<div class='col-md-5'>";
					html += "<select name='efRelation' id='efRelation' class='form-select'>";
					var rel = result.famList[i].efRelation;
					if(rel == "부"){
						html += "<option value='부' selected='selected'>부</option>";
						html += "<option value='모'>모</option>";
						html += "<option value='형'>형</option>";
						html += "<option value='동생'>동생</option>";
					}else if(rel == "모"){
						html += "<option value='부'>부</option>";
						html += "<option value='모' selected='selected'>모</option>";
						html += "<option value='형'>형</option>";
						html += "<option value='동생'>동생</option>";
					}else if(rel == "형"){
						html += "<option value='부'>부</option>";
						html += "<option value='모'>모</option>";
						html += "<option value='형' selected='selected'>형</option>";
						html += "<option value='동생'>동생</option>";
					}else if(rel == "동생"){
						html += "<option value='부'>부</option>";
						html += "<option value='모'>모</option>";
						html += "<option value='형'>형</option>";
						html += "<option value='동생' selected='selected'>동생</option>";
					}
					html += "</select>";
					html += "</div>";
					html += "</div>";
					html += "<div class='row'>";
					html += "<div class='col-md-4 text-center'>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>연락처</p>";
					html += "</div>";
					html += "<div class='col-md-5'>";
					html += "<input class='form-control' id='efPhone' type='text' name='efPhone' value='"+result.famList[i].efPhone+"' placeholder='연락처'>";
					html += "</div>";
					html += "</div>";
					html += "<div class='row'>";
					html += "<div class='col-md-4 text-center'>";
					html += "<p class='fw-bold px-4 py-2 fs-6'>주민등록번호</p>";
					html += "</div>";
					html += "<div class='col-md-4'>";
					html += "<input class='form-control' id='efReg1' type='text' name='efReg1' value='"+result.famList[i].efReg1+"' placeholder='앞자리(6자리)'>";
					html += "</div>";
					html += "<div class='col-md-4'>";
					html += "<input class='form-control' id='efReg2' type='text' name='efReg2' value='"+result.famList[i].efReg2+"' placeholder='뒷자리(7자리)'>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "<div class='modal-footer'>";
					html += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
					html += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_fammod('"+result.famList[i].efNo+"')\">수정</button>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "</div>";
					html += "</form>";
				
				}
				$("#famInfo").html(html);
			}
			
			var carrhtml = "";
			if(carrCount == 0){
				$("#noCarrInfo").css("display","block");
			}else{
				var carrInfo = "";
				$("#noCarrInfo").css("display","none");
				$("#carrInfo").css("display","block");
				for(let i = 0; i < carrCount; i++){
					
				
					carrInfo += "<div class='row' id='carrInfo"+result.carrList[i].caNo+"'>";
					carrInfo += "<div class='col-md-1'>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-3'>";
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
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caComName"+result.carrList[i].caNo+"'>"+result.carrList[i].caComName+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caClf"+result.carrList[i].caNo+"'>"+result.carrList[i].caClf+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caType"+result.carrList[i].caNo+"'>"+result.carrList[i].caType+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caEntDate"+result.carrList[i].caNo+"'>"+result.carrList[i].caEntDate+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caEndDate"+result.carrList[i].caNo+"'>"+result.carrList[i].caEndDate+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caDept"+result.carrList[i].caNo+"'>"+result.carrList[i].caDept+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caDut"+result.carrList[i].caNo+"'>"+result.carrList[i].caDut+"</p>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6' id='caPos"+result.carrList[i].caNo+"'>"+result.carrList[i].caPos+"</p>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-1'>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='icon-demo-content'>";
					carrInfo += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					carrInfo += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#carrModify"+result.carrList[i].caNo+"'></i>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='icon-demo-content'>";
					carrInfo += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					carrInfo += "<i class='bx bx-x' onclick=\"fn_carrDel('"+result.carrList[i].caNo+"')\"></i>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<form  method='post' id='carrModifyForm"+result.carrList[i].caNo+"'>";
					carrInfo += "<input type='hidden' value='"+result.carrList[i].caNo+"' id='caNo' name='caNo'/>";
					carrInfo += "<input type='hidden' value='"+result.empNo+"' id='empNo' name='empNo'/>";
					carrInfo += "<div id='carrModify"+result.carrList[i].caNo+"' class='modal fade bs-example-modal-center' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
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
					carrInfo += "<input class='form-control' type='text' id='caComName' value='"+result.carrList[i].caComName+"' name='caComName' placeholder='회사이름'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>회사분류</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' type='text' id='caClf' value='"+result.carrList[i].caClf+"' name='caClf' placeholder='회사분류'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>근로유형</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' type='text' id='caType' value='"+result.carrList[i].caType+"' name='caType' placeholder='근로유형'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>입사일자</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' type='date' id='caEntDate' value='"+result.carrList[i].caEntDate+"' name='caEntDate'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>퇴사일자</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' id='caEndDate' value='"+result.carrList[i].caEndDate+"' type='date' name='caEndDate'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>부서</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' id='caDept' value='"+result.carrList[i].caDept+"' type='text' name='caDept'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직책</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' id='caDut' value='"+result.carrList[i].caDut+"' type='text' name='caDut'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='row'>";
					carrInfo += "<div class='col-md-4 text-center'>";
					carrInfo += "<p class='fw-bold px-4 py-2 fs-6'>직급</p>";
					carrInfo += "</div>";
					carrInfo += "<div class='col-md-5'>";
					carrInfo += "<input class='form-control' id='caPos' value='"+result.carrList[i].caPos+"' type='text' name='caPos'>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "<div class='modal-footer'>";
					carrInfo += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
					carrInfo += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"javascript:fn_carrmod('"+result.carrList[i].caNo+"')\">수정</button>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</div>";
					carrInfo += "</form>";
				}
				$("#carrInfo").html(carrInfo);
			}
			
			if(acadCount == 0){
				$("#noAcadInfo").css("display","block");
				
			}else{
				var acadHtml = "";
				$("#noAcadInfo").css("display","none");
				
				for(let i = 0; i < acadCount; i++){
					acadHtml += "<div class='row' id='acadInfo"+result.acadList[i].acadNo+"'>";
					acadHtml += "<div class='col-md-1'>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-3'>";
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
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadName"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadName+"</p>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadClf"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadClf+"</p>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadEntDate"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadEntDate+"</p>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadEndDate"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadEndDate+"</p>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadStat"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadStat+"</p>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6' id='acadMaj"+result.acadList[i].acadNo+"'>"+result.acadList[i].acadMaj+"</p>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-1'>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='icon-demo-content'>";
					acadHtml += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					acadHtml += "<i class='uil-pen' data-bs-toggle='modal' data-bs-target='#acadModify"+result.acadList[i].acadNo+"'></i>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='icon-demo-content'>";
					acadHtml += "<div class='col-xl-3 col-lg-4 col-sm-6'>";
					acadHtml += "<i class='bx bx-x' onclick=\"fn_acadDel('"+result.acadList[i].acadNo+"')\"></i>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-3'>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<form method='post' id='acadModifyForm"+result.acadList[i].acadNo+"' novalidate='novalidate'>";
					acadHtml += "<input type='hidden' id='acadNo' value='"+result.acadList[i].acadNo+"' name='acadNo'/>";
					acadHtml += "<input type='hidden' id='empNo' value='"+result.empNo+"' name='empNo'/>";
					acadHtml += "<div id='acadModify"+result.acadList[i].acadNo+"' class='modal fade bs-example-modal-lg' role='dialog' tabindex='-1' aria-labelledby='myModalLabel' style='display: none;' aria-hidden='true'>";
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
					acadHtml += "<input class='form-control' type='text' id='acadClf' value='"+result.acadList[i].acadClf+"' name='acadClf' placeholder='학교구분'/>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='col-md-4 text-center'>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>학교이름</p>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-5'>";
					acadHtml += "<input class='form-control' type='text' id='acadName' value='"+result.acadList[i].acadName+"' name='acadName' placeholder='학교이름'/>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='col-md-4 text-center'>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>입학일자</p>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-5'>";
					acadHtml += "<input class='form-control' type='date' id='acadEntDate' value='"+result.acadList[i].acadEntDate+"' name='acadEntDate'/>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='col-md-4 text-center'>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업일자</p>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-5'>";
					acadHtml += "<input class='form-control' type='date' id='acadEndDate' value='"+result.acadList[i].acadEndDate+"' name='acadEndDate'/>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='col-md-4 text-center'>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>졸업여부</p>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-5'>";
					acadHtml += "<input class='form-control' type='text' id='acadStat' value='"+result.acadList[i].acadStat+"' name='acadStat' placeholder='졸업여부'/>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='row'>";
					acadHtml += "<div class='col-md-4 text-center'>";
					acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>전공</p>";
					acadHtml += "</div>";
					acadHtml += "<div class='col-md-5'>";
					acadHtml += "<input class='form-control' type='text' id='acadMaj' value='"+result.acadList[i].acadMaj+"' name='acadMaj' placeholder='전공' />";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "<div class='modal-footer'>";
					acadHtml += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
					acadHtml += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"javascript:fn_acadmod('"+result.acadList[i].acadNo+"')\">수정</button>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</div>";
					acadHtml += "</form>";
				}
			}
			$("#acadInfo").html(acadHtml);
			$("#acadInfo").css("display","block");
		},
		error : function(result){
			console.log(result);
			alert("실패");
		}
	});

	
	
	// 가족정보 추가
	var famRegisterForm = $("#famRegisterForm");
	var famRegisterBtn = $("#famRegisterBtn");
	
	famRegisterBtn.on("click", function(){
		
		var data = {
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
				html += "<div class='col-md-3'>";
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
				html += "<div class='col-md-5'>";
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
				Swal.fire({
					title : '가족정보가 추가되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
				$("#noFamInfo").css("display","none");
				$("#famInfo").css("display","block");
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
				
				var carrInfo = "";
				
				carrInfo += "<div class='row' id='carrInfo"+result.caNo+"'>";
				carrInfo += "<div class='col-md-1'>";
				carrInfo += "</div>";
				carrInfo += "<div class='col-md-3'>";
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
				carrInfo += "<div class='col-md-5'>";
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
				carrInfo += "<div class='col-md-5'>";
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
				carrInfo += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_carrmod('"+result.caNo+"')\">추가</button>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</div>";
				carrInfo += "</form>";

				$("#carrInfo").prepend(carrInfo);
				Swal.fire({
					title : '경력정보가 추가되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
				$("#noCarrInfo").css("display","none");
				$("#carrInfo").css("display","block");
				
			}
		});
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
				acadHtml += "<div class='col-md-3'>";
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
				acadHtml += "<div class='col-md-5'>";
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
				acadHtml += "<div class='col-md-5'>";
				acadHtml += "<input class='form-control' type='text' id='acadStat' value='"+result.acadStat+"' name='acadStat' placeholder='졸업여부'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='row'>";
				acadHtml += "<div class='col-md-4 text-center'>";
				acadHtml += "<p class='fw-bold px-4 py-2 fs-6'>전공</p>";
				acadHtml += "</div>";
				acadHtml += "<div class='col-md-5'>";
				acadHtml += "<input class='form-control' type='text' id='acadMaj' value='"+result.acadMaj+"' name='acadMaj' placeholder='전공'>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "<div class='modal-footer'>";
				acadHtml += "<button type='button' class='btn btn-light' data-bs-dismiss='modal'>취소</button>";
				acadHtml += "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' onclick=\"fn_acadmod('"+result.acadNo+"')\">추가</button>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</div>";
				acadHtml += "</form>";
				
				$("#acadInfo").prepend(acadHtml);
				Swal.fire({
					title : '학력정보가 추가되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
				$("#noAcadInfo").css("display","none");
				$("#acadInfo").css("display","block");
			}
		});
	});
});
	
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
				Swal.fire({
					title : '경력정보가 수정되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
			}
		});
		
	}
	
	// 가족정보 삭제
	function fn_famDel(efNo){
		var no = efNo;
		
		Swal.fire({
			  title: "정말 삭제하시겠습니까?",
			  text: "You won't be able to revert this!",
			  icon: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#038edc",
			  cancelButtonColor: "#d33",
			  cancelButtonText: "취소",
			  confirmButtonText: "삭제"
			}).then((result) => {
			  if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url : "/mypage/famDel?${_csrf.parameterName}=${_csrf.token}",
					data : {efNo : efNo},
					success : function(){
						console.log($("#famInfo").firstChild);
						console.log($("#famInfo").length);
						$("#famInfo"+efNo).remove();
						$("#famModifyForm"+efNo).remove();
						console.log($("#famInfo").length);
						if($("#famInfo").firstChild == null){
							$("#noFamInfo").css("display","block");
							$("#famInfo").css("display","none");
						}else{
							$("#famInfo").css("display","block");
							$("#noFamInfo").css("display","none");
						}
					}
				});
				Swal.fire({
					title : '가족정보가 삭제되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
			  }
			});
		
	}
	
	// 경력정보 삭제
	function fn_carrDel(caNo){

		Swal.fire({
			title: "정말 삭제하시겠습니까?",
			text: "You won't be able to revert this!",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: "#038edc",
			cancelButtonColor: "#d33",
			cancelButtonText: "취소",
			confirmButtonText: "삭제"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url : "/mypage/carrDel?${_csrf.parameterName}=${_csrf.token}",
					data : {caNo : caNo},
					success : function(){
						console.log("성공");
						$("#carrInfo"+caNo).remove();
						$("#carrModifyForm"+caNo).remove();
						if($("#carrInfo").firstChild == null){
		// 					alert("있음");
							$("#noCarrInfo").css("display","block");
							$("#carrInfo").css("display","none");
						}else{
							$("#carrInfo").css("display","block");
							$("#noCarrInfo").css("display","none");
						}
					}
				});
				Swal.fire({
					title : '경력정보가 삭제되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
			}
		});
	}
	
	// 학력정보 삭제
	function fn_acadDel(acadNo){
		Swal.fire({
			title: "정말 삭제하시겠습니까?",
			text: "You won't be able to revert this!",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: "#038edc",
			cancelButtonColor: "#d33",
			cancelButtonText: "취소",
			confirmButtonText: "삭제"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url : "/mypage/acadDel?${_csrf.parameterName}=${_csrf.token}",
					data : {acadNo : acadNo},
					success : function(){
						console.log("성공");
						$("#acadInfo"+acadNo).remove();
						$("#acadModifyForm"+acadNo).remove();
						if($("#acadInfo").length == 1){
		
							$("#noAcadInfo").css("display","block");
							$("#acadInfo").css("display","none");
						}else{
							$("#noAcadInfo").css("display","none");
							$("#acadInfo").css("display","block");
						}
						
					}
				});
				Swal.fire({
					title : '학력정보가 삭제되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
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
				Swal.fire({
					title : '가족정보가 수정되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
			}
		});
	}
	
	function fn_acadmod(acadNo){
		var form = $("#acadModifyForm"+acadNo).serialize();
		var modifyForm = $("#acadModifyForm"+acadNo);
		console.log(modifyForm.find("input[name=empNo]").val());
// 		console.log(form);
		
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
				Swal.fire({
					title : '학력정보가 수정되었습니다!',
					confirmButtonText: '확인',
					confirmButtonColor: '#038edc'
				});
			}
		});
	}
</script>