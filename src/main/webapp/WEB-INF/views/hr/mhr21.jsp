<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<div>
	<div class="card">
		<div class="tab-content p-3 text-muted col-md">
			<div>
				<div class="card-body">
					<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
						<form method="post" id="searchForm">
							<ul class="nav nav-pills">
								<li class="nav-item"><input type="hidden" name="page"
									id="page" /> <select class="form-select" name="searchType">
										<option value="empName"
											<c:if test="${searchType eq 'empName' }">selected</c:if>>이름</option>
										<option value="empNo"
											<c:if test="${searchType eq 'empNo' }">selected</c:if>>사번</option>
										<option value="empDept"
											<c:if test="${searchType eq 'empDept' }">selected</c:if>>부서</option>
										<option value="empPos"
											<c:if test="${searchType eq 'empPos' }">selected</c:if>>직책</option>
								</select></li>
								<li class="nav-item"><input type="text" name="searchWord"
									value="${searchWord }" class="form-control float-right"
									placeholder="카테고리 선택, 검색"></li>
								<li class="nav-item">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary">
											검색
										</button>
									</div>
								</li>
								<sec:csrfInput />
							</ul>
						</form>
					</div>
					<div class="d-flex justify-content-center">
						<h4><b>승진</b></h4>
					</div>
					<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
						<button type="button" class="btn btn-primary" id="modifyPos">발령등록</button>
						<button type="button" class="btn btn-info " data-bs-toggle="modal"
                                        data-bs-target=".bs-example-modal-center">메모</button>
                        <div id="md1" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog"
                                        aria-labelledby="mySmallModalLabel" aria-hidden="true">
	                        <div class="modal-dialog modal-dialog-centered">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <h5 class="modal-title">메모</h5>
	                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
	                                        aria-label="Close">
	                                    </button>
	                                </div>
	                                <div class="modal-body">
	                                    <textarea rows="5" cols=""class="form-control" id="hrMemo" name="hrMemo" placeholder="메모를 입력해주세요."></textarea>
	                                    <div align="right" style="margin-top: 10px;">
	                                    	<button type="button" class="btn btn-primary" id="registerBtn">저장</button>
	                                	</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
					</div>
					<div id="table-pagination" class="table">
						<div role="complementary" class="gridjs gridjs-container"
							style="width: 100%;">
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table table table-hover" style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr">
											<th data-column-id="check" class="gridjs-th">
												<div class="gridjs-th-content"></div>
											</th>
											<th data-column-id="empName" class="gridjs-th"><div
													class="gridjs-th-content"><b>이름</b></div></th>
											<th data-column-id="empNo" class="gridjs-th"><div
													class="gridjs-th-content"><b>사번</b></div></th>
											<th data-column-id="empDept" class="gridjs-th"><div
													class="gridjs-th-content"><b>부서</b></div></th>
											<th data-column-id="" class="gridjs-th"><div
													class="gridjs-th-content"><b>기존 직책</b></div></th>
											<th data-column-id="empPos" class="gridjs-th"><div
													class="gridjs-th-content"><b>이동할 직책</b></div></th>
										</tr>
									</thead>
									<tbody class="gridjs-tbody">
										<c:set value="${pagingVO.dataList }" var="mhr2List" />
										<c:choose>
											<c:when test="${empty mhr2List }">
												<tr class="text-center">
													<td colspan="5" class="text-dark font-weight-bolder">조회하신
														게시글이 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${mhr2List }" var="hr">
													<tr class="gridjs-tr">
														<td data-column-id="check" class="gridjs-td">
															<div class="form-check">
																<div class="d-flex justify-content-center">
																	<input type="checkbox" class="form-check-input"
																		id="invalidCheck" required="">
																</div>
															</div>
														</td>
														<td data-column-id="empName" class="gridjs-td">${hr.empName }</td>
														<td data-column-id="empNo" class="gridjs-td">${hr.empNo }</td>
														<td data-column-id="empDept" class="gridjs-td">${hr.empDept }</td>
														<td data-column-id="" class="gridjs-td">${hr.empPos }</td>
														<td data-column-id="empPos" id="empPos" class="gridjs-td"><select
															class="form-select" name="searchType">
																<option value="">선택하세요</option>
																<option value="b002">파트장</option>
																<option value="b003">팀장</option>
																<option value="b004">실장</option>
																<option value="b005">본부장</option>
																<option value="b006">CFO</option>
																<option value="b007">CEO</option>
																<option value="b001">직책 없음</option>
														</select></td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<div class="gridjs-footer">
								<nav aria-label="Page navigation example" id="pagingArea">
									${pagingVO.pagingHTML }</nav>
							</div>
							<div id="gridjs-temp" class="gridjs-temp"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Sweet Alerts js -->
<script
	src="${pageContext.request.contextPath }/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

$(function() {
    var saveButton = $("#registerBtn");
    var memoTextArea = $("#hrMemo"); 

    var temporaryMemo = ""; 

    saveButton.click(function() {
        var memoText = memoTextArea.val();

        temporaryMemo = memoText;

        $("#md1").modal('hide'); 
    });

    $("#modifyPos").click(function() {
        console.log("일시적으로 저장한 메모: " + temporaryMemo);
    });
});

$(function(){
    var modifyPosButton = $("#modifyPos");
    var empPosSelect = $("#empPos");
    
    modifyPosButton.click(function() {
        var selectedPos = empPosSelect.val();
        
        var checkedRowsData = [];
        $(".form-check-input:checked").each(function() {
            var row = $(this).closest("tr");
            var empName = row.find(".gridjs-td[data-column-id='empName']").text();
            var empNo = row.find(".gridjs-td[data-column-id='empNo']").text();
            var empDept = row.find(".gridjs-td[data-column-id='empDept'] select").val();
            var empPos = row.find(".gridjs-td[data-column-id='empPos'] select").val();
            var data = {
            	empName: empName,
                empNo: empNo,
                empDept: empDept,
                empPos: empPos,
            };
            checkedRowsData.push(data);
            console.log(data);
        });

        if (checkedRowsData.length === 0) {
        	alertify.warning("수정할 곳에 체크 해주세요.");
            return;
        }

        $.ajax({
            method: "post",
            url: "/hr/modifyMhr21",
            beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
            dataType: "json",
            data: JSON.stringify({hrHxVOList: checkedRowsData, hrMemo : $("#hrMemo").val()}),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                console.log("RESULT " + result);
                alertify.success("등록 완료되었습니다.");
                setTimeout(() => location.reload(), 1000);
            }
        });
    });
});



</script>
























