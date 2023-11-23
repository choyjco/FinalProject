<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 78%;
    color: #999999;
}

.filebox label {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}

.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>

<c:set value="등록" var="name"/>
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name"/>
</c:if>
	<div class="row">
		<div class="col-lg-12">
		    
			<div class="card card-primary">
				<form action="/notice/register" method="post" id="noticeForm" enctype="multipart/form-data">
<!-- 				<form action="/notice/register" method="post" id="noticeForm" class="file"> -->
					
					<c:if test="${status eq 'u' }">
						<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo }">
						<input type="hidden" id="boardFile" name="boardFile" value="${board.boardFile }">
					</c:if>
					<div class="card-header">
						<h3>공지사항 ${name }</h3>
						<div class="card-tools"></div>
					</div>
					<div class="card-body">
						<!-- 드랍다운 메뉴 -->
						<div class="form-group" role="group">      
							<label for="boardCate">공지할 부서를 선택해주세요</label>                          
							<select name="boardCate" id="boardCate" class="form-select" >
								<c:forEach items="${deptList }" var="dept">
									<option value="${dept.comCode }" <c:if test="${board.boardCate eq dept.comCode}">selected="selected"</c:if> >${dept.comName }</option>
								</c:forEach>
							</select>
			            </div> <br/>
						<div class="form-group">
							<label for="boardTitle">제목을 입력해주세요</label> 
							<input type="text" id="boardTitle" name="boardTitle" value="${board.boardTitle }" class="form-control" placeholder="제목을 입력해주세요">
						</div> <br/>
						<div class="form-group">
							<label for="boardCont">내용을 입력해주세요</label>
							<textarea id="boardCont" name="boardCont" class="form-control" rows="14">${board.boardCont }</textarea>
						</div>
						<div class="form-group">
						
							<div class="filebox">
							    <input class="upload-name" value="첨부파일" placeholder="첨부파일" >
							    <label for="file">파일찾기</label> 
							    <input type="file" id="file" id="boFile" name="boFile" multiple="multiple">
							</div>
						</div>
					</div>
					<sec:csrfInput/>
				</form>
                                    
				<c:if test="${status eq 'u' }">
					<c:set value="${board.boardFileList }" var="boardFileList"/>
					<c:if test="${not empty boardFileList }">
						<div class="col-md-12">
							<div class="row">
								<c:forEach items="${boardFileList }" var="boardFile"> 
									<div class="col-md-2">
										<div class="card shadow-lg">
											<div class="card-header mt-n4 mx-3 p-0 bg-transparent position-relative z-index-2">
												<a class="d-block blur-shadow-image text-center"> 
													<img src="${pageContext.request.contextPath}/resources/assets/images/img.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg">
												</a>
												<div class="colored-shadow" style="background-image: url(&quot;https://images.unsplash.com/photo-1536321115970-5dfa13356211?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=934&amp;q=80&quot;);"></div>
											</div>
											<div class="card-body text-center bg-white border-radius-lg p-3 pt-0">
												<h6 class="mt-3 mb-1 d-md-block d-none">
													${boardFile.fileOrgname } (${boardFile.fileSize })
												</h6>
												<p class="mb-0 text-xs font-weight-bolder text-info text-uppercase">
													<button type="button" class="btn btn-primary fileDelete" id="btn_${boardFile.fileNo }">delete</button>
												</p>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</c:if>
				<div class="card-footer bg-white">
					<div class="row">
						<div class="col-12 d-flex justify-content-end">
							<!-- 등록 일때는 목록, 등록 버튼이 나타나야하고 수정 일때는 수정, 취소 버튼이 나타나야함 -->
							<input style="margin-right: 5px;" type="button" value="${name }" id="insertBtn" class="btn btn-primary float-right">
							<c:if test="${status eq 'u' }">
								<input type="button" value="취소" id="cancelBtn" class="btn btn-success float-right"> 
							</c:if>
							<c:if test="${status ne 'u' }">
								<input type="button" value="목록" id="listBtn" class="btn btn-success float-right"> 
							</c:if>
						</div>
					</div>
				</div>
			</div>

    </div><!-- end card -->
</div><!-- end card body -->
            
<!-- ==================================================================================== -->
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("boardCont", {
		filebrowserUploadUrl: "/imageUpload.do?${_csrf.parameterName}=${_csrf.token}"
	});
	
	var listBtn = $("#listBtn");
	var insertBtn = $("#insertBtn");
	var noticeForm = $("#noticeForm");
	var cancelBtn = $("#cancelBtn");
	
	listBtn.on("click", function(){
		location.href = "/notice/list";
	});
	
	insertBtn.on("click", function(){
		var title = $("#boardTitle").val();
// 		var content = $("#boardCont").val(); // 일반 textarea .val()를 이용해서 데이터 가져옴
		var content = CKEDITOR.instances.boardCont.getData();	// 내용 데이터

		if(title == null || title == ""){
			alertify.warning('제목을 입력해주세요.');
			return false;
		}
		if(content == null || content == ""){
			alertify.warning('내용을 입력해주세요.');
			return false;
		}
		
		if($(this).val() == "수정"){
			noticeForm.attr("action", "/notice/update");
		}
		
		noticeForm.submit();
	});
	
	cancelBtn.on("click", function(){
		var boardNo = $("#boardNo").val();
		location.href = "/notice/detail?boardNo=" + boardNo;
	});
	
	$(".fileDelete").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var fileNo = id.substring(idx + 1); // fileNo 가져오기
		var ptrn = "<input type='hidden' name='delBoardNo' value='%V'/>";
		noticeForm.append(ptrn.replace("%V", fileNo));
		$(this).parents("div[class=col-md-2]").hide();
	});
	
	$(".attachmentFileDel").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var noticeFileNo = id.substring(idx + 1);
		var ptrn = "<input type='text' name='delNoticeNo' value='%V' hidden='hidden'/>";
		$("#noticeForm").append(ptrn.replace("%V", noticeFileNo));
		$(this).parents("li:first").hide();
	});
	
	// 파일네임 불러오기
	$("#file").on('change',function(){
		var fileName = $("#file").val();
		$(".upload-name").val(fileName);
	});
	
});
</script>