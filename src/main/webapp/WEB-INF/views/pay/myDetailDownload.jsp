	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
											
											
    <!-- pdf 생성 영역 부분 -->

		<div class="card">
			<div class="card-body">
<button class="btn btn-light" id="savePdfBtn">다운로드<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-download icon nav-icon"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg></button>

<div>
	<p></p>
	<hr/>
	<p></p>
	<div id="pdfDiv">
		<div class="modal-content" style="width: 1350px;">
			<div class="modal-header">
			<c:set var="today" value="<%=new java.util.Date()%>" />
				<h5 class="modal-title">
				<fmt:formatDate value="${today}" pattern="yyyy년"/>
				<span id="typedMonth1"></span> 월 급여 명세서 상세
				</h5>
				<button type="button" class="btn-close" aria-label="Close" onclick="fn_close()">
				</button>
			</div>
			<div class="modal-body" style="padding-top: 10px;">
				<table border="3px solid black;" style="width: 100%; position: relative; margin: auto; margin-top: 30px;">
					<thead style="border: 2px solid black; background-color: #f5f6f8;">
						<tr height="35">
							<td style="text-align: center; font-weight: bold;" colspan="4">요약</td>
						</tr>
					</thead>
					<tbody>
						<tr style="border: 1px solid black;" height="40">
							<td style="border: 1px solid black; text-align: center; font-weight: bold;"">사번</td>
							<td style="border: 1px solid black; text-align: center;">${vo.empNo }</td>
							<td style="border: 1px solid black; text-align: center; font-weight: bold;"">실 지급액</td>
							<td style="border: 1px solid black; text-align: center;"><span id="incSetRes3"></span> 원</td>
						</tr>
					</tbody>
				</table>
			
				<div class="row" style="padding-top: 40px;">
					<div class="card col-md-6">
						<div class="card-header justify-content-between d-flex align-items-center">
							<h4 class="card-title"><strong>지급내역</strong></h4>
						</div>
						<!-- end card header -->
						<div class="card-body" style="padding: 5px; height: 40vh;">
							<div class="table-responsive" style="width: 100%;">
								<table border="3px solid black;" style="width: 100%;">
									<thead style="border: 1px solid black;">
										<tr style="border: 1px solid black;" height="60">
											<th style="border: 1px solid black; text-align: center; font-weight: bold;">임금항목</th>
											<th style="border: 1px solid black; text-align: center; font-weight: bold;">지급 금액</th>
										</tr>
									</thead>
									<tbody style="border: 1px solid black;">
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">기본급</td>
											<td style="text-align: right; border: 1px solid black;"><span id="gibonPay" ></span></td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">기타수당</td>
											<td style="text-align: right; border: 1px solid black;"><span id="gitaPay" ></span></td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">직책수당</td>
											<td style="text-align: right; border: 1px solid black;"><span id="jikPay" ></span></td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">상여금</td>
											<td style="text-align: right; border: 1px solid black;"> 0</td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">유류비</td>
											<td style="text-align: right; border: 1px solid black;"> 0</td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">식대</td>
											<td style="text-align: right; border: 1px solid black;"> 0</td>
										</tr>
									</tbody>
									<!-- end tbody-->
									<tfoot style="border: 1px solid black;">
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">지급 총액</td>
											<td style="text-align: right;"><span id="incSetAmt3" ></span></td>
										</tr>
									</tfoot>
								</table>
								<!-- end table-->
							</div>
							<!-- end table responsive -->
						</div>
						<!-- end card body -->
					</div>
					<!-- end card -->
					<div class="card col-md-6">
						<div class="card-header justify-content-between d-flex align-items-center">
							<h4 class="card-title"><strong>공제내역</strong></h4>
						</div>
						<!-- end card header -->
						<div class="card-body" style="padding: 5px;">
							<div class="table-responsive" style="width: 100%;">
								<table border="3px solid black;" style="width: 100%;">
									<thead style="border: 1px solid black;">
										<tr style="border: 1px solid black;">
											<th style="border: 1px solid black; text-align: center; font-weight: bold;" height="60">공제항목</th>
											<th style="border: 1px solid black; text-align: center; font-weight: bold;">지급 금액</th>
										</tr>
									</thead>
									<tbody style="border: 1px solid black;">
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">사대보험</td>
											<td style="text-align: right; border: 1px solid black;"><span id="sadae" ></span></td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">소득세</td>
											<td style="text-align: right; border: 1px solid black;"><span id="sodeuk" ></span></td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">국민연금</td>
											<td style="text-align: right; border: 1px solid black;">사대보험에 포함</td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">건강보험</td>
											<td style="text-align: right; border: 1px solid black;">사대보험에 포함</td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">장기요양</td>
											<td style="text-align: right; border: 1px solid black;">사대보험에 포함</td>
										</tr>
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">고용보험</td>
											<td style="text-align: right; border: 1px solid black;">사대보험에 포함</td>
										</tr>
									</tbody>
									<!-- end tbody-->
									<tfoot style="border: 1px solid black;">
										<tr style="border: 1px solid black;" height="40">
											<td style="border: 1px solid black;">공제 총액</td>
											<td style="text-align: right; border: 1px solid black;"><span id="incSetDedt3" ></span></td>
										</tr>
									</tfoot>
								</table>
								<!-- end table-->
							</div>
							<!-- end table responsive -->
						</div>
						<!-- end card body -->
					</div>
					<!-- end card -->
				</div>
				<!-- end modal body row -->
				
				<table border="3px solid black;" style="width: 90%; position: relative; margin: auto; margin-top: 30px; height: 40%;">
					<thead style="border: 2px solid black; background-color: #f5f6f8;">
						<tr height="30">
							<td style="text-align: center; font-weight: bold;" colspan="2">계산식</td>
						</tr>
					</thead>
					<tbody style="border: 1px solid black;">
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">기타 수당 (연장, 휴일, 야간 포함)</td>
							<td style="border: 1px solid black; text-align: center;">통상 시급 X 근로 시간 X 1.5</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">직책 수당(직책에 따라 차등 부과)</td>
							<td style="border: 1px solid black; text-align: center;">파트장, 팀장, 실장, 본부장, CFO, CEO</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">사대보험</td>
							<td style="border: 1px solid black; text-align: center;">총 지급액 X 0.0939</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;" rowspan="8">임금별 소득세</td>
							<td style="border: 1px solid black; text-align: center;">1200만원 미만 임금 X 0.06</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">4600만원 미만 임금 X 0.15</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">8800만원 미만 임금 X 0.24</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">1억 5천만원 미만 임금 X 0.35</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">3억원 미만 임금 X 0.38</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">5억원 미만 임금 X 0.40</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">10억원 미만 임금 X 0.42</td>
						</tr>
						<tr style="border: 1px solid black;" height="30">
							<td style="border: 1px solid black; text-align: center;">10억원 이상 임금 X 0.45</td>
						</tr>
					</tbody>
				</table>
				<p></p>
				<div class="modal-footer">
					<button type="button" class="btn btn-light" onclick="fn_close()">닫기</button>
				</div>
			</div>
		</div><!-- /.modal-content -->
	</div>
</div>
</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<!-- html2canvas : 웹 페이지의 DOM 요소를 캡처해 이미지로 만듦 -->
<script src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>
<script>
$('#savePdfBtn').click(function() {
	var typedMonth1 = $("#typedMonth1");
    html2canvas($('#pdfDiv')[0]).then(function(canvas) {
        // 캔버스를 이미지로 변환
        let imgData = canvas.toDataURL('image/png');

        let margin = 10; // 출력 페이지 여백설정
        let imgWidth = 210 - (10 * 2); // 이미지 가로 길이(mm) A4 기준
        let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
        let imgHeight = canvas.height * imgWidth / canvas.width;
        let heightLeft = imgHeight;

        let doc = new jsPDF('p', 'mm');
        let position = margin;

        // 첫 페이지 출력
        doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;

        // 한 페이지 이상일 경우 루프 돌면서 출력
        while (heightLeft >= 20) {
            position = heightLeft - imgHeight;
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            doc.addPage();
            heightLeft -= pageHeight;
        }

        // 파일 저장
        doc.save('23년'+${vo.month}+'월 급여명세서.pdf');
    });
});
$(function() {
	var incSetRes = ${vo.incSetRes};
	var yearAmt = ${vo.yearAmt};
	var incSetAmt = ${vo.incSetAmt};
	var incSetDedt = ${vo.incSetDedt};
	var gibonPay = ${vo.gibonpay};
	var gitaPay = ${vo.gitapay};
	var jikPay = ${vo.jikpay};
	var sadae = ${vo.sadae};
	var sodeuk = ${vo.sodeuk};
// 	var month = ${vo.month};
	
	document.getElementById('incSetRes3').innerHTML = Number(incSetRes).toLocaleString();
	document.getElementById('incSetAmt3').innerHTML = Number(incSetAmt).toLocaleString();
	document.getElementById('incSetDedt3').innerHTML = Number(incSetDedt).toLocaleString();
	document.getElementById('gibonPay').innerHTML = Number(gibonPay).toLocaleString();
	document.getElementById('gitaPay').innerHTML = Number(gitaPay).toLocaleString();
	document.getElementById('jikPay').innerHTML = Number(jikPay).toLocaleString();
	document.getElementById('sadae').innerHTML = Number(sadae).toLocaleString();
	document.getElementById('sodeuk').innerHTML = Number(sodeuk).toLocaleString();

	fn_setMonth(${vo.month});

});
function fn_close() {
	window.close();
}

function fn_setMonth(mon){
// 	console.log(mon);
	if(mon == null){
		let today = new Date();   
		let month = today.getMonth() +1;
		document.getElementById('typedMonth1').innerHTML = month;
	}else{
		document.getElementById('typedMonth1').innerHTML = mon;
	}
}
</script>