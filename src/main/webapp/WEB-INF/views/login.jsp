<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    request.setAttribute("pageTitle", "Login | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/login.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<div class="auth-page">
    <div class="auth-card">
        <div class="auth-header">
            <a href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats">
            </a>
            <h2>Welcome Back</h2>
            <p style="color: var(--text-muted); margin-top:0.5rem;">Sign in to continue</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-msg"><c:out value="${error}" /></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="btn btn-primary btn-full">Login</button>
        </form>

        <div class="auth-footer">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign Up</a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>