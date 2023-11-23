<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                	<div class="row d-flex justify-content-between">
	                	<div class="col-3">
							<select class="form-select" id="selectDept" aria-label="Default select example" style="width:113px;" disabled>
			                	<c:forEach items="${comList}" var="comList">
				                	<c:if test="${fn:startsWith(comList.comCode, 'a') }">
										<option value="${comList.comCode}" <c:if test="${comList.comCode eq deptCode}">selected</c:if>>${comList.comName}</option>
				                	</c:if>
							    </c:forEach>
							</select>
						</div>
	                	<div class="col-3">
	                		<button type="button" class="btn btn-light" id="download">
		                		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
								  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"></path>
								  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"></path>
								</svg>
					           	근무내역 다운로드 하기
					        </button>
					    </div>
	                	<div class="col-3">
	                		<div class="badge rounded-pill bg-info">　</div> 근무
	                		<div class="badge rounded-pill bg-soft-danger">　</div> 휴가
	                		<div class="badge rounded-pill bg-warning">　</div> 외근
	                		<div class="badge rounded-pill bg-purple">　</div> 출장
	                	</div>
	                	<div class="col-3 d-flex justify-content-end">
	                		<div class="gridjs-search">
								<input type="date" id="datePick" name="datePick" placeholder="날짜 선택" aria-label="Type a keyword..." class="gridjs-input gridjs-search-input">
								<button style="margin-bottom: 4px;" type="button" class="btn btn-primary" id="dateBtn">검색</button>
							</div>
	                	</div>
				    </div>
                    <table id="myTable" class="table table-bordered align-middle table-nowrap table-check">
                        <thead class="table-light">
							<tr>
                        		<th scope="col"></th>
                           		<c:forEach var="work" varStatus="i" begin="0" end="6" step="1">
									<th scope="col" id="date${i.index }"></th>
                           		</c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody"></tbody>
                    </table>
                </div>
                <div class="card-footer clearfix" id="pagingArea"></div>	
            </div>
        </div>
    </div>
</div>
<form action="/excel/teamworklist" method="post" id="workForm">
	<input type="hidden" name="firDate" id="firDate">
	<input type="hidden" name="laDate" id="laDate">
	<input type="hidden" name="selDept" id="selDept">
	<sec:csrfInput/>
</form>
<script type="text/javascript">
$(document).ready(function() {
    var dateBtn = $("#dateBtn");
    var datePick = $("#datePick");
    var download = $("#download");
    var workForm = $("#workForm");
    var laDate = $("#laDate");
    var firDate = $("#firDate");
    var selDept = $("#selDept");
    var holidayArr = [];
 	var clickedPage = 1;
    
    $("#pagingArea").on("click", "a", function(event) {
    	event.preventDefault();
	    clickedPage = $(this).data("page");
	    console.log("클릭한 페이지 : ", clickedPage);
	    dateBtn.trigger("click");
    });
    
    var data = {
            firstDate: "",
            lastDate: "",
            selectDept: ""
        };
    
    // 나중에 공휴일 정보 더 필요하거나 수정해야하면 이거 수정해서 반영하기
    var holidayArrTest = [
    	{holidayDate:"20231002",holidayName:"임시공휴일"},
    	{holidayDate:"20231003",holidayName:"개천절"},
    	{holidayDate:"20231009",holidayName:"한글날"},
    	{holidayDate:"20231225",holidayName:"기독탄신일"}
    ];
    
    // 현재 날짜를 가져와서 날짜 선택에 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    datePick.val(formattedDate);
    
    // 공휴일 받아와서 holidayArr에 세팅
//     getHolidayData();
//     console.log(holidayArr);

	var thisWeek = [];

    // dateBtn 클릭 이벤트 
    dateBtn.on("click", function() {
        var selectedDate = datePick.val();
        var selectDept = $("#selectDept").val();
        
        $("#selectDept").change(function(){
        	selectDept = $(this).val();
        	dateBtn.trigger("click");
        });

        // 선택한 날짜
//         console.log(selectedDate);
        var currentDay = new Date(selectedDate);
        var theYear = currentDay.getFullYear();
        var theMonth = currentDay.getMonth();
        var theDate = currentDay.getDate();
        var theDayOfWeek = currentDay.getDay();
		
        // 선택한 날짜를 기준으로 한 월요일~일요일의 날짜를 구함
        for (var i = 0; i < 7; i++) {
            var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek + 1));
            var yyyy = resultDay.getFullYear();
            var mm = String(resultDay.getMonth() + 1).padStart(2, '0');
            var dd = String(resultDay.getDate()).padStart(2, '0');
            thisWeek[i] = yyyy + '-' + mm + '-' + dd;
        }
		// 요일 배열을 날짜에 붙여주고 주별 날짜 배열 생성
        var day = ["(월)", "(화)", "(수)", "(목)", "(금)", "(토)", "(일)"];
        for (var i = 0; i < thisWeek.length; i++) {
            $("#date" + i).text(thisWeek[i] + day[i]);
        }
        
        
        var param = {
                firstDate: thisWeek[0],
                lastDate: thisWeek[6],
                selectDept: selectDept,
                page: clickedPage
        };
        
        $.ajax({
            type: "post",
            url: "/work/teamworklist",
            beforeSend: function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            data: JSON.stringify(param),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(res) {
            	settingList(res.dataList);
                
            	 var html = "";
                 for(var i = 0; i < arr.length; i++){
//                  	console.log(arr.length);
//                  	console.log("arr??? : ", arr);
 					html += "<tr>";
 					html += "   <td>";
 					html += "      <h5>";
					if(arr[i].empProfile == null){
						html += "<img src='${pageContext.request.contextPath }/resources/images/profile.jpg' alt='' class='avatar-sm rounded-circle me-2'>";
					}else{
						html += "<img src='${pageContext.request.contextPath }"+ arr[i].empProfile +"' alt='' class='avatar-sm rounded-circle me-2'>";
						
					}
 					html += "         <span class='fs-6 fw-bold'>" + arr[i].empName + "</span>" + " " + "<span class='fs-6 text-secondary'>" + arr[i].comName + "</span>";
 					html += "         <div class='badge badge-soft-purple'>" + arr[i].workTotal + "시간</div>";
 					html += "      </h5>";
 					html += "   </td>";
 					for (var j = 0; j < arr[i].date.length; j++) {
 					    var isHoliday = false;
//  					    console.log("arr[i].date[j] : ", arr[i].date[j]);
 					    // arr[i].date[j]가 holidayName과 같다면 빨간색 글씨로, 아니라면 검은 글씨로 보이게 하기
 					    for (var a = 0; a < holidayArrTest.length; a++) {
 					        if (arr[i].date[j] === holidayArrTest[a].holidayName) {
 					            isHoliday = true;
 					            break;
 					        }
 					    }
 					    if (isHoliday) {
 					        // 휴일인 경우 빨간색 글씨로 출력
 					        html += "<td><span class='fs-6 text-danger'>" + arr[i].date[j] + "</span></td>";
 					    } else {
 					        // 휴일이 아닌 경우 기존과 같이 출력
 					        html += "<td><span class='fs-6'>" + arr[i].date[j] + "</span></td>";
 					    }
 					}
 					html += "</tr>";
 	            }
 	             $("#tbody").html(html);
 	             $("#pagingArea").html(res.pagingHTML);
 	        }
 	    });
 	});
    
    download.on("click", function() {
    	selDept.val($("#selectDept").val());
    	firDate.val(thisWeek[0]);
    	laDate.val(thisWeek[6]);
    	workForm.submit();
	});
    
    var arr = null;
    var names = [];
    function settingList(res){
        arr = new Array();
       var nameBox = "";
       for(var i = 0; i < res.length; i++){
          if(nameBox != res[i].empName){
             nameBox = res[i].empName;
             names.push({
                empName : res[i].empName,
                comName : res[i].comName,
                workTotal : res[i].workTotal
             });
          }
       }
        
//        console.log(names);
       var cnt = 0;
       for(var j = 0; j < names.length; j++){
          var data = new Object();
          data.empName = names[j].empName;
          data.comName = names[j].comName;
          data.workTotal = names[j].workTotal;
          var dateArr = new Array();
          for(var k = 0; k < thisWeek.length; k++){
             dateArr.push(thisWeek[k]);
          }
          data.date = dateArr;
          arr.push(data);
       }
//        console.log(arr);
       
       var total = 0;
       var nameBox = "";
       var cnt = parseInt(0);
       var flag = false;
       for(var i = 0; i < res.length; i++){
          if(i == 0){
             nameBox = res[i].empName;
          }else{
             if(nameBox != res[i].empName){
//                 console.log(nameBox + " : " + total);
                nameBox = res[i].empName;
                total = 0;
             }
          }
          for(var j = 0; j < arr.length; j++){
// 		      console.log(arr[j].empName +" ::: "+res[i].empName);
		      if(res[i].empName == arr[j].empName){
		         for(var k = 0; k < arr[j].date.length; k++){
		            if(arr[j].date[k] == res[i].workStime.split(" ")[0]){
						arr[j].date[k] = res[i].workStime.substring(11,16) + "~" + res[i].workEtime.substring(11,16);
						total += parseInt(res[i].workTotal);
						arr[j].workTotal = total;
			         }
			      }
			   }
			}
		}
       
       // 공휴일 설정
       for(var j = 0; j < arr.length; j++){
          for (var i = 0; i < arr[j].date.length; i++) {
             for (var k = 0; k < holidayArrTest.length; k++) {
                if(arr[j].date[i].split(" ")[0].replaceAll("-","") == holidayArrTest[k].holidayDate){
//                    console.log(arr[j].date[i] + " ::::::::: " + holidayArrTest[k].holidayName);
                   arr[j].date[i] = holidayArrTest[k].holidayName; // 
                }
             }
          }
//           console.log(arr[j].empName + "님 : " + arr[j].workTotal);
       }
//        console.log(arr);
       names = [];
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
    dateBtn.trigger("click");
    
});


</script>