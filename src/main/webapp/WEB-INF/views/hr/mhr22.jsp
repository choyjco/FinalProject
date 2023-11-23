<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
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
			<div>
				<div class="card-body">
					<div class="d-flex justify-content-end">
						<button type="button" id="imp" class="btn btn-primary">채용처리</button>		
					</div>
					<a>※처리상태가 <b style="color: black;">합격</b>인 해당 사람의 부서, 직위, 근로유형을 더블클릭하여 선택하고 처리버튼을 누르십시오. </a>
					<div id="grid"></div>
				</div>	
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script type="text/javascript">
$(function() {
	
	$.ajax({
		url : "/hr/mhr22GridList",
		method : "get",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			
			console.log('result =>',result);
			grid.resetData(result);
		}
	});
	
	//채용처리 버튼 클릭
	$("#imp").on("click",function(){
		console.log("here is imp");
		
		//let trArr = $("#grid").children("div").children("div:eq(0)").children("div:eq(1)").children("div:eq(1)").children("div").children("div").children("table").children("tbody").children("tr"); //.html();
		
		var elem = $("#grid").find(".tui-grid-rside-area").find(".tui-grid-body-area").find("tr");
		var data = [];
		elem.map(function(i,e){
			var recno = $(e).find(".tui-grid-cell")[0];
			var ele = $(e).find(".tui-grid-cell")[4];
			var dept = $(e).find(".tui-grid-cell")[5];
			var job = $(e).find(".tui-grid-cell")[6];
			var work = $(e).find(".tui-grid-cell")[7];
			if(ele.children[0].innerText == "합격" && dept.children[0].innerText != ""){
				data.push({
					recCode : recno.children[0].innerText,
					empDept : dept.children[0].innerText,
					empJob : job.children[0].innerText,
					empWork : work.children[0].innerText
				});
			}
		});
		
		console.log(data);
		$.ajax({
			method : "post",
			url : "/hr/register",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data : JSON.stringify(data),
			dataType : "text",
			contentType : "application/json; charset=utf-8",
			success : function(result){
				console.log("result : " + result);
				if(result > 0){
					alertify.success("채용등록이 완료되었습니다.");
	                setTimeout(() => location.reload(), 1000);
				}else{
					alertify.error("합격자만 채용처리 할 수 있습니다!");
	                setTimeout(() => location.reload(), 1000);
				}
			}
		});
	});


	var grid = $("#grid");
	
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		columns : [ {
			header : '지원번호',
			name : 'recCode',
			align : 'center',
			sortable : true,
			resizeable : true
		},{
			header : '지원종류',
			name : 'recType',
			align : 'center',
			sortable : true,
			resizeable : true
		}, {
			header : '이름',
			name : 'recName',
			align : 'center',
			sortable : true
		}, {
			header : '성별',
			name : 'recGen',
			align : 'center',
			sortable : true
		}, {
			header : '처리상태',
			name : 'recStat',
			align : 'center',
			sortable : true
		},{
			header : '부서',
			name : 'empDept',
			align : 'center',
			editor : {
				type : 'select',
				options : {
					listItems : [ {
						text : '개발 1팀',
						value :'개발 1팀'
					}, {
						text : '개발 2팀',
						value : '개발 2팀'
					},{
						text : '개발 3팀',
						value : '개발 3팀'
					},{
						text : '개발 4팀',
						value : '개발 4팀'
					},{
						text : '개발 5팀',
						value : '개발 5팀'
					},{
						text : '영업 1팀',
						value : '영업 1팀'
					},{
						text : '영업 2팀',
						value : '영업 2팀'
					},{
						text : '영업 3팀',
						value : '영업 3팀'
					},{
						text : '경영 1팀',
						value : '경영 1팀'
					},{
						text : '경영 2팀',
						value : '경영 2팀'
					},{
						text : '인사 1팀',
						value : '인사 1팀'
					},{
						text : '인사 2팀',
						value : '인사 2팀'
					},{
						text : '마케팅 1팀',
						value : '마케팅 1팀'
					},{
						text : '마케팅 2팀',
						value : '마케팅 2팀'
					},{
						text : '개발 A팀',
						value : '개발 A팀'
					},{
						text : '개발 B팀',
						value : '개발 B팀'
					},{
						text : '개발 C팀',
						value : '개발 C팀'
					},
					]
				}
			}
		},{
			header : '직위',
			name : 'empJob',
			align : 'center',
			editor : {
				type : 'select',
				options : {
					listItems : [ {
						text : '사원',
						value : '사원'
					}, {
						text : '주임',
						value : '주임'
					},{
						text : '대리',
						value : '대리'
					},{
						text : '과장',
						value : '과장'
					},{
						text : '차장',
						value : '차장'
					},{
						text : '부장',
						value : '부장'
					},
					]
				}
			}
		},{
			header : '근로유형',
			name : 'empWork',
			align : 'center',
			editor : {
				type : 'select',
				options : {
					listItems : [ {
						text : '정규직',
						value : '정규직'
					}, {
						text : '계약직',
						value : '계약직'
					},
					]
				}
			}
		},
		],
		pageOptions : {
			useClient : true,
			perPage : 20
		},
		scrollX : false,
		scrollY : false
	});
});
</script>


















