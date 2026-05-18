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
    <title>Register | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/register.css">
</head>
<body>

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

<!--
     REGISTRATION FORM SECTION
     This creates the white box asking for the user's details
     like their First Name, Last Name, Email, and Password.
     -->
<div class="auth-page">
    <div class="auth-card">
        <div class="auth-header">
            <a href="${pageContext.request.contextPath}/index.jsp">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats">
            </a>
            <h2>Create an Account</h2>
            <p style="color: var(--text-muted); margin-top:0.5rem;">Join us for fine delivery</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <!-- This form securely sends the new user data to the server -->
        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" required>
                </div>
            </div>

            <input type="hidden" id="combinedName" name="name">

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
                <div id="emailError" style="color: #e63946; font-size: 0.85rem; margin-top: 5px; display: none;"></div>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" required>
                <div id="phoneError" style="color: #e63946; font-size: 0.85rem; margin-top: 5px; display: none;"></div>
            </div>

            <div class="form-group">
                <label for="regPassword">Password</label>
                <input type="password" id="regPassword" name="password" required>
                <div id="passError" style="color: #e63946; font-size: 0.85rem; margin-top: 5px; display: none;"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" required>
                <div id="confirmError" style="color: #e63946; font-size: 0.85rem; margin-top: 5px; display: none;"></div>
            </div>

            <button type="submit" class="btn btn-primary btn-full">Create Account</button>
        </form>

        <div class="auth-footer">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
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

<!--
     JAVASCRIPT SECTION
     This code runs on the user's computer to check if the
     two passwords match BEFORE sending data to the server.
     -->
<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        let hasError = false;

        // Clear all previous errors
        document.getElementById('emailError').style.display = 'none';
        document.getElementById('phoneError').style.display = 'none';
        document.getElementById('passError').style.display = 'none';
        document.getElementById('confirmError').style.display = 'none';

        const email = document.getElementById('email').value;
        if(!email.includes('@gmail.com')) {
            const err = document.getElementById('emailError');
            err.innerText = "Email must contain @gmail.com";
            err.style.display = 'block';
            hasError = true;
        }

        const phone = document.getElementById('phone').value;
        if(!/^98\d{8}$/.test(phone)) {
            const err = document.getElementById('phoneError');
            err.innerText = "Phone number must be exactly 10 digits and start with 98";
            err.style.display = 'block';
            hasError = true;
        }

        const pass = document.getElementById('regPassword').value;
        const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$/;
        if(!passRegex.test(pass)) {
            const err = document.getElementById('passError');
            err.innerText = "Password must contain at least one uppercase letter, one lowercase letter, one number, and one symbol.";
            err.style.display = 'block';
            hasError = true;
        }

        const confirm = document.getElementById('confirmPassword').value;
        if(pass !== confirm) {
            const err = document.getElementById('confirmError');
            err.innerText = "Passwords do not match!";
            err.style.display = 'block';
            hasError = true;
        }

        if(hasError) {
            e.preventDefault();
            return;
        }

        const firstName = document.getElementById('firstName').value.trim();
        const lastName = document.getElementById('lastName').value.trim();
        document.getElementById('combinedName').value = firstName + " " + lastName;
    });
</script>

</body>
</html>
