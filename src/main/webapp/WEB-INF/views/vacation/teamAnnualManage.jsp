<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
               		<div class="d-flex">
		                <div class="p-2 flex-grow-1"></div>
	                	<div class="p-2">
	                		<button type="button" class="btn btn-light" id="download">
		                		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
								  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"></path>
								  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"></path>
								</svg>
					           	내역 다운로드
					        </button>
	                	</div>
	                	<div class="p-2">
	                		<button type="button" class="btn btn-purple" id="annUpdate" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRightVac" aria-controls="offcanvasRight">
	                			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
								  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
								  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
								</svg>
	                			연차 일괄 조정
	                		</button>
	                	</div>
				    </div>
					    	<form method="post" id="searchForm">
					    		<input type="hidden" name="page" id="page"/>
								<div class="row d-flex justify-content-between">
	                				<div class="col-3">
	                					<select class="form-select" id="selectDept" name="selectDept" aria-label="Default select example" style="width:133px;">
						                	<c:forEach items="${comList}" var="comList">
							                	<c:if test="${fn:startsWith(comList.comCode, 'a') }">
													<option <c:if test="${pagingVO.selectDept eq comList.comCode }">selected="selected"</c:if> value="${comList.comCode}">${comList.comName}</option>
							                	</c:if>
										    </c:forEach>
										</select>
									</div>
				                	<div class="col-4"></div>
				                	<div class="col-5 d-flex justify-content-end" style="margin-bottom: 5px; ">
										<select id="yearSelect" name="yearSelect" class="form-select" aria-label="Default select example" style="width:133px; margin-bottom: 2px; margin-right: 3px;">
											<option <c:if test="${pagingVO.yearSelect eq '2013'}">selected="selected"</c:if> value="2013">2013</option>
											<option <c:if test="${pagingVO.yearSelect eq '2014'}">selected="selected"</c:if> value="2014">2014</option>
											<option <c:if test="${pagingVO.yearSelect eq '2015'}">selected="selected"</c:if> value="2015">2015</option>
											<option <c:if test="${pagingVO.yearSelect eq '2016'}">selected="selected"</c:if> value="2016">2016</option>
											<option <c:if test="${pagingVO.yearSelect eq '2017'}">selected="selected"</c:if> value="2017">2017</option>
											<option <c:if test="${pagingVO.yearSelect eq '2018'}">selected="selected"</c:if> value="2018">2018</option>
											<option <c:if test="${pagingVO.yearSelect eq '2019'}">selected="selected"</c:if> value="2019">2019</option>
											<option <c:if test="${pagingVO.yearSelect eq '2020'}">selected="selected"</c:if> value="2020">2020</option>
											<option <c:if test="${pagingVO.yearSelect eq '2021'}">selected="selected"</c:if> value="2021">2021</option>
											<option <c:if test="${pagingVO.yearSelect eq '2022'}">selected="selected"</c:if> value="2022">2022</option>
											<option <c:if test="${pagingVO.yearSelect eq '2023'}">selected="selected"</c:if> value="2023">2023</option>
										</select>
				                		<div class="gridjs-search">
											<input type="text" id="searchWord" name="searchWord" value="${searchWord }" placeholder="사원명 검색" aria-label="Type a keyword..." class="gridjs-input gridjs-search-input">
											<button type="submit" style="margin-bottom: 4px;" class="btn btn-primary" id="searchBtn">검색</button>
										</div>
				                	</div>
							    </div>
							    <sec:csrfInput/>
						    </form>
		                    <table class="table table-bordered align-middle table-nowrap table-check">
		                        <thead class="table-light">
		                            <tr>
		                                <th scope="col">이름</th>
		                                <th scope="col">사번</th>
		                                <th scope="col">부서</th>
		                                <th scope="col">잔여 연차</th>
		                                <th scope="col">1월</th>
		                                <th scope="col">2월</th>
		                                <th scope="col">3월</th>
		                                <th scope="col">4월</th>
		                                <th scope="col">5월</th>
		                                <th scope="col">6월</th>
		                                <th scope="col">7월</th>
		                                <th scope="col">8월</th>
		                                <th scope="col">9월</th>
		                                <th scope="col">10월</th>
		                                <th scope="col">11월</th>
		                                <th scope="col">12월</th>
		                            </tr>
		                        </thead>
		                        <tbody id="tbody">
		                        	<c:set value="${pagingVO.dataList }" var="annList"/>
		                        	<c:choose>
		                        		<c:when test="${empty annList }">
		                        			<tr>
		                        				<td colspan="16" align="center">검색 내역이 존재하지 않습니다.</td>
		                        			</tr>
		                        		</c:when>
		                        		<c:otherwise>
		                        			<c:forEach items="${annList }" var="annList">
				                            <tr>
				                                <td>${annList.empName }</td>
				                                <td>${annList.empNo }</td>
				                                <td>${annList.comName }</td>
				                                <td>
										            <c:set var="curVacation" 
												            value="${annList.jan + annList.feb + annList.mar + annList.apr 
												            		+ annList.may + annList.jun + annList.jul + annList.aug 
												            		+ annList.sep + annList.oct + annList.nov + annList.dec}" />
										            ${curVacation}
				                                </td>
				                                <td>${annList.jan }</td>
				                                <td>${annList.feb }</td>
				                                <td>${annList.mar }</td>
				                                <td>${annList.apr }</td>
				                                <td>${annList.may }</td>
				                                <td>${annList.jun }</td>
				                                <td>${annList.jul }</td>
				                                <td>${annList.aug }</td>
				                                <td>${annList.sep }</td>
				                                <td>${annList.oct }</td>
				                                <td>${annList.nov }</td>
				                                <td>${annList.dec }</td>
				                            </tr>
											</c:forEach>
		                        		</c:otherwise>
		                        	</c:choose>
		                        </tbody>
		                    </table>
					    </div>
				    </div>
					<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRightVac" aria-labelledby="offcanvasRightLabel" style="background-color: #e6f4fc; width: 40%">
						<div class="offcanvas-header">
					    	<h3 id="offcanvasRightLabel placeholder-glow" style="color: #0380c6;"><strong>연차 일괄 조정</strong></h3>
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
													<td width="45%">휴가 부여 일수</td>
													<td width="55%" height="40px;">
														<div class="col-md-12 d-flex flex-wrap align-items-center justify-content-md-center" style="padding-right: 0px; height: 25px;">
															<input type="text" class="form-control" id="vacAmt" style="height: 25px;" required /> 
														</div>
													</td>
												</tr>
												<tr>
													<td>적용 성별</td>
													<td style="position:relative; justify-content: center;" height="40px;">
														<input class="form-check-input" type="checkbox" id="vacGenAll" checked/>
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
											<textarea id="vacRsn" class="form-control" placeholder="조정 사유를 입력하세요."></textarea>
										</div>
									</div>
									<div class="d-flex flex-wrap align-items-end justify-content-md-end">
										<button type="button" class="btn btn-light d-flex align-items-end" id="autoBtn">자동완성</button>	
										<button type="button" class="btn btn-primary d-flex align-items-end" id="vacChgBtn">조정하기</button>	
									</div>
								</form>
							</div>
						</div>
						<!-- offCanvas Body 끝 -->
					</div>
					<!-- 휴가 추가 오른쪽 offCanvas 끝 -->
				    <div class="card-footer clearfix" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>	
                </div>
            </div>
        </div>
<form action="/excel/annualmanagelist" method="post" id="vacForm">
	<input type="hidden" name="selYear" id="selYear">
	<sec:csrfInput/>
</form>

<script type="text/javascript">
$(function() {
	var download = $("#download"); // 엑셀 다운로드 버튼
	var annUpdate = $("#annUpdate"); // 연차 일괄 조정 버튼
	var searchForm = $("#searchForm"); // 검색 폼
	var searchWord = $("#searchWord"); // 사원명 검색
	var selectDept = $("#selectDept"); // 부서 검색
	var yearSelect = $("#yearSelect"); // 연도 검색
	var pagingArea = $("#pagingArea"); // 페이징 구역
	var vacChgBtn = $("#vacChgBtn"); // 연차 일괄 조정 오프캔버스 내부의 실행 버튼 
	var autoBtn = $("#autoBtn"); // 연차 일괄 조정 오프캔버스 내부의 자동완성
	var vacName = $("#vacName"); // 오프캔버스 내부 휴가명입력
	var vacCont = $("#vacCont"); // 오프캔버스 내부 휴가정보입력
	var vacAmt = $("#vacAmt"); // 오프캔버스 내부 휴가부여일수입력
	var vacRsn = $("#vacRsn"); // 오프캔버스 내부 조정사유 입력
	
    
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	    
	selectDept.on("change", function(){
		searchForm.submit();
	});

	yearSelect.on("change", function(){
		searchForm.submit();
	});
	
	autoBtn.on("click", function() {
    	vacName.val("대체 휴가");
    	vacCont.val("회사 창립일 대체 휴가");
    	vacAmt.val("1");
    	vacRsn.val("회사창립일과 공휴일이 겹쳐 연차 하루를 대체하여 부여합니다.");
    	
	});

    download.on("click", function() {
    	$("#selYear").val($("#yearSelect").val());
    	vacForm.submit();
	});
    
    vacChgBtn.on("click", function(){
    	 $.ajax({
 		    type: "get",
 		    url: "/vacation/allvacchange",
//  		    beforeSend : function(xhr){
//  		      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//  		   }, 
//  		    data: JSON.stringify(data), 
//  		    contentType : "application/json; charset=utf-8",
//  		    dataType : "json",
 		    success: function(res) {
 		    	console.log(res);
 		    	if(res == "OK"){
 		    		location.reload();
 		    	}
 		    }
		});
	});
	
});
</script>