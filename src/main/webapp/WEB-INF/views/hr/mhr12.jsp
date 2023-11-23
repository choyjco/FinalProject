<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.css" />
<!-- jQuery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jstree cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<div>
	<div class="card">
		<div class="tab-content p-3 text-muted col-md">
			<div>
				<div class="card-body">
					<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
						<form action="/hr/searchMhr12" method="post" id="searchForm">
							<ul class="nav nav-pills">
								<li class="nav-item">
								<select class="form-select" name="searchType" id="searchType">
										<option value="empName">이름</option>
									    <option value="empNo">사번</option>
									    <option value="empDept">부서</option>
									    <option value="empJob">직위</option>
									    <option value="empStat">재직상태</option>
								</select></li>
								<li class="nav-item">
									<input type="text" name="searchWord" id="searchWord" class="form-control float-right" placeholder="카테고리 선택, 검색">
								</li>
								<li class="nav-item">
									<div class="input-group-append">
										<button type="button" id="search" class="btn btn-primary">
											검색
										</button>
									</div>
								</li>
								<sec:csrfInput />
							</ul>
						</form>
					</div>
					<div class="row">
						<div class="col-xl-3 col-sm-6">
							<div class="card border shadow-none">
								<div class="card-body" id="statBtn">
									<div class="d-flex align-items-center">
										<div class="flex-grow-1 overflow-hidden">
											<p class="mb-1 text-truncate text-muted" style="font-size: larger"><b>재직중</b></p>
											<c:forEach items="${StatCountList }" var="ct">
												<h5 class="font-size-16 mb-0" id="empStatCount1">${ct.empStatCount1}명</h5>
											</c:forEach>
										</div>
										<div class="flex-shrink-0 me-3">
											<!-- <div
												class="avatar-title bg-light text-primary rounded-circle" style="font-size: x-large" >
												<i class="uil uil-desktop-alt"></i>
											</div> -->
											<img src="${pageContext.request.contextPath }/resources/images/mhr1201.jpg" style="width: 60px; height: 60px;">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6">
							<div class="card border shadow-none">
								<div class="card-body" id="statBtn2">
									<div class="d-flex align-items-center">
										<div class="flex-grow-1 overflow-hidden">
											<p class="mb-1 text-truncate text-muted" style="font-size: larger"><b>휴직중</b></p>
											<c:forEach items="${StatCountList2 }" var="ct">
												<h5 class="font-size-16 mb-0" id="empStatCount2">${ct.empStatCount2}명</h5>
											</c:forEach>
										</div>
										<div class="flex-shrink-0 me-3">
											<!-- <div
												class="avatar-title bg-light text-primary rounded-circle" style="font-size: x-large">
												<i class="uil uil-calendar-alt"></i>
											</div> -->
											<img src="${pageContext.request.contextPath }/resources/images/mhr1202.jpg" style="width: 60px; height: 60px;">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6">
							<div class="card border shadow-none">
								<div class="card-body" id="statBtn3">
									<div class="d-flex align-items-center">
										<div class="flex-grow-1 overflow-hidden">
											<p class="mb-1 text-truncate text-muted" style="font-size: larger"><b>수습중</b></p>
											<c:forEach items="${StatCountList3 }" var="ct">
												<h5 class="font-size-16 mb-0" id="empStatCount3">${ct.empStatCount3}명</h5>
											</c:forEach>
										</div>
										<div class="flex-shrink-0 me-3">
											<!-- <div
												class="avatar-title bg-light text-primary rounded-circle" style="font-size: x-large">
												<i class="uil uil-users-alt"></i>
											</div> -->
											<img src="${pageContext.request.contextPath }/resources/images/mhr1203.jpg" style="width: 60px; height: 60px;">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-6">
							<div class="card border shadow-none">
								<div class="card-body" id="statBtn4">
									<div class="d-flex align-items-center">
										<div class="flex-grow-1 overflow-hidden">
											<p class="mb-1 text-truncate text-muted" style="font-size: larger"><b>퇴직 예정</b></p>
											<c:forEach items="${StatCountList4 }" var="ct">
												<h5 class="font-size-16 mb-0" id="empStatCount4">${ct.empStatCount4}명</h5>
											</c:forEach>
										</div>
										<div class="flex-shrink-0 me-3">
											<!-- <div
												class="avatar-title bg-light text-primary rounded-circle" style="font-size: x-large">
												<i class="uil uil-plane"></i>
											</div> -->
											<img src="${pageContext.request.contextPath }/resources/images/mhr1204.jpg" style="width: 60px; height: 60px;">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				<div id="grid"></div>
				</div>
				<!-- MODAL START -->
				<div id="statmodal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myExtraLargeModalLabel"><b>재직중</b></h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
							<div class="card">
								<div class="card-body">
									<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
										<form action="/hr/searchMhr12" method="post" id="searchForm1">
											<ul class="nav nav-pills">
												<li class="nav-item">
												<select class="form-select" name="searchType" id="searchType1">
														<option value="empName">이름</option>
													    <option value="empNo">사번</option>
													    <option value="empDept">부서</option>
													    <option value="empJob">직위</option>
													    <option value="empStat">재직상태</option>
												</select></li>
												<li class="nav-item">
													<input type="text" name="searchWord" id="searchWord1" class="form-control float-right" placeholder="카테고리 선택, 검색">
												</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="button" id="search1" class="btn btn-primary">
															검색
														</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
									<div id="gridStat"></div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="statmodal2" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myExtraLargeModalLabel"><b>휴직중</b></h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
							<div class="card">
									<div class="card-body">
									<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
										<form action="/hr/searchMhr12" method="post" id="searchForm1">
											<ul class="nav nav-pills">
												<li class="nav-item">
												<select class="form-select" name="searchType" id="searchType">
														<option value="empName">이름</option>
													    <option value="empNo">사번</option>
													    <option value="empDept">부서</option>
													    <option value="empJob">직위</option>
													    <option value="empStat">재직상태</option>
												</select></li>
												<li class="nav-item">
													<input type="text" name="searchWord" id="searchWord" class="form-control float-right" placeholder="카테고리 선택, 검색">
												</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="button" id="search" class="btn btn-primary">
															검색
														</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
									<div id="gridStat2"></div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="statmodal3" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myExtraLargeModalLabel"><b>수습중</b></h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
							<div class="card">
									<div class="card-body">
									<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
										<form action="/hr/searchMhr12" method="post" id="searchForm1">
											<ul class="nav nav-pills">
												<li class="nav-item">
												<select class="form-select" name="searchType" id="searchType">
														<option value="empName">이름</option>
													    <option value="empNo">사번</option>
													    <option value="empDept">부서</option>
													    <option value="empJob">직위</option>
													    <option value="empStat">재직상태</option>
												</select></li>
												<li class="nav-item">
													<input type="text" name="searchWord" id="searchWord" class="form-control float-right" placeholder="카테고리 선택, 검색">
												</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="button" id="search" class="btn btn-primary">
															검색
														</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
									<div id="gridStat3"></div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="statmodal4" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myExtraLargeModalLabel"><b>퇴직 예정</b></h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
							<div class="card">
									<div class="card-body">
									<div class="d-flex flex-wrap align-items-start justify-content-md-end mt-2 mt-md-0 gap-2 mb-3">
										<form action="/hr/searchMhr12" method="post" id="searchForm1">
											<ul class="nav nav-pills">
												<li class="nav-item">
												<select class="form-select" name="searchType" id="searchType">
														<option value="empName">이름</option>
													    <option value="empNo">사번</option>
													    <option value="empDept">부서</option>
													    <option value="empJob">직위</option>
													    <option value="empStat">재직상태</option>
												</select></li>
												<li class="nav-item">
													<input type="text" name="searchWord" id="searchWord" class="form-control float-right" placeholder="카테고리 선택, 검색">
												</li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="button" id="search" class="btn btn-primary">
															검색
														</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
									<div id="gridStat4"></div>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- MODAL END -->
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
$(function() {
	var search = $("#search");
	var grid = $("#grid");
	
	search.on("click", function(){
		var searchType = $("#searchType").val();
		var searchWord = $("#searchWord").val();
		
		var data = {
			searchType : searchType, 
			searchWord : searchWord, 
		};
		$.ajax({
			method : "post",
			url : "/hr/searchMhr12",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				grid.resetData(result);
			}
		});
	});

	$(document).ready(function() {
	    $("#searchForm").on("keyup keypress", function(e) {
	        var keyCode = e.keyCode || e.which;
	        if (keyCode === 13) {
	            e.preventDefault();
	            return false;
	        }
	    });
	});
	
	var search1 = $("#search1");
	var gridStat = $("#gridStat");
	
	search1.on("click", function(){
		var searchType = $("#searchType1").val();
		var searchWord = $("#searchWord1").val();
		
		var data = {
			searchType : searchType, 
			searchWord : searchWord, 
		};
		$.ajax({
			method : "post",
			url : "/hr/statList",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				gridStat.resetData(result);
			}
		});
	});

	$(document).ready(function() {
	    $("#searchForm1").on("keyup keypress", function(e) {
	        var keyCode = e.keyCode || e.which;
	        if (keyCode === 13) {
	            e.preventDefault();
	            return false;
	        }
	    });
	});

	

	var gridStat = new tui.Grid({
		el : document.getElementById('gridStat'),
		columns : [ {
			header : '이름',
			name : 'empName',
			align : 'center',
			sortable : true
		}, {
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
			sortable : true
		}, {
			header : '직위',
			name : 'empJob',
			align : 'center',
			sortable : true
		},{
			header : '재직상태',
			name : 'empStat',
			align : 'center',
			sortable : true
		},],
			pageOptions : {
				useClient : true,
				perPage : 10
			},
			scrollX : false,
			scrollY : false
	});
	
	
$("#statBtn").on("click", function() {
	var data = {
			empName: empName,
			empNo: empNo,
			empDept: empDept,
			empJob: empJob,
			empStat: empStat,
	    };
	
	var empName, empNo, empDept, empJob, empStat;
	
	$.ajax({
		method : "post",
		url : "/hr/statList",
	    beforeSend: function (xhr) {
        	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType : "json",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success : function(result){
			console.log("result : " + JSON.stringify(result));
			console.log("gridStat : " + gridStat);
			gridStat.resetData(result);
			$("#statmodal").modal("show");
			setTimeout(() => gridStat.refreshLayout(), 200);
			
		}
	}); 
});

var gridStat2 = new tui.Grid({
	el : document.getElementById('gridStat2'),
	columns : [ {
		header : '이름',
		name : 'empName',
		align : 'center',
		sortable : true
	}, {
		header : '사번',
		name : 'empNo',
		align : 'center',
		sortable : true
	}, {
		header : '부서',
		name : 'empDept',
		align : 'center',
		sortable : true
	}, {
		header : '직위',
		name : 'empJob',
		align : 'center',
		sortable : true
	},{
		header : '재직상태',
		name : 'empStat',
		align : 'center',
		sortable : true
	},],
		pageOptions : {
			useClient : true,
			perPage : 10
		},
		scrollX : false,
		scrollY : false
});

$("#statBtn2").on("click", function() {
	var data = {
			empName: empName,
			empNo: empNo,
			empDept: empDept,
			empJob: empJob,
			empStat: empStat,
	    };
	
	var empName, empNo, empDept, empJob, empStat;
	
	$.ajax({
		method : "post",
		url : "/hr/statList2",
	    beforeSend: function (xhr) {
        	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType : "json",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success : function(result){
			console.log("result : " + JSON.stringify(result));
			console.log("gridStat : " + gridStat);
			gridStat2.resetData(result);
			$("#statmodal2").modal("show");
			setTimeout(() => gridStat2.refreshLayout(), 200);
			
		}
	}); 
});

var gridStat3 = new tui.Grid({
	el : document.getElementById('gridStat3'),
	columns : [ {
		header : '이름',
		name : 'empName',
		align : 'center',
		sortable : true
	}, {
		header : '사번',
		name : 'empNo',
		align : 'center',
		sortable : true
	}, {
		header : '부서',
		name : 'empDept',
		align : 'center',
		sortable : true
	}, {
		header : '직위',
		name : 'empJob',
		align : 'center',
		sortable : true
	},{
		header : '재직상태',
		name : 'empStat',
		align : 'center',
		sortable : true
	},],
		pageOptions : {
			useClient : true,
			perPage : 10
		},
		scrollX : false,
		scrollY : false
});


$("#statBtn3").on("click", function() {
	var data = {
			empName: empName,
			empNo: empNo,
			empDept: empDept,
			empJob: empJob,
			empStat: empStat,
	    };
	
	var empName, empNo, empDept, empJob, empStat;
	
	$.ajax({
		method : "post",
		url : "/hr/statList3",
	    beforeSend: function (xhr) {
        	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType : "json",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success : function(result){
			console.log("result : " + JSON.stringify(result));
			console.log("gridStat : " + gridStat);
			gridStat3.resetData(result);
			$("#statmodal3").modal("show");
			setTimeout(() => gridStat3.refreshLayout(), 200);
			
		}
	}); 
});

var gridStat4 = new tui.Grid({
	el : document.getElementById('gridStat4'),
	columns : [ {
		header : '이름',
		name : 'empName',
		align : 'center',
		sortable : true
	}, {
		header : '사번',
		name : 'empNo',
		align : 'center',
		sortable : true
	}, {
		header : '부서',
		name : 'empDept',
		align : 'center',
		sortable : true
	}, {
		header : '직위',
		name : 'empJob',
		align : 'center',
		sortable : true
	},{
		header : '재직상태',
		name : 'empStat',
		align : 'center',
		sortable : true
	},],
		pageOptions : {
			useClient : true,
			perPage : 10
		},
		scrollX : false,
		scrollY : false
});


$("#statBtn4").on("click", function() {
	var data = {
			empName: empName,
			empNo: empNo,
			empDept: empDept,
			empJob: empJob,
			empStat: empStat,
	    };
	
	var empName, empNo, empDept, empJob, empStat;
	
	$.ajax({
		method : "post",
		url : "/hr/statList4",
	    beforeSend: function (xhr) {
        	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		dataType : "json",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		success : function(result){
			console.log("result : " + JSON.stringify(result));
			console.log("gridStat : " + gridStat);
			gridStat4.resetData(result);
			$("#statmodal4").modal("show");
			setTimeout(() => gridStat4.refreshLayout(), 200);
			
		}
	}); 
});

	
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		columns : [ {
			header : '이름',
			name : 'empName',
			align : 'center',
			sortable : true,
			resizeable : true
		}, {
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
			sortable : true
		}, {
			header : '직위',
			name : 'empJob',
			align : 'center',
			sortable : true
		},{
			header : '재직상태',
			name : 'empStat',
			align : 'center',
			editor : {
				type : 'select',
				options : {
					listItems : [ {
						text : '재직중',
						value : '재직중'
					}, {
						text : '휴직중',
						value : '휴직중'
					},{
						text : '수습중',
						value : '수습중'
					},{
						text : '퇴직 예정',
						value : '퇴직 예정'
					},
					
					]
				}
			}
		},],
			pageOptions : {
				useClient : true,
				perPage : 10
			},
			scrollX : false,
			scrollY : false
	});
	
	$.ajax({
		url : "/hr/mhr12GridList",
		method : "get",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			console.log(result);
			grid.resetData(result);

		}
	});
	
	grid.on("editingFinish", function(event) { // 수정이 발생한 그리드 위치의 정보()
		// event.rowKey : editingFinish 이벤트가 발생한 row의 위치
		var grid_empStat = event.rowKey;
		var grid_row_empStat = grid.getValue(grid_empStat, "empStat"); // 이벤트가 발생된 row의 empStat의 value
		var data = grid.getRow(grid_empStat); // 이벤트가 발생한 row 정보

		$.ajax({
			method : "post",
			url : "/hr/modifyMhr12",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			dataType : "json",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				alertify.success("재직상태가 변경되었습니다.");
				grid.resetData(result);
				setTimeout(() => location.reload(), 1000);
			}
		});
	});
});
</script>

















