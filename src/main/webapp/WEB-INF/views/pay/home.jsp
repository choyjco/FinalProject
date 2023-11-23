<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
				<div class="row" style="padding-top: 15px;">
					<div class="col-md-6">
					</div>
				</div>
				<!-- end row -->

				<div class="tab-content">
					<div class="tab-pane active" id="overview" role="tabpanel">
						<div class="card">
<!-- 							<div class="card-header justify-content-between d-flex align-items-center"> -->
<!-- 								<h4 class="mb-0" style="margin: auto; position: relative;"><strong>정산하기</strong></h4> -->
<!-- 							</div> -->
							<div class="card-body">
								<div class="row">
									<div class="col-xl-5 col-sm-6">
										<div class="card task-box">
											<div class="card-body">
												<div class="d-flex align-items-start mb-2 gap-2">
													<div class="flex-grow-1">
														<span class="btn btn-light btn-sm badge badge-soft-purple">중간 정산</span>
													</div>
													<div class="flex-shrink-0 ms-2">
														<div class="dropdown">
															<a href="#" class="dropdown-toggle font-size-16 text-muted" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<i class="mdi mdi-lightbulb-on-outline"></i>
															</a>
															<div class="dropdown-menu dropdown-menu-end" style="padding: 10px;">
																 중도 정산을 원하는 직원이 있을 시에 정산합니다.
															</div>
														</div>
													</div>
												</div>
												<h2 class="font-size-20 mb-1">중간 정산</h2>
											</div>
											<div class="card-footer bg-transparent border-top d-flex">
												<div class="flex-shrink-0 ms-2">
													<a href="/pay/inCal" type="button" class="btn btn-primary">정산하기</a>
												</div>
											</div><!-- end card-footer -->
										</div>
									</div>
									<!-- end col -->
									<div class="col-xl-5 col-sm-6">
										<div class="card task-box">
											<div class="card-body">
												<div class="d-flex align-items-start mb-2 gap-2">
													<div class="flex-grow-1">
														<span class="btn btn-light btn-sm badge badge-soft-primary">근로소득</span>
														<span class="btn btn-light btn-sm badge badge-soft-dark">지급일 18일 전</span>
													</div>
													<div class="flex-shrink-0 ms-2">
														<div class="dropdown">
															<a href="#" class="dropdown-toggle font-size-16 text-muted" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<i class="mdi mdi-lightbulb-on-outline"></i>
															</a>
															<div class="dropdown-menu dropdown-menu-end" style="padding: 10px;">
																 월말마다 자동으로 정산됩니다.
															</div>
														</div>
													</div>
												</div>
												<h2 class="font-size-20 mb-1">정기 급여</h2>
											</div>
											<div class="card-footer bg-transparent border-top d-flex">
												<div class="flex-shrink-0 ms-2">
													<a href="/pay/inCal" type="button" class="btn btn-primary">정산하기</a>
												</div>
											</div><!-- end card-footer -->
										</div>
									</div>
									<!-- end col -->
								</div>
								<div class="row">
									<div class="col-xl-5 col-sm-6">
									<div class="card task-box">
											<div class="card-body">
												<div class="d-flex align-items-start mb-2 gap-2">
													<div class="flex-grow-1">
														<span class="btn btn-light btn-sm badge badge-soft-danger">퇴직 소득</span>
													</div>
													<div class="flex-shrink-0 ms-2">
														<div class="dropdown">
															<a href="#" class="dropdown-toggle font-size-16 text-muted" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<i class="mdi mdi-lightbulb-on-outline"></i>
															</a>
															<div class="dropdown-menu dropdown-menu-end" style="padding: 10px;">
																 1일평균임금 × 30일 × (재직일수÷365일)
															</div>
														</div>
													</div>
												</div>
												<h2 class="font-size-20 mb-1">퇴직금 정산</h2>
											</div>
											<div class="card-footer bg-transparent border-top d-flex">
												<div class="flex-shrink-0 ms-2">
													<a href="/pay/outCal" type="button" class="btn btn-primary">정산하기</a>
												</div>
											</div><!-- end card-footer -->
										</div>
									</div>
									<!-- end col -->
									<div class="col-xl-5 col-sm-6">
										<div class="card task-box">
											<div class="card-body">
												<div class="d-flex align-items-start mb-2 gap-2">
													<div class="flex-grow-1">
														<span class="btn btn-light btn-sm badge badge-soft-purple">중간 정산</span>
														<span class="btn btn-light btn-sm badge badge-soft-dark">중간 정산자 목록</span>
													</div>
													<div class="flex-shrink-0 ms-2">
														<div class="dropdown">
															<a href="#" class="dropdown-toggle font-size-16 text-muted" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<i class="mdi mdi-lightbulb-on-outline"></i>
															</a>
															<div class="dropdown-menu dropdown-menu-end" style="padding: 10px;">
																 중도 정산이 완료된 직원을 볼 수 있습니다.
															</div>
														</div>
													</div>
												</div>
												<h2 class="font-size-20 mb-1">중간 정산 사원 목록</h2>
											</div>
											<div class="card-footer bg-transparent border-top d-flex">
												<div class="flex-shrink-0 ms-2">
													<a href="/pay/middleCal" type="button" class="btn btn-primary">정산하기</a>
												</div>
											</div><!-- end card-footer -->
										</div>
									</div>
									<!-- end col -->
								</div>
							</div>
							<!-- end row -->
						</div>
						<!-- end card body -->
					</div>
					<!-- end card -->
				</div>
				<!-- end tab pane -->
			</div>
		</div>
		<!-- end row -->
	</div>
	<!-- end card -->
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
$(function() {
});
</script>