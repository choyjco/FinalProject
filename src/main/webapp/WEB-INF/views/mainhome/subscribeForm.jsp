<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
          	<h4 style="text-align: center;"><b>WSI 시스템에서 제공하는 통계 데이터를 참고해서 구매하세요!</b></h4>
        	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
            <form action="/subscribe" method="post" id="subscribeForm">
                <div class="col-lg-12" style="background-color: #F5F3F750; display: flex;">
					<div class="col-lg-6 pt-5 pb-5" align="center">
						<h5 style="text-align: center;"><b>가장 많이 선택된 기능</b></h5>
						<canvas id="funcChart" width="350px;" height="350px;"></canvas>
						<br>
						<p><b>급여관리 > 기안·결재 > 휴가관리 > 근태관리</b><br>순으로 많이 선택되었습니다!</p>
					</div>
<!--                 	<div class="col-lg-4 pt-5 pb-5" align="center"> -->
<!-- 						<h5 style="text-align: center;"><b>가장 많이 선택된 레벨</b></h5> -->
<%-- 						<canvas id="levelChart" width="320px;" height="320px;"></canvas> --%>
<!-- 						<br> -->
<!-- 					</div> -->
					<div class="col-lg-6 pt-5 pb-5" align="center" style="margin-top: 90px;">
						<h5 style="text-align: center;"><b>회사 인원수에 따른 레벨 선택</b></h5>
					<table class="table col-lg-12">
			        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
			        		<th style="width: 45%;">회사 사원수</th>
			        		<th style="width: 55%;">레벨명</th>
			        	</tr>
			        	<tr>
			        		<td>30명 미만</td>
			        		<td align="center">LEVEL1</td>
			        	</tr>
			        	<tr>
			        		<td>30명 이상 100명 미만</td>
			        		<td align="center">LEVEL2</td>
			        	</tr>
			        	<tr>
			        		<td>100명 이상 300명 미만</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        	<tr>
			        		<td>300명 이상</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        </table>
			        <p>
			        	<b>WSI 시스템을 이용하고 있는 회사들이 선택한 레벨</b>을 확인해보세요!<br>
			        	(<b>회사 사원수에 따라 가장 많이 선택된 레벨</b>의 통계입니다.)
			        </p>
					</div>
					
				</div>
				
                <div class="row" style="display: flex;">
                    <div class="col-lg-6">
                        <div class="p-5">
                            <h2><b>1. Level 선택</b></h2>
                            <br>
                            <p>level에 따라 자료실의 용량이 달라집니다.<br> 원하는 용량에 따라 선택해보세요!</p>
                            <br>
                            <div>
<%--                             	<c:forEach items="${levelNames }" var="levelNames"> --%>
<%--                             		<input type="radio" id="level" name="levelName" value="${levelNames.levelName }"> --%>
<%--                             	</c:forEach> --%>
                                <label for="levelName1" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="levelName1" name="levelName" value="LEVEL1" checked="checked"> &nbsp;&nbsp;&nbsp; Level 1 : 30인 이하 사업장 추천(2,500원)</label><br>
                                <label for="levelName2" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="levelName2" name="levelName" value="LEVEL2"> &nbsp;&nbsp;&nbsp; Level 2 : 30인~100인 사업장 추천(3,500원)</label><br>
                                <label for="levelName3" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="levelName3" name="levelName" value="LEVEL3"> &nbsp;&nbsp;&nbsp; Level 3 : 100인 이상 사업장 추천(4,500원)</label>
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
                                <label for="funcName1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="funcName1" name="funcNames" checked="checked" disabled="disabled"> &nbsp;&nbsp;&nbsp; 기본 제공 : 인사관리, 채용관리, 경영관리, 자료실</label><br>
                                <label for="funcName2" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="funcName2" name="funcNames" value="work"> &nbsp;&nbsp;&nbsp; 근태관리 : 1,000원/월</label><br>
                                <label for="funcName3" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="funcName3" name="funcNames" value="vacation"> &nbsp;&nbsp;&nbsp; 휴가관리 : 1,000원/월</label><br>
                                <label for="funcName4" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="funcName4" name="funcNames" value="pay"> &nbsp;&nbsp;&nbsp; 급여관리 : 1,000원/월</label><br>
                                <label for="funcName5" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="funcName5" name="funcNames" value="document"> &nbsp;&nbsp;&nbsp; 기안·결재 : 1,000원/월</label><br>
                            </div>
                        </div>
                    </div>
                </div>
               <div align="center" style="margin-bottom: 50px;">
				    <div class="row" style="flex-direction: column; align-items: center;">
				        <button type="button" id="testBtn" class="btn btn-light" style="width: 500px;">테스트 하기</button><br>
				        <button type="button" id="nextBtn" class="btn btn-primary" style="width: 500px;">다음 단계</button>
				    </div>
				</div>

                <sec:csrfInput/>
            </form>
        </div>
    </div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">

$(function() {
    var nextBtn = $("#nextBtn");
    var testBtn = $("#testBtn");
    var subscribeForm = $("#subscribeForm");

//     var selectedLevelName = ''; // 라디오 버튼 값 저장
//     var selectedFuncNames = []; // 체크박스 값 배열

//     // 라디오 버튼 클릭
//     $("input[type='radio']").on('click', function() {
//         selectedLevelName = $(this).val();
//         console.log("레벨 이름 : " + selectedLevelName);
//     });

//     // 체크박스 클릭
//     $("input[type='checkbox']").on('click', function() {
//         var selectFuncName = $(this).val();
//         if ($(this).is(':checked')) {
//             selectedFuncNames.push(selectFuncName);
//         } else {
//             var index = selectedFuncNames.indexOf(selectFuncName);
//             if (index !== -1) {
//                 selectedFuncNames.splice(index, 1);
//             }
//         }
//         console.log(selectedFuncNames);
//     });


    nextBtn.on("click", function() {
    	
//         // 선택된 값들을 다음 페이지로 전달
//         var formData = {
//             levelName: selectedLevelName,
//             funcName: selectedFuncNames
//         };

//         // JSON 형식으로 데이터를 전달
//         $.post(window.location.href = "/subscribe2", formData, function(response) {
//             // 서버에서의 응답을 처리하거나, 페이지를 이동하는 로직을 추가할 수 있습니다.
//             console.log("데이터 전송 완료");
//         });
    	subscribeForm.submit();
    });
    
    testBtn.on("click", function() {
    	window.open("/signin", "_blank");
    	setTimeout(() => {
    	location.reload();
		}, 7000);
	});
    
    
    $.ajax({
        url: "/levelchart1",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var levelNamelist = [];
            var countlist = [];
            var ratiolist = [];

            $.each(data, function(){
                levelNamelist.push(this["levelName"]);
                countlist.push(this["cnt"]);
                ratiolist.push(this["ratio"] );
            });

            console.log("levelName :", data);
            console.log("레벨 이름:", levelNamelist);
            console.log("레벨 선택 수:", countlist);
            console.log("레벨 선택 비율:", ratiolist);

            const ctx = document.getElementById('levelChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: levelNamelist,
                    datasets: [{
                        label: '레벨 선택',
                        data: ratiolist,
                        backgroundColor: [
                            'lightblue',
                            'pink',
                            '#fcf6bd'
                        ],
                        hoverOffset: 4
                    }]
                },
	            options: {
	            	responsive: false,
	            	title: {
	            		display: true,
	            		text: '가장 많이 선택된 레벨',
	            		fontSize: 20
	            	},
	            	legend: {
	            		display: true,
	            		position: 'top',
	            	},
	//             	tooltips: {
	//             		enabled: false
	//             	},
	            }
            	
            });
        }, // 레벨 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
    
    $.ajax({
        url: "/funcchart1",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var funcMemolist = [];
            var countlist = [];
            var ratiolist = [];

            $.each(data, function(){
                funcMemolist.push(this["funcMemo"]);
                countlist.push(this["cnt"]);
                ratiolist.push(this["ratio"]);
            });

            console.log("funcName :", data);
            console.log("기능 이름:", funcMemolist);
            console.log("기능 선택 수 :", countlist);
            console.log("기능 선택 비율:", ratiolist);

            const ctx = document.getElementById('funcChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: funcMemolist,
                    datasets: [{
                        label: '기능 선택',
                        data: ratiolist,
                        backgroundColor: [
                            'lightblue',
                            'pink',
                            '#fcf6bd',
                            '#cdb4db',
                        ],
                        hoverOffset: 4
                    }]
                },
            
	            options: {
	            	responsive: false,
	            	title: {
	            		display: true,
	            		text: '가장 많이 선택된 기능',
	            		fontSize: 20
	            	},
	            	legend: {
	            		display: true,
	            		position: 'top',
	            	},
	//             	tooltips: {
	//             		enabled: false
	//             	},
	            }
            });
        }, // 기능 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
    
    
    
    
});




</script>