<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="sections/head.jsp" />
</head>
<body class="m-4">
	<section class="container">
		<jsp:include page="sections/header.jsp" />
		<div class="row">
			<div class="col-md-6">
				<div class="card">
					<div
						class="card-header d-flex align-items-center justify-content-between">
						<h4 class="mb-0">
							<i class="bi bi-cart4"></i>
							<spring:message code="newOrder.selected.items" />
						</h4>
						<spring:url value="/users/orders/newOrder/clearItems"
							var="clearItemsUrl" />
						<a href="${clearItemsUrl}" class="btn btn-outline-secondary">
							<i class="bi bi-x-circle"></i> <spring:message
								code="newOrder.clear" />
						</a>
					</div>
					<div class="card-body">
						<c:forEach items="${order.getItems().entrySet()}" var="order">
							<div class="d-flex flex-row mb-3">
								<div class="flex-shrink-1">
									<img src="data:image/jpeg;base64, ${order.key.base64Image}"
										alt="${order.key.name}" class="media-object"
										style="width: 60px">
								</div>
								<div class="flex-grow-1 d-flex flex-column">
									<div class="d-flex flex-row">
										<span class="flex-shrink-1 h5">${order.key.name}</span> <small>
											x ${order.value} = ${order.key.price * order.value} €</small>
									</div>
									<p>${order.key.description}</p>
								</div>
								<div class="d-flex flex-column">
									<spring:url value="/users/orders/newOrder/increaseItem"
										var="increaseItemUrl" />
									<a href="${increaseItemUrl}?reference=${order.key.reference}"
										class="link-secondary"> <i class="bi bi-plus-circle"></i>
									</a>
									<spring:url value="/users/orders/newOrder/decreaseItem"
										var="decreaseItemUrl" />
									<a href="${decreaseItemUrl}?reference=${order.key.reference}"
										class="link-secondary"> <i class="bi bi-dash-circle"></i>
									</a>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="card-footer d-grid d-md-block">
						<spring:url value="/users/orders/newOrder/finishOrder"
							var="finishOrderUrl" />
						<a href="${finishOrderUrl}" class="btn btn-outline-secondary col-12"
							role="button"> <i class="bi bi-bag-check-fill"></i> Finish
							order
						</a>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-header">
						<h4>
							<i class="bi bi-list"></i>
							<spring:message code="newOrder.items" />
						</h4>
					</div>
					<c:forEach items="${availableItems}" var="item">
						<div class="card">
							<div class="card-body">
								<div class="d-flex flex-row">
									<div class="flex-shrink-1">
										<img src="data:image/jpeg;base64, ${item.base64Image}"
											alt="${item.name}" class="media-object" style="width: 60px">
									</div>
									<div class="flex-grow-1 d-flex flex-column">
										<div class="dflex flex-row">
											<span class="flex-shrink-1 h5">${item.name}</span> <small>${item.price}
												€</small>
										</div>
										<p>${item.description}</p>
									</div>
									<div class="d-flex">
										<spring:url value="/users/orders/newOrder/increaseItem"
											var="increaseItemUrl" />
										<a href="${increaseItemUrl}?reference=${item.reference}"
											class="link-secondary"> <i class="bi bi-plus-circle"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
</body>
</html>
