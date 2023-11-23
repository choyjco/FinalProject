<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tree test</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<body>
	<button type="button" id="regBtn">추가</button>
	<button type="button" id="modBtn">수정</button>
	<button type="button" id="delBtn">삭제</button>
	<button type="button" id="infoBtn">노드정보</button>
	<br>
	<input type="text" id="search_input" name="search_input">
	<button type="button" id="seachBtn" name="seachBtn">검색</button>
	<div id="jstree">

	</div>	
	
	<button type="button" id="selectBtn">전체 선택</button>
	<button type="button" id="deselectBtn">전체 해제</button>
	<br>
	<button type="button" id="openBtn">전체 열기</button>
	<button type="button" id="closeBtn">전체 닫기</button>
	<hr>
	<button type="button" id="saveBtn">저장</button>
	<button type="button" id="cancelBtn">취소</button>
</body>
<script type="text/javascript">
	
// 드래그 엔 드롭 기능
$('#jstree').on("changed.jstree", function (e, data) {
    console.log("se : "+data.changed.selected); // newly selected
    console.log("dese : "+data.changed.deselected); // newly deselected
  })
  .jstree({ 
	'core' : {
		'data' : {
			"url" : "/tree/list.do",
			"dataType" : "json"
		},
		"check_callback" : true // 이동하기 위한 설정! 주의) core안에 선언할 것!
	},
	'search': {
        "show_only_matches": true,				// true: 검색이 일치해야 나온다.
        "show_only_matches_children": false,	// true: 부모가 검색이 일치하면 자식이면 일치하지 않아도 나온다. 
    },
	'plugins' : ["dnd", "search", "contextmenu", "state", "types", "wholerow", "changed"]	// 드래그를 하기 위한 설정! 주의) core와 같은 라인에 선언할 것!
	// wholerow : 한 행자체를 인식
	// dnd : 드래그하기위한 설정
	// unique : 형제로 동일이름 공존 불가
	// search : 검색
	// contextmenu : 우클릭 활성화
});

// 전체선택 버튼 
$("#selectBtn").on("click", function(){
	$('#jstree').jstree("select_all");
});

// 전체선택 해제 버튼 
$("#deselectBtn").on("click", function(){
	$('#jstree').jstree("deselect_all");
});

// 노드 추가버튼
$("#regBtn").on("click", function(){
	var ref = $('#jstree').jstree(true),
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
	var ref = $('#jstree').jstree(true),
		sel = ref.get_selected();
	if(!sel.length) { return false; }
	sel = sel[0];
	ref.edit(sel);

// 	var info = $('#tree').jstree('get_selected',true);
	
// 	if(!info.length) { return false; }
// 	console.log(info[0].id);
// 	$('#tree').jstree(true).edit(info[0].id);
});

// 노드 삭제버튼
$("#delBtn").on("click", function(){
	var ref = $('#jstree').jstree(true),
		sel = ref.get_selected();
	if(!sel.length) { return false; }
	
	console.log("삭제된 노드정보 : " + sel);
	
	ref.delete_node(sel);
	
// 	var info = $('#tree').jstree('get_selected',true);
	
// 	if(!info.length) { return false; }
// 	console.log(info[0].id);
// 	var parentId = $("#tree").jstree().get_node( $node ).id;
// 	$("#tree").jstree().delete_node( $("#"+ info[0].id) );
// 	$('#tree').jstree(true).delete_node(info[0].id);
});

// 검색버튼
$("#seachBtn").on("click", function(){
	var text = $("#search_input").val().trim();
	$('#jstree').jstree(true).search(text);
});

// 노드정보 버튼
$("#infoBtn").on("click", function(){
	var info = $('#jstree').jstree('get_selected',true);
	console.log(info);
});

// 전체 열기 버튼
$("#openBtn").on("click", function(){
	$('#jstree').jstree("open_all");
});

// 전체 닫기 버튼
$("#closeBtn").on("click", function(){
	$('#jstree').jstree("close_all");
});

// 클릭된 노드 정보출력
$('#jstree').on('changed.jstree', function (e, data) {
    console.log('1클릭된 노드 ID:', data.selected);
});

</script>
</html>
