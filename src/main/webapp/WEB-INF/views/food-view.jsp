
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.coursework.entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- Retrieve the logged-in user from the session --%>
<%
    User loggedInUser = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${food.name} | Ridkk's Eats</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/food-view.css">
</head>
<body>

<!--
     HEADER SECTION
     This is the top navigation bar of the website.
     It contains the logo and the Login/Profile buttons.
     -->
<header class="header">
    <div class="header-container">

        <!-- Logo and brand name linking back to homepage -->
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 40px;">
                <span class="logo-text">Ridkk's Eats</span>
            </a>
        </div>

        <!-- Right side of header: show Login button if not logged in, icons if logged in -->
        <div class="header-right">
            <% if (loggedInUser == null) { %>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Login</a>
            <% } else { %>
            <div class="user-icons">
                <button class="icon-btn" title="Notifications">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                </button>
                <div class="profile-dropdown-container" style="position: relative; display: inline-block;">
                    <button class="icon-btn" title="My Profile" onclick="toggleProfileDropdown()">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    </button>
                    <div id="profileDropdown" class="profile-dropdown" style="display: none; position: absolute; right: -50px; top: 120%; background: white; border: 1px solid #ddd; padding: 15px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 150px; text-align: center; z-index: 100;">
                        <div style="font-size: 12px; color: #888; margin-bottom: 5px; text-transform: uppercase; font-weight: bold;">My Profile</div>
                        <div style="font-weight: 600; margin-bottom: 10px; color: #333;">
                            <%= (loggedInUser.getRole() != null && loggedInUser.getRole().equalsIgnoreCase("admin")) ? "Admin" : loggedInUser.getName() %>
                        </div>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary" style="display: block; width: 100%; padding: 8px 0; font-size: 14px;">Logout</a>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/cart?action=view" class="icon-btn" title="Cart" style="display:inline-flex;align-items:center;justify-content:center;background:none;border:none;cursor:pointer;text-decoration:none;color:inherit;">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </a>
            </div>
            <% } %>
        </div>

    </div>
</header>
<!-- END HEADER -->


<!--
     FOOD DETAIL SECTION
     This part displays the big picture of the food,
     the description, price, and the "Add to Cart" button.
     -->
<div class="view-container">

    <%-- Build the image URL dynamically using the safe food name (without apostrophe and space) --%>
    <c:set var="quote" value="'" />
    <c:set var="safeName1" value="${fn:replace(food.name, quote, '')}" />
    <c:set var="safeName2" value="${fn:replace(safeName1, ' ', '')}" />
    <c:url value="/static/images/${safeName2}.png" var="foodImageUrl" />

    <!-- Food image section; falls back to logo if image not found -->
    <div class="view-image" style="background-image: url(${foodImageUrl});">
        <%-- Hidden img tag used to detect load error and swap background to fallback logo --%>
        <img src="${foodImageUrl}" style="display:none;"
             onerror="this.parentElement.style.backgroundImage='url(${pageContext.request.contextPath}/static/images/logo.png)'">
    </div>

    <!-- Food info and add-to-cart section -->
    <div class="view-details">

        <!-- Back navigation link to the full menu -->
        <a href="${pageContext.request.contextPath}/food" style="color: var(--text-muted); margin-bottom: 1rem; display: inline-block;">&larr; Back to Menu</a>

        <!-- Food name heading -->
        <h1 class="view-title"><c:out value="${food.name}" /></h1>

        <!-- Food price display -->
        <div class="view-price">Rs. <c:out value="${food.price}" /></div>

        <!-- Food description paragraph -->
        <p class="view-desc"><c:out value="${food.description}" /></p>

        <!-- Add to cart / Buy form — submits foodId and quantity to CartServlet -->
        <form action="${pageContext.request.contextPath}/cart?action=add" method="post" class="add-cart-form">

            <!-- Hidden field to pass the selected food's ID to the servlet -->
            <input type="hidden" name="foodId" value="${food.foodId}">

            <!-- Quantity selector: controlled by JS buttons, value between 1 and 20 -->
            <div class="quantity-selector">
                <button type="button" class="qty-btn" id="decreaseQty">-</button>
                <input type="number" name="quantity" id="qtyInput" class="qty-input" value="1" min="1" max="20" readonly>
                <button type="button" class="qty-btn" id="increaseQty">+</button>
            </div>

            <!-- Action buttons: Buy (direct purchase) and Add (add to cart) -->
            <div style="display:flex; gap:15px; margin-top:1rem;">
                <button type="submit" class="btn"
                        style="background-color: #28a745; color: white; padding: 1rem 2rem; font-size: 1.1rem; border: none; border-radius: 5px; cursor: pointer; flex: 1; font-weight: 600;">
                    Buy
                </button>
                <button type="submit" class="btn btn-primary"
                        style="padding: 1rem 2rem; font-size: 1.1rem; flex: 1;">
                    Add
                </button>
            </div>

        </form>
    </div>

</div>
<!-- END FOOD DETAIL VIEW -->


<!--
     FOOTER SECTION
     This is the dark bottom area of the website.
     It contains contact info and social media links.
     -->
<footer class="footer">
    <div class="footer-container">

        <!-- Brand column: logo, name, and short description -->
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats
            </div>
            <div class="brand-desc-box">
                <p>Bringing the finest culinary experiences straight to your doorstep. Fresh, fast, and full of flavor.</p>
            </div>
        </div>

        <!-- Quick links column -->
        <div class="footer-col">
            <h4>Information</h4>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact Us</a></li>
            </ul>
        </div>

        <!-- Contact details column -->
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="contact-list">
                <li> Pokhara -17, Birauta</li>
                <li>+977 9845342311</li>
                <li>ridkk'seats@gmail.com</li>
            </ul>
        </div>

        <!-- Social media links column -->
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

    <!-- Copyright bar at the bottom of the footer -->
    <div class="footer-bottom">
        <p>&copy; 2026 Ridkk's Eats. All rights reserved.</p>
    </div>
</footer>
<!-- END FOOTER -->


<!--
     JAVASCRIPT SECTION
     This code controls the "+" and "-" buttons so users
     can change the quantity of the food they want to buy.
     -->
<script>
    // Get references to the quantity control elements
    const decreaseBtn = document.getElementById('decreaseQty');
    const increaseBtn = document.getElementById('increaseQty');
    const qtyInput = document.getElementById('qtyInput');

    // Only attach listeners if all elements exist on the page
    if(decreaseBtn && increaseBtn && qtyInput) {

        // Decrease quantity by 1, minimum value is 1
        decreaseBtn.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            if(current > 1) qtyInput.value = current - 1;
        });

        // Increase quantity by 1, maximum value is 20
        increaseBtn.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            if(current < 20) qtyInput.value = current + 1;
        });
    }

    // Profile Dropdown Logic
    function toggleProfileDropdown() {
        const dropdown = document.getElementById('profileDropdown');
        if(dropdown) {
            dropdown.style.display = (dropdown.style.display === 'none' || dropdown.style.display === '') ? 'block' : 'none';
        }
    }

    // Close dropdown if clicked outside
    window.addEventListener('click', function(e) {
        const container = document.querySelector('.profile-dropdown-container');
        if (container && !container.contains(e.target)) {
            const dropdown = document.getElementById('profileDropdown');
            if(dropdown) dropdown.style.display = 'none';
        }
    });
</script>
</body>
</html>