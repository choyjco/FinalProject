<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>레벨, 기능 선택</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="container pt-5 pb-5">
    <div class="row">
        <div class="col-lg-12">
            <form action="">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="p-5">
                            <h2><b>1. Level 선택</b></h2>
                            <br>
                            <p>level에 따라 자료실의 용량이 달라집니다.<br> 원하는 용량에 따라 선택해보세요!</p>
                            <br>
                            <div>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="levelName" value="level1" checked="checked"> &nbsp;&nbsp;&nbsp; Level 1 : 자료실 용량 1GB<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="levelName" value="level2"> &nbsp;&nbsp;&nbsp; Level 2 : 자료실 용량 5GB<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="levelName" value="level3"> &nbsp;&nbsp;&nbsp; Level 3 : 자료실 용량 10GB
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="p-5">
                            <h2><b>2. 기능 선택</b></h2>
                            <br>
                            <p>필요한 기능만 선택해보세요.<br>각 회사의 니즈에 따라 달라지는 맞춤형 인사시스템이 됩니다.</p>
                            <br>
                            <div>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" disabled="disabled"> &nbsp;&nbsp;&nbsp; 기본 제공 : 인사관리, 채용관리, 경영관리, 자료실<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="funcName" value="work"> &nbsp;&nbsp;&nbsp; 근태관리<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="funcName" value="vacation"> &nbsp;&nbsp;&nbsp; 휴가관리<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="funcName" value="pay"> &nbsp;&nbsp;&nbsp; 급여관리<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" name="funcName" value="document"> &nbsp;&nbsp;&nbsp; 기안·결재<br>
                            </div>
                        </div>
                    </div>
                </div>
                <div align="center" style="margin-bottom: 50px;">
                    <button type="button" id="nextBtn" class="btn btn-primary" style="width: 500px;">다음 단계</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">

$(function() {
    var nextBtn = $("#nextBtn");

    var selectedLevelName = ''; // 라디오 버튼 값 저장
    var selectedFuncNames = []; // 체크박스 값 배열

    // 라디오 버튼 클릭
    $("input[name='levelName']").on('click', function() {
        selectedLevelName = $(this).val();
        console.log("레벨 이름 : " + selectedLevelName);
    });

    // 체크박스 클릭
    $("input[name='funcArray']").on('click', function() {
        var selectFuncName = $(this).val();
        if ($(this).is(':checked')) {
            selectedFuncNames.push(selectFuncName);
        } else {
            var index = selectedFuncNames.indexOf(selectFuncName);
            if (index !== -1) {
                selectedFuncNames.splice(index, 1);
            }
        }
        console.log("기능 이름 : " + selectedFuncNames);
    });

    nextBtn.on("click", function() {
        // 선택된 값들을 다음 페이지로 전달
        var formData = {
            levelName: selectedLevelName,
            funcArray: selectedFuncNames
        };

        // JSON 형식으로 데이터를 전달
        $.post("다음페이지URL", formData, function(response) {
            // 서버에서의 응답을 처리하거나, 페이지를 이동하는 로직을 추가할 수 있습니다.
            console.log("데이터 전송 완료");
            // 예: window.location.href = "다음페이지URL";
        });
    });
});



// $(function() {
// 	var nextBtn = $("#nextBtn");
// 	var purchaseForm = $("#purchaseForm");
	
// 	// 라디오
// 	$("input[name='levelName']").on('click', function() {
// 	    var selectLevelName = $(this).val(); // 클릭된 라디오 버튼의 값을 가져옴
// 	    console.log("레벨 이름 : " + selectLevelName);
// 	});

// 	var selectFuncNames = []; // 체크박스 값 배열

// 	// 체크박스 클릭
// 	$("input[name='funcArray']").on('click', function() {
// 	    var selectFuncName = $(this).val();
// 	    if ($(this).is(':checked')) {
// 	    	selectFuncNames.push(selectFuncName); // 체크될 때 배열에 추가
// 	    } else {
// 	        var index = selectFuncNames.indexOf(selectFuncName);
// 	        if (index !== -1) {
// 	        	selectFuncNames.splice(index, 1); // 체크 해제 시 배열에서 제거
// 	        }
// 	    }
// 	    console.log("기능 이름 : " + selectFuncNames)
// 	});
	
// 	nextBtn.on("click", function() {
		
		
		
// 	});
	

    
// });

</script>