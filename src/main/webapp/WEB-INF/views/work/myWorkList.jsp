<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
tr:hover{
    background: #F1F1F2;    
}
</style>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                	<div class="row d-flex justify-content-between">
                		<div class="col-3">
                			<div class="p-2"><h5 class="fw-bold">이번 주 총 근무시간 : <span id="sum"></span></h5></div>
                		</div>
                		<div class="col-6"></div>
                		<div class="col-3 d-flex justify-content-end">
							<div class="gridjs-search">
								<input type="date" id="datePick" placeholder="날짜 선택" aria-label="Type a keyword..." class="gridjs-input gridjs-search-input" style="margin-bottom: 5px; ">
								<button style="margin-bottom: 4px;" type="button" class="btn btn-primary" id="dateBtn">검색</button>
							</div>
                		</div>
                	</div>
                    <table class="table table-bordered align-middle table-nowrap table-check">
                        <thead class="table-light">
                            <tr>
                                <th>날짜</th>
                                <th>근무 형태</th>
                                <th>근무한 시간</th>
                                <th>총근무시간</th>
                            </tr>
                        </thead>
                        <tbody id="tbody"></tbody>
                    </table>
                    <br>
                    <hr>
                    <br>
                   	<h5 class="fw-bold" style="margin-bottom: 30px;">월별 근무 내역</h5>
                    <table class="table table-bordered align-middle table-nowrap table-check">
                        <thead class="table-light">
                            <tr>
                                <th>날짜</th>
                                <th>근무 형태</th>
                                <th>근무한 시간</th>
                                <th>총근무시간</th>
                            </tr>
                        </thead>
                        <tbody id="monTbody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    var dateBtn = $("#dateBtn");
    var datePick = $("#datePick");
    var holidayArr = [];
    
    // 현재 날짜를 가져와서 날짜 선택에 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    datePick.val(formattedDate);

    // 공휴일을 받아오는 함수
    getHolidayData();
    
    dateBtn.on("click", function() {
        var selectedDate = datePick.val();
        // 선택한 날짜
//         console.log(selectedDate);
        var currentDay = new Date(selectedDate);
        var theYear = currentDay.getFullYear();
        var theMonth = currentDay.getMonth();
        var themonth = String(currentDay.getMonth() + 1).toString().padStart(2, '0'); // 월을 두 자리로 포맷팅
        var theDate = currentDay.getDate();
        var theDayOfWeek = currentDay.getDay();
        
        // 해당 월의 모든 날짜 구하기
        var daysInMonth = new Date(theYear, currentDay.getMonth() + 1, 0).getDate();
        // 모든 날짜가 저장될 배열
        var monthDays = [];
        for (var i = 1; i <= daysInMonth; i++) {
        	var currentDate = new Date(theYear, currentDay.getMonth(), i);
        	var date = String(currentDate.getDate()).padStart(2, '0');
            var formattedDate = theYear + '-' + themonth + '-' + date; // yyyy-MM-dd 형식
            var dayOfWeek = currentDate.toLocaleDateString('ko-KR', { weekday: 'long' }); 
            monthDays.push({ date: formattedDate, dayOfWeek: dayOfWeek });
        }
        
        console.log("날짜들", monthDays);
        console.log("날짜 나와>??", monthDays[1].date);
        
        
        // 선택 날짜의 해당 주 날짜
        var thisWeek = [];
        for (var i = 0; i < 7; i++) {
            var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek + 1));
            var yyyy = resultDay.getFullYear();
            var mm = String(resultDay.getMonth() + 1).padStart(2, '0');
            var dd = String(resultDay.getDate()).padStart(2, '0');
            thisWeek[i] = yyyy + '-' + mm + '-' + dd;
        }
            
        var data = {
                firstDate : thisWeek[0],
                lastDate : thisWeek[6],
        };
        
        var selData = {
                selectedDate : selectedDate
        }
        
        var day = ["월", "화", "수", "목", "금", "토", "일"];
          
        // 월 근무 정보
        $.ajax({
		    type: "POST",
		    url: "/work/myworkList",
		    beforeSend : function(xhr){
		      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		   }, 
		    data: JSON.stringify(selData), 
		    contentType : "application/json; charset=utf-8",
		    dataType : "json",
		    success: function(res) {
		    	console.log(res);
		    	var monHtml = "";
		    	for(var i = 0; i < monthDays.length; i++){
		    		var colors = "";
		    		
		    		if(monthDays[i].dayOfWeek.substr(0,1) == "토"){
			    		colors = "primary fw-bold";
		    		}else if(monthDays[i].dayOfWeek.substr(0,1) == "일"){
			    		colors = "danger fw-bold";
		    		}
		    		
			    	var monFlag = false;
			    	
			    	for(var a = 0; a < res.length; a++){
			    		if(monthDays[i].date == res[a].workStime.substr(0,10)){
				    		monHtml += "<tr onclick='javascript:location.href=/document/documentwrite?docClfCode=2'>";
					    	monHtml += "	<td><font class='text-" + colors + "'>"+ settingDate(monthDays[i].date, monthDays[i].dayOfWeek.substr(0,1)) + "</font></td>";
					    	monHtml += "	<td>";
					    	monHtml += "		<div id='workBadge'>";
				    		monHtml += "			<h5>";
					    	monHtml += "				<span class='badge badge-soft-info'>근무</span>";
					    	monHtml += "			</h5>";
					    	monHtml += "		</div>";
					    	monHtml += "	</td>";
					    	monHtml += "	<td>";
					    	monHtml += "		<div class='d-flex gap-2'>";
					    	monHtml += "				<span class='fs-6'>";
					    	monHtml += 						res[a].workStime.substr(11,5) + '~'+ res[a].workEtime.substr(11,5);
					    	monHtml += "				</span>";
					    	monHtml += "		</div>";
					    	monHtml += "	</td>";
					    	monHtml += "	<td>"+res[a].workTotal + '시간'+"</td>";
					    	monHtml += "</tr>";
					    	monFlag = true;
					    	break;
			    		}
			    	}
			    	if(monFlag == false){
			    		monHtml += "<tr onclick='javascript:location.href=/document/documentwrite?docClfCode=2'>";
				    	monHtml += "	<td><font class='text-" + colors + "'>"+ settingDate(monthDays[i].date, monthDays[i].dayOfWeek.substr(0,1)) + "</font></td>";
				    	monHtml += "	<td></td>";
				    	monHtml += "	<td></td>";
				    	monHtml += "</tr>";
			    	}
		    	}
		    	$("#monTbody").html(monHtml);
		    }
        });
        
        
        
        // 주 근무 정보
		$.ajax({
		    type: "POST",
		    url: "/work/myworklist",
		    beforeSend : function(xhr){
		      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		   }, 
		    data: JSON.stringify(data), // 날짜
		    contentType : "application/json; charset=utf-8",
		    dataType : "json",
		    success: function(res) {
// 		        console.log(res[0].workStime); 
// 		        console.log(res[0].workEtime); 
		        console.log(holidayArr);
				var sum = 0;
		    	var html = "";
		    	for(var i = 0; i < 7; i++){
		    		var flag = false;
		    		var font = "";	// 주말일때만 색깔을 부여하기 위함
		    		// 기본근무 + 외근 + 출장
		    		for(var j = 0; j < res.length; j++){
		    			// datepicker로 골라낸 날짜로 받은 주의 날짜가 DB에 저장된 근무기록의 날짜와 같을 때 
			    		if(thisWeek[i] == res[j].workStime.substr(0,10)){
			    			if(i >= 5 && res.length >= 5){	// 주말데이터가 존재함
			    				if(i == 5) color = "primary";
			    				if(i == 6) color = "danger";
			    				font += "<font class='text-"+color+" fw-bold'>";
			    				font += settingDate(thisWeek[i],day[i]);
			    				font += "</font>";
			    			}else{
			    				font += settingDate(thisWeek[i],day[i]);
			    			}
				    		html += "<tr onclick='javascript:location.href=/document/documentwrite?docClfCode=2'>";
					    	html += "	<td>"+font+"</td>";
					    	html += "	<td>";
					    	html += "		<div id='workBadge'>";
				    		html += "			<h5>";
					    	html += "				<span class='badge badge-soft-info'>근무</span>";
					    	html += "			</h5>";
					    	html += "		</div>";
					    	html += "	</td>";
					    	html += "	<td>";
					    	html += "		<span class='fs-6'>";
					    	html += 			res[j].workStime.substr(11,5) + '~'+ res[j].workEtime.substr(11,5);
					    	html += "		</span>";
					    	html += "	</td>";
					    	html += "	<td>" + res[j].workTotal + '시간' + "</td>";
// 					    	html += "	<td></td>";
					    	html += "</tr>";
					    	flag = true;
				    		sum += res[j].workTotal;
					    	break;
			    		}
		    		}
		    		
		    		// datepicker로 골라낸 날짜가 DB에 저장된 근무기록의 날짜가 아닐 때 그냥 출력
		    		if(i < 5 && flag == false){
		    			html += `<tr onclick="location.href='/document/documentwrite?docClfCode=2'">`;
		    			html += "	<td>"+settingDate(thisWeek[i],day[i])+"</td>";
		    			html += "	<td></td>";
		    			html += "	<td></td>";
// 		    			html += "	<td></td>";
		    			html += "</tr>";
		    		}
		    		
		    		// 주말에 해당하는 날짜 처리는 여기서
		    		// 토요일
		    		if(i == 5 && font == ""){
		    			html += `<tr onclick="location.href='/document/documentwrite?docClfCode=2'">`;
		    			html += "	<td>" + "<font class='text-primary fw-bold'>" + settingDate(thisWeek[i],day[i]) + "</font></td>";
		    			html += "	<td></td>";
		    			html += "	<td></td>";
// 		    			html += "	<td></td>";
		    			html += "</tr>";
		    		}
		    		// 일요일
		    		if(i == 6 && font == ""){
		    			html += `<tr onclick="location.href='/document/documentwrite?docClfCode=2'">`;
		    			html += "	<td>" + "<font class='text-danger fw-bold'>" + settingDate(thisWeek[i],day[i]) + "</font></td>";
		    			html += "	<td></td>";
		    			html += "	<td></td>";
// 		    			html += "	<td></td>";
		    			html += "</tr>";
		    		}
		    	}
		    	$("#sum").text(sum + '시간');
		        $("#tbody").html(html);
		    }
		});    
    });

    // 날짜 표시해주는 함수
    function settingDate(week, day){
    	var result = "";
    	var flag = false;
    	var datetime = week.replaceAll("-","");
	    for(var i = 0; i < holidayArr.length; i++){
    		if(datetime == holidayArr[i].holidayDate){
	    		result = week + "(" + day + ")<font class='text-danger fw-bold'> ["+holidayArr[i].holidayName+"] </font>";
	    		flag = true;
	    	}
	    }
	    
	    if(flag == false){
	    	result = week + "(" + day + ")";
	    }
	    return result;
    }
    
    // 공휴일을 받아오는 함수
    function getHolidayData(){
    	$.ajax({
    		url : "/holiday",
    		type : "get",
    		success : function(res){
    			res.map(function(e, i){
	    			holidayArr.push({"holidayDate" : e.holidayDate, "holidayName" : e.holidayName});
    			});
    		}
    	});
    }
    
    // 페이지 로딩 시 자동으로 dateBtn 클릭 이벤트 발생
    setTimeout(() => {
	    dateBtn.trigger("click");
	}, 100);
    
    
});
</script>