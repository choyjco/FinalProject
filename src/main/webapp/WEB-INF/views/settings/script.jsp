<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- jstree cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<!-- 아이콘 스타일 cdn -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="${pageContext.request.contextPath }/resources/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-time-picker/dist/tui-time-picker.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-pagination/dist/tui-pagination.js"></script>
<script src="${pageContext.request.contextPath }/resources/tui-grid/dist/tui-grid.js"></script>
<script type="text/javascript">
function fn_xlsXlsxChk(fileName) {
	
	// 문자열.split() 메소드는 문자열을 파라미터에 적은 문자로 구분하여 배열로 저장한다.
	var tmp = fileName.split(".");
	var extensionType = tmp[1];
	    
	// extensionType에 담은 확장자가 'xls' 또는 'xlsx'이면 true를 리턴. 아닐 경우 false를 리턴.
	if( extensionType == "xls" ){
	    return true;
	} else if( extensionType == "xlsx" ){
	    return true;
	} else{
	    return false;
	}
}
function regularExpression( fileName ) {
	
	// -, _, ., 숫자, 알파벳 소문자가 아니면 체크
	var checkRegExp = /^[-_.0-9a-z]*$/;
	    
	// 2. 허용된 범위의 문자만 사용했다면 true를 리턴. 그 외의 문자를 사용했다면 false를 리턴.
	if ( !checkRegExp.test( fileName ) ) return false;
	else return true;
}
function fn_chkNSubmit() {
	 
    // input type="file"의 value는 선택한 파일의 경로!
    var filePath = $("#empListFile").val();
 
    // input type="file"의 파일명은 .files[0].name 메소드를 사용
    var fileName = $("#empListFile")[0].files[0].name;

	console.log(fileName);
    // 파일명 체크 스크립트
    if ( !regularExpression( fileName ) ) {
//         alert("파일명을 확인!");
        return false;
    }
 
    // 확장자 체크 스크립트
    if ( !fn_xlsXlsxChk( fileName ) ) {
    	alertify.error("엑셀파일만 업로드 가능!");
        return false;
    }
 
    // 파일명을 "." 으로 나눠서 확장자를 제외한 파일명만 저장
    var tmp = fileName.split(".");
    var justFileName = tmp[0];
 
    // 파일명만 URI에 붙여서 URI를 완성한 후, action속성 추가 후 Submit!
    $("#frm").attr("action", "jsp이름.jsp?justFileName=" + justFileName);
    $("#frm").submit[0]();
}
$(function() {
    $("#uploadBtn").click(function() {
        fn_chkNSubmit();
		
// 		const data = $('frm')[0];
		var formData = new FormData($('#frm')[0]);
// 		console.log("req data : "+formData.get('empListFile'));
		$.ajax({
			url : "/settings/insertEmpExcel?${_csrf.parameterName}=${_csrf.token}",
			method : "post",
			data :  formData,
			contentType : false,
			processData : false,
// 			contentType : "application/json; charset=utf-8",
			success : function(result) {
				if(result = 0) {
					alertify.error("등록에 실패하였습니다. 관리자에게 문의하세요.");
				}
				else {
					alertify.success("사원 일괄등록이 완료되었습니다.");
				}
			}
		});
    });
});
//////////////////////////위까지가 엑셀 db에 인서트 하기


function isImageFile(file) {
	var ext = file.name.split(".").pop().toLowerCase();
	return ($.inArray(ext, ["jpg","jpeg","gif","png"]) === -1) ? false : true;
}

function getThumbnailName(fileName) {
	var front = fileName.substr(0, 12);	// 2023/09/04 폴더
	var end = fileName.substr(12);		//뒤 파일명
	
	console.log("front" + front);
	console.log("end" + end);
	
	return front + "s_" + end;
}

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
	
	var compForm = $("#compForm");
	var cusLogo = $("#cusLogo");
	var cusEmp = $("#cusEmp");
	var cusSignature = $("#cusSignature");
	var cusImage = $("#cusImage");
	var compModifyBtn = $("#compModifyBtn");
	
	cusLogo.on("change", function(event) {
		var file = event.target.files[0];
		
		if(isImageFile(file)) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#nowImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
		}else {
			alertify.warning("이미지 파일을 선택해주세요!");
			return false;
		}
	});
	var updFlag = false;
	
	compModifyBtn.on("click", function(){
		updFlag = true;
		
		if(updFlag != false) {
			$("input[name=cusLogoFile]").removeAttr("disabled");
			$("input[name=cusSignatureFile]").removeAttr("disabled");
			$("input[name=cusImageFile]").removeAttr("disabled");
			$("input[name=cusEmp]").removeAttr("readonly");
			$("img[id=nowImg]").attr("src","");

			compModifyBtn.on("click", function(){
				alertify.success("수정이 완료되었습니다!");
				updFlag = false;
				compForm.submit();
// 				location.href="/settings/list";
			});
		}
	});
	
	
	/////////////// 휴가 //////////////////////////
	
	var registerHoliForm = $("#registerHoliForm");
	var registerHoliBtn = $("#registerHoliBtn");
	var autoHoliBtn = $("#autoHoliBtn");
	var vacCheckFlag = false;
	
	autoHoliBtn.on("click", function() {
		var vacName = $("#vacName");
		var vacCont = $("#vacCont");
		var vacAmt = $("#vacAmt");
		var vacGenAll = $("#vacGenAll");
		var vacWgPay = $("#vacWgPay");
		var vacCert = $("#vacCert");
		
		vacName.attr("value", "크리스마스 특별 휴가");
		vacAmt.attr("value", "1일");
		vacGenAll.attr("checked", "checked");
		vacWgPay.attr("checked", "checked");
		vacCert.removeAttr("checked", "checked");
		
		var content = "연말을 맞아 전 직원에 대해 특별 휴가가 부여됩니다.";
		var textarea_str = vacCont.val();

		textarea_str = textarea_str + content;
		vacCont.html(textarea_str);
	});
	
	registerHoliBtn.on("click", function() {
		
		var vacName = $("#vacName").val();
		
		var data = {
			vacName : vacName
		};
		
		$.ajax({
			type : "post",
			url : "/settings/vacCheck?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			success : function(res) {
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
							alertify.success("휴가가 등록되었습니다.");
						    setTimeout(() => location.href="/settings/list", 1000);
						}
					});
					vacCheckFlag = true;
				} else {
					alertify.error("중복된 휴가명입니다.");
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
	
	var saveAjaxBtn = $("#saveAjaxBtn");
	
	saveAjaxBtn.on("click", function() {
		var obj = $('#ajax').jstree(true).get_json('#', {flat:true});
		console.log(obj);
		
		$.ajax({
			type : "post",
			url : "/settings/treeUpdate",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			data : JSON.stringify(obj),
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				alertify.success("부서 수정이 완료되었습니다.");
			    setTimeout(() => location.href="/settings/list", 1000);
			}
		});
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
	
	
///////////////////////조직도 트리 끝 ///////////////////////// 계정관리 시작///////////////////////////////////////////////

	
	var settingVO = $("#settingVO").val();
	var grid = $("#grid");
	var selectEmp = $("#selectEmp");
	var empModifyBtn = $("#empModifyBtn");
	var changes = [];
	
	var grid = new tui.Grid({
		el : document.getElementById('grid'),
		data : settingVO,
		columns : [ {
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true
		}, {
			header : '사원명',
			name : 'empName',
			align : 'center',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
			sortable : true
		}, {
			header : '계정 권한',
			name : 'empRole',
			formatter: 'listItemText',
			align : 'center',
			sortable : true
			,editor: {
				type: 'select',
				options: {
					listItems: [
						{ text: '일반 사원', value: 'ROLE_MEMBER' },
						{ text: '중간 관리자', value: 'ROLE_MANAGER' },
						{ text: '최고 관리자', value: 'ROLE_ADMIN' }
					]
				}
			}
		}],
		pageOptions : {
			useClient : true,
			perPage : 15
		},
		scrollX : false,
		scrollY : false
	});
	grid.on('afterChange', ev => {
		console.log('after change:', ev);
		
		var tmpChanges = ev.changes[0];
		var empNo = grid.getRow(tmpChanges.rowKey).empNo;
		var changeValue = tmpChanges.value;
		var data = {
				empNo : empNo,
				empRole : changeValue
		}
		changes.push(data);
	});
	
	selectEmp.on("click", function() {
		var data = grid.getCheckedRows();
		
		$.ajax({
			url : "/settings/selectEmp",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				grid.resetData(result);
				setTimeout(() => grid.refreshLayout(), 500);

			}
		});
	});
	
	empModifyBtn.on("click", function() {
		console.log(changes);
		var paramList = {
				"paramList" : JSON.stringify(changes)
		}
		$.ajax({
			url : "/settings/empModifyAuth?${_csrf.parameterName}=${_csrf.token}",
			method : "post",
			data :  paramList,
			success : function(result) {
				alertify.success("수정이 완료되었습니다.");
				setTimeout(() => location.href="/settings/list", 1000);
			}
		});
	});
	
	
/////////////////////////기본그룹관리/////////////////////////////////////////////////////////////////

	
	var settingVO = $("#settingVO").val();
	var gridDefault = $("#gridDefault");
	var selectDefault = $("#selectDefault");
	var role_mem = $("#role_mem");
	var role_man = $("#role_man");
	var role_adm = $("#role_adm");
	
	var gridDefault = new tui.Grid({
		el : document.getElementById('gridDefault'),
		data : settingVO,
		columns : [ {
			header : '사번',
			name : 'empNo',
			align : 'center',
			sortable : true
		}, {
			header : '사원명',
			name : 'empName',
			align : 'center',
			sortable : true
		}, {
			header : '부서',
			name : 'empDept',
			align : 'center',
			sortable : true
		}, {
			header : '계정 권한',
			name : 'empRole',
			formatter: 'listItemText',
			align : 'center',
			sortable : true
			,editor: {
				type: 'select',
				options: {
					listItems: [
						{ text: '일반 사원', value: 'ROLE_MEMBER' },
						{ text: '중간 관리자', value: 'ROLE_MANAGER' },
						{ text: '최고 관리자', value: 'ROLE_ADMIN' }
					]
				}
			}
		}],
		pageOptions : {
			useClient : true,
			perPage : 10
		},
		scrollX : false,
		scrollY : false
	});
	
	selectDefault.on("click", function() {
		$.ajax({
			url : "/settings/selectDefault",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				gridDefault.resetData(result);
				setTimeout(() => gridDefault.refreshLayout(), 500);
				disableColumn('empRole');
			}
		});
	});
	role_mem.on("click", function() {
		$.ajax({
			url : "/settings/selectMem",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				gridDefault.resetData(result);
				setTimeout(() => gridDefault.refreshLayout(), 500);
				disableColumn('empRole');
			}
		});
	});
	role_man.on("click", function() {
		$.ajax({
			url : "/settings/selectMan",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				gridDefault.resetData(result);
				setTimeout(() => gridDefault.refreshLayout(), 500);
				disableColumn('empRole');
			}
		});
	});
	role_adm.on("click", function() {
		$.ajax({
			url : "/settings/selectAdm",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				gridDefault.resetData(result);
				setTimeout(() => gridDefault.refreshLayout(), 500);
				disableColumn('empRole');
			}
		});
	});
	
	
/////////////////////////맞춤그룹관리/////////////////////////////////////////////////////////////////
	
	var selectCustom = $("#selectCustom");
	
	selectCustom.on("click", function() {
		$.ajax({
			url : "/settings/selectCustom",
			method : "get",
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				var customArray = $("#customArray");
				var str = "";
				if(result != null){
					for(let i = 0; i < result.length; i++) {
						str += "<div class='d-flex flex-wrap alert alert-primary col-md-4 gap-2'>";
						str += result[i].empRole;
						str += "</div>";
					}
					customArray.html(str);
				}
			}
		});
	});
	var registerAuthForm = $("#registerAuthForm");
	var registerAuthBtn = $("#registerAuthBtn");
	
	registerAuthBtn.on("click", function() {
		
		var empRole = $("#empRole").val();
		var empDept = $("#empDept").val();
		
		var data = {
				empDept : empDept,
				empRole : empRole
		};
		$.ajax({
			type : "post",
			url : "/settings/registerRole?${_csrf.parameterName}=${_csrf.token}",
			data :  data,
			success : function(res) {
				alertify.success("계정 권한이 등록되었습니다.");
			    setTimeout(() => location.href="/settings/list", 1000);
			}
		});
	});
	
});
</script>