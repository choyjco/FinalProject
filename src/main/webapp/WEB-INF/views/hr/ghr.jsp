<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
							<form action="/hr/ghrExcel" method="get">
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
											<option value="empDept1"
												<c:if test="${searchType eq 'empDept1' }">selected</c:if>>이름</option>
											<option value="empDept2"
												<c:if test="${searchType eq 'empDept2' }">selected</c:if>>부서</option>
											<option value="empDept3"
												<c:if test="${searchType eq 'empDept3' }">selected</c:if>>직위</option>
									</select></li>
									<li class="nav-item"><input type="text" name="searchWord"
										value="${searchWord }" class="form-control float-right"
										placeholder="Search"></li>
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
							<table class="table align-middle table-nowrap table-check gridjs-table table table-hover" id="data-table">
								<thead>
									<tr>
										<th scope="col">이름</th>
										<th scope="col">부서</th>
										<th scope="col">직위</th>
									</tr>
								</thead>
								<tbody>
									<c:set value="${pagingVO.dataList }" var="ghrList" />
									<c:choose>
										<c:when test="${empty ghrList }">
											<tr class="text-center">
												<td colspan="5" class="text-dark font-weight-bolder">조회하신
													게시글이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${ghrList }" var="hr">
												<tr onclick="location.href='/mypage/other?empNo=${hr.empNo }'">
													<td>
										                <c:choose>
										                    <c:when test="${empty hr.empProfile}">
										                        <img src="${pageContext.request.contextPath }/resources/images/profile.jpg" alt="" class="avatar-sm rounded-circle me-2">
										                    </c:when>
										                    <c:otherwise>
										                        <img src="${pageContext.request.contextPath }${hr.empProfile}" alt="" class="avatar-sm rounded-circle me-2">
										                    </c:otherwise>
										                </c:choose>
										                <a class="text-body fw-medium">${hr.empName }</a>
										            </td>
													<td>${hr.empDept }</td>
													<td>
														<div class="d-flex gap-2">
															<c:if test="${hr.empJob eq '사원' }">
																<h5><span class="badge badge-soft-secondary">${hr.empJob }</span></h5>
															</c:if>
															<c:if test="${hr.empJob eq '주임' }">
																<h5><span class="badge badge-soft-warning">${hr.empJob }</span></h5>
															</c:if>
															<c:if test="${hr.empJob eq '대리' }">
																<h5><span class="badge badge-soft-success">${hr.empJob }</span></h5>
															</c:if>
															<c:if test="${hr.empJob eq '과장' }">
																<h5><span class="badge badge-soft-purple">${hr.empJob }</span></h5>
															</c:if>
															<c:if test="${hr.empJob eq '차장' }">
																<h5><span class="badge badge-soft-info">${hr.empJob }</span></h5>
															</c:if>
															<c:if test="${hr.empJob eq '부장' }">
																<h5><span class="badge badge-soft-primary">${hr.empJob }</span></h5>
															</c:if>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="row g-0 text-center text-sm-start" style="padding-top: 20px">
							<div class="col-sm">
								<nav aria-label="Page navigation example" id="pagingArea">
									${pagingVO.pagingHTML }
								</nav>
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
				<div id="ajax"></div>
				<button type="button" id="openBtn" class="btn btn-outline-info btn-sm">
					전체열기
				</button>
				<button type="button" id="closeBtn" class="btn btn-outline-info btn-sm">
					전체 닫기
				</button>
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
		$(this).jstree("open_node", "a"); // 이 경우 id가 a번인 root노드(DDIT)를 열린 상태로 로드함
	});

});

//전체 열기 버튼
$("#openBtn").on("click", function(){
   $('#ajax').jstree("open_all");
});

// 전체 닫기 버튼
$("#closeBtn").on("click", function(){
   $('#ajax').jstree("close_all");
});

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
	      url: '/hr/selectTreeG',
	      method: 'POST',
	      beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		  },
	      data: { comCode: nodeID },
	      dataType: 'json',
	      success: function (response) {
	    	  console.log("pagingHTML : " + response.pagingHTML);
	    	  
	    	  $("#pagingArea").html(response.pagingHTML);
	    	  response = response.dataList; 
  
    	  for(let i = 0; i<response.length; i++) {
              var rowData = response[i];
              
			  var row = $('<tr>'); 
			  var cell1;
				 if (rowData.empProfile == null) {
					    cell1 = $('<td>').html('<img src="/resources/images/profile.jpg" alt="" class="avatar-sm rounded-circle me-2"><a href="/mypage/other?empNo=' + rowData.empNo + '" class="text-body fw-medium">' + rowData.empName + '</a>');
					} else {
					    cell1 = $('<td>').html('<img src="' + rowData.empProfile + '" alt="" class="avatar-sm rounded-circle me-2"><a href="/mypage/other?empNo=' + rowData.empNo + '" class="text-body fw-medium">' + rowData.empName + '</a>');
					}


			  var cell2 = $('<td>').text(rowData.empDept);
			  var cell3 = $('<td>').html('<div class="d-flex gap-2">' + badge(rowData.empJob) + '</div></div>');

			  function badge(empJob) {
			      switch (empJob) {
			          case '사원':
			              return '<h5><span class="badge badge-soft-secondary">' + empJob + '</span></h5>';
			          case '주임':
			              return '<h5><span class="badge badge-soft-warning">' + empJob + '</span></h5>';
			          case '대리':
			              return '<h5><span class="badge badge-soft-success">' + empJob + '</span></h5>';
			          case '과장':
			              return '<h5><span class="badge badge-soft-purple">' + empJob + '</span></h5>';
			          case '차장':
			              return '<h5><span class="badge badge-soft-info">' + empJob + '</span></h5>';
			          case '부장':
			              return '<h5><span class="badge badge-soft-primary">' + empJob + '</span></h5>';
			          default:
			              return empJob;
			      }
			  }
			    row.append(cell1, cell2, cell3);
			
			    dataTableBody.append(row);
    		}
		},
		error: function (error) {
        	console.error('Error:', error);
      }
    });
  });
});

</script>

















