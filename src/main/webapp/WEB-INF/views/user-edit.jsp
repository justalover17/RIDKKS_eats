<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.coursework.entity.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <style>
        .page-wrapper { max-width: 760px; margin: 0 auto; padding: 4rem 2rem; min-height: 65vh; }
        .page-title { text-align: center; margin-bottom: 2.5rem; }
        .page-title h1 { font-size: 3rem; margin-bottom: .5rem; }
        .page-title p { color: var(--text-muted); }
        .form-card { background: var(--white); border: 1px solid var(--border-color); border-radius: 18px; padding: 2rem; box-shadow: var(--shadow-sm); }
        .field { margin-bottom: 1.2rem; }
        .field label { display: block; font-weight: 600; margin-bottom: .45rem; color: var(--text-main); }
        .field input, .field select { width: 100%; padding: .9rem 1rem; border: 1px solid var(--border-color); border-radius: 10px; font-family: var(--font-body); font-size: 1rem; outline: none; }
        .field input:focus, .field select:focus { border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(230,57,70,.12); }
        .form-actions { display: flex; gap: 1rem; margin-top: 1.5rem; flex-wrap: wrap; }
        .note { background: #fff3cd; color: #856404; border-radius: 12px; padding: 1rem; margin-bottom: 1.2rem; font-size: .92rem; }
        @media (max-width: 700px) { .page-title h1 { font-size: 2.2rem; } .form-card { padding: 1.4rem; } }
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
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-login">Dashboard</a>
            <a href="${pageContext.request.contextPath}/user?action=list" class="btn btn-primary">Users</a>
        </div>
    </div>
</header>

<main class="page-wrapper">
    <% if (user != null) { %>
    <section class="page-title">
        <h1>Edit User</h1>
        <p>Update account details without changing the password.</p>
    </section>

    <div class="form-card">
        <div class="note">Password is not changed from this form. This prevents accidental empty-password login problems.</div>

        <form method="post" action="${pageContext.request.contextPath}/user">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= user.getUserId() %>">

            <div class="field">
                <label>Name</label>
                <input type="text" name="name" value="<%= user.getName() != null ? user.getName() : "" %>" required>
            </div>

            <div class="field">
                <label>Email</label>
                <input type="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
            </div>

            <div class="field">
                <label>Phone</label>
                <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
            </div>

            <div class="field">
                <label>Role</label>
                <select name="role">
                    <option value="customer" <%= "customer".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>Customer</option>
                    <option value="admin" <%= "admin".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>Admin</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <a href="${pageContext.request.contextPath}/user?action=list" class="btn btn-login">Cancel</a>
            </div>
        </form>
    </div>
    <% } else { %>
    <section class="page-title">
        <h1>User Not Found</h1>
        <p>The selected account could not be loaded.</p>
    </section>
    <a href="${pageContext.request.contextPath}/user?action=list" class="btn btn-primary">Back to Users</a>
    <% } %>
</main>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo"><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats</div>
            <div class="brand-desc-box"><p>Admin management panel for Ridkk's Eats.</p></div>
        </div>
        <div class="footer-col"><h4>Quick Links</h4><ul><li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li><li><a href="${pageContext.request.contextPath}/user?action=list">Users</a></li></ul></div>
        <div class="footer-col"><h4>Contact Info</h4><ul class="contact-list"><li>Pokhara -17, Birauta</li><li>+977 9845342311</li><li>ridkk'seats@gmail.com</li></ul></div>
    </div>
    <div class="footer-bottom"><p>&copy; 2026 Ridkk's Eats. All rights reserved.</p></div>
</footer>
</body>
</html>
