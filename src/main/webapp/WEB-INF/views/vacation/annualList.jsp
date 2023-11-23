<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="card">
	<div class="card-body">
		<div class="row">
			<div class="col-1">
				<select id="yearSelect" class="form-select" aria-label="Default select example" style="width:133px; margin-bottom: 13px;">
					<option value="2013">2013년</option>
					<option value="2014">2014년</option>
					<option value="2015">2015년</option>
					<option value="2016">2016년</option>
					<option value="2017">2017년</option>
					<option value="2018">2018년</option>
					<option value="2019">2019년</option>
					<option value="2020">2020년</option>
					<option value="2021">2021년</option>
					<option value="2022">2022년</option>
					<option value="2023" selected>2023년</option><!-- 기본 선택: 현재 연도 -->
				</select>
			</div>
			<div class="col-11"></div>
		</div>
		<div class="row">
			<div class="col-3">
				<div class="card shadow-lg">
					<div class="card-body">
						<h5 class="card-title fw-bold"><span class="badge bg-lg bg-primary">　</span> 잔여일수</h5>
						<div class="card-body">
							<h4 id="curr" class="card-text fw-bold text-primary">
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-3">
				<div class="card shadow-lg">
					<div class="card-body">
						<h5 class="card-title fw-bold"><span class="badge bg-lg bg-secondary">　</span> 자동부여</h5>
						<div class="card-body">
							<h4 id="outo" class="card-text fw-bold text-secondary">
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-3">
				<div class="card shadow-lg">
					<div class="card-body">
						<h5 class="card-title fw-bold"><span class="badge bg-lg bg-success">　</span> 조정</h5>
						<div class="card-body">
							<h4 id="settle" class="card-text fw-bold text-success">
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-3">
				<div class="card shadow-lg">
					<div class="card-body">
						<h5 class="card-title fw-bold"><span class="badge bg-lg bg-danger">　</span> 사용</h5>
						<div class="card-body">
							<h4 id="use" class="card-text fw-bold text-danger">
							</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="table-responsive">
			<table class="table table-bordered align-middle table-nowrap table-check">
			    <thead class="table-light">
			        <tr>
			            <th scope="col">날짜</th>
			            <th scope="col">자동부여</th>
			            <th scope="col">자동소멸</th>
			            <th scope="col">조정</th>
			            <th scope="col">사용</th>
			            <th scope="col">잔여일수</th>
			        </tr>
			   </thead>
			   <tbody id="tbody"></tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    // 페이지 로딩 시 2023 값을 기본 값으로 설정하고 ajax 요청 보내기
    var yearSelect = $("#yearSelect").val();
    loadData(yearSelect);

    // 연도 선택이 변경될 때마다 ajax 요청 보내고 결과를 출력
    $("#yearSelect").change(function() {
        var selectedYear = $(this).val();
        loadData(selectedYear);
        $("#outo").html('');
        $("#settle").html('');
    	$("#use").html('');
    });

    function loadData(year) {
        var data = {
            year : year
        };

        $.ajax({
            type: "POST",
            url: "/vacation/annuallist",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(res) {
                updateUI(res);
				console.log(res);
            }
        });
    }

    function updateUI(data) {
    	var html = "";
    	var totalAddDays = 0; // 조정인 경우의 vpAddDays의 총합
        var totalSubDays = 0; // 사용인 경우의 vpSubDays의 총합
        
    	for(var i = 0; i < data.length; i++){
	        html += "<tr>";
	        html += "<td>" + data[i].vpChgDate.substr(0,10) + "</td>";
	        	
	        if(data[i].vpChgCase == '자동부여'){
	        	$("#outo").html('+' + data[i].vpAddDays + '일');
		        html += "<td><font class='text-secondary'>+" + data[i].vpAddDays + "일</font></td>";
	        }else{
		        html += "<td></td>";
	        }
	        	
	        if(data[i].vpChgCase == '자동소멸'){
		        html += "<td><font class='text-danger'>-" + data[i].vpSubDays + "일</font></td>";
	        }else{
		        html += "<td></td>";
	        }
	        
	        if(data[i].vpChgCase == '조정'){
		        html += "<td><font class='text-success'>+" + data[i].vpAddDays + "일</font></td>";
		        totalAddDays += parseInt(data[i].vpAddDays);
	        }else{
		        html += "<td></td>";
	        }

	        if(data[i].vpChgCase == '사용'){
		        html += "<td><font class='text-danger'>-" + data[i].vpSubDays + "일</font></td>";
		        totalSubDays += parseInt(data[i].vpSubDays);
	        }else{
		        html += "<td></td>";
	        }
	        
	        html += "<td><font class='text-primary fw-bold'>" + data[i].vpDays + "일</font></td>";
	        html += "</tr>";
	        $("#settle").html('+' + totalAddDays + '일');
	    	$("#use").html('-' + totalSubDays + '일');
	    	$("#curr").html(data[i].vpDays + '일');
    		
    	}
    	$("#tbody").html(html);
    	
    }
});

</script>