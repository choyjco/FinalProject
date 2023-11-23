<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<head>
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
					<div class="col-md-6">
						<div class="d-flex flex-wrap gap-2 mt-2 mt-md-0 mb-3">
							<span class="font-size-20 mb-1">
								<c:set var="today" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${today}" pattern="yyyy년 MM"/>월 정산 관리 <br/>
								<span class="font-size-14 mb-1">
									중간 정산 완료 사원은 ▷중간정산자 목록◁ 에서 확인 할 수 있습니다.
								</span>
							</span>
						</div>
					</div>
					<!-- end col -->

					<div class="col-md-6">
						<div class="d-flex flex-wrap align-items-center justify-content-md-end mt-2 mt-md-0 mb-3" style="background-color: rgba(245, 246, 248, 0.25);">
							<input class="form-control" type="text" name="searchWord" id="searchWord" placeholder="  사원이름, 부서 검색" style="width: 184px;"/>
							<button type="submit" class="btn btn-primary">
								검색
							</button>
							<button class="btn btn-purple" id="startInCal" style="margin-left: 10px;">
								정산하기
							</button>
						</div>
					</div><!-- end col -->
				</div>
				<!-- end row -->

				<div id="grid">
				</div>

				<div class="modal fade bs-example-modal-xl" id="modalTest"
					tabindex="-1" aria-labelledby="myExtraLargeModalLabel"
					aria-modal="true" role="dialog" style="display: none;"
					aria-hidden="true">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="myExtraLargeModalLabel">정산하기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="card">
									<div class="card-body">
										<div id="grid2"></div>
									</div>
									<div class="d-flex justify-content-md-end">
										<button class="btn btn-primary btn-sm d-flex justify-content-md-end" id="PAY">
											정산하기
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<!-- end row -->
	</div>
	<!-- end card -->
</div>
<script src="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
$(function() {
	var grid = $("#grid");
	var grid2 = $("#grid2");
	
	var search = $("#search");
	var startInCal = $("#startInCal");
	var PAY = $("#PAY");
	
	search.on("click", function() {
		var searchWord = $("#searchWord").val();
		var data = {
			searchWord : searchWord
		};
		$.ajax({
			method : "post",
			url : "/pay/searchList?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log(result);
				if(result.length == 0) {
					alertify.warning("조회하신 사원이 존재하지 않습니다.");
				}else{
					grid.resetData(result);
				}
			}
		});
	});
	
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		rowHeaders : [ 'checkbox' ],
		columns : [ {
			header : '사번',
			name : 'empNo',
			align : 'center',
// 			editor : 'text',
			sortable : true,
			resizeable : true
		}, {
			header : '사원명',
			name : 'empName',
			align : 'center',
// 			editor : 'text',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
// 			editor : 'text',
			sortable : true
		}, {
			header : '정산여부',
			name : 'incSetConf',
			align : 'center',
// 			editor : 'text',
			sortable : true
		}, {
			header : '재직상태',
			name : 'empStat',
			align : 'center',
			sortable : true
		},],
			pageOptions : {
			useClient : true,
			perPage : 10
		}
	});
	
	
	$.ajax({
		url : "/pay/inCalList",
		method : "get",
		// 		dataType : "application/json",
		contentType : "application/json; charset=utf-8",
		//         data : JSON.stringify(form),
		success : function(result) {
			// 	     	   console.log(result);
			grid.resetData(result);

		}
	});
	var tmp = 100;
	var grid2 = new tui.Grid({
		el : document.getElementById('grid2'),
		columns : [{
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true,
			resizeable : true
		}, {
			header : '사원명',
			name : 'empName',
			align : 'center',
			sortable : true
		}, {
			header : '기본급',
			name : 'gibonpay',
			align : 'right',
			sortable : true
		}, {
			header : '근무시간',
			name : 'workTime',
			align : 'right',
			sortable : true
		}, {
			header : '기타수당',
			name : 'gitapay',
			align : 'right',
			editor : 'text',
			sortable : true
		}, {
			header : '직책수당',
			name : 'jikpay',
			align : 'right',
			editor : 'text',
			sortable : true
		}, {
			header : '사대보험',
			name : 'sadae',
			align : 'right',
			sortable : true
		}, {
			header : '소득세',
			name : 'sodeuk',
			align : 'right',
			sortable : true
		},{
			header : '지급총액',
			name : 'incSetAmt',
			align : 'right',
			sortable : true
		},{
			header : '공제총액',
			name : 'incSetDedt',
			align : 'right',
			sortable : true
		},{
			header : '실지급액',
			name : 'incSetRes',
			align : 'right',
			sortable : true
		}],
			pageoptions : {
			useclient : true,
			perpage : 10
		}
	});
	
	
	startInCal.on("click", function() {
		var data = grid.getCheckedRows();
		
		$.ajax({
			method : "post",
			url : "/pay/inCalIng?${_csrf.parameterName}=${_csrf.token}",
			dataType : "json",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log("result : " + JSON.stringify(result));
				console.log("grid2 : " + grid2);
				$("#modalTest").modal("show");
				
				grid2.resetData(result);
				setTimeout(() => grid2.refreshLayout(), 500);
				
			}
		});
	});
	
	PAY.on("click", function name() {
		
		var data = {
				empNo : grid2.getColumnValues("empNo"),
				incSetAmt :  grid2.getColumnValues("incSetAmt"),
				incSetDedt :  grid2.getColumnValues("incSetDedt"),
				incSetRes :  grid2.getColumnValues("incSetRes")
		};
		
		var dataList = [];
		for (var i = 0; i < data.empNo.length; i++) {			
			var tempVO = {
					empNo : data["empNo"][i],
					incSetAmt : data["incSetAmt"][i],
					incSetDedt : data["incSetDedt"][i],
					incSetRes : data["incSetRes"][i]
			};
			
			dataList.push(tempVO);
		}
			
// 		console.log("@@ data : " + JSON.stringify(data));
// 		console.log("@@ rtnList : " + JSON.stringify(dataList));
		$.ajax({
			method : "post",
			url : "/pay/inPaying?${_csrf.parameterName}=${_csrf.token}",
			dataType : "json",
			data : JSON.stringify(dataList),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log("data : " + JSON.stringify(data));
				console.log("result : " + JSON.stringify(result));
			}
		});
		
		alertify.alert("정산", "정산이 완료되었습니다.", function(){ 
			$("#modalTest").modal("hide");
			location.href="/pay/middleCal";
		});
	});
});
</script>
