<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                	<div class="row d-flex justify-content-between">
	                	<div class="col-9"></div>
	                	<div class="col-3 d-flex justify-content-end">
	                		<div class="gridjs-search">
								<input type="date" id="datePick" placeholder="날짜 선택" aria-label="Type a keyword..." style="margin-bottom: 5px; " class="gridjs-input gridjs-search-input">
								<button style="margin-bottom: 4px;" type="button" class="btn btn-primary" id="dateBtn">검색</button>
							</div>
	                	</div>
				    </div>
                    <table id="myTable" class="table table-bordered align-middle table-nowrap table-check display">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">사원</th>
                                <th scope="col">부서</th>
                                <th scope="col">사번</th>
                                <th scope="col">근무 유형</th>
                                <th scope="col">근무 예정 시간</th>
                                <th scope="col">추가 근무 시간</th>
                                <th scope="col">승인 여부</th>
                            </tr>
                        </thead>
                        <tbody id="tbody"></tbody>
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
    
    // 현재 날짜를 가져와서 날짜 선택에 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    datePick.val(formattedDate);

    // dateBtn 클릭 이벤트 핸들러
    dateBtn.on("click", function() {
        var selectedDate = datePick.val();

        // 선택한 날짜
//         console.log(selectedDate);

        var currentDay = new Date(selectedDate);
        var theYear = currentDay.getFullYear();
        var theMonth = currentDay.getMonth();
        var theDate = currentDay.getDate();
        var theDayOfWeek = currentDay.getDay();

        var data = {
                firstDate : selectedDate,
        };
        
        var html = "";
        
        $.ajax({
		    type: "POST",
		    url: "/work/workmanage",
		    beforeSend : function(xhr){
		      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		   }, 
		    data: JSON.stringify(data), 
		    contentType : "application/json; charset=utf-8",
		    dataType : "json",
		    success: function(res) {
		    	console.log(res);
		    	if(res.length == 0){
		    		html += `<tr>
		    		        	<td colspan='7' align=center>선택된 날짜에 근무 신청 내역이 없습니다.</td>
		    		         </tr>`;
		    	}else{
			    	for(var i = 0; i < res.length; i++){
			    		html += "<tr>";
			    		html += "	<td>" + res[i].empName + "</td>";
			    		html += "	<td>" + res[i].comName + "</td>";
			    		html += "	<td>" + res[i].empNo + "</td>";
			    		html += "	<td>";
			    		html += "		<div class='d-flex gap-2'>";
			    		if(res[i].workKind == '연장'){
			    			html += "<h5><span class='badge bg-soft-purple'>연장</span></h5>";
			    		}else if(res[i].workKind == '외근'){
			    			html += "<h5><span class='badge bg-warning'>외근</span></h5>";
			    		}else if(res[i].workKind == '출장'){
			    			html += "<h5><span class='badge bg-purple'>출장</span></h5>";
			    		}
			    		html += "		</div>";
			    		html += "	</td>";
			    		html += "	<td>" + res[i].workSdate.substr(11,5) + "~" + res[i].workEdate.substr(11,5) + "</td>";
			    		html += "	<td>" + res[i].workAmt + "시간</td>";
			    		html += "	<td>";
			    		if(res[i].docStat == '승인'){
			    			html += "<h5><span class='badge bg-success'>승인</span></h5>";
			    		}else if(res[i].docStat == '대기중'){
			    			html += "<h5><button type='button' class='btn btn-secondary' onclick=\"location.href='/document/udatedoc' \">승인대기</button></h5>";
			    		}else if(res[i].docStat == '반려'){
			    			html += "<h5><button type='button' class='btn btn-danger' onclick=\"location.href='/document/udatedoc' \>반려</button></h5>";
			    		}
			    		html += "	</td>";
			    		html += "</tr>";
			    	}
		    	}
		    	$("#tbody").html(html);
		    }
        });
    });

    // 페이지 로딩 시 자동으로 dateBtn 클릭 이벤트 발생
    dateBtn.trigger("click");
});


</script>