<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "About Us | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/page.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
    <section class="page-title">
        <h1>About Ridkk's Eats</h1>
        <p>Fresh food, simple ordering, and fast delivery for hungry customers around Pokhara.</p>
    </section>

    <section class="info-card" style="margin-bottom: 1.5rem;">
        <h2>Who We Are</h2>

        <p style="margin-top: 1rem; color: var(--text-muted);">
            Ridkk's Eats is a food ordering web application made for the APT coursework.
            The system lets customers browse food items, add meals to cart, checkout, and view their order history.
        </p>

        <p style="margin-top: 1rem; color: var(--text-muted);">
            The admin side helps manage menu items, users, orders, and dashboard records from one place.
            The aim is to make the food ordering process easy for both customer and restaurant staff.
        </p>
    </section>

    <section style="display:grid; grid-template-columns:repeat(auto-fit, minmax(240px, 1fr)); gap:1rem;">
        <div class="info-card">
            <h3>Fresh Food</h3>
            <p class="muted" style="margin-top:.7rem;">Customers can explore different categories and popular dishes.</p>
        </div>

        <div class="info-card">
            <h3>Easy Ordering</h3>
            <p class="muted" style="margin-top:.7rem;">The cart and checkout process is simple and user friendly.</p>
        </div>

        <div class="info-card">
            <h3>Admin Control</h3>
            <p class="muted" style="margin-top:.7rem;">Admins can manage food items, users, and order information.</p>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>