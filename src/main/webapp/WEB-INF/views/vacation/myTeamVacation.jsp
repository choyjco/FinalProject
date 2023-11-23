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
		           <form method="post" id="searchForm">
			           	<input type="hidden" name="page" id="page"/>
		               	<div class="row d-flex justify-content-between">
	                		<div class="col-3">
								<select class="form-select" id="selectDept" aria-label="Default select example" style="width:113px;" disabled>
				                	<c:forEach items="${comList}" var="comList">
				                		<c:set value="${deptCode }" var="deptCode"/>
					                	<c:if test="${fn:startsWith(comList.comCode, 'a') }">
											<option value="${comList.comCode}" <c:if test="${comList.comCode eq deptCode}">selected</c:if>>${comList.comName}</option>
					                	</c:if>
								    </c:forEach>
								</select>
							</div>
							<div class="col-3"></div>
							<div class="col-3"></div>
		                	<div class="col-3 d-flex justify-content-end">
		                		<div class="gridjs-search">
									<input type="text" id="searchWord" name="searchWord" value="${searchWord }" placeholder="사원명 검색" aria-label="Type a keyword..." class="gridjs-input gridjs-search-input">
									<button type="submit" style="margin-bottom: 4px;" class="btn btn-primary" id="searchBtn">검색</button>
								</div>
		                	</div>
					    </div>
					    <sec:csrfInput/>
					</form>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
							    	<div class="table-responsive">
					                    <table class="table table-bordered align-middle table-nowrap table-check">
					                        <thead class="table-light">
					                            <tr>
					                                <th scope="col">이름</th>
					                                <th scope="col">사번</th>
					                                <th scope="col">부서</th>
					                                <th scope="col">최초 부여 일수</th>
					                                <th scope="col">잔여 휴가 일수</th>
					                            </tr>
											</thead>
					                        <tbody id="tbody">
					                        	<c:set value="${pagingVO.dataList }" var="haveVacList"/>
					                        	<c:choose>
					                        		<c:when test="${empty haveVacList }">
					                        			<tr>
					                        				<td colspan="5" align="center">검색 내역이 존재하지 않습니다.</td>
					                        			</tr>
					                        		</c:when>
					                        		<c:otherwise>
					                        			<c:forEach items="${haveVacList }" var="haveVacList">
							                            <tr>
							                                <td>
								                            	<c:choose>
												                    <c:when test="${empty haveVacList.empProfile}">
												                        <img src="${pageContext.request.contextPath }/resources/images/profile.jpg" alt="" class="avatar-sm rounded-circle me-2">
												                    </c:when>
												                    <c:otherwise>
												                        <img src="${pageContext.request.contextPath }${haveVacList.empProfile}" alt="" class="avatar-sm rounded-circle me-2">
												                    </c:otherwise>
												                </c:choose>
							                                	${haveVacList.empName }
							                                </td>
							                                <td>${haveVacList.empNo }</td>
							                                <td>
							                                	<c:forEach items="${comList}" var="comList">
															        <c:if test="${haveVacList.empDept eq comList.comCode}">
															            ${comList.comName}
															        </c:if>
															    </c:forEach>
							                                </td>
							                                <td>${haveVacList.oldestVpDays }일</td>
							                                <td>${haveVacList.latestVpDays }일</td>
							                            </tr>
														</c:forEach>
					                        		</c:otherwise>
					                        	</c:choose>
					                        </tbody>
					                    </table>
							    	</div>
							    </div>
							</div>
						</div>
					</div>
				</div>
			<div class="card-footer clearfix" id="pagingArea">
				${pagingVO.pagingHTML }
			</div>	
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	var searchWord = $("#searchWord");
	var pagingArea = $("#pagingArea");
	var selectDept = $("#selectDept");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	    
	selectDept.on("change", function(){
		searchForm.submit();
	});
	
});
</script>