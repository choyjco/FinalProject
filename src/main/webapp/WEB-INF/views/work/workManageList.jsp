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
                	<div id="date" class="px-4 py-2 fs-4 fw-bold" style="margin-bottom: 10px;"></div>
                	<div class="row d-flex justify-content-between">
	                	<div class="col-3">
	                		<select class="form-select" id="selectDept" aria-label="Default select example" style="width:113px;">
			                	<c:forEach items="${comList}" var="comList">
				                	<c:if test="${fn:startsWith(comList.comCode, 'a') }">
										<option value="${comList.comCode}">${comList.comName}</option>
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
	                		<div class="badge rounded-pill badge-soft-danger">　</div> 초과
	                		<div class="badge rounded-pill badge-soft-warning">　</div> 미달
	                		<div class="badge rounded-pill badge-soft-success">　</div> 준수
	                	</div>
	                	<div class="col-3 d-flex justify-content-end" style="margin-bottom: 5px; ">
	                		<div class="gridjs-search">
								<input type="date" id="datePick" placeholder="날짜 선택" aria-label="Type a keyword..." class="gridjs-input gridjs-search-input">
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
                                <th scope="col">기간 내 총 근무 시간</th>
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
<form action="/excel/workmanagelist" method="post" id="workForm">
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
    var pagingArea = $("#pagingArea");
    var laDate = $("#laDate");
    var firDate = $("#firDate");
    var selDept = $("#selDept");
    var clickedPage = 1;
    
    $("#pagingArea").on("click", "a", function(event) {
    	event.preventDefault();
	    clickedPage = $(this).data("page");
	    console.log("클릭한 페이지 : ", clickedPage);
	    dateBtn.trigger("click");
    });
    
    var param = {
            firstDate: "",
            lastDate: "",
            selectDept: "",
            page: clickedPage
        };
    
    var thisWeek = [];
    
    // 현재 날짜를 가져와서 날짜 선택에 설정
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();
    var formattedDate = yyyy + '-' + mm + '-' + dd;
    datePick.val(formattedDate);

///////////////////////////////////////////////////////////////////////////////////////    
    download.on("click", function() {
    	selDept.val($("#selectDept").val());
    	firDate.val(thisWeek[0]);
    	laDate.val(thisWeek[6]);
    	workForm.submit();
	});
///////////////////////////////////////////////////////////////////////////////////////    
    
    // dateBtn 클릭 이벤트 핸들러
    dateBtn.on("click", function() {
        var selectedDate = datePick.val();
        
	// 부서검색 
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

        for (var i = 0; i < 7; i++) {
            var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek + 1));
            var yyyy = resultDay.getFullYear();
            var mm = String(resultDay.getMonth() + 1).padStart(2, '0');
            var dd = String(resultDay.getDate()).padStart(2, '0');
            thisWeek[i] = yyyy + '-' + mm + '-' + dd;
        }

        var day = ["(월)", "(화)", "(수)", "(목)", "(금)", "(토)", "(일)"];
        for (var i = 0; i < thisWeek.length; i++) {
            $("#date").text('기간 : ' + thisWeek[0] + day[0]+'~'+thisWeek[6] + day[6]);
        }
        
        param.firstDate = thisWeek[0];
        param.lastDate = thisWeek[6];
        param.selectDept = selectDept;
        param.page = clickedPage;
        
       	var html = "";
       	var firstDate = thisWeek[0];
       	var lastDate = thisWeek[6];
       	
        $.ajax({
            type: "post",
            url: "/work/workmanagelist",
            beforeSend: function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            data: JSON.stringify(param),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(res) {
            	console.log("pagingVO.dataList", res.dataList);
            	for(var i = 0; i < res.dataList.length; i++){
            		html += "<tr>";
            		html += "<td>"
					if(res.dataList[i].empProfile == null){
						html += "<img src='${pageContext.request.contextPath }/resources/images/profile.jpg' alt='' class='avatar-sm rounded-circle me-2'>";
					}else{
						html += "<img src='${pageContext.request.contextPath }"+ res.dataList[i].empProfile +"' alt='' class='avatar-sm rounded-circle me-2'>";
						
					}
            		html += "<a href='/work/workdetail?empNo=" + res.dataList[i].empNo + "&firstDate=" + firstDate + "&lastDate=" + lastDate + "'>" + res.dataList[i].empName + "</a></td>";
            		html += "	<td>" + res.dataList[i].comName + "</td>";
            		html += "	<td>" + res.dataList[i].empNo + "</td>";
            		html += "	<td>";
            		html += "		<h5>";
            		if(res.dataList[i].workSum > 52){
            			html += "		<div class='badge badge-soft-danger'>초과</div><span class='fs-6'>" + " " + res.dataList[i].workSum + "시간</span>";
            		}else if(res.dataList[i].workSum < 40){
            			html += "		<div class='badge badge-soft-warning'>미달</div><span class='fs-6'>" + " " + res.dataList[i].workSum + "시간</span>";
            		}else{
            			html += "		<div class='badge badge-soft-success'>준수</div><span class='fs-6'>" + " " + res.dataList[i].workSum + "시간</span>";
            		}
            		html += "		</h5>";
            		html += "	</td>";
            		html += "</tr>";
            	}
            	
		        $("#tbody").html(html);
		        $("#pagingArea").html(res.pagingHTML);
            }
        });
        
    });
	
    // 페이지 로딩 시 자동으로 dateBtn 클릭 이벤트 발생
    dateBtn.trigger("click");
});
</script>