<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coursework.entity.Orders" %>
<%@ page import="com.coursework.entity.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    ArrayList<Orders> orders = (ArrayList<Orders>) request.getAttribute("orders");
    if (orders == null) {
        orders = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <style>
        .page-wrapper { max-width: 1100px; margin: 0 auto; padding: 4rem 2rem; min-height: 65vh; }
        .page-title { text-align: center; margin-bottom: 2.5rem; }
        .page-title h1 { font-size: 3rem; margin-bottom: .5rem; }
        .page-title p { color: var(--text-muted); }
        .table-card { background: var(--white); border: 1px solid var(--border-color); border-radius: 16px; box-shadow: var(--shadow-sm); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 1rem; text-align: left; border-bottom: 1px solid var(--border-color); }
        th { background: #f7f7f7; color: var(--text-muted); font-weight: 600; font-size: .9rem; }
        tr:last-child td { border-bottom: none; }
        .status-badge { display: inline-block; padding: .35rem .75rem; border-radius: 20px; background: #fff3cd; color: #856404; font-size: .82rem; font-weight: 600; }
        .action-link { color: var(--primary-color); font-weight: 600; }
        .empty-box { text-align: center; padding: 4rem 2rem; }
        .empty-box h2 { margin-bottom: .7rem; }
        .empty-box p { color: var(--text-muted); margin-bottom: 1.5rem; }
        .top-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.2rem; gap: 1rem; flex-wrap: wrap; }
        @media (max-width: 700px) { .page-title h1 { font-size: 2.2rem; } th, td { padding: .8rem; font-size: .9rem; } .hide-mobile { display: none; } }
    </style>
</head>
<body>
<header class="header">
    <div class="header-container">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 40px;">
            <span class="logo-text">Ridkk's Eats</span>
        </a>
        <div class="user-icons">
            <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Menu</a>
            <a href="${pageContext.request.contextPath}/cart?action=view" class="icon-btn" title="Cart">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
            </a>
            <% if (loggedInUser != null && loggedInUser.getRole() != null && loggedInUser.getRole().equalsIgnoreCase("admin")) { %>
            <a href="${pageContext.request.contextPath}/dashboard" class="icon-btn" title="Dashboard">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
            </a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
        </div>
    </div>
</header>

<main class="page-wrapper">
    <section class="page-title">
        <h1>My Orders</h1>
        <p>Check your previous orders and their current status.</p>
    </section>

    <div class="top-actions">
        <a href="${pageContext.request.contextPath}/food" class="btn btn-login">← Continue Ordering</a>
    </div>

    <div class="table-card">
        <% if (orders.isEmpty()) { %>
        <div class="empty-box">
            <h2>No orders yet</h2>
            <p>Your order history will appear here after checkout.</p>
            <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">Browse Menu</a>
        </div>
        <% } else { %>
        <table>
            <thead>
            <tr>
                <th>Order ID</th>
                <th class="hide-mobile">Date</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Orders order : orders) { %>
            <tr>
                <td>#<%= order.getOrderId() %></td>
                <td class="hide-mobile"><%= order.getCreatedAt() != null ? order.getCreatedAt() : "-" %></td>
                <td>Rs. <%= String.format("%.2f", order.getTotalAmount()) %></td>
                <td><span class="status-badge"><%= order.getStatus() %></span></td>
                <td><a class="action-link" href="${pageContext.request.contextPath}/order?action=details&orderId=<%= order.getOrderId() %>">View</a></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</main>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo"><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats</div>
            <div class="brand-desc-box"><p>Bringing the finest culinary experiences straight to your doorstep.</p></div>
        </div>
        <div class="footer-col"><h4>Information</h4><ul><li><a href="${pageContext.request.contextPath}/aboutus.jsp">About Us</a></li><li><a href="#">Contact Us</a></li></ul></div>
        <div class="footer-col"><h4>Contact Info</h4><ul class="contact-list"><li>Pokhara -17, Birauta</li><li>+977 9845342311</li><li>ridkk'seats@gmail.com</li></ul></div>
    </div>
    <div class="footer-bottom"><p>&copy; 2026 Ridkk's Eats. All rights reserved.</p></div>
</footer>
</body>
</html>
