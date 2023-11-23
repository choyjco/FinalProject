<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
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
		<div class="d-flex">
			<div class="tab-content p-3 text-muted col-md-10">
				<div>
					<div class="card-body">
						<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
							 <form action="/hr/mhr1Excel" method="get">
					            <button type="submit" class="btn btn-light">
									<i class="bx bx-download" data-feather="download" style="width: 20px; height: 20px; margin-bottom: 3px"></i>
									사원정보 엑셀 다운로드
								</button>
					        </form>
							<form method="post" id="searchForm">
								<ul class="nav nav-pills">
									<li class="nav-item"><input type="hidden" name="page"
										id="page" />
									<input type="hidden" id="comCode" name="comCode" value="${comCode}" />
									<select class="form-select" name="searchType">
											<option value="empName"
												<c:if test="${searchType eq 'empName' }">selected</c:if>>이름</option>
											<option value="empStat"
												<c:if test="${searchType eq 'empStat' }">selected</c:if>>재직상태</option>
											<option value="empNo"
												<c:if test="${searchType eq 'empNo' }">selected</c:if>>사번</option>
											<option value="empDate"
												<c:if test="${searchType eq 'empDate' }">selected</c:if>>입사일</option>
											<option value="emptEndDate"
												<c:if test="${searchType eq 'emptEndDate' }">selected</c:if>>퇴사일</option>
											<option value="empWork"
												<c:if test="${searchType eq 'empWork' }">selected</c:if>>근로유형</option>
									</select></li>
									<li class="nav-item">
										<input type="text" name="searchWord" value="${searchWord }" class="form-control float-right"
										placeholder="카테고리 선택, 검색">
									</li>
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
					<%-- <div class="d-flex justify-content-center">
						<input type="text" id="empDept" name="empDept" value="${empDept}" />
						<h4>${empDept}</h4>
					</div> --%>
						<div id="table-sorting" class="table">
							<div role="complementary" class="gridjs gridjs-container" style="width: 100%;">
								<div class="gridjs-wrapper" style="height: auto;" id="data-table">
									<table role="grid" class="gridjs-table table table-hover" style="height: auto;" >
										<thead class="gridjs-thead">
											<tr class="gridjs-tr">
												<th data-column-id="empName" class="gridjs-th gridjs-th-sort"">
							                        <div class="gridjs-th-content">이름</div>
							                        <button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-desc"></button>
						                        </th>
												<th data-column-id="empStat" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">재직상태</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
												<th data-column-id="empNo" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">사번</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
												<th data-column-id="empDate" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">입사일</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
						                        <th data-column-id="emptEndDate" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">퇴사일</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
						                        <th data-column-id="empKdate" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">근속기간</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
						                        <th data-column-id="empWork" class="gridjs-th gridjs-th-sort">
						                        	<div class="gridjs-th-content">근로유형</div>
						                        	<button tabindex="-1" aria-label="Sort column ascending" title="Sort column ascending" class="gridjs-sort gridjs-sort-neutral"></button>
						                        </th>
											</tr>
										</thead>
										<tbody class="gridjs-tbody">
											<c:set value="${pagingVO.dataList }" var="mhr1List" />
											<c:choose>
												<c:when test="${empty mhr1List }">
													<tr class="text-center">
														<td colspan="5" class="text-dark font-weight-bolder">조회하신
															게시글이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${mhr1List }" var="hr">
														<tr class="gridjs-tr" onclick="location.href='/mypage/other?empNo=${hr.empNo }'">
															<td data-column-id="empName" class="gridjs-td">${hr.empName }</td>
															<td data-column-id="empStat" class="gridjs-td">
																<div class="d-flex gap-2">
																	<c:if test="${hr.empStat eq '재직중' }">
																		<h5><span class="badge badge-soft-primary">${hr.empStat }</span></h5>
																	</c:if>
																	<c:if test="${hr.empStat eq '휴직중' }">
																		<h5><span class="badge badge-soft-warning">${hr.empStat }</span></h5>
																	</c:if>
																	<c:if test="${hr.empStat eq '수습중' }">
																		<h5><span class="badge badge-soft-success">${hr.empStat }</span></h5>
																	</c:if>
																	<c:if test="${hr.empStat eq '퇴직예정' }">
																		<h5><span class="badge badge-soft-purple">${hr.empStat }</span></h5>
																	</c:if>
																	<c:if test="${hr.empStat eq '퇴직완료' }">
																		<h5><span class="badge badge-soft-secondary">${hr.empStat }</span></h5>
																	</c:if>
																</div>
															</td>
															<td data-column-id="empNo" class="gridjs-td">${hr.empNo }</td>
															<td data-column-id="empDate" class="gridjs-td">
																<fmt:formatDate value="${hr.empDate }" pattern="yyyy-MM-dd" />
															</td>
															<td data-column-id="emptEndDate" class="gridjs-td">
																<fmt:formatDate value="${hr.emptEndDate}" pattern="yyyy-MM-dd" />
															</td>
															<td data-column-id="empKdate" class="gridjs-td" style="text-align: right;">${hr.empKdate} 일</td>
															<td data-column-id="empWork" class="gridjs-td">
																<div class="d-flex gap-2">
																	<h5><span class="badge badge-soft-primary">${hr.empWork }</span></h5>
																</div>
															</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
								<div class="gridjs-footer">
									<nav aria-label="Page navigation example" id="pagingArea">
										${pagingVO.pagingHTML }
									</nav>
								</div>
								<div id="gridjs-temp" class="gridjs-temp"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="vr"></div>
			<div class="card-body">
				<div>
					<h4></h4>
				</div>
				<div class="mb-3">
					<span class="card-title fw-bold fs-5"><b>조직도</b></span>
				</div>
				<div class="justify-content-between d-flex align-items-center">
					<h4 class="card-title">
						<c:forEach items="${EmpCount }" var="ec">
							전체 구성원 <span class="text-muted fw-normal ms-2">${ec.empCount}명</span>
						</c:forEach>
					</h4>
				</div>
				<div></div>
				<div id="ajax"></div>
				<button type="button" id="openBtn"
					class="btn btn-outline-info btn-sm">전체열기</button>
				<button type="button" id="closeBtn"
					class="btn btn-outline-info btn-sm">전체 닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
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
	$('#ajax').jstree({
		'core' : {
			'data' : {
				"url" : "/hr/hr.do",
				"dataType" : "json"
			},
		},
	});

	// 해당 id의 노드를 open 상태로 바꿉니다.
	$("#ajax").on("ready.jstree", function() {
		$(this).jstree("open_node", "a"); // 이 경우 id가 1번인 root노드(DDIT)를 열린 상태로 로드함
	});

});

//전체 열기 버튼
$("#openBtn").on("click", function() {
	$('#ajax').jstree("open_all");
});

// 전체 닫기 버튼
$("#closeBtn").on("click", function() {
	$('#ajax').jstree("close_all");
});


function formatDateString(dateString) {
    var date = new Date(dateString); 
    var year = date.getFullYear().toString();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month + '-' + day;
}

//클릭된 노드 정보출력
$('#ajax').on('changed.jstree', function (e, data) {
  var selectedNodeIDs = data.selected;
  var dataTableBody = $('#data-table tbody');

  dataTableBody.empty();

  selectedNodeIDs.forEach(function (nodeID) {
    
	console.log("nodeID : " + nodeID);
	$("#comCode").val(nodeID);

	$("input[name='searchWord']").val("");
	  
    $.ajax({
      url: '/hr/selectTree',
      method: 'POST',
      beforeSend: function(xhr){
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	  },
      data: { comCode: nodeID },
      dataType: 'json',
      success: function (response) {
    	  console.log("pagingHTML : " + response.pagingHTML);
    	  
    	  $("#pagingArea").html(response.pagingHTML);
    	  //response : PaginationInfoVO<EmpVO> pagingVO
    	  //pagingVO.dataList
    	  response = response.dataList; 
    
        for(let i = 0; i<response.length; i++) {
          var rowData = response[i];

          var row = $('<tr class="gridjs-tr">'); 
          var cell1 = $('<td data-column-id="empName" class="gridjs-td"><a href="/mypage/other?empNo=' + rowData.empNo + '" class="text-body fw-medium">' + rowData.empName + '</a>');
          var cell2 = $('<td data-column-id="empStat" class="gridjs-td">').html('<div class="d-flex gap-2">' + badge(rowData.empStat) + '</div>');
          function badge(empStat) {
              switch (empStat) {
                  case '재직중':
                      return '<h5><span class="badge badge-soft-primary">' + empStat + '</span></h5>';
                  case '휴직중':
                      return '<h5><span class="badge badge-soft-warning">' + empStat + '</span></h5>';
                  case '수습중':
                      return '<h5><span class="badge badge-soft-success">' + empStat + '</span></h5>';
                  case '퇴직예정':
                      return '<h5><span class="badge badge-soft-purple">' + empStat + '</span></h5>';
                  case '퇴직완료':
                      return '<h5><span class="badge badge-soft-secondary">' + empStat + '</span></h5>';
                  default:
                      return empStat;
              }
          }
          var cell3 = $('<td data-column-id="empNo" class="gridjs-td">').text(rowData.empNo);
          var originalDate = rowData.empDate;
          var formattedDate = formatDateString(originalDate);
          var cell4 = $('<td data-column-id="empDate" class="gridjs-td">').text(formattedDate);
          var originalDate2 = rowData.emptEndDate;
          if (originalDate2) {
              var formattedDate2 = formatDateString(originalDate2);
              var cell5 = $('<td data-column-id="emptEndDate" class="gridjs-td">').text(formattedDate2);
          } else {
              var cell5 = $('<td data-column-id="emptEndDate" class="gridjs-td">');
          }
          var empKdateDay = rowData.empKdate + "일";
          var cell6 = $('<td data-column-id="empKdate" class="gridjs-td" style="text-align: right;">').text(empKdateDay);
          var cell7 = $('<td data-column-id="empWork" class="gridjs-td">').html('<div class="d-flex gap-2"><h5><span class="badge badge-soft-primary">'+ rowData.empWork + '</div></div>');

          row.append(cell1, cell2, cell3, cell4, cell5, cell6, cell7);
          console.log('row:', row)
          dataTableBody.append(row);
          
        }//end for
        
       
      },
      error: function (error) {
        console.error('Error:', error);
      }
    });
  });
});


	
</script>

















