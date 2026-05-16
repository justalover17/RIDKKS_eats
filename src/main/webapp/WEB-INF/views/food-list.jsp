food list
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
    <title>Menu | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/food-list.css">
</head>
<!--
     HEADER SECTION
     This is the top navigation bar of the website.
     It contains the logo and the Login/Profile buttons.
     -->
<header class="header">
    <div class="header-container">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 40px;">
                <span class="logo-text">Ridkk's Eats</span>
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
                <button class="icon-btn" title="Cart">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </button>
            </div>
            <% } %>
        </div>
    </div>
</header>

<!--
     MENU BANNER SECTION
     This is the title area at the very top of the menu page.
     -->
<div class="page-header">
    <h1>Our Full Menu</h1>
    <p>Discover the finest dishes crafted just for you.</p>
</div>

<!--
     CATEGORY FILTERS
     This connects the small 'category-filters.jsp' file
     which draws the category buttons (Nepali, Breakfast, etc).
     -->
<jsp:include page="/WEB-INF/views/category-filters.jsp" />

<%--  ADD THIS: Add Food button — only admin sees it --%>
<% if (loggedInUser != null && "admin".equals(loggedInUser.getRole())) { %>
<div style="text-align: center; margin-bottom: 2rem;">
    <a href="${pageContext.request.contextPath}/food?action=add"
       style="background-color: #e63946; color: white; padding: 0.7rem 1.5rem;
                  border-radius: 8px; text-decoration: none; font-weight: 600;
                  font-family: var(--font-body); font-size: 1rem;">
        + Add Food Item
    </a>
</div>
<% } %>

<!--
     FOOD GRID SECTION
     This is a loop that draws a card for EVERY food item
     found in the database and displays its picture and price.
     -->
<div class="food-grid">
    <c:choose>
        <c:when test="${empty foods}">
            <div style="grid-column: 1/-1; text-align: center; padding: 4rem;">
                <h3>No food items available at the moment.</h3>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="food" items="${foods}">
                <div class="food-item-card">
                    <a href="${pageContext.request.contextPath}/food?action=view&id=${food.foodId}"
                       style="text-decoration: none; color: inherit; display: flex; flex-direction: column; height: 100%;">
                        <div class="food-item-img"
                             style="overflow: hidden; display: flex; align-items: center; justify-content: center; height: 200px; background-color: #f1f3f5;">
                            <c:url value="/static/images/${food.name}.png" var="foodImageUrl" />
                            <img src="${foodImageUrl}" alt="${food.name}"
                                 style="width: 100%; height: 100%; object-fit: cover;"
                                 onerror="this.src='${pageContext.request.contextPath}/static/images/logo.png'">
                        </div>
                        <div class="food-item-content"
                             style="padding: 1.5rem; text-align: center; flex-grow: 1; display: flex; flex-direction: column; justify-content: center;">
                            <h3 style="font-size: 1.25rem; margin-bottom: 0.5rem;">
                                <c:out value="${food.name}" />
                            </h3>
                            <span class="food-price"
                                  style="font-size: 1.25rem; font-weight: 700; color: var(--primary-color);">
                                Rs. <c:out value="${food.price}" />
                            </span>
                        </div>
                    </a>

                        <%--  ADD THIS: Edit button — only admin sees it --%>
                    <% if (loggedInUser != null && "admin".equals(loggedInUser.getRole())) { %>
                    <div style="padding: 0 1.5rem 1.5rem; text-align: center;">
                        <a href="${pageContext.request.contextPath}/food?action=edit&id=${food.foodId}"
                           style="display: inline-block; padding: 0.4rem 1.2rem;
                                      border: 2px solid #e63946; color: #e63946;
                                      border-radius: 6px; font-size: 0.85rem;
                                      font-weight: 600; text-decoration: none;">
                            Edit
                        </a>
                    </div>
                    <% } %>

                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!--
     FOOTER SECTION
     This is the dark bottom area of the website.
     It contains contact info and social media links.
     -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats"
                     style="height: 35px; margin-right: 10px;"> Ridkk's Eats
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
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="contact-list">
                <li> Pokhara -17, Birauta</li>
                <li> +977 9845342311</li>
                <li> ridkk'seats@gmail.com</li>
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
        <p>&copy; 2026 Ridkk's Eats. All rights reserved.</p>
    </div>
</footer>

<script>
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