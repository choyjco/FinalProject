<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
label {
  text-align: end;
}
</style>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/hero_2.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>회원가입</h1>
			</div>
		</div>
	</div>
</div>

<br>

<div class="col-lg-12 justify-content-md-center spacer" style="margin-bottom: 100px;">
    <div class="col-lg-12" align="center">
<!--         <h3 class="mb-5" align="center">WSI 회원가입</h3> -->
		<div style="background-color: #D0DDF3; width: 30%; height: 100px;">
			<h5 style="padding: 16px;">
				<b>국세청에 등록된 사업자번호만 가입 가능합니다!<br>휴/폐업 사업자번호는 가입하실 수 없습니다!<br>(국세청 사업자등록번호 상태조회 서비스 이용)</b>
			</h5>
		</div>
		<p></p>
		<button type="button" class="btn btn-light" id="outoInsert">자동완성</button>
		<p></p>
		<br>		
        <form action="/register" id="regiForm" class="pb-5 col-lg-10 justify-content-md-center" method="post" enctype="multipart/form-data">
            <div class="col-lg-10 justify-content-md-center">
                <div class="form-group row">
                    <label class="col-lg-4 col-form-label">아이디(사업자등록번호) *</label>
                    <div class="col-lg-5">
                        <input type="text" class="form-control" id="cusRnum" name="cusRnum" maxlength="10" placeholder="아이디를 입력해주세요.">
                   		<span id="idCheckRes">아이디는 사업자 등록번호 10자리입니다.('-'는 빼고 입력해주세요.)</span>
                    </div>
                    <div class="col-lg-2">
						<button type="button" id="idCheckBtn" class="btn btn-primary" style="text-align: start;">상태 조회</button>
					</div>
                </div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">비밀번호 *</label>
					<div class="col-lg-5">
						<input type="password" class="form-control" id="cusPw" name="cusPw" maxlength="16" placeholder="비밀번호를 입력해주세요.">
						<span id="pwValiRes"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">비밀번호 확인 *</label>
					<div class="col-lg-5">
						<input type="password" class="form-control" id="cusPw2" name="cusPw2" maxlength="16" placeholder="비밀번호를 다시 입력해주세요.">
						<span id="pwCheckRes"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">회사 이름 *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusCom" name="cusCom" placeholder="회사 이름을 입력해주세요.">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">이름(대표자 이름) *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusName" name="cusName" placeholder="이름을 입력해주세요.">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">우편번호 *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusZip" name="cusZip" onclick="DaumPostcode()" placeholder="누르면 주소 찾기로 이동합니다.">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">회사 주소 *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusAddr" name="cusAddr" placeholder="회사 주소를 입력해주세요.">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">상세 주소</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusAddr2" name="cusAddr2" placeholder="상세 주소를 입력해주세요.">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">회사 전화번호 *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusTel" name="cusTel" placeholder="회사 전화번호를 입력해주세요.('-' 포함해주세요.)">
						<span id="telValiRes"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">사원수 *</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusEmp" name="cusEmp" maxlength="5" placeholder="사원수를 입력해주세요.(숫자만 입력)" oninput="inputNum(this.cusEmp)">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">이메일 *</label>
					<div class="col-lg-5">
						<input type="email" class="form-control" id="cusEmail" name="cusEmail" placeholder="이메일을 입력해주세요.(비밀번호 찾기 시 사용)">
						<span id="emailVali"></span>
					</div>
					<div class="col-lg-2">
						<button type="button" id="emailCheckBtn" class="btn btn-primary" style="text-align: start;">중복 확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">창립일</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" id="cusBirth" name="cusBirth" placeholder="회사 창립일을 입력해주세요.(예시 : 1993-10-12)" maxlength="10">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">회사 로고</label>
					<div class="col-lg-5">
						<input type="file" class="form-control" id="cusLogoImg" name="cusLogoImg">
					</div>
				</div>
				<div class="form-group row text-center">
					<label class="col-lg-4 col-form-label"></label>
					<div class="col-lg-5">
						<div id="thumbnailContainer"></div>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">프로필 이미지</label>
					<div class="col-lg-5">
						<input type="file" class="form-control" id="cusProfileImg" name="cusProfileImg">
					</div>
				</div>
				<div class="form-group row text-center">
					<label class="col-lg-4 col-form-label"></label>
					<div class="col-lg-5">
						<div id="thumbnailContainer2"></div>
<!-- 						<img id="profileImg" alt="Customer Profile Image" src="/resources/images/yangkoong.jpg" style="width: 300px;"> -->
					</div>
				</div>
				<div class="form-group row">
					<label class="col-lg-4 col-form-label">회사 직인</label>
					<div class="col-lg-5">
						<input type="file" class="form-control" id="cusSignImg" name="cusSignImg">
					</div>
				</div>
				<div class="form-group row text-center">
					<label class="col-lg-4 col-form-label"></label>
					<div class="col-lg-5">
						<div id="thumbnailContainer3"></div>
<!-- 						<img id="signImg" alt="Company Signature Image" src="/resources/images/yangkoong.jpg" style="width: 300px;"> -->
					</div>
				</div>
				<br><br>
				
				<div class="form-group" align="center">
					<button type="button" class="btn btn-primary" id="regiBtn" style="width: 500px;">회원가입</button>
				</div>
		</div>
		<sec:csrfInput/>
	</form>
	</div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>  
<script type="text/javascript">

$(function() {
	var regiBtn = $("#regiBtn");
	var regiForm = $("#regiForm");
	var logoImg = $("#logoImg");
	var profileImg = $("#profileImg");
	var signImg = $("#signImg");
	var cusImageFile = $("#cusImageFile");
	var cusSignature = $("#cusSignature");
	var idCheckBtn = $("#idCheckBtn");
	var emailCheckBtn = $("#emailCheckBtn");
// 	var imgFile= $("#imgFile");
	var item= $("#item");
	var cusLogoImg= $("#cusLogoImg");
	var cusSignImg= $("#cusSignImg");
	var cusProfileImg= $("#cusProfileImg");
	var idCheckFlag = false;
	var emailCheckFlag = false;
	
	/////////////////////자동완성/////////////////////////////
	var outoInsert = $("#outoInsert");
	var cusRnum = $("#cusRnum"); //사업자번호
	var cusPw = $("#cusPw"); //비번
	var cusPw2 = $("#cusPw2"); //비번확인
	var cusCom = $("#cusCom"); //회사이름
	var cusName = $("#cusName"); //대표이름
	var cusZip = $("#cusZip"); //우편번호
	var cusAddr = $("#cusAddr"); //주소
	var cusAddr2 = $("#cusAddr2"); //상세주소
	var cusTel = $("#cusTel"); //전화
	var cusEmp = $("#cusEmp"); //사원수
	var cusEmail = $("#cusEmail"); //이메일
	var cusBirth = $("#cusBirth"); //창립일
	
	outoInsert.on("click", function(){
		cusRnum.val("7408800770");
		// 예비로 사용할 사업자 번호
		// 
		// 
		// 
		// 7408800770
		cusPw.val("aa1234**");
		cusPw2.val("aa1234**");
		cusCom.val("성심당");
		cusName.val("김대덕");
		cusZip.val("34908");
		cusAddr.val("대전 중구 계룡로 846");
		cusAddr2.val("3-4층");
		cusTel.val("042-222-8202");
		cusEmp.val("160");
		cusEmail.val("p__yb24@naver.com");
		cusBirth.val("1989-11-03");
	});
	/////////////////////자동완성/////////////////////////////
	
	
	$("#cusRnum").keyup(function() {
    var id = $("#cusRnum").val();
    
    // 아이디 길이 체크
    if (isValidId(id)) {
        var data = {
            cusRnum: id
        };
        
        $.ajax({
            type: "post",
            url: "/idCheck",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            success: function(res) {
                console.log("아이디 중복 확인 결과 : " + res);
                if (res == "NOTEXIST") {
                    $("#idCheckRes").html("사용 가능한 아이디입니다! 상태 조회를 해주세요!");
                    $("#idCheckRes").css("color", "green");
                    $("#cusRnum").css("border", "1px solid green");
                    idCheckFlag1 = true; // 가입하기 버튼을 클릭할 때 아이디 중복 체크를 했는지 여부
                } else {
                    $("#idCheckRes").html("이미 사용중인 아이디입니다!");
                    $("#idCheckRes").css("color", "red");
                    $("#cusRnum").css("border", "1px solid red");
                }
            },
            error: function() {
                alert("서버 요청 실패!");    
            }
        });
    } else {
        // 아이디 길이가 10자가 아닌 경우 처리
        $("#idCheckRes").html("아이디는 숫자 10자리이어야 합니다!");
        $("#idCheckRes").css("color", "red");
    }
});

	
	///////////////////
	
	idCheckBtn.on("click", function() {
		
		var id = $("#cusRnum").val();
		
		if(id == null || id == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
        var data = {
//            b_no: [1248100998], // 실제 존재하는 사업자 번호
           b_no: [id],
        	};

        let serviceKey ="KEY";
        $.ajax({
          url:
            "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" +
            serviceKey,
          type: "POST",
          data: JSON.stringify(data),	// json 을 string으로 변환하여 전송
          dataType: "JSON",
          contentType: "application/json",
          accept: "application/json",
          success: function (result) {
            console.log("결과:: ", result);
            
            var checkCode = result.data[0].b_stt_cd;
            
            if(checkCode == "01") {
            	alert("정상적인 사업자 번호입니다! 가입이 가능합니다!");
            	idCheckFlag = true;
            }else if(checkCode == "02" || checkCode == "03") {
            	alert("휴/폐업한 사업자 번호입니다! 다시 입력해주세요!");
            }else {
            	alert("국세청에 등록되지 않은 사업자번호입니다! 다시 입력해주세요!");
            }
 
          },
          error: function (result) {
        	  console.log(result.responseText);
        	  
          },
        });
      });
	
	
	/////////////////////
	
	
	
// 	idCheckBtn.on("click", function() {
// 		var id = $("#cusRnum").val();
		
// 		if(id == null || id == "") {
// 			alert("아이디를 입력해주세요.");
// 			return false;
// 		}
		
// 		var data = {
// 			cusRnum : id
// 		};
		
// 		$.ajax({
// 			type: "post",
// 			url: "/idCheck",
// 			beforeSend : function(xhr) {
// 				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
// 			},
// 			data: JSON.stringify(data),
// 			contentType: "application/json; charset=utf-8",
// 			success: function(res) {
// 				console.log("아이디 중복 확인 결과 : " + res);
// 				if(res == "NOTEXIST") { // 아이디 사용 가능
// 					alert("사용 가능한 아이디입니다!");
// 					idCheckFlag = true; // 가입하기 버튼을 클릭할 때 아이디 중복 체크를 했는지 여부
// 				}else {					// 아이디 사용 불가능
// 					alert("이미 사용중인 아이디입니다!");
// 				}
// 			}
// 		});
// 	});
	
	/////////////////////
	
	$("#cusPw").keyup(function() {
		var reg = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;

		var pw = $("#cusPw").val();

		if (reg.test(pw)) {
			 $("#pwValiRes").html("조건에 만족합니다!");
			 $("#pwValiRes").css("color", "green");
			 $("#cusPw").css("border", "1px solid green");
		} else {
		    $("#pwValiRes").html("비밀번호는 8 ~ 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.");
		    $("#pwValiRes").css("color", "red");
		    $("#cusPw").css("border", "1px solid red");
		}

		
	});
	
	////////////////////////
	
	$("#cusPw2").keyup(function() {
		var pw = $("#cusPw").val();
		var pw2 = $("#cusPw2").val();
		
		if(pw === pw2) {
			$("#pwCheckRes").html("비밀번호가 일치합니다!");
			$("#pwCheckRes").css("color", "green");
			$("#cusPw2").css("border", "1px solid green");
		}else {
			$("#pwCheckRes").html("비밀번호가 일치하지 않습니다!");
			$("#pwCheckRes").css("color", "red");
			$("#cusPw2").css("border", "1px solid red");
		}
	});
	
	
	/////////////////////
	
// 	$("#cusEmail").keyup(function() {
// 		var email = $("#cusEmail").val();
		
// 		var data = {
// 	 			cusEmail : email
// 	 		};
			
// 	 		$.ajax({
// 	 			type: "post",
// 	 			url: "/emailCheck",
// 	 			beforeSend : function(xhr) {
// 	 				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
// 	 			},
// 	 			data: JSON.stringify(data),
// 	 			contentType: "application/json; charset=utf-8",
// 	 			success: function(res) {
// 	 				console.log("이메일 중복 확인 결과 : " + res);
// 	 				if(res == "NOTEXIST") { // 이메일 사용 가능
// 	 					$("#emailCheckRes").html("사용 가능한 이메일입니다!");
// 	 					$("#emailCheckRes").css("color", "green");
// 	 					emailCheckFlag = true; // 가입하기 버튼을 클릭할 때 이메일 중복 체크를 했는지 여부
// 	 				}else {					// 이메일 사용 불가능
// 	 					$("#emailCheckRes").html("이미 사용중인 이메일입니다!");
// 	 					$("#emailCheckRes").css("color", "red");
// 	 				}
// 	 			},
// 	 			error : function() {
// 					alert("서버 요청 실패!");	
// 				}
// 	 		});
// 		});
	
	///////////////////
	
	$("#cusEmail").keyup(function() {
		var email = $("#cusEmail").val();
		
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(exptext.test(email)==false){
			$("#emailVali").html("이메일 형식이 올바르지 않습니다!");
			$("#emailVali").css("color", "red");
			$("#cusEmail").css("border", "1px solid red");
		}else {
			$("#emailVali").html("이메일 형식이 맞습니다! 중복 확인을 해주세요!");
			$("#emailVali").css("color", "green");
			$("#cusEmail").css("border", "1px solid green");
			
		}
		
	});
	
	
	emailCheckBtn.on("click", function() {
		var email = $("#cusEmail").val();
		
		if(email == null || email == "") {
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		
		var data = {
			cusEmail : email
		};
		
		$.ajax({
			type: "post",
			url: "/emailCheck",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(res) {
				console.log("이메일 중복 확인 결과 : " + res);
				if(res == "NOTEXIST") { // 이메일 사용 가능
					alert("사용 가능한 이메일입니다!");
					emailCheckFlag = true; // 가입하기 버튼을 클릭할 때 이메일 중복 체크를 했는지 여부
				}else {					// 이메일 사용 불가능
					alert("이미 사용중인 이메일입니다!");
				}
			}
		});
	});

	///////////////////////////
	
	$("#cusTel").keyup(function() {
		var reg = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

		var tel = $("#cusTel").val();

		if (reg.test(tel)) {
			 $("#telValiRes").html("형식에 만족합니다!");
			 $("#telValiRes").css("color", "green");
			 $("#cusTel").css("border", "1px solid green");
		} else {
		    $("#telValiRes").html("유효하지 않은 전화번호거나 '-'를 포함하여 입력해주세요.");
		    $("#telValiRes").css("color", "red");
		    $("#cusTel").css("border", "1px solid red");
		}

		
	});
	
	
	
	//////////////////////////
	regiBtn.on("click", function() {
		var id = $("#cusRnum").val();
		var pw = $("#cusPw").val();
		var pw2 = $("#cusPw2").val();
		var companyName = $("#cusCom").val();
		var name = $("#cusName").val();
		var address = $("#cusAddr").val();
		var zip = $("#cusZip").val();
		var tel = $("#cusTel").val();
		var emp = $("#cusEmp").val();
		var email = $("#cusEmail").val();
		
		if(id == null || id == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		if(pw == null || pw == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		if(pw2 == null || pw2 == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
// 		if(pw != pw2) {
// 			alert("비밀번호가 일치하지 않습니다!");
// 			return false;
// 		}
		
		if(companyName == null || companyName == "") {
			alert("회사 이름을 입력해주세요.");
			return false;
		}

		if(name == null || name == "") {
			alert("이름을 입력해주세요.");
			return false;
		}
		
		if(address == null || address == "") {
			alert("주소를 입력해주세요.");
			return false;
		}
		
		if(zip == null || zip == "") {
			alert("우편번호를 입력해주세요.");
			return false;
		}
		
		if(tel == null || tel == "") {
			alert("전화번호를 입력해주세요.");
			return false;
		}
		
		if(emp == null || emp == "") {
			alert("사원수를 입력해주세요.");
			return false;
		}
		
		if(email == null || email == "") {
			alert("이메일을 입력해주세요.");
			return false;
		}
		
		if(idCheckFlag) {
			if(emailCheckFlag) {
				regiForm.submit();
			}else {
				alert("이메일 중복 체크를 해주세요!");
			}
		}else {
			alert("아이디 중복 체크를 해주세요!");
		}
		
	});
	
	
	cusLogoImg.on("change", function(event) {
        var file = event.target.files[0];

        if (isImageFile(file)) {
          var reader = new FileReader();
          reader.onload = function(e) {
            var maxThumbnailWidth = 300; // 원하는 썸네일 이미지 너비
            var img = new Image();
            img.src = e.target.result;

            img.onload = function() {
              var width = img.width;
              var height = img.height;

              // 이미지 크기가 너무 큰 경우 조절
              if (width > maxThumbnailWidth) {
                height = (maxThumbnailWidth / width) * height;
                width = maxThumbnailWidth;
              }

              // 동적으로 이미지 엘리먼트 생성 및 추가
              var $thumbnail = $("<img>").attr("src", e.target.result).css({ width: width, height: height });
              $("#thumbnailContainer").empty().append($thumbnail);
            };
          };
          reader.readAsDataURL(file);
        } else {
          alert("이미지 파일을 선택해주세요!");
        }
      });
	
	
	cusProfileImg.on("change", function(event) {
        var file = event.target.files[0];

        if (isImageFile(file)) {
          var reader = new FileReader();
          reader.onload = function(e) {
            var maxThumbnailWidth = 300; // 원하는 썸네일 이미지 너비
            var img = new Image();
            img.src = e.target.result;

            img.onload = function() {
              var width = img.width;
              var height = img.height;

              // 이미지 크기가 너무 큰 경우 조절
              if (width > maxThumbnailWidth) {
                height = (maxThumbnailWidth / width) * height;
                width = maxThumbnailWidth;
              }

              // 동적으로 이미지 엘리먼트 생성 및 추가
              var $thumbnail = $("<img>").attr("src", e.target.result).css({ width: width, height: height });
              $("#thumbnailContainer2").empty().append($thumbnail);
            };
          };
          reader.readAsDataURL(file);
        } else {
          alert("이미지 파일을 선택해주세요!");
        }
      });
	
	
	cusSignImg.on("change", function(event) {
        var file = event.target.files[0];

        if (isImageFile(file)) {
          var reader = new FileReader();
          reader.onload = function(e) {
            var maxThumbnailWidth = 300; // 원하는 썸네일 이미지 너비
            var img = new Image();
            img.src = e.target.result;

            img.onload = function() {
              var width = img.width;
              var height = img.height;

              // 이미지 크기가 너무 큰 경우 조절
              if (width > maxThumbnailWidth) {
                height = (maxThumbnailWidth / width) * height;
                width = maxThumbnailWidth;
              }

              // 동적으로 이미지 엘리먼트 생성 및 추가
              var $thumbnail = $("<img>").attr("src", e.target.result).css({ width: width, height: height });
              $("#thumbnailContainer3").empty().append($thumbnail);
            };
          };
          reader.readAsDataURL(file);
        } else {
          alert("이미지 파일을 선택해주세요!");
        }
      });

	
// 	cusSignImg.on("change", function(event) {
// 		var file = event.target.files[0];
		
// 		if(isImageFile(file)) {
// 			var reader = new FileReader();
// 			reader.onload = function(e) {
// 				$("#signImg").attr("src", e.target.result);
// 			}
// 			reader.readAsDataURL(file);
// 		}else {
// 			alert("이미지 파일을 선택해주세요!");
// 		}
// 	});
	
	
	
});




//이미지 파일인지 체크
function isImageFile(file) {
	var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 꺼낸다.
	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1 ? false : true);	
	
}

function DaumPostcode() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('cusZip').value = data.zonecode;
            document.getElementById("cusAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("cusAddr2").focus();
        }
    }).open();
}

function isValidId(id) {
    // 정규표현식을 사용하여 10자리 숫자인지 확인
    var idPattern = /^\d{10}$/;
    return idPattern.test(id);
}

function inputNum(cusEmp) {
	var element = document.getElementById('cusEmp');
	element.value = element.value.replace(/[^0-9]/gi, "");
	}


</script>
