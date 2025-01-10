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
		<table class="table table-striped table-bordered table-condensed table-responsive">
            <thead>
                <tr>
                    <th><spring:message code="orders.reference" /></th>
                    <th><spring:message code="orders.deliveryAddress" /></th>
                    <th><spring:message code="orders.startDate" /></th>
                    <th><spring:message code="orders.state" /></th>
                    <th><spring:message code="orders.deliveryDate" /></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Orders}" var="order">
                    <tr>
                        <td>${order.reference}</td>
                        <td>${order.deliveryAddress.address}</td> <!-- Asegúrate de mostrar la dirección correctamente -->
                        <td><fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy" /></td>
                        <td>${order.state}</td>
                        <td><fmt:formatDate value="${order.deliveryDate}" pattern="dd/MM/yyyy" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
		<%-- TODO if user has role ADMIN -> Show all orders of all users and let change state and delivery date --%>
		<%-- TODO if user has role USER -> Show all orders of the user --%>
	</div>
</body>
</html>
