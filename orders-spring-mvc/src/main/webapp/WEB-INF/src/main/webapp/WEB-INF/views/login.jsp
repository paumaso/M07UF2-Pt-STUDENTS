<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<spring:url value="/j_spring_security_check" var="action" />
		<form method="post" action="${action}">
			<div class="container g-2 mb-4">
				<div class="row justify-content-center overflow-hidden">
					<div class="col-sm-9 col-md-7 col-lg-5 col-xl-4">
						<div class="card">
							<div class="card-header bg-secondary-subtle">
								<h5 class="card-title mb-0">
									<spring:message code="login.give.credentials" />
								</h5>
							</div>

							<div class="card-body">
							
								<c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        <spring:message code="login.credentials.failure" />
                                    </div>
                                </c:if>
								
								<div class="input-group py-1">
									<spring:message code="login.username" var="loginUsername" />
									<span class="input-group-text"> <i
										class="bi bi-person-fill"></i>
									</span> <input class="form-control" id="username" name="username" placeholder="${loginUsername}"
										type="text" />
								</div>

								<div class="input-group py-1">
									<spring:message code="login.password" var="loginPassword" />
									<span class="input-group-text"> <i
										class="bi bi-key-fill"></i>
									</span> <input class="form-control" id="password" name="password"  placeholder="${loginPassword}"
										type="password" />
								</div>
							</div>

							<div class="card-footer bg-secondary-subtle">
								<input class="btn btn-light btn-outline-secondary col-12"
									type="submit" value="<spring:message code='login.login' />" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>