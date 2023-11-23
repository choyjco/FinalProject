<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jstree cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<div>
	<div class="card">
		<div class="tab-content p-3 text-muted col-md">
			<div class="tab-pane active" id="home1" role="tabpanel">
				<div class="card-body">
					<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
						<form method="post" id="searchForm">
							<ul class="nav nav-pills">
								<li class="nav-item"><input type="hidden" name="page"
									id="page" /> <select class="form-select" name="searchType">
										<option value="hrType"
											<c:if test="${searchType eq 'hrType' }">selected</c:if>>발령분류</option>
										<option value="hrResp"
											<c:if test="${searchType eq 'hrResp' }">selected</c:if>>발령자</option>
										<option value="hrDate"
											<c:if test="${searchType eq 'hrDate' }">selected</c:if>>일자</option>
										<option value="hrMemo"
											<c:if test="${searchType eq 'hrMemo' }">selected</c:if>>메모</option>
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
					<div class="table-responsive">
						<table class="table align-middle table-nowrap table-check table-hover">
							<thead>
								<tr>
									<th scope="col"><b>발령분류</b></th>
									<th scope="col"><b>발령자</b></th>
									<th scope="col"><b>발령내역등록일자</b></th>
									<th scope="col"><b>메모</b></th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:set value="${pagingVO.dataList }" var="mhr3List" />
								<c:choose>
									<c:when test="${empty mhr3List }">
										<tr class="text-center">
											<td colspan="6" class="text-dark font-weight-bolder">조회하신
												게시글이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${mhr3List }" var="hr">
											<tr>
												<td><a class="fw-medium" onclick="showDetailModal('${hr.hrCode }', '${hr.hrType }')">${hr.hrType }</a></td>
												<td>${hr.hrResp }</td>
												<td><fmt:formatDate value="${hr.hrDate }"
														pattern="yyyy-MM-dd HH:mm" /></td>
												<td>${hr.hrMemo }</td>
												<td>
													<div class="d-flex justify-content-center">
														<button type="button" class="btn btn-primary" onclick="memoModify('${hr.hrCode }')">메모수정</button>
													</div>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<div id="md2" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog"
                                        aria-labelledby="mySmallModalLabel" aria-hidden="true">
	                        <div class="modal-dialog modal-dialog-centered">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <h5 class="modal-title">메모 수정</h5>
	                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
	                                        aria-label="Close">
	                                    </button>
	                                </div>
	                                <div class="modal-body">
	                                    <textarea rows="5" cols=""class="form-control" id="hrMemo" name="hrMemo" placeholder="메모를 입력해주세요.">${hr.hrMemo }</textarea>
	                                    <div align="right" style="margin-top: 10px;">
	                                    	<button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
	                                	</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
						<!--  Extra Large modal example -->
						<div id="md1" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	                        <div class="modal-dialog modal-xl">
	                            <div class="modal-content">
	                                <div class="modal-header" >
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="tab-content p-3 text-muted col-md">
											<div>
												<h5 class="modal-title d-flex flex-wrap align-items-center justify-content-md-center" id="myExtraLargeModalLabel">${hrType }</h5>
												<div class="card-body">
													<div id="table-pagination" class="table">
														<div role="complementary" class="gridjs gridjs-container"
															style="width: 100%;">
															<div class="gridjs-wrapper" style="height: auto;">
																<table
																	class="table align-middle table-nowrap table-check">
																	<thead id="selecthType">
																	</thead>
																	<tbody id="deptBody">
																		<c:set value="${pagingVO.dataList }" var="mhr3DeptList" />
																		<c:choose>
																			<c:when test="${empty mhr3DeptList }">
																				<tr class="text-center">
																					<td colspan="6"
																						class="text-dark font-weight-bolder">조회하신
																						게시글이 존재하지 않습니다.</td>
																				</tr>
																			</c:when>
																			<c:otherwise>
																				<c:forEach items="${mhr3DeptList }" var="dp">
																					<tr>
																						<td id="hrName">${dp.hrName }</td>
																						<td id="empNo">${dp.empNo }</td>
																						<td id="hrHistory">${dp.hrHistory }</td>
																						<td id="hrDept">${dp.hrDept }</td>
																						<td id="hrPos">${dp.hrPos }</td>
																						<td id="hrStat">${dp.hrStat }</td>
																					</tr>
																				</c:forEach>
																			</c:otherwise>
																		</c:choose>
																	</tbody>
																</table>
															</div>
															<%-- <div class="gridjs-footer">
																<nav aria-label="Page navigation example" id="pagingArea">
																	${pagingVO.pagingHTML }</nav>
															</div> --%>
															<div id="gridjs-temp" class="gridjs-temp"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row g-0 text-center text-sm-start">
						<div class="col-sm">
							<nav aria-label="Page navigation example" id="pagingArea">
								${pagingVO.pagingHTML }</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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

function memoModify(hrCode) {
	console.log("hrCode : " + hrCode);
// 	var data = {
// 		hrCode: hrCode,
// 	};

	sessionStorage.setItem("hrCode",hrCode);
	
    var saveButton = $("#modifyBtn");
    var memoTextArea = $("#hrMemo"); 
    var hrCode = $("#hrCode"); 

    var temporaryMemo = ""; 

    saveButton.click(function() {
    
        var memoText = memoTextArea.val();
        
        temporaryMemo = memoText;
        
        let data = { 
            	"hrMemo":memoText,
            	"hrCode":sessionStorage.getItem("hrCode")           	
            };
        //data : {"hrMemo":"ㅇㅇㅇ","hrCode":"165"}
        console.log("data : " + JSON.stringify(data));
        
        $.ajax({
            method: "POST",
            url: "/hr/modifyMemo",
            contentType:"application/json;charset:utf-8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            dataType: "text",
            data: JSON.stringify(data),
            success: function(response) {
            	//success 또는 failed
            	console.log("response : " + response);
            	
                if (response=="success") {
                	alertify.success("수정 완료 되었습니다.");
                	$("#md2").modal('hide'); 
	                setTimeout(() => location.reload(), 1000);
                } else {
                	alertify.error("저장 실패하였습니다.");
                }
            },
            error: function() {
            	alertify.error("에러가 발생 했습니다.");
            }
        });
    });
    $("#md2").modal('show');
    
    $("#modifyBtn").click(function() {
        console.log("일시적으로 저장한 메모: " + temporaryMemo);
    });
}

function showDetailModal(hrCode, hrType) {
	// thead 컬럼명 처리
	let tHeadCol = document.querySelector("#selecthType");
	if(hrType == "승진"){
		tHeadCol.innerHTML = `
			<tr>
				<th scope="col">발령 대상 사원</th>
				<th scope="col">발령 대상 사번</th>
				<th scope="col">부서</th>
				<th scope="col">발령 전 직책</th>
				<th scope="col">발령 후 직책</th>
			</tr>
		`;
	}else if(hrType == "부서 이동"){
		tHeadCol.innerHTML = `
			<tr>
				<th scope="col">발령 대상 사원</th>
				<th scope="col">발령 대상 사번</th>
				<th scope="col">발령 전 부서 </th>
				<th scope="col">발령 후 부서</th>
				<th scope="col">직책</th>
			</tr>
		`;
	}else{
		tHeadCol.innerHTML = `
			<tr>
				<th scope="col">사원</th>
				<th scope="col">사번</th>
				<th scope="col">부서 </th>
				<th scope="col">재직상태</th>
			</tr>
		`;
	}

	
    var data = {
        hrType: hrType,
        hrCode: hrCode,
    };

    var hrName, empNo, hrDept, hrPos, hrType, hrCode, hrHistory;
    var htmlStr = "";
    
    var titleElement = $("#myExtraLargeModalLabel");
    titleElement.text(data.hrType);
    
    // ajax
    $.ajax({
        url: '/hr/mhr3Dept',
        method: 'POST',
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
        	
        	console.log()
        	
        	if( response.length > 0){
	            for (let i = 0; i < response.length; i++) {
	                var rowData = response[i];
					console.log("rowData => ", rowData)
	               /*  htmlStr += "<tr><td>" + rowData.hrName + "</td><td>" 
	                + rowData.empNo + "</td><td>" 
	                + rowData.hrHistory + "</td><td>" 
	                + rowData.hrDept + "</td><td>" 
	                + rowData.hrPos + "</td></tr>";
	            } */
	            
	            
	            if (hrType == "승진") {
		            	htmlStr += "<tr><td>" + rowData.hrName + "</td><td>" 
		                + rowData.empNo + "</td><td>" 
		                + rowData.hrDept + "</td><td>" 
		                + rowData.hrHistory + "</td><td>" 
		                + rowData.hrPos + "</td></tr>";
	                } else if(hrType == "부서 이동") {
	                	htmlStr += "<tr><td>" + rowData.hrName + "</td><td>" 
		                + rowData.empNo + "</td><td>" 
		                + rowData.hrHistory + "</td><td>" 
		                + rowData.hrDept + "</td><td>" 
		                + rowData.hrPos + "</td></tr>";
	                } else{
	                	htmlStr += "<tr><td>" + rowData.hrName + "</td><td>" 
		                + rowData.empNo + "</td><td>" 
		                + rowData.hrDept + "</td><td>" 
		                + rowData.hrStat + "</td><td>" 
	                }
        		}
	           
	            
	
	            $("#deptBody").html(htmlStr);
	            $("#md1").modal('show');
        		
        	}else{
        		htmlStr += "<tr><td colspan='7'>데이터가 존재하지 않습니다.</td></tr>";
        		
        		$("#deptBody").html(htmlStr);
	            $("#md1").modal('show');
        	}
        	
        }
    });
}
</script>


















