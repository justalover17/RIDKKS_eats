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
    <title>Menu | Riddik's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <style>
        .page-header {
            background-color: var(--dark-bg);
            padding: 4rem 2rem;
            text-align: center;
            color: var(--white);
            margin-bottom: 4rem;
        }
        .page-header h1 {
            color: var(--white);
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }
        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1280px;
            margin: 0 auto 4rem auto;
            padding: 0 2rem;
        }
        .food-item-card {
            background: var(--white);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
        }
        .food-item-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }
        .food-item-img {
            height: 200px;
            background-color: #f1f3f5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
        }
        .food-item-content {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .food-item-content h3 {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        .food-item-desc {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            flex-grow: 1;
        }
        .food-item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }
        .food-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        .btn-add {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="header-container">
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Riddik's Eats" style="height: 40px;">
                <span class="logo-text">Riddik's Eats</span>
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

<div class="page-header">
    <h1>Our Full Menu</h1>
    <p>Discover the finest dishes crafted just for you.</p>
</div>

<div class="category-filters" style="text-align: center; margin-bottom: 3rem;">
    <a href="${pageContext.request.contextPath}/food" class="btn btn-login" style="margin: 0 5px;">All</a>
    <a href="${pageContext.request.contextPath}/food?category=1" class="btn btn-login" style="margin: 0 5px;">Nepali</a>
    <a href="${pageContext.request.contextPath}/food?category=2" class="btn btn-login" style="margin: 0 5px;">Italian</a>
    <a href="${pageContext.request.contextPath}/food?category=3" class="btn btn-login" style="margin: 0 5px;">Burgers</a>
    <a href="${pageContext.request.contextPath}/food?category=4" class="btn btn-login" style="margin: 0 5px;">Desserts</a>
</div>

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
                    <a href="${pageContext.request.contextPath}/food?action=view&id=${food.foodId}" style="text-decoration: none; color: inherit; display: flex; flex-direction: column; height: 100%;">
                        <div class="food-item-img" style="overflow: hidden; display: flex; align-items: center; justify-content: center; height: 200px; background-color: #f1f3f5;">
                            <img src="${pageContext.request.contextPath}/static/images/${food.name}.png" alt="${food.name}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='${pageContext.request.contextPath}/static/images/logo.png'">
                        </div>
                        <div class="food-item-content" style="padding: 1.5rem; text-align: center; flex-grow: 1; display: flex; flex-direction: column; justify-content: center;">
                            <h3 style="font-size: 1.25rem; margin-bottom: 0.5rem;"><c:out value="${food.name}" /></h3>
                            <span class="food-price" style="font-size: 1.25rem; font-weight: 700; color: var(--primary-color);">Rs. <c:out value="${food.price}" /></span>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
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
    // Modals Logic for Food List Page
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
        document.body.style.overflow = 'hidden';
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
</script>

</body>
</html>
