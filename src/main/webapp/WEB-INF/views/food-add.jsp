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
    <title>Add Food Item | Riddik's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/food-list.css">
    <style>
        .page-header {
            background-color: var(--dark-bg);
            padding: 4rem 2rem;
            text-align: center;
            color: var(--white);
            margin-bottom: 3rem;
        }
        .page-header h1 {
            color: var(--white);
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }
        .page-header p {
            color: rgba(255,255,255,0.7);
            font-size: 1rem;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto 4rem auto;
            padding: 0 2rem;
        }
        .form-card {
            background: var(--white);
            border-radius: 12px;
            padding: 2.5rem;
            box-shadow: var(--shadow-sm);
        }
        .form-group {
            margin-bottom: 1.25rem;
        }
        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--dark-bg);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: var(--font-body);
            font-size: 1rem;
            color: var(--text-main);
            background-color: #fafafa;
            transition: var(--transition);
            outline: none;
            box-sizing: border-box;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--primary-color);
            background-color: var(--white);
            box-shadow: 0 0 0 3px rgba(230, 57, 70, 0.1);
        }
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        .form-divider {
            height: 1px;
            background: var(--border-color);
            margin: 1.5rem 0;
        }
        .form-actions {
            display: flex;
            gap: 1rem;
        }
        .btn-submit {
            flex: 1;
            padding: 0.8rem 1.5rem;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-family: var(--font-body);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(230, 57, 70, 0.3);
        }
        .btn-submit:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(230, 57, 70, 0.4);
        }
        .btn-cancel {
            flex: 1;
            padding: 0.8rem 1.5rem;
            background: transparent;
            color: var(--text-muted);
            border: 2px solid var(--border-color);
            border-radius: 8px;
            font-family: var(--font-body);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        .btn-cancel:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
    </style>
</head>
<body>

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

<div class="page-header">
    <h1>Add Food Item</h1>
    <p>Fill in the details to add a new item to the menu</p>
</div>

<div class="form-container">
    <div class="form-card">
        <form action="${pageContext.request.contextPath}/food" method="post">
            <input type="hidden" name="action" value="insert" />

            <div class="form-group">
                <label for="name">Item Name</label>
                <input type="text" id="name" name="name"
                       placeholder="e.g. Margherita Pizza" required />
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="price">Price (Rs.)</label>
                    <input type="number" id="price" name="price"
                           step="0.01" min="0" placeholder="0.00" required />
                </div>
                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="" disabled selected>Select one</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description"
                          placeholder="Short description of the dish..."></textarea>
            </div>

            <div class="form-divider"></div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/food?action=list"
                   class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">Add to Menu</button>
            </div>
        </form>
    </div>
</div>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Riddik's Eats
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
                <li>Pokhara -17, Birauta</li>
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

</body>
</html>
