<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.coursework.entity.Orders" %>
<%@ page import="com.coursework.entity.OrderDetails" %>
<%@ page import="com.coursework.entity.FoodItem" %>
<%@ page import="com.coursework.entity.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    Orders order = (Orders) request.getAttribute("order");
    ArrayList<OrderDetails> items = (ArrayList<OrderDetails>) request.getAttribute("items");
    Map<Integer, FoodItem> foodMap = (Map<Integer, FoodItem>) request.getAttribute("foodMap");
    Double totalObj = (Double) request.getAttribute("total");
    double total = totalObj != null ? totalObj : 0;
    if (items == null) {
        items = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <style>
        .page-wrapper { max-width: 1000px; margin: 0 auto; padding: 4rem 2rem; min-height: 65vh; }
        .details-header { background: var(--dark-bg); color: var(--white); border-radius: 18px; padding: 2rem; margin-bottom: 2rem; box-shadow: var(--shadow-md); display: flex; justify-content: space-between; gap: 1rem; flex-wrap: wrap; }
        .details-header h1 { color: var(--white); font-size: 2.5rem; margin-bottom: .4rem; }
        .details-header p { color: rgba(255,255,255,.75); }
        .status-badge { display: inline-block; padding: .45rem .85rem; border-radius: 20px; background: #fff3cd; color: #856404; font-weight: 700; }
        .table-card { background: var(--white); border: 1px solid var(--border-color); border-radius: 16px; box-shadow: var(--shadow-sm); overflow: hidden; margin-bottom: 1.5rem; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 1rem; text-align: left; border-bottom: 1px solid var(--border-color); }
        th { background: #f7f7f7; color: var(--text-muted); font-weight: 600; font-size: .9rem; }
        tr:last-child td { border-bottom: none; }
        .total-box { background: var(--white); border: 1px solid var(--border-color); border-radius: 16px; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center; box-shadow: var(--shadow-sm); }
        .total-box strong { font-size: 1.5rem; color: var(--primary-color); }
        .actions { display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
        @media (max-width: 700px) { .details-header h1 { font-size: 2rem; } th, td { padding: .8rem; font-size: .9rem; } .hide-mobile { display: none; } }
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
            <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-primary">My Orders</a>
            <% if (loggedInUser != null && loggedInUser.getRole() != null && loggedInUser.getRole().equalsIgnoreCase("admin")) { %>
            <a href="${pageContext.request.contextPath}/dashboard" class="icon-btn" title="Dashboard">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
            </a>
            <% } %>
        </div>
    </div>
</header>

<main class="page-wrapper">
    <div class="actions">
        <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-login">← Back to Orders</a>
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">Order More</a>
    </div>

    <% if (order != null) { %>
    <section class="details-header">
        <div>
            <h1>Order #<%= order.getOrderId() %></h1>
            <p>Date: <%= order.getCreatedAt() != null ? order.getCreatedAt() : "-" %></p>
        </div>
        <div><span class="status-badge"><%= order.getStatus() %></span></div>
    </section>

    <div class="table-card">
        <table>
            <thead>
            <tr>
                <th>Food Item</th>
                <th>Quantity</th>
                <th class="hide-mobile">Unit Price</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <% if (items.isEmpty()) { %>
            <tr><td colspan="4">No item details found for this order.</td></tr>
            <% } else { %>
            <% for (OrderDetails item : items) {
                FoodItem food = foodMap != null ? foodMap.get(item.getFoodId()) : null;
                double unitPrice = item.getQuantity() > 0 ? item.getSubtotal() / item.getQuantity() : 0;
            %>
            <tr>
                <td><%= food != null ? food.getName() : "Food ID #" + item.getFoodId() %></td>
                <td><%= item.getQuantity() %></td>
                <td class="hide-mobile">Rs. <%= String.format("%.2f", unitPrice) %></td>
                <td>Rs. <%= String.format("%.2f", item.getSubtotal()) %></td>
            </tr>
            <% } %>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="total-box">
        <span>Total Amount</span>
        <strong>Rs. <%= String.format("%.2f", total) %></strong>
    </div>
    <% } else { %>
    <div class="table-card" style="padding: 3rem; text-align: center;">
        <h2>Order not found</h2>
        <p style="color: var(--text-muted); margin: .8rem 0 1.5rem;">The order may have been removed or is not available.</p>
        <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-primary">Go Back</a>
    </div>
    <% } %>
</main>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo"><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats</div>
            <div class="brand-desc-box"><p>Fresh food, quick service and simple online ordering.</p></div>
        </div>
        <div class="footer-col"><h4>Information</h4><ul><li><a href="${pageContext.request.contextPath}/aboutus.jsp">About Us</a></li><li><a href="#">Contact Us</a></li></ul></div>
        <div class="footer-col"><h4>Contact Info</h4><ul class="contact-list"><li>Pokhara -17, Birauta</li><li>+977 9845342311</li><li>ridkk'seats@gmail.com</li></ul></div>
    </div>
    <div class="footer-bottom"><p>&copy; 2026 Ridkk's Eats. All rights reserved.</p></div>
</footer>
</body>
</html>
