<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sections/head.jsp" />
</head>
<body class="m-4">
	<div class="container">
		<jsp:include page="sections/header.jsp" />
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th><spring:message code="orders.reference" /></th>
						<th><spring:message code="orders.deliveryAddress" /></th>
						<th><spring:message code="orders.startDate" /></th>
						<th><spring:message code="orders.state" /></th>
						<th><spring:message code="orders.deliveryDate" /></th>
						<sec:authorize access="hasRole('ADMIN')">
							<th class="text-end"><i id="editButton"
								class="bi bi-pencil-square"></i></th>
						</sec:authorize>
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
											<form action="/orders/admin/orders/setState" method="post">
												<input type="hidden" name="reference"
													value="${order.reference}" /> <select class="form-select"
													name="state" id="state" onchange="this.form.submit();">
													<c:forEach items="${STATES}" var="state" varStatus="status">
														<spring:message code="${state}" var="states" />
														<option value="${status.index}"
															${order.state == status.index ? 'selected' : ''}>
															${states}</option>
													</c:forEach>
												</select>
											</form>
										</sec:authorize></td>
									<td><sec:authorize access="hasRole('USER')">
											<fmt:formatDate value="${order.deliveryDate}"
												pattern="MMM dd, yyyy" />
										</sec:authorize> <sec:authorize access="hasRole('ADMIN')">
											<form action="/orders/admin/orders/setDeliveryDate"
												method="post">
												<input type="hidden" name="reference"
													value="${order.reference}" /> <input class="form-control"
													type="date" id="deliveryDate" name="deliveryDate"
													value="<fmt:formatDate value='${order.deliveryDate}' pattern='yyyy-MM-dd'/>"
													onchange="this.form.submit();" />

											</form>
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
														<td><strong>${total} <spring:message
																	code="currency.symbol" /></strong></td>
													</tr>
												</tbody>
											</table>
										</div>
									</td>
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
