<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<head>
<style>
td {
	word-wrap: break-word;
	text-align: center;
}
</style>
</head>
<div>
	<div class="col-lg-12">
	<!-- 	<div class="card">
			<div class="card-body"> -->
				<div class="row" style="display: flex;">
					<div class="col-lg-6 pt-5 pb-5">
						<h5 style="text-align: center;"><b>사원 성별 비율</b></h5>
						<div class="card">
						<div class="card-body col-lg-7" style="display: flex;">
						<canvas id="genderChart" style="width: 300px; height: 300px;"></canvas>
						<table class="table col-lg-8" style="height: 200px; margin-top: 50px;">
				        	<tr align="center" style="background: #E9ECF5;">
				        		<th style="width: 33%;">구분</th>
				        		<th style="width: 33%;">사원 수(명)</th>
				        		<th style="width: 33%;">비율(%)</th>
				        	</tr>
			        	<c:choose>
			        		<c:when test="${empty genderRateList }">
			        			<tr>
			        				<td align="center" colspan="3">조회할 데이터가 없습니다.</td>
			        			</tr>
			        		</c:when>
			        		<c:otherwise>
			        			<c:forEach items="${genderRateList }" var="genderRateList">
							        	<tr>
							        		<td align="center">${genderRateList.empGen }</td>
							        		<td style="text-align: right">
								        		<fmt:formatNumber value="${genderRateList.genCnt }" pattern="#,###" />명
							        		</td>
							        		<td style="text-align: right">${genderRateList.genRatio }%</td>
							        	</tr>
			        			</c:forEach>
			        		</c:otherwise>
			        	</c:choose>
			        </table>
			        	<br>
			        	</div>
			        	</div>
			        	</div>
			        	<div class="col-lg-6 pt-5 pb-5">
						<h5 style="text-align: center;"><b>근무 유형</b></h5>
						<div class="card">
						<div class="card-body col-lg-7" style="display: flex;">
						<canvas id="workChart" style="width: 300px; height: 300px;"></canvas>
						<table class="table col-lg-8" style="height: 200px; margin-top: 50px;">
				        	<tr style="background: #E9ECF5;" align="center">
				        		<th style="width: 50%;">근무 유형</th>
				        		<th style="width: 50%;">비율(%)</th>
				        	</tr>
				        	<tr>
				        		<td>일반 근무</td>
				        		<td style="text-align: right">80%</td>
				        	</tr>
				        	<tr>
				        		<td>추가 근무</td>
				        		<td style="text-align: right">15%</td>
				        	</tr>
				        	<tr>
				        		<td>기타</td>
				        		<td style="text-align: right">5%</td>
				        	</tr>
			        </table>
			        	<br>
			        	</div>
			        	</div>
			        	</div>
					
					<div class="col-lg-6 pb-5">
						<h5 style="text-align: center;"><b>연도별 채용된 사원 수</b></h5>
						<div class="card">
						<div class="card-body">
						<canvas id="recruitChart" style="width: 780px; height: 500px;"></canvas>
					</div>
					</div>
					</div>
					<div class="col-lg-6 pb-5">
						<h5 style="text-align: center;"><b>연도별 채용된 사원 수</b></h5>
						<div class="card">
						<div class="card-body">
						<table class="table col-lg-12">
				        	<tr align="center" style="background: #E9ECF5;">
				        		<th style="width: 20%;">연도</th>
				        		<th style="width: 20%;">신입</th>
				        		<th style="width: 20%;">경력</th>
				        		<th style="width: 35%;">총 채용 인원 수</th>
				        	</tr>
				        	<c:choose>
				        		<c:when test="${empty recuritList }">
				        			<tr>
				        				<td align="center" colspan="2">조회할 데이터가 없습니다.</td>
				        			</tr>
				        		</c:when>
				        		<c:otherwise>
				        			<c:forEach items="${recuritList }" var="recuritList">
								        	<tr>
								        		<td align="center">${recuritList.year }년</td>
								        		<td style="text-align: right">${recuritList.newCnt }명</td>
								        		<td style="text-align: right">${recuritList.carCnt }명</td>
								        		<td style="text-align: right">${recuritList.totalCnt }명</td>
								        	</tr>
				        			</c:forEach>
				        		</c:otherwise>
				        	</c:choose>
				        </table>
					</div>
					</div>
					</div>
					
<!-- 					<div class="col-lg-3 pt-5 pb-5"> -->
<!-- 						<h5 style="text-align: center;"><b>근무 차트</b></h5> -->
<%-- 						<canvas id="workChart" style="width: 500px; height: 500px;"></canvas> --%>
<!-- 					</div> -->
<!-- 					<div class="col-lg-4"> -->
<!-- 						<h5 style="text-align: center;"><b>일주일 근무 total</b></h5> -->
<%-- 						<canvas id="workinfochart" style="width: 250px; height: 250px;"></canvas> --%>
<!-- 					</div> -->
<!-- 					<div class="col-lg-4"> -->
<!-- 						<h5 style="text-align: center;"><b>근무 차트</b></h5> -->
<%-- 						<canvas id="my" style="width: 250px; height: 250px;"></canvas> --%>
<!-- 					</div> -->
<!-- 					<div class="col-lg-4 pb-5"> -->
<!-- 						<h5 style="text-align: center;"><b>부서별 급여</b></h5> -->
<%-- 						<canvas id="departmentPayChart" style="width: 250px; height: 250px;"></canvas> --%>
<!-- 					</div> -->
					<div class="col-lg-6 pb-5">
						<h5 style="text-align: center;"><b>분기별 매출액/이익률</b></h5>
						<div class="card">
						<div class="card-body">
						<canvas id="companySalesChart"></canvas>
					</div>
					</div>
					</div>
					<div class="col-lg-6 pb-5">
						<h5 style="text-align: center;"><b>부서별 직원 수 및 평균 연봉</b></h5>
						<div class="card">
						<div class="card-body">
						<canvas id="departmentEmpChart"></canvas>
					</div>
					</div>
					</div>
				</div>
			<!-- </div>
		</div> -->
	</div>
</div>








<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script> -->
<script type="text/javascript">

$(function() {
	// 성별 차트
	$.ajax({
        url: "/stats/genderchart",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
//         data: JSON.stringify(data),
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var empGenlist = [];
            var countlist = [];
            var ratiolist = [];

            $.each(data, function(){
            	empGenlist.push(this["empGen"]);
                countlist.push(this["cnt"]);
                ratiolist.push(this["ratio"]);
            });

            console.log("Data received:", data);
            console.log("Gender Names:", empGenlist);
            console.log("Counts:", countlist);
            console.log("Ratios:", ratiolist);

            const ctx = document.getElementById('genderChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: empGenlist,
                    datasets: [{
                        label: '성별',
                        data: ratiolist,
                        backgroundColor: [
                            'gray',
                            '#54D4FF',
                            '#FF5454',
                        ],
//                         borderWidth: 1
                        hoverOffset: 4
                    }]
                },
                options: {
                	responsive: false,
                	title: {
                		display: true,
                		text: '사원 성별 비율',
                		fontSize: 20
                	},
                	legend: {
                		display: true,
                		position: 'top',
                	},
//                 	tooltips: {
//                 		enabled: false
//                 	},
                }
            });
        }, // 성별 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
	
	// 채용차트
	
	
	$.ajax({
        url: "/stats/recruityearchart",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
//         data: JSON.stringify(data),
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var yearlist = [];
            var totalCntlist = [];
            var carCntlist = [];
            var newCntlist = [];

            $.each(data, function(){
            	yearlist.push(this["year"]);
            	totalCntlist.push(this["totalCnt"]);
            	carCntlist.push(this["carCnt"]);
            	newCntlist.push(this["newCnt"]);
            });

            console.log("Data received:", data);
            console.log("채용년도 :", yearlist);
            console.log("Counts:", totalCntlist);
            console.log("Counts:", carCntlist);
            console.log("Counts:", newCntlist);

            const ctx = document.getElementById('recruitChart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: yearlist,
                    datasets: [{
                    	label: '신입',
                    	data: newCntlist,
                    	backgroundColor: '#54D4FF',
                    	borderWidth: 1
                    }, {
                    	label: '경력',
                    	data: carCntlist,
                    	backgroundColor: '#54A7FF',
                    	borderWidth: 1
                    }]
                },
                options: {
                	scales: {
                		x: {
                			stacked: true,
                		},
                		y: {
                			stacked: true,
                		},
                	}
                }
            });
        },	// 채용 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
	
	
	$.ajax({
        url: "/stats/workinfochart",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
        async: true,
//         data: JSON.stringify(data),
        type: "POST",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function(data) {
            var empNolist = [];
            var totalWorklist = [];
            var workStimelist = [];

            $.each(data, function(){
            	empNolist.push(this["empNo"]);
            	totalWorklist.push(this["totalWork"]);
            	workStimelist.push(this["workStime"]);
            });

            console.log("Data received:", data);
            console.log("empNolist:", empNolist);
            console.log("totalWorklist:", totalWorklist);
            console.log("workStimelisst:", workStimelist);

            const ctx = document.getElementById('workinfochart').getContext('2d');
            const myChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: empNolist,
                    datasets: [{
                        label: '근무시간',
                        data: totalWorklist,
                        backgroundColor: [
                            'lightblue',
                        ],
                        hoverOffset: 4
                    }]
                }
            });
        }, // 근무 차트
        
        error: function(xhr, status, error) {
            console.log("AJAX Error: " + error);
            console.log(xhr.responseText);
        }
    });
	
	
	
});

	
new Chart(document.getElementById("workChart"), {
    type: 'doughnut',
    data: {
      labels: ["일반 근무", "추가 근무", "기타"],
      datasets: [
        {
          label: "근무",
          backgroundColor: ["#BBD0FF", "#C8B6FF", "#E7C6FF"],
          data: [80, 15, 5]
        }
      ]
      
    },
    options: {
    	responsive: false,
    }
});

new Chart(document.getElementById("companySalesChart"), {
    type: 'line',
    data: {
      labels: [
    	  "2019년 1분기", "2019년 2분기", "2019년 3분기", "2019년 4분기",
    	  "2020년 1분기", "2020년 2분기", "2020년 3분기", "2020년 4분기",
    	  "2021년 1분기", "2021년 2분기", "2021년 3분기", "2021년 4분기",
    	  "2022년 1분기", "2022년 2분기", "2022년 3분기", "2022년 4분기",
    	  "2023년 1분기", "2023년 2분기", "2022년 3분기"],
      datasets: [
        {
          label: "매출(단위: 일 억원)",
          backgroundColor: ["#54D4FF50"],
          borderColor: ["#54D4FF"],
          borderWidth: 1,
          yAxisID: 'y1',
          data: [
        	  150, 180, 130, 190,
        	  100, 80, 90, 110,
			  120, 100, 130, 90,        	  
        	  160 ,120, 140, 100,
        	  200, 180, 250],
          type: 'bar'
        }, {
        	label: '이익률',
        	data: [
        		0.15, 0.18, 0.13, 0.19,
        		0.1, 0.08, 0.09, 0.11,
        		0.12, 0.1, 0.13, 0.09,
        		0.16, 0.12, 0.14, 0.1,
        		0.2, 0.18, 0.25],
        	backgroundColor: '#9D9D9D',
        	borderColor: '#9D9D9D',
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
                    stepSize: 100,
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
//                 	callback: function(value, index, ticks) {
//							return `${value.toLocaleString()}`;
//						}
                    min: 0,
                    stepSize: 0.05,
                    fontSize: 14,
                },
            }
        }
    }
});

new Chart(document.getElementById("departmentEmpChart"), {
    type: 'line',
    data: {
      labels: [
    	  "개발 1팀", "개발 2팀", "개발 3팀", "개발 4팀", "개발 5팀",
    	  "영업 1팀", "영업 2팀", "영업 3팀",
    	  "경영 1팀", "경영 2팀",
    	  "인사 1팀", "인사 2팀",
    	  "마케팅 1팀", "마케팅 2팀"
    	  ],
      datasets: [
        {
          label: "부서 직원 수",
          backgroundColor: [
        	  'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)',
        	  'rgba(255, 205, 86, 0.2)', 'rgba(255, 205, 86, 0.2)', 'rgba(255, 205, 86, 0.2)',
        	  'rgba(75, 192, 192, 0.2)', 'rgba(75, 192, 192, 0.2)',
        	  'rgba(54, 162, 235, 0.2)', 'rgba(54, 162, 235, 0.2)',
        	  'rgba(153, 102, 255, 0.2)', 'rgba(153, 102, 255, 0.2)'
          ],
          borderColor: [
        	  'rgb(255, 99, 132)', 'rgb(255, 99, 132)', 'rgb(255, 99, 132)', 'rgb(255, 99, 132)', 'rgb(255, 99, 132)',
        	  'rgb(255, 205, 86)', 'rgb(255, 205, 86)', 'rgb(255, 205, 86)',
        	  'rgb(75, 192, 192)', 'rgb(75, 192, 192)',
        	  'rgb(54, 162, 235)', 'rgb(54, 162, 235)',
        	  'rgb(153, 102, 255)', 'rgb(153, 102, 255)'
          ],
          borderWidth: 1,
          yAxisID: 'y1',
          data: [
        	  29, 14, 15, 11, 12,
        	  14, 12, 7,
        	  11, 7,
        	  10, 4,
        	  8, 9
        	  ],
        type: 'bar'
        }, {
        	label: '부서별 평균 연봉(단위: 천 만원)',
        	data: [
        		4, 5.5, 4.2, 4.5, 3.8,
        		3.1, 3.2, 3.6,
        		3.8, 4,
        		3.5, 3.3,
        		3.1, 3.7
        	],
        	backgroundColor: '#9D9D9D',
        	borderColor: '#9D9D9D',
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
                    stepSize: 5,
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
//                 	callback: function(value, index, ticks) {
//							return `${value.toLocaleString()}`;
//						}
                    min: 0,
                    max: 6,
                    stepSize: 0.5,
                    fontSize: 14,
                },
            }
        }
    }
});

</script>

