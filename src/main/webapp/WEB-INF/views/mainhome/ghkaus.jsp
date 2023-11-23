<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="site-blocks-cover overlay" style="background-image: url(${pageContext.request.contextPath }/resources/images/cloud.jpg); height: 30px;" data-aos="fade" id="home-section">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-6 mt-lg-5 text-center">
				<h1>화면</h1>
			</div>
		</div>
	</div>
</div>

<div class="container pt-5 pb-5">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">${notice.boTitle }</h3>
						<div class="card-tools">${notice.boWriter } ${notice.boDate } ${notice.boHit } </div>
					</div>
					<form id="quickForm" novalidate="novalidate">
						<div class="card-body">${notice.boContent }</div>
						<div class="card-footer bg-white">
							<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
								<c:if test="${not empty notice.noticeFileList }">
									<c:forEach items="${notice.noticeFileList }" var="noticeFile" varStatus="vs">
										<li>
											<span class="mailbox-attachment-icon">
												<i class="far fa-file-pdf"></i>
										</span>
											<div class="mailbox-attachment-info">
												<a href="#" class="mailbox-attachment-name">
													<i class="fas fa-paperclip"></i> ${noticeFile.fileName }
												</a>
												<span class="mailbox-attachment-size clearfix mt-1">
													<span>${noticeFile.fileFancysize }</span>
														<c:url value="/notice/download.do?${_csrf.parameterName}=${_csrf.token}" var="downloadURL">
															<c:param name="fileNo" value="${noticeFile.fileNo }"/>
														</c:url>
														<a href="${downloadURL }">
															<span class="btn btn-default btn-sm float-right">
																<i class="fas fa-download"></i>
															</span>
														</a>
												</span>
											</div>
										</li>
									</c:forEach>
								</c:if>
								
							</ul>
						</div>
						<div class="card-footer" align="right">
							<button type="button" id="btnList" class="btn btn-primary">목록</button>
							<button type="button" id="btnModify" class="btn btn-info">수정</button>
							<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
						</div>
					</form>
				</div>
			</div>
			<form action="/notice/delete.do" method="post" id="noticeForm">
				<input type="hidden" name="boNo" value="${notice.boNo }"/>
				<sec:csrfInput/>
			</form>
			<div class="col-md-6"></div>
		</div>
	</div>
</div>





