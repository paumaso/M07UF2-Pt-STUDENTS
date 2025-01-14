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
		<table
			class="table table-striped table-bordered table-condensed table-responsive">
			<thead>
				<tr>
					<th><spring:message code="orders.reference" /></th>
					<th><spring:message code="orders.deliveryAddress" /></th>
					<th><spring:message code="orders.startDate" /></th>
					<th><spring:message code="orders.state" /></th>
					<th><spring:message code="orders.deliveryDate" /></th>
				</tr>
			</thead>
			<sec:authorize access="hasRole('ADMIN')">
				<section>adios</section>
			</sec:authorize>

			<sec:authorize access="hasRole('USER')">
				<tbody>
					<c:choose>
						<c:when test="${empty Orders}">
							<tbody>
								<tr>
									<td colspan="6">You have no orders</td>
								</tr>
							</tbody>
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
            									${order.client.firstName}  ${order.client.lastName}
											</c:otherwise>
										</c:choose>
										<br>
										${order.deliveryAddress.zipCode} <br>
										${order.deliveryAddress.city} <br>
										${order.deliveryAddress.state} <br>
										${order.deliveryAddress.country}</td>
										
									<td>${order.deliveryAddress.address}</td>
									<td><fmt:formatDate value="${order.startDate}"
											pattern="MMM dd, yyyy" /></td>
									<spring:message code="${STATES[order.state]}" var="state" />
									<td>${state}</td>
									<td><fmt:formatDate value="${order.deliveryDate}"
											pattern="MMM dd, yyyy" /></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</sec:authorize>
		</table>
	</div>
</body>
</html>
