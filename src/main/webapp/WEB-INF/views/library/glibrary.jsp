<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<div class="row">
	<div>
		<div class="card">
			<div class="card-body">
				<div class="tab-content p-3 text-muted">
					<div id="table-search" class="table">
						<div role="complementary" class="gridjs gridjs-container"
							style="width: 100%;">
							<div class="row">
								<div class="col-md-3">
									<div data-simplebar="init" style="max-height: 230px;">
										<div class="simplebar-wrapper" style="margin: 0px;">
											<div class="simplebar-height-auto-observer-wrapper">
												<div class="simplebar-height-auto-observer"></div>
											</div>
											<div class="simplebar-mask">
												<div class="simplebar-offset"
													style="right: -17px; bottom: 0px;">
													<div class="simplebar-content-wrapper"
														style="height: auto; overflow: hidden scroll;">
														<div class="simplebar-content" style="padding: 0px;">
															<ul class="list-unstyled unstyled mb-0">
																<li class="px-4 py-3">
																	<div class="d-flex align-items-center">
																		<div class="flex-shrink-0 me-3">
																			<div class="avatar-sm">
																				<div
																					class="avatar-title bg-light text-primary rounded-circle font-size-18">
																					<i class="bx bxs-cloud-upload"></i>
																				</div>
																			</div>
																		</div>
																		<div class="flex-grow-1">
																			<p class="text-muted mb-2">
																				자료실 사용량 <span class="float-end fw-medium">${libSize } %</span>
																			</p>
																			<div
																				class="progress animated-progess custom-progress">
																				<div class="progress-bar" role="progressbar"
																					style="width: ${libSize}%" aria-valuenow="${libSize }"
																					aria-valuemin="0" aria-valuemax="100"></div>
																			</div>
																		</div>
																	</div>
																</li>

															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="simplebar-placeholder"
												style="width: auto; height: 306px;"></div>
										</div>
									</div>
								</div>
								<div class="col-md-9 d-flex justify-content-bottom justify-content-end">
									<div class="align-items-end justify-content-bottom pt-4 ">
										<div class="d-flex justify-content-end justify-content-bottom">
											<form method="post" id="searchForm">
												<ul class="nav nav-pills">
													<li class="nav-item"><input type="hidden" name="page"
														id="page" /> <select class="form-select"
														name="searchType">
															<option value="both"
																<c:if test="${searchType eq 'both' }">selected</c:if>>모두</option>
															<option value="title"
																<c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
															<option value="writer"
																<c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
													</select></li>
													<li>&nbsp;</li>
													<li class="nav-item">
													<input type="text" name="searchWord" value="${searchWord }"
														class="form-control float-right" placeholder="검색어를 입력하세요">
													</li>
													<li>&nbsp;</li>
													<li class="nav-item">
														<div class="input-group-append">
															<button type="submit" class="btn btn-primary">검색</button>
														</div>
													</li>
													<sec:csrfInput/>
												</ul>
											</form>
										</div>
									</div>
									</div>
							</div>
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table" style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr text-center">
											<th data-column-id="title" class="gridjs-th">
												<div class="gridjs-th-content">제목</div>
											</th>
											<th data-column-id="gname" class="gridjs-th">
												<div class="gridjs-th-content">작성자</div>
											</th>
											<th data-column-id="mname" class="gridjs-th">
												<div class="gridjs-th-content">업로드일자</div>
											</th>
											<th data-column-id="wdate" class="gridjs-th">
												<div class="gridjs-th-content">다운로드 수</div>
											</th>
											<th data-column-id="mdate" class="gridjs-th">
												<div class="gridjs-th-content">다운로드</div>
											</th>
										</tr>
									</thead>
									<tbody class="gridjs-tbody">
										<c:set value="${pagingVO.dataList }" var="libList" />
										<c:choose>
											<c:when test="${empty libList }">
												<tr class="gridjs-tr text-center">
													<td data-column-id="title" class="gridjs-td" colspan="7">해당
														조회 정보가 존재하지 않습니다</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${libList }" var="lib">
													<tr class="gridjs-tr">
														<td data-column-id="title" class="gridjs-td text-left">${lib.libTitle }</td>
														<td data-column-id="gname" class="gridjs-td text-center">${lib.empName }</td>
														<td data-column-id="wdate" class="gridjs-td text-center"><fmt:formatDate
																value="${lib.libUpddate }" pattern="yyyy-MM-dd(E) HH:mm" /></td>
														<td data-column-id="mdate" class="gridjs-td text-center">${lib.libDowncount }</td>
														<td data-column-id="mname" class="gridjs-td text-center">
															<div class="row icon-demo-content text-center">
																<div class="ms-auto">
																	<a href="/library/download?libFileNo=${lib.libFileNo }">
																		<i class="bx bx-download" data-feather="download"></i>
																	</a>
																</div>
															</div> <!-- 												</form> -->
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							<div class="row g-0 text-center text-sm-start">
								<div class="col-sm">
									<nav aria-label="Page navigation example" id="pagingArea">
										${pagingVO.pagingHTML }
									</nav>
								</div>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		var searchForm = $("#searchForm");
		var pagingArea = $("#pagingArea");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});
</script>


