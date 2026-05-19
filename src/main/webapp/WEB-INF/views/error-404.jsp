<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%
  request.setAttribute("pageTitle", "Page Not Found | Ridkk's Eats");
  request.setAttribute("extraCss", "/static/css/page.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
  <div class="empty-card">
    <h1 style="font-size: 4rem; color: var(--primary-color);">404</h1>
    <h2>Page Not Found</h2>

    <p class="muted" style="margin-top: 1rem;">
      The page you are looking for does not exist or may have been moved.
    </p>

    <br>

    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
      Go to Home
    </a>

    <a href="${pageContext.request.contextPath}/food" class="btn btn-login">
      View Menu
    </a>
  </div>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>