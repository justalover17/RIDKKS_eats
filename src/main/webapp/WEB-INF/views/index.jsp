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
    <title>Riddik's Eats | Fine Delivery</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
</head>
<body>

<!-- Header -->
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
            <button class="btn btn-login" id="headerLoginBtn">Login</button>
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

<!-- Home Section -->
<section class="home" id="homeSection">
    <div class="home-bg" id="homeBg" style="background-image: url('${pageContext.request.contextPath}/static/images/Home%20page.png');"></div>
    <div class="home-content">
        <h1>Find your perfect meal.</h1>
        <p>Search your favorite cuisine</p>
        <form class="search-bar-container" action="${pageContext.request.contextPath}/food" method="get">
            <input type="text" name="query" class="search-input" id="homeSearchInput" placeholder="e.g. Momo, Pizza, Burgers...">
            <button type="submit" class="search-btn">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </button>
        </form>
    </div>
</section>

<!-- Cuisine Grid Section -->
<section class="cuisine-section">
    <div class="section-header">
        <h2>Popular Cuisine</h2>
        <p class="sub-header">Crowd favorite at Riddik's Eats</p>
    </div>

    <div class="cuisine-grid">
        <!-- 8 Grid Items Using Local Images -->
        <a href="${pageContext.request.contextPath}/food?action=view&id=1" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Chicken%20Momo.png');"></div>
            <div class="card-info"><h3>Chicken Momo</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=2" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Pizza.png');"></div>
            <div class="card-info"><h3>Pizza</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=3" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Riddiks%20Breakfast.png');"></div>
            <div class="card-info"><h3>Riddik's Breakfast</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=4" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Spaghetti.png');"></div>
            <div class="card-info"><h3>Spaghetti</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=5" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Vanilla%20%20Waffle.png');"></div>
            <div class="card-info"><h3>Vanilla Waffle</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=6" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/club%20sandwich.png');"></div>
            <div class="card-info"><h3>Club Sandwich</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=7" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/pad%20thai.png');"></div>
            <div class="card-info"><h3>Pad Thai</h3></div>
        </a>
        <a href="${pageContext.request.contextPath}/food?action=view&id=8" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/sirloin%20steak.png');"></div>
            <div class="card-info"><h3>Sirloin Steak</h3></div>
        </a>
    </div>

    <div class="menu-btn-container">
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">View Full Menu</a>
    </div>
</section>

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
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="contact-list">
                <li> Pokhara -17, Birauta</li>
                <li>+977 9845342311</li>
                <li>riddik'seats@gmail.com</li>
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

<!-- Modals -->
<div class="modal-overlay" id="modalOverlay"></div>

<jsp:include page="/WEB-INF/views/login.jsp" />
<jsp:include page="/WEB-INF/views/register.jsp" />

<script>
    // Search Bar Hover Interaction for Home Background
    const searchInput = document.getElementById('homeSearchInput');
    const homeBg = document.getElementById('homeBg');

    if(searchInput && homeBg) {
        searchInput.addEventListener('focus', () => {
            homeBg.classList.add('focused');
        });
        searchInput.addEventListener('blur', () => {
            homeBg.classList.remove('focused');
        });
    }

    // Modals Logic
    const overlay = document.getElementById('modalOverlay');
    const loginModal = document.getElementById('loginModal');
    const registerModal = document.getElementById('registerModal');

    const loginBtn = document.getElementById('headerLoginBtn');
    const closeBtns = document.querySelectorAll('.close-btn');

    const toRegister = document.getElementById('toRegister');
    const toLogin = document.getElementById('toLogin');

    function openModal(modal) {
        if(!modal) return;
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden'; // prevent background scrolling
        // Close all first
        if(loginModal) loginModal.classList.remove('active');
        if(registerModal) registerModal.classList.remove('active');
        modal.classList.add('active');
    }

    function closeModal() {
        if(overlay) overlay.classList.remove('active');
        if(loginModal) loginModal.classList.remove('active');
        if(registerModal) registerModal.classList.remove('active');
        document.body.style.overflow = '';
    }

    if(loginBtn) {
        loginBtn.addEventListener('click', () => openModal(loginModal));
    }

    closeBtns.forEach(btn => {
        btn.addEventListener('click', closeModal);
    });

    if(overlay) overlay.addEventListener('click', closeModal);

    if(toRegister) {
        toRegister.addEventListener('click', (e) => {
            e.preventDefault();
            openModal(registerModal);
        });
    }

    if(toLogin) {
        toLogin.addEventListener('click', (e) => {
            e.preventDefault();
            openModal(loginModal);
        });
    }

    // Register Form Interceptor
    const registerForm = document.getElementById('registerForm');
    if(registerForm) {
        registerForm.addEventListener('submit', function(e) {
            const pass = document.getElementById('regPassword').value;
            const confirm = document.getElementById('confirmPassword').value;

            if(pass !== confirm) {
                e.preventDefault();
                alert("Passwords do not match!");
                return;
            }

            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();
            document.getElementById('combinedName').value = firstName + " " + lastName;
        });
    }

    // URL Parameter Handling for Login/Register Errors and Success
    const urlParams = new URLSearchParams(window.location.search);
    if(urlParams.has('loginError')) {
        const errMsg = document.getElementById('loginErrorMsg');
        if(errMsg) {
            errMsg.textContent = "Invalid email or password!";
            errMsg.style.display = 'block';
        }
        openModal(loginModal);
    }
    if(urlParams.has('registerError')) {
        const errMsg = document.getElementById('registerErrorMsg');
        if(errMsg) {
            errMsg.textContent = "Registration failed or email already exists.";
            errMsg.style.display = 'block';
        }
        openModal(registerModal);
    }
    if(urlParams.has('loginOpen')) {
        alert("Registered successfully! Please login.");
        openModal(loginModal);
    }
</script>

</body>
</html>