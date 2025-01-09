<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><%@ taglib prefix="fn"
	uri="jakarta.tags.functions"%>

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
					<div class="col-md-6">
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

						<form:form method="POST"
							action="/orders/users/orders/newOrder/finishOrder"
							modelAttribute="order">
							<!-- Shipment Data Section -->
							<section class="mb-4">
								<h3 class="h5">
									✉️
									<spring:message code="finishOrder.shipment.data" />
								</h3>
								<div class="row g-3">
									<div class="col-12">
										<label class="form-label"><spring:message
												code="finishOrder.recipient" /></label>
										<form:input path="deliveryAddress.recipientName"
											class="form-control"
											placeholder="<spring:message code='login.login'/>" />
									</div>
									<div class="col-12">
										<label class="form-label"><spring:message
												code="finishOrder.address" /></label>
										<form:input path="deliveryAddress.address"
											class="form-control"
											placeholder="<spring:message code='finishOrder.address.placeholder'/>" />
									</div>
									<div class="col-md-6">
										<label class="form-label"><spring:message
												code="finishOrder.zip.code" /></label>
										<form:input path="deliveryAddress.zipCode"
											class="form-control"
											placeholder="<spring:message code='finishOrder.zip.code.placeholder'/>" />
									</div>
									<div class="col-md-6">
										<label class="form-label"><spring:message
												code="finishOrder.city" /></label>
										<form:input path="deliveryAddress.city" class="form-control"
											placeholder="<spring:message code='finishOrder.city.placeholder'/>" />
									</div>
									<div class="col-12">
										<label class="form-label"><spring:message
												code="finishOrder.state.province" /></label>
										<form:input path="deliveryAddress.state" class="form-control"
											placeholder="<spring:message code='finishOrder.state.province.placeholder'/>" />
									</div>
									<div class="col-12">
										<label class="form-label"><spring:message
												code="finishOrder.country" /></label>
										<form:input path="deliveryAddress.country"
											class="form-control"
											placeholder='<spring:message code="finishOrder.country.placeholder"/>' />
									</div>
								</div>
							</section>

							<!-- Order Items Section -->
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
													<td>${orderItem.key.price}€</td>
													<td>${orderItem.value}</td>
													<td>${orderItem.key.price * orderItem.value}€</td>
												</tr>
												<c:set var="total"
													value="${total + (orderItem.key.price * orderItem.value)}" />
											</c:forEach>
											<tr>
												<td colspan="3"></td>
												<td><strong>Total</strong></td>
												<td><strong>${total} €</strong></td>
											</tr>
										</tbody>
									</table>
								</div>
							</section>

							<!-- Final Order Button Section -->
							<div class="card-footer">
								<button type="submit" class="btn btn-secondary w-100">
									<spring:message code="header.navbar.finish.order" />
								</button>
							</div>
						</form:form>
						<!-- End Form -->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
