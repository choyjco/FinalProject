<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>애널리틱스</h1>
			</div>
		</div>
	</div>
</div>
<div class="container" style="max-width: 80%;">
    <div class="row" style="margin: 0; padding: 0;">
        <div class="col-lg-2 pt-5 pb-5" style="padding-left: 20px; padding-right: 20px;">
            <!-- 사이드 메뉴 -->
            <%@ include file="sidemenuAdmin.jsp" %>
        </div>

		<div class="col-lg-10 pt-5" style="padding-left: 20px; padding-right: 20px;">
			<!--차트가 그려질 부분-->
			<div class="row" style="display: flex;">
				<div class="col-lg-8 pt-5 pb-5">
					<h5 style="text-align: center;"><b>월별 매출</b></h5>
					<canvas id="salesChart" style="width: 600px;"></canvas>
				</div>
				<div class="col-lg-4 pt-5 pb-5">
					<h5 style="text-align: center;"><b>월별 매출</b></h5>
					<table class="table col-lg-12">
			        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
			        		<th style="width: 33%;">월</th>
			        		<th style="width: 33%;">매출액</th>
			        		<th style="width: 33%; text-align: right;">결제 횟수</th>
			        	</tr>
			        	<c:choose>
			        		<c:when test="${empty salesList }">
			        			<tr align="center">
			        				<td colspan="3">조회할 데이터가 없습니다.</td>
			        			</tr>
			        		</c:when>
			        		<c:otherwise>
			        			<c:forEach items="${salesList }" var="salesList">
						        	<tr>
						        		<td align="center">${salesList.month }</td>
						        		<td align="right">
							        		<fmt:formatNumber value="${salesList.totalCnt }" pattern="#,###" />원
						        		</td>
						        		<td align="right">${salesList.salesCnt }번</td>
						        	</tr>
			        			</c:forEach>
			        		</c:otherwise>
			        	</c:choose>
			        </table>
				</div>
				<div class="col-lg-8 pt-5 pb-5" align="center">
					<h5 style="text-align: center;"><b>가장 많이 선택된 레벨</b></h5>
					<canvas id="levelChart" width="500px;" height="500px;"></canvas>
					<br>
				</div>
				<div class="col-lg-4 pt-5 pb-5" style="margin-top: 100px;">
					<h5 style="text-align: center;"><b>가장 많이 선택된 레벨</b></h5>
					<table class="table col-lg-12">
			        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
			        		<th style="width: 30%; text-align: left;">레벨 이름</th>
			        		<th style="width: 40%;">레벨 선택 비율</th>
			        		<th style="width: 30%;">레벨 선택 수</th>
			        	</tr>
			        	<c:choose>
			        		<c:when test="${empty levelList }">
			        			<tr align="center">
			        				<td colspan="3">조회할 레벨이 없습니다.</td>
			        			</tr>
			        		</c:when>
			        		<c:otherwise>
			        			<c:forEach items="${levelList }" var="levelList">
						        	<tr>
						        		<td>${levelList.levelName }</td>
						        		<td align="right">${levelList.levelRatio }%</td>
						        		<td align="right">${levelList.levelCnt }번</td>
						        	</tr>
			        			</c:forEach>
			        		</c:otherwise>
			        	</c:choose>
			        </table>
			        <div style="padding-left: 80px;">
				        <div style="background-color: #D0DDF326; width: 250px; font-size: 16px; color: black;">
				        	<p align="center"><b><레벨 정보></b></p>
				        	레벨 1 : 30인 이하 사업장 추천<br>
				        	레벨 2 : 30인 ~ 100인 사업장 추천<br>
				        	레벨 3 : 100인 이상 사업장 추천<br>
				        </div>
			        </div>
				</div>
				<div class="col-lg-8 pt-5 pb-5" align="center">
					<h5 style="text-align: center;"><b>가장 많이 선택된 기능</b></h5>
					<canvas id="funcChart" width="500px;" height="500px;"></canvas>
				</div>
				<div class="col-lg-4 pt-5 pb-5" style="margin-top: 100px;">
					<h5 style="text-align: center;"><b>가장 많이 선택된 기능</b></h5>
					<table class="table col-lg-12">
			        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
			        		<th style="width: 30%; text-align: left;">기능 이름</th>
			        		<th style="width: 40%;">기능 선택 비율</th>
			        		<th style="width: 30%;">기능 선택 수</th>
			        	</tr>
			        	<c:choose>
			        		<c:when test="${empty funcList }">
			        			<tr align="center">
			        				<td colspan="3">조회할 기능이 없습니다.</td>
			        			</tr>
			        		</c:when>
			        		<c:otherwise>
			        			<c:forEach items="${funcList }" var="funcList">
						        	<tr>
						        		<td>${funcList.funcMemo }</td>
						        		<td align="right">${funcList.funcRatio }%</td>
						        		<td align="right">${funcList.funcCnt }번</td>
						        	</tr>
			        			</c:forEach>
			        		</c:otherwise>
			        	</c:choose>
			        </table>
				</div>
				
				<div class="col-lg-7 pt-5 pb-5">
					<h5 style="text-align: center;"><b>사이트 회원의 회사 인원수</b></h5>
					<canvas id="cusEmpChart" style="width: 700px; height: 600px;"></canvas>
				</div>
				<div class="col-lg-5 pt-5 pb-5">
					<h5 style="text-align: center;"><b>회사 인원수에 따른 레벨 선택</b></h5>
					<table class="table col-lg-12">
			        	<tr style="background-color: #D0DDF3; color: black; text-align: center;">
			        		<th style="width: 45%;">회사 인원수</th>
			        		<th style="width: 55%;">가장 많이 선택한 레벨명</th>
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
			        		<td>300명 이상 500명 미만</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        	<tr>
			        		<td>500명 이상 700명 미만</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        	<tr>
			        		<td>700명 이상 1,000명 미만</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        	<tr>
			        		<td>1,000명 이상</td>
			        		<td align="center">LEVEL3</td>
			        	</tr>
			        </table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script> -->
<script type="text/javascript">




$(function(){
    $.ajax({
        url: "/levelchart",
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
        url: "/funcchart",
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
    
    $.ajax({
        url: "/saleschart",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        async: true,
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            var totalCntlist = [];
            var monthlist = [];
            var salesCntlist = [];

            $.each(data, function () {
                totalCntlist.push(this["totalCnt"]);
                monthlist.push(this["month"]);
                salesCntlist.push(this["salesCnt"]);
            });

            const ctx = document.getElementById('salesChart').getContext('2d');
            const myChart1 = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: monthlist,
                    datasets: [{
                        label: '매출액',
                        data: totalCntlist,
                        backgroundColor: [
                        	'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 99, 132, 0.2)',
                        ],
                        borderColor: [
                        	'rgb(54, 162, 235)',
                        	'rgb(255, 99, 132)',
                        ],
                        borderWidth: 1,
                        yAxisID: 'y1',
                        type: 'bar'
                    }, {
                        label: '결제 횟수',
                        data: salesCntlist,
                        backgroundColor: 'gray',
                        borderColor: 'gray',
                        borderWidth: 2,
                        yAxisID: 'y2',
                    }]
                },
                options: {
                    title: {
                        display: true,
                        text: '월별 매출액',
                        fontSize: 20
                    },
                    legend: {
                        display: true,
                        position: 'top',
                    },
                    scales: {
                        y1: {
                            beginAtZero: true,
                            position: 'left',
                            ticks: {
                                min: 0,
                                stepSize: 500000,
                                fontSize: 14,
                            },
                        },
                        y2: {
                        	beginAtZero: true,
                            position: 'right',
                            grid: {
                                drawOnChartArea: false,
                            },
                            ticks: {
//                             	callback: function(value, index, ticks) {
// 									return `${value.toLocaleString()}`;
// 								}
                                min: 0,
                                stepSize: 2,
                                fontSize: 14,
                            },
                        }
                    }
                }
            });
        },
        error: function (xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });

    
    $.ajax({
        url: "/cusempchart",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var cusEmpRangelist = [];
            var empCntlist = [];

            $.each(data, function(){
            	cusEmpRangelist.push(this["cusEmpRange"]);
            	empCntlist.push(this["empCnt"]);
            });

            console.log("Sales:", data);
            console.log("범위:", cusEmpRangelist);
            console.log("인원수:", empCntlist);

            const ctx = document.getElementById('cusEmpChart').getContext('2d');
            const myChart1 = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: cusEmpRangelist,
                    datasets: [{
                        label: '회사 인원수',
                        data: empCntlist,
                        yAxisID: 'y1',
                        backgroundColor: [
                        	'rgba(54, 162, 235, 0.2)',
                        	'rgba(255, 99, 132, 0.2)',
                        ],
                        borderColor: [
                        	'rgba(54, 162, 235)',
                        	'rgba(255, 99, 132)',
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                	title: {
                		display: true,
                		text: '회사 인원수',
                		fontSize: 20
                	},
                	legend: {
                		display: true,
                		position: 'top',
                	},
//                 	tooltips: {
//                 		enabled: false
//                 	},
                	responsive: false,
                	scales: {
                		y1: {
                            beginAtZero: true,
                            position: 'left',
                            ticks: {
                                min: 0,
                                stepSize: 4,
                                fontSize: 14,
                            },
                        },
                	}
                }
            });
        }, // 매출 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
    
    
    
    
    
    
    
    
});




</script>
