<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>결제하기</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="container pb-5">
    <div class="row">
        <div class="col-lg-12 p-5" align="center">
        	<input type="hidden" id="cusRnum" name="cusRnum" value="${SessionInfo.cusRnum }">
        	<input type="hidden" id="payCode" name="payCode" value="${paymentVO.payCode }">
        	<input type="hidden" id="cusEmail" name="cusEmail" value="${SessionInfo.cusEmail }">
        	<input type="hidden" id="cusTel" name="cusTel" value="${SessionInfo.cusTel }">
        	<input type="hidden" id="cusCom" name="cusCom" value="${SessionInfo.cusCom }">
        	<input type="hidden" id="cusName" name="cusName" value="${SessionInfo.cusName }">
        	<input type="hidden" id="cusEmp" name="cusEmp" value="${SessionInfo.cusEmp }">
        	<input type="hidden" id="payAmt" name="payAmt" value="${paymentVO.payAmt }">
        	
        	<div>
	        	<h2><b>WSI 시스템 결제</b></h2>
	        	<hr style="border: solid 0.5px black;">
        	</div>
        	<br>
        	<div class="col-lg-10" style="font-size: 18px;">
        		<div style="font-size: 18px;" style="background-color: #F5F3F750;">
		        	인사시스템의 관리자 계정을 최초 생성하기 위해 <b style="background-color: #E3EEFF;">구매자의 사번</b>이 필요합니다.<br>
		        	입력하신 사번으로 아이디를 생성하여 계정 정보를 <b style="background-color: #E3EEFF;">등록된 이메일</b>로 보내드립니다.<br>
		        	<b style="background-color: #E3EEFF;">사번과 회사 정보</b>를 확인해주세요!
        		</div>
	        	<br>
	        	<div class="col-lg-4 row" align="center">
				    <div class="col-lg-4" align="right" style="padding-right: 0px;">
				        <label class="col-form-label">사번 : </label>
				    </div>
				    <div class="col-lg-8" style="padding-left: 5px;">
				        <input class="form-control" type="text" id="empNo" name="empNo" maxlength="10" style="height: 38px;">
				    </div>
				</div>
	  			회사 이름 : ${SessionInfo.cusCom }<br>
	  			대표자 이름 : ${SessionInfo.cusName }<br>
	  			<b>이메일 : ${SessionInfo.cusEmail }</b><br>
	       		<br>
	       		<table>
        			<tr align="center" style="background-color: #E3EEFF;">
        				<th>회사 로고</th>
        				<th>시스템 프로필</th>
        				<th>회사 직인</th>
        			</tr>
        			<tr>
        				<td>
		       				<img src="${pageContext.request.contextPath }${customer.cusLogo }" style="width: 200px;">
        				</td>
        				<td>
		       				<img src="${pageContext.request.contextPath }${customer.cusImage }" style="width: 200px;">
        				</td>
        				<td>
		       				<img src="${pageContext.request.contextPath }${customer.cusSignature }" style="width: 200px;">
        				</td>
        			</tr>
	        	</table>
				<br>
				<hr>
				<br>
	  			<div style="font-size: 18px;" style="background-color: #F5F3F750;">
		        	<p><b style="background-color: #E3EEFF;">선택하신 레벨과 기능</b>을 확인해주세요!<br></p>
	  			</div>
	        	<div style="font-size: 18px; margin-left: 200px; margin-right: 200px;">
		        	<p style="background-color: #E3EEFF;" ><b>선택한 레벨</b></p><br> 
		        		<b>${paymentVO.levelName }(${paymentVO.levelMemo }) - <fmt:formatNumber value="${paymentVO.levelFee }" pattern="#,###" />원  * ${customer.cusEmp }명</b><br>
		        	<br>
		        	<p style="background-color: #E3EEFF;"><b>선택한 기능</b></p><br>
		        	<c:forEach items="${paymentVO.funcLevelList }" var="funcLevelList" >
		        		<b>${funcLevelList.funcName }(${funcLevelList.funcMemo }) - <fmt:formatNumber value="${funcLevelList.funcFee }" pattern="#,###" />원</b><br>
		       		</c:forEach>
			       	</div>
			    <br>
	        	<hr>
	        	<br>
	       		<p style="font-size: 25px;"><b>총 결제 금액 : 
	       		<c:set var="total" value="0"/>
	       		<c:set var="levelPrice" value="${(paymentVO.levelFee)*(customer.cusEmp) }"/>
	       			<c:forEach items="${paymentVO.funcLevelList }" var="result" varStatus="status">
	       				<c:set var="total" value="${total + (result.funcFee) }"/>
	       			</c:forEach>
	       			<fmt:formatNumber value="${total + levelPrice }" pattern="#,###" />원</b></p>
	       		<br>
        	</div>
        	<div align="center" style="margin-bottom: 50px;">
			    <button onclick="requestPay()" type="button" id="purchaseBtn" class="btn btn-primary" style="width: 500px;">결제하기</button>
		    </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">


// 결제1

// var uid = '';
// var IMP = window.IMP; 
// IMP.init('imp38408463');	// 가맹점 식별코드

// function requestPay() {
	
// 	var email = $("#cusEmail").val();
// 	var phone = $("#cusTel").val();
// 	var name = $("#cusCom").val();
	
//     // IMP.request_pay(param, callback) 결제창 호출
//     IMP.request_pay({ // param
//     	pg: "{kakaopay}.{TC0ONETIME}",
//         pay_method: "card",
//         merchant_uid: 'merchant_' + new Date().getTime(), //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
//         name: "WSI 시스템 결제", //결제창에 노출될 상품명
// //         name: scName.textContent, //결제창에 노출될 상품명
//         amount: 160000, //금액
//         buyer_email : email, 
//         buyer_name : name,
//         buyer_tel : phone,
//     }, function (rsp) { // callback
//         if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
//             uid = rsp.imp_uid;
//             // 결제검증
//             $.ajax({
//                 url: '/verify/' + rsp.imp_uid,
//                 type: 'post'
//             }).done(function(data) {
//                 // 결제를 요청했던 금액과 실제 결제된 금액이 같으면 해당 주문건의 결제가 정상적으로 완료된 것으로 간주한다.
//                 if (rsp.paid_amount === data.response.amount) {
//                     // jQuery로 HTTP 요청
//                     // 주문정보 생성 및 테이블에 저장 
		        	
//                         // 데이터를 json으로 보내기 위해 바꿔준다.
//                         data = JSON.stringify({
//                             "orderNum" :  rsp.merchant_uid,
//                             "productNum" : detailNum.textContent, //상품번호
//                             "num" : userNum.value, // 회원번호
//                             "productName" : rsp.name,
//                             "orderDate" : new Date().getTime(),
//                             "totalPrice" : rsp.paid_amount,
//                             "imp_uid" : rsp.imp_uid,
//                             "reserNum" :  reserNum.textContent // 예약정보를 담고있는번호
//                         });
					
//                         jQuery.ajax({
//                             url: "/order/complete", 
//                             type: "POST",
//                             dataType: 'json',
//                             contentType: 'application/json',
//                             data : data
//                         })
//                         .done(function(res) {
//                             if (res > 0) {
//                                 swal('주문정보 저장 성공')
//                                 createPayInfo(uid);
//                             }
//                             else {
//                                 swal('주문정보 저장 실패');
//                             }
//                         })
//                 }
//                 else {
//                     alert('결제 실패');
//                 }
//             })
//             } else {
//                 swal("결제에 실패하였습니다.","에러 내용: " +  rsp.error_msg,"error");
//             }
//         });
// }


// 카드
// var IMP = window.IMP; 
// IMP.init('imp38408463');	// 가맹점 식별코드
	
// 	var today = new Date();
// 	var hours = today.getHours();
// 	var minutes = today.getMinutes();
// 	var seconds = today.getSeconds();
// 	var milliseconds = today.getMilliseconds();
// 	var makeMerchantUid = hours + minutes + seconds + milliseconds;
	
// 	function requestPay(data) {
//     	var IMP = window.IMP; // 생략 가능
//     	IMP.init("가맹점 코드"); // 예: imp00000000
//       //IMP.request_pay(param, callback) 결제창 호출
      
//       IMP.request_pay({ // param
//           pg: "html5_inicis.INIpayTest", //결제대행사 설정에 따라 다르며 공식문서 참고
//           pay_method: "card", //결제방법 설정에 따라 다르며 공식문서 참고
//           merchant_uid: "IMP" + makeMerchantUid, //주문번호
//           name: "WSI 시스템 결제", //결제창에 노출될 상품명
//           amount: 100,
//           buyer_email: "support@wsi.team",
//           buyer_name: "WSI",
//           buyer_tel: "010-1234-5678",
//           buyer_addr: "대전광역시 중구 계룡로 846(오류동 175-13)",
// 		  buyer_postcode: "12345"
//       }, function (rsp) { // callback
//           if (rsp.success) {
//         	// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
//               // jQuery로 HTTP 요청
//               jQuery.ajax({
//                 url: "/payment/verify/"+ rsp.imp_uid, 
//                 method: "POST",
//               }).done(function (data) {
//             	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (iamport 서버검증)
//             	  if(rsp.paid_amount == data.response.amount){
//   		        	succeedPay(rsp.imp_uid, rsp.merchant_uid);
//   	        	} else {
//   	        		alert("결제 검증 실패");
//   	        	}
//               })
//           } else {
//         	  var msg = '결제에 실패하였습니다.';
//               msg += '에러내용 : ' + rsp.error_msg;
//               alert(msg);
//           }
//       });
//     }
	
		
	/////
	var cusRnum = $("cusRnum").val();
	var payCode = $("payCode").val();
	var email = $("#cusEmail").val();
	var phone = $("#cusTel").val();
	var name = $("#cusName").val();
	var price = $("#payAmt").val();
	
	var IMP = window.IMP; 
	IMP.init('가맹점코드');	// 가맹점 식별코드
	
	function requestPay() {
		IMP.request_pay({
			pg : "html5_inicis.{INIBillTst}", // KG이니시스 pg 파라미터 값
			pay_method : "card", // 결제 방법
			merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
			name : "WSI 시스템 결제", // 결제창에 노출될 상품명
// 			amount : price, // 실제 금액
			amount : 100, // 테스트할 때 금액
			buyer_email : email,
			buyer_name : name,
			buyer_tel : phone,
		}, function(rsp) {
			// rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 판단합니다.

			if (rsp.success) {
				alert("결제가 완료되었습니다!");
				console.log("결제 성공!!!!!!");
				location.href = "/payment/order";
				
				// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
				// jQuery로 HTTP 요청
				$.ajax({
					type : "GET",
					url : "/payment/verify/",
					data : {
						imp_uid : rsp.imp_uid,
						merchant_uid : rsp.merchant_uid
					}
				});
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}

	function succeedPay(imp_uid, merchant_uid){
		$.ajax({  
			 url : '/payment/succeed',
			 type : 'POST',
			 async : true,
			 dataType : "Json", 
			 data :{
				imp_uid: imp_uid,            // 결제 고유번호
	            merchant_uid: merchant_uid   // 주문번호 
			 },
			 success : function(data){
				 if(data.cnt > 0){
	            	var msg = '결제 및 검증이 완료되었습니다.';
	          		alert(msg);
	            	location.href= $.getContextPath() + "/payment/order?cusRnum=" + cusRnum + "&payCode=" + payCode;
	            }else{
	            	var msg = '결제가 완료되었으나 에러가 발생했습니다.';
	               	alert(msg);
	               	location.href= $.getContextPath() + "/payment/order?cusRnum=" + cusRnum + "&payCode=" + payCode;
			 }
			 }, 
			 error : function (e){
				 alert("에러");
			 }
		});
	}
	
	/////////////

	// //주문번호 만들기
	// function createOrderNum(){
	// 	const date = new Date();
	// 	const year = date.getFullYear();
	// 	const month = String(date.getMonth() + 1).padStart(2, "0");
	// 	const day = String(date.getDate()).padStart(2, "0");

	// 	let orderNum = year + month + day;
	// 	for(let i=0;i<10;i++) {
	// 		orderNum += Math.floor(Math.random() * 8);	
	// 	}
	// 	return orderNum;
	// }
</script>