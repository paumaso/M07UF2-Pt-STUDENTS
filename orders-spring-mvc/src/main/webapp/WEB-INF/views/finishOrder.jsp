<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="sections/head.jsp" />
</head>
<body class="m-4">
	<div class="container">
		<jsp:include page="sections/header.jsp" />

		<div class="card">
			<div class="card-header">
				<h2 class="mb-0">
					<spring:message code="finishOrder.order" />
				</h2>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-md-12">
						<section class="mb-4">
							<h3 class="h5">
								👤
								<spring:message code="finishOrder.client.data" />
							</h3>
							<div class="row">
								<div class="col-12">
									<p class="mb-1">
										<strong><spring:message code="finishOrder.first.name" />:</strong>
										${order.client.firstName}
									</p>
									<p>
										<strong><spring:message code="finishOrder.last.name" />:</strong>
										${order.client.lastName}
									</p>
								</div>
							</div>
						</section>
					</div>
					<div class="col-md-6">
						<spring:url value="finishOrder" var="action" />
						<form:form method="POST" action="${action}" modelAttribute="order">
							<section class="mb-4">
								<h3 class="h5">
									✉️
									<spring:message code="finishOrder.shipment.data" />
								</h3>

								<!-- Fields for delivery address -->
								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.recipient" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.recipient.placeholder"
											var="recipientPlaceholder" />
										<form:input path="deliveryAddress.recipientName"
											class="form-control" placeholder="${recipientPlaceholder}" />
										<form:errors path="deliveryAddress.recipientName"
											cssClass="text-danger" htmlEscape="false" />
									</div>
								</div>

								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.address" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.address.placeholder"
											var="addressPlaceholder" />
										<form:input path="deliveryAddress.address"
											class="form-control" placeholder="${addressPlaceholder}" />
										<form:errors path="deliveryAddress.address"
											cssClass="text-danger fs-6" htmlEscape="false" />
									</div>
								</div>

								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.zip.code" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.zip.code.placeholder"
											var="zipCodePlaceholder" />
										<form:input path="deliveryAddress.zipCode"
											class="form-control" placeholder="${zipCodePlaceholder}" />
										<form:errors path="deliveryAddress.zipCode"
											cssClass="text-danger" htmlEscape="false" />
									</div>
								</div>

								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.city" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.city.placeholder"
											var="cityPlaceholder" />
										<form:input path="deliveryAddress.city" class="form-control"
											placeholder="${cityPlaceholder}" />
										<form:errors path="deliveryAddress.city"
											cssClass="text-danger" htmlEscape="false" />
									</div>
								</div>

								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.state.province" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.state.province.placeholder"
											var="stateProvincePlaceholder" />
										<form:input path="deliveryAddress.state" class="form-control"
											placeholder="${stateProvincePlaceholder}" />
										<form:errors path="deliveryAddress.state"
											cssClass="text-danger" htmlEscape="false" />
									</div>
								</div>

								<div class="row mb-3 align-items-center">
									<div class="col-md-3">
										<label class="form-label"><spring:message
												code="finishOrder.country" /></label>
									</div>
									<div class="col-md-9">
										<spring:message code="finishOrder.country.placeholder"
											var="countryPlaceholder" />
										<form:input path="deliveryAddress.country"
											class="form-control" placeholder="${countryPlaceholder}" />
										<form:errors path="deliveryAddress.country"
											cssClass="text-danger" htmlEscape="false" />
									</div>
								</div>
							</section>
					</div>

					<div class="col-md-6">
						<section class="mb-4">
							<h3 class="h5">
								📋
								<spring:message code="finishOrder.items" />
							</h3>
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th><spring:message code="finishOrder.reference" /></th>
											<th><spring:message code="finishOrder.item" /></th>
											<th><spring:message code="finishOrder.price" /></th>
											<th><spring:message code="finishOrder.quantity" /></th>
											<th><spring:message code="finishOrder.amount" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${order.items.entrySet()}" var="orderItem">
											<tr>
												<td>${orderItem.key.reference}</td>
												<td>${orderItem.key.name}</td>
												<td><fmt:formatNumber value="${orderItem.key.price}"
														type="number" minFractionDigits="2" maxFractionDigits="2" />
													<spring:message code="currency.symbol" /></td>
												<td>${orderItem.value}</td>
												<td><fmt:formatNumber
														value="${orderItem.key.price * orderItem.value}"
														type="number" minFractionDigits="2" maxFractionDigits="2" />
													<spring:message code="currency.symbol" /></td>
											</tr>
											<c:set var="total"
												value="${total + (orderItem.key.price * orderItem.value)}" />
										</c:forEach>
										<tr>
											<td colspan="3"></td>
											<td><strong><spring:message code="orders.total"/></strong></td>
											<td><strong><fmt:formatNumber value="${total}"
														type="number" minFractionDigits="2" maxFractionDigits="2" />
													<spring:message code="currency.symbol" /></strong></td>
										</tr>
									</tbody>
								</table>
							</div>
						</section>
					</div>

					<div class="card-footer">
						<button type="submit" class="btn btn-secondary w-100">
							<i class="bi bi-credit-card"></i>
							<spring:message code="header.navbar.finish.order" />
						</button>
					</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
