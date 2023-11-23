<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="col-lg-12">
    <div class="card">
		<form method="post" id="searchForm" >
        	<div class="card-header justify-content-between d-flex align-items-center" style="margin-top: 20px;">
            
				<!-- 드랍다운 메뉴 -->
				<div style="margin-bottom: 4px; margin-left: 80px;" class="btn-group" role="group">                                
					<select name="boardCate" id="boardCate" class="form-select" >
						<c:forEach items="${deptList }" var="dept">
							<option <c:if test="${pagingVO.boardCate eq dept.comCode }">selected="selected"</c:if> value="${dept.comCode }">${dept.comName }</option>
						</c:forEach>
					</select>
	            </div>
				<div class="col-md-9">
					<div class="d-flex justify-content-end">
						<input type="hidden" name="page" id="page"/>
						<div style="margin-bottom: 4px;" class="btn-group" role="group">                                
							<select name="searchType" id="searchType" class="form-select">
								<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
								<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
								<option value="both" <c:if test="${searchType eq 'both' }">selected</c:if>>제목+작성자</option>
							</select>
                        </div>
                        
						<div class="search" >
							<input type="text" name="searchWord" value="${searchWord }" placeholder="검색어를 입력하세요..." aria-label="Type a keyword..." class="gridjs-input gridjs-search-input">
							<button style="margin-bottom: 4px; margin-right: 80px;" type="submit" class="btn btn-primary">검색</button>
						</div>
						<sec:csrfInput/>
					</div>
				</div>
			</div><!-- end card header -->
		</form>
		
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover mb-0" style="text-align: center; width: 1400px; margin-left: 80px;">
                    <thead>
                        <tr>
                            <th style="width: 5%;">번호</th>
                            <th style="width: 10%;">부서</th>
                            <th style="width: 50%;">제목</th>
                            <th style="width: 15%;">작성자</th>
                            <th style="width: 20%;">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:set value="${pagingVO.dataList }" var="boardList"/>
						<c:choose>
							<c:when test="${empty boardList }">
								<tr class="text-center">
									<td colspan="5" class="text-dark font-weight-bolder">조회하신 게시글이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${boardList }" var="board">
									<tr class="text-center">
										<td>${board.boardNo }</td>
										<c:forEach items="${deptList }" var="dept">
											<c:if test="${board.boardCate eq dept.comCode }"><td>${dept.comName }</td></c:if> 
										</c:forEach>
										<td class="text-dark" style="text-align: left;">
											<a href="/notice/detail?boardNo=${board.boardNo }">${board.boardTitle }</a>
										</td>
										<td>${board.boardWriter }</td>
										
										<td>
											<fmt:formatDate value="${board.boardRegdate }" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
                    </tbody><!-- end tbody -->
                </table><!-- end table -->
            </div><!-- end table responsive-->
			
			<div class="card-body">
			    <nav aria-label="...">
			    	<div class="d-flex justify-content-end">
			    		<button style="margin-right: 80px;" type="button" id="regBtn" class="btn btn-primary" onclick="javascript:location.href='/notice/register'"><i class="uil uil-pen me-2"></i>글쓰기</button>
			    	</div>
			    	
			    	<!-- 페이징 -->
					<div class="pagination justify-content-center" id="pagingArea">
						${pagingVO.pagingHTML }
					</div>
			    </nav>
			</div><!-- end card body -->                 
        </div><!-- end card body -->
    </div><!-- end card -->
</div><!-- end card body -->
            
       
<!-- ==================================================================================== -->

<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");
	var boardCate = $("#boardCate");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	boardCate.on("change", function(){
		searchForm.submit();
	});
});
</script>
