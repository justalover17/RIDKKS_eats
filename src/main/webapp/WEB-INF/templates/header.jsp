<%@ page import="com.coursework.entity.User" %>
<%
    User templateUser = (User) session.getAttribute("user");
    boolean templateAdmin = templateUser != null
            && templateUser.getRole() != null
            && templateUser.getRole().equalsIgnoreCase("admin");
%>

<header class="header">
    <div class="header-container">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/home" class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 40px;">
                <span class="logo-text">Ridkk's Eats</span>
            </a>
        </div>

        <div class="header-right">
            <% if (templateUser == null) { %>
            <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Menu</a>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
            <% } else { %>
            <div class="user-icons">
                <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Menu</a>

                <button class="icon-btn" type="button" title="Notifications">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                    </svg>
                </button>

                <div class="profile-dropdown-container" style="position: relative; display: inline-block;">
                    <button class="icon-btn" type="button" title="My Profile" onclick="toggleProfileDropdown()">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </button>

                    <div id="profileDropdown" class="profile-dropdown" style="display: none; position: absolute; right: -50px; top: 120%; background: white; border: 1px solid #ddd; padding: 15px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 165px; text-align: center; z-index: 1000;">
                        <div style="font-size: 12px; color: #888; margin-bottom: 5px; text-transform: uppercase; font-weight: bold;">My Profile</div>

                        <div style="font-weight: 600; margin-bottom: 10px; color: #333;">
                            <%= templateAdmin ? "Admin" : templateUser.getName() %>
                        </div>

                        <a href="${pageContext.request.contextPath}/order?action=history" style="display:block; margin-bottom:8px; font-size:13px; color:#333;">Orders</a>

                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary" style="display: block; width: 100%; padding: 8px 0; font-size: 14px;">Logout</a>
                    </div>
                </div>

                <% if (templateAdmin) { %>
                <a href="${pageContext.request.contextPath}/dashboard" class="icon-btn" title="Dashboard">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <rect x="3" y="3" width="7" height="7"></rect>
                        <rect x="14" y="3" width="7" height="7"></rect>
                        <rect x="14" y="14" width="7" height="7"></rect>
                        <rect x="3" y="14" width="7" height="7"></rect>
                    </svg>
                </a>
                <% } %>

                <a href="${pageContext.request.contextPath}/cart?action=view" class="icon-btn" title="Cart">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <circle cx="9" cy="21" r="1"></circle>
                        <circle cx="20" cy="21" r="1"></circle>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                    </svg>
                </a>
            </div>
            <% } %>
        </div>
    </div>
</header>