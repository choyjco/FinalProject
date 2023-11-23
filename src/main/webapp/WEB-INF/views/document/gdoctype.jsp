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
									<!-- 										<a href="/library/register"><button type="button" class="btn btn-success">자료추가</button></a> -->
								</div>
								<div class="col-md-9">
									<div class="d-flex justify-content-end">
										<form method="post" id="searchForm">
											<input type="hidden" name="page" id="page" />
											<ul class="nav nav-pills">
												<li class="nav-item"><input type="text"
													name="searchWord" value="${searchWord }"
													class="form-control float-right" placeholder="문서종류를 입력하세요"></li>
												<li class="nav-item">
													<div class="input-group-append">
														<button type="submit" class="btn btn-primary">검색</button>
													</div>
												</li>
												<sec:csrfInput />
											</ul>
										</form>
									</div>
								</div>
							</div>
							<div class="gridjs-wrapper" style="height: auto;">
								<table role="grid" class="gridjs-table text-center"
									style="height: auto;">
									<thead class="gridjs-thead">
										<tr class="gridjs-tr">
											<th data-column-id="name" class="gridjs-th"
												style="min-width: 83px; width: 174px;">
												<div class="gridjs-th-content">문서종류</div>
											</th>
											<th data-column-id="email" class="gridjs-th"
												style="min-width: 181px; width: 380px;">
												<div class="gridjs-th-content"></div>
											</th>
										</tr>
									</thead>
									<tbody class="gridjs-tbody">
										<c:set value="${docTypeList.dataList }" var="docTypeList" />
										<c:forEach items="${docTypeList }" var="doc">
											<tr class="gridjs-tr">
												<td data-column-id="name" class="gridjs-td">${doc.docClfName }</td>
												<td data-column-id="email" class="gridjs-td">
													<div class="d-flex justify-content-center">
														<a href="/document/documentwrite?docClfCode=${doc.docClfCode }">
														<button type="button" class="btn btn-info">작성</button></a>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="row g-0 text-center text-sm-start">
					<div class="col-sm">
						<nav aria-label="Page navigation example" id="pagingArea">
							${pagingVO.pagingHTML }</nav>
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














