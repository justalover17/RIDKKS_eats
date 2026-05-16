<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.coursework.entity.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridkk's Eats | Fine Delivery</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
</head>
<body>

<!--
     HEADER SECTION
     This is the top navigation bar. It shows the logo on the left
     and the user Profile/Cart buttons on the right.
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
     HOME BANNER SECTION
     This is the large image at the top of the homepage.
     It contains the big title and the search bar.
     -->
<section class="home" id="homeSection">
    <div class="home-bg" id="homeBg" style="background-image: url('${pageContext.request.contextPath}/static/images/Home%20page.png');"></div>
    <div class="home-content">
        <h1>Find your perfect meal.</h1>
        <p>Search your favorite cuisine</p>
        <form class="search-bar-container" action="${pageContext.request.contextPath}/food" method="get">
            <input type="text" name="search" class="search-input" id="homeSearchInput" placeholder="e.g. Momo, Pizza, Burgers...">
            <button type="submit" class="search-btn">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </button>
        </form>
    </div>
</section>

<!--
     CUISINE GRID SECTION
     This draws the 8 boxes showing the popular food items.
     Each box is a link that takes the user to the details page.
     -->
<section class="cuisine-section">
    <div class="section-header">
        <h2>Popular Cuisine</h2>
        <p class="sub-header">Crowd favorite at Ridkk's Eats</p>
    </div>

    <div class="cuisine-grid">
        <!-- 8 Grid Items Using Local Images -->
        <a href="${pageContext.request.contextPath}/food?action=view&id=1" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Burger.png');"></div>
            <div class="card-info"><h3>Burger</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=26" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Pizza.png');"></div>
            <div class="card-info"><h3>Pizza</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=11" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Ridkks%20Breakfast.png');"></div>
            <div class="card-info"><h3>Ridkk's Breakfast</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=27" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Spaghetti.png');"></div>
            <div class="card-info"><h3>Spaghetti</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=12" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Vanilla%20%20Waffle.png');"></div>
            <div class="card-info"><h3>Vanilla Waffle</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=10" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Club%20sandwich.png');"></div>
            <div class="card-info"><h3>Club Sandwich</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=9" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Pad%20thai.png');"></div>
            <div class="card-info"><h3>Pad Thai</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=28" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Sirloin%20steak.png');"></div>
            <div class="card-info"><h3>Sirloin Steak</h3></div>
        </a>
    </div>

    <div class="menu-btn-container">
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">View Full Menu</a>
    </div>
</section>

<!--
     FOOTER SECTION
     This is the dark bottom area with contact details.
     -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats
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
                <li>+977 9845342311</li>
                <li>ridkk'seats@gmail.com</li>
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
