<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
					<div class="d-flex">
                        <c:set var="totalWork" value="0" />
						<c:forEach items="${workList}" var="work">
						    <c:set var="totalWork" value="${totalWork + work.workTotal}" />
						</c:forEach>
                        <c:forEach items="${workList }" var="work" begin="0" end="0" step="1">
		                	<div class="p-2 flex-fill">
		                		<h5>${work.comName } ${work.empName }님의 총 근무시간 : ${totalWork }시간
				                	<c:choose>
									    <c:when test="${totalWork < 40}">
									        <span class="badge badge-soft-danger">미달</span>
									    </c:when>
									    <c:when test="${totalWork >= 40 && totalWork < 52}">
									        <span class="badge badge-soft-success">준수</span>
									    </c:when>
									    <c:when test="${totalWork >= 52}">
									        <span class="badge badge-soft-danger">초과</span>
									    </c:when>
									</c:choose>
								</h5>
							</div>
						</c:forEach>
						<div class="p-2 justify-content-end">
<!-- 	                		<span class="badge rounded-pill badge-soft-info"> </span> 근무 -->
<!-- 	                		<span class="badge rounded-pill badge-soft-danger"> </span> 휴가 -->
<!-- 	                		<span class="badge rounded-pill bg-warning"> </span> 외근 -->
<!-- 	                		<span class="badge rounded-pill bg-purple"> </span> 출장 -->
	                	</div>
	                </div>
                    <table class="table table-bordered align-middle table-nowrap table-check">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">날짜</th>
                                <th scope="col">기본 근무 시간</th>
                                <th scope="col">초과 근무 시간</th>
                                <th scope="col">총 근무 시간</th>
                            </tr>
                        </thead>
                        <tbody>
	                        <c:forEach items="${workList }" var="work">
	                            <tr>
	                                <td><fmt:formatDate pattern="yyyy-MM-dd(E)" value="${work.workStime }"/></td>
	                                <td>
	                                	<div class="d-flex gap-2">
	                                	 	<c:set value="${fn:substring(work.workStime, 11, 16) }~${fn:substring(work.workEtime, 11, 16) }" var="workTime"/>
											<c:choose>
											    <c:when test="${workTime == '09:00~18:00' }">
											        <h5><span class="badge badge-soft-info">근무</span></h5>${workTime }
											    </c:when>
											    <c:when test="${workTime == '14:00~18:00' }">
											        <h5><span class="badge badge-soft-danger">휴가</span></h5>${workTime }
											    </c:when>
											    <c:when test="${workTime == '09:00~13:00' }">
											        <h5><span class="badge badge-soft-danger">휴가</span></h5>${workTime }
											    </c:when>
											    <c:otherwise>
											    	<h5><span class="badge badge-info">근무</span></h5>${fn:substring(work.workStime, 11, 16) }~${fn:substring(work.workEtime, 11, 16) }
											    </c:otherwise>
											</c:choose>
	                                    </div>
	                                </td>
	                                <td>
	                                	<div class="d-flex gap-2">
		                                	<c:choose>
		                                		<c:when test="${fn:substring(work.workEtime, 11, 13) > 18}">
		                                			<h5><span class="badge bg-soft-purple">연장</span></h5>18:00~${fn:substring(work.workEtime, 11, 16)}
		                                		</c:when>
		                                		<c:otherwise>
		                                		</c:otherwise>
		                                	</c:choose>
	                                	</div>
	                                </td>
	                                <td>${work.workTotal }시간</td>
	                            </tr>
			                 </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
