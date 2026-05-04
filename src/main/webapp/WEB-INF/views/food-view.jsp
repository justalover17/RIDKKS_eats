<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.coursework.entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${food.name} | Riddik's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/food-view.css">
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-container">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 40px;">
                <span class="logo-text">Riddik's Eats</span>
            </a>
        </div>
        <div class="header-right">
            <% if (loggedInUser == null) { %>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Login</a>
            <% } else { %>
                <div class="user-icons">
                    <button class="icon-btn" title="Notifications">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                    </button>
                    <button class="icon-btn" title="My Profile">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    </button>
                    <button class="icon-btn" title="Cart">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                    </button>
                </div>
            <% } %>
        </div>
    </div>
</header>

<div class="view-container">
    <c:url value="/static/images/${food.name}.png" var="foodImageUrl" />
    <div class="view-image" style="background-image: url('${foodImageUrl}');">
        <img src="${foodImageUrl}" style="display:none;" onerror="this.parentElement.style.backgroundImage='url(\'${pageContext.request.contextPath}/static/images/logo.png\')'">
    </div>
    <div class="view-details">
        <a href="${pageContext.request.contextPath}/food" style="color: var(--text-muted); margin-bottom: 1rem; display: inline-block;">&larr; Back to Menu</a>
        <h1 class="view-title"><c:out value="${food.name}" /></h1>
        <div class="view-price">Rs. <c:out value="${food.price}" /></div>
        <p class="view-desc"><c:out value="${food.description}" /></p>
        
        <form action="${pageContext.request.contextPath}/cart?action=add" method="post" class="add-cart-form">
            <input type="hidden" name="foodId" value="${food.foodId}">
            
            <div class="quantity-selector">
                <button type="button" class="qty-btn" id="decreaseQty">-</button>
                <input type="number" name="quantity" id="qtyInput" class="qty-input" value="1" min="1" max="20" readonly>
                <button type="button" class="qty-btn" id="increaseQty">+</button>
            </div>
            
            <div style="display:flex; gap:15px; margin-top:1rem;">
                <button type="submit" class="btn" style="background-color: #28a745; color: white; padding: 1rem 2rem; font-size: 1.1rem; border: none; border-radius: 5px; cursor: pointer; flex: 1; font-weight: 600;">Buy</button>
                <button type="submit" class="btn btn-primary" style="padding: 1rem 2rem; font-size: 1.1rem; flex: 1;">Add</button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Riddik's Eats" style="height: 35px; margin-right: 10px;"> Riddik's Eats
            </div>
            <div class="brand-desc-box">
                <p>Bringing the finest culinary experiences straight to your doorstep. Fresh, fast, and full of flavor.</p>
            </div>
        </div>
        <div class="footer-col">
            <h4>Information</h4>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="contact-list">
                <li>📍 123 Food Street, Culinary District</li>
                <li>📞 +977 9800000000</li>
                <li>✉️ support@riddikseats.com</li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Social Media</h4>
            <div class="social-links">
                <a href="#" class="social-icon">
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24"><path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"></path></svg> Facebook
                </a>
                <a href="#" class="social-icon">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg> Instagram
                </a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 Riddik's Eats. All rights reserved.</p>
    </div>
</footer>

<script>
    // Quantity Selector Logic
    const decreaseBtn = document.getElementById('decreaseQty');
    const increaseBtn = document.getElementById('increaseQty');
    const qtyInput = document.getElementById('qtyInput');

    if(decreaseBtn && increaseBtn && qtyInput) {
        decreaseBtn.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            if(current > 1) qtyInput.value = current - 1;
        });

        increaseBtn.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            if(current < 20) qtyInput.value = current + 1;
        });
    }
</script>

</body>
</html>
