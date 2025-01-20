<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sections/head.jsp" />
<script>
	function toggleEditForms() {
		var stateDiv = document.getElementById("state");
		var stateForm = document.getElementById("stateForm");

		var deliveryDateDiv = document.getElementById("deliveryDate");
		var deliveryDateForm = document.getElementById("deliveryDateForm");

		if (stateDiv.style.display === "none") {
			stateDiv.style.display = "block";
			stateForm.style.display = "none";
		} else {
			stateDiv.style.display = "none";
			stateForm.style.display = "block";
		}

		if (deliveryDateDiv.style.display === "none") {
			deliveryDateDiv.style.display = "block";
			deliveryDateForm.style.display = "none";
		} else {
			deliveryDateDiv.style.display = "none";
			deliveryDateForm.style.display = "block";
		}
	}
</script>
</head>
<body class="m-4">
	<div class="container">
		<jsp:include page="sections/header.jsp" />
		<div class="table-responsive">
			<table class="table table-striped table-bordered ">
				<thead>
					<tr>
						<th><spring:message code="orders.reference" /></th>
						<th><spring:message code="orders.deliveryAddress" /></th>
						<th><spring:message code="orders.startDate" /></th>
						<th><spring:message code="orders.state" /></th>
						<th><spring:message code="orders.deliveryDate" /></th>
						<th><spring:message code="orders.details" /></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty Orders}">
							<tr>
								<td colspan="6" class="text-center">You have no orders</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${Orders}" var="order">
								<tr>
									<td><c:choose>
											<c:when
												test="${not empty order.deliveryAddress.recipientName}">
                                                ${order.deliveryAddress.recipientName}
                                            </c:when>
											<c:otherwise>
                                                ${order.client.firstName} ${order.client.lastName}
                                            </c:otherwise>
										</c:choose> <br>${order.deliveryAddress.zipCode}<br>
										${order.deliveryAddress.city}<br>
										${order.deliveryAddress.state}<br>
										${order.deliveryAddress.country}</td>
									<td class="text-truncate" style="max-width: 200px;">
										${order.deliveryAddress.address}</td>
									<td><fmt:formatDate value="${order.startDate}"
											pattern="MMM dd, yyyy" /></td>
									<spring:message code="${STATES[order.state]}" var="state" />
									<td><sec:authorize access="hasRole('USER')">
                                            ${state}
                                        </sec:authorize> <sec:authorize
											access="hasRole('ADMIN')">
											<div id="state">${state}</div>
											<div id="stateForm" style="display: none">
												<form action="/orders/admin/orders/setState" method="post">
													<input type="hidden" name="reference"
														value="${order.reference}" /> <select class="form-select"
														name="state" id="state" onchange="this.form.submit();">
														<c:forEach items="${STATES}" var="state"
															varStatus="status">
															<spring:message code="${state}" var="states" />
															<option value="${status.index}"
																${order.state == status.index ? 'selected' : ''}>
																${states}</option>
														</c:forEach>
													</select>
												</form>
											</div>
										</sec:authorize></td>
									<td><sec:authorize access="hasRole('USER')">
											<fmt:formatDate value="${order.deliveryDate}"
												pattern="MMM dd, yyyy" />
										</sec:authorize> <sec:authorize access="hasRole('ADMIN')">
											<div id="deliveryDate">
												<fmt:formatDate value="${order.deliveryDate}"
													pattern="MMM dd, yyyy" />
											</div>
											<div id="deliveryDateForm" style="display: none">
												<form action="/orders/admin/orders/setDeliveryDate"
													method="post">
													<input type="hidden" name="reference"
														value="${order.reference}" /> <input class="form-control"
														type="date" id="deliveryDate" name="deliveryDate"
														value="<fmt:formatDate value='${order.deliveryDate}' pattern='yyyy-MM-dd'/>"
														onchange="this.form.submit();" />
												</form>
											</div>

										</sec:authorize></td>
									<td>
										<div class="table-responsive">
											<table class="table table-striped table-bordered">
												<thead>
													<tr>
														<th><spring:message code="orders.reference" /></th>
														<th><spring:message code="orders.item" /></th>
														<th><spring:message code="orders.price" /></th>
														<th><spring:message code="orders.quantity" /></th>
														<th><spring:message code="orders.amount" /></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${order.items.entrySet()}"
														var="orderItem">
														<tr>
															<td>${orderItem.key.reference}</td>
															<td>${orderItem.key.name}</td>
															<td><fmt:formatNumber value="${orderItem.key.price}"
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" /> <spring:message
																	code="currency.symbol" /></td>
															<td>${orderItem.value}</td>
															<td><fmt:formatNumber
																	value="${orderItem.key.price * orderItem.value}"
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" /> <spring:message
																	code="currency.symbol" /></td>
														</tr>
														<c:set var="total"
															value="${total + (orderItem.key.price * orderItem.value)}" />
													</c:forEach>
													<tr>
														<td colspan="3"></td>
														<td><strong><spring:message
																	code="orders.total" /></strong></td>
														<td><strong><fmt:formatNumber
																	value="${total}" type="number" minFractionDigits="2"
																	maxFractionDigits="2" /> <spring:message
																	code="currency.symbol" /></strong></td>
													</tr>
												</tbody>
											</table>
										</div>
									</td>
									<sec:authorize access="hasRole('ADMIN')">
										<td class="text-end"><a id="editButton"
											class="btn btn-primary me-2" onclick="toggleEditForms()">
												<i class="bi bi-pencil-fill"></i>
										</a></td>
									</sec:authorize>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
