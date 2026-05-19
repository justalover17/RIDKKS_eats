<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coursework.entity.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
    if (users == null) {
        users = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | Ridkk's Eats</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <style>
        .page-wrapper { max-width: 1200px; margin: 0 auto; padding: 4rem 2rem; min-height: 65vh; }
        .page-title { text-align: center; margin-bottom: 2.5rem; }
        .page-title h1 { font-size: 3rem; margin-bottom: .5rem; }
        .page-title p { color: var(--text-muted); }
        .admin-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.2rem; gap: 1rem; flex-wrap: wrap; }
        .table-card { background: var(--white); border: 1px solid var(--border-color); border-radius: 16px; box-shadow: var(--shadow-sm); overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 850px; }
        th, td { padding: 1rem; text-align: left; border-bottom: 1px solid var(--border-color); }
        th { background: #f7f7f7; color: var(--text-muted); font-weight: 600; font-size: .9rem; }
        tr:last-child td { border-bottom: none; }
        .role-badge { display: inline-block; padding: .35rem .75rem; border-radius: 20px; background: #eef2ff; color: #3730a3; font-size: .82rem; font-weight: 700; text-transform: capitalize; }
        .role-badge.admin { background: #fff3cd; color: #856404; }
        .action-link { color: var(--primary-color); font-weight: 600; margin-right: .8rem; }
        .delete-link { color: #dc3545; font-weight: 600; }
        .muted { color: var(--text-muted); }
        @media (max-width: 700px) { .page-title h1 { font-size: 2.2rem; } }
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
            <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Menu</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
        </div>
    </div>
</header>

<main class="page-wrapper">
    <section class="page-title">
        <h1>Manage Users</h1>
        <p>View, edit, and remove customer/admin accounts.</p>
    </section>

    <div class="admin-actions">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-login">← Back to Dashboard</a>
        <span class="muted">Total Users: <%= users.size() %></span>
    </div>

    <div class="table-card">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Created</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% if (users.isEmpty()) { %>
            <tr><td colspan="7">No users found.</td></tr>
            <% } else { %>
            <% for (User user : users) { %>
            <tr>
                <td>#<%= user.getUserId() %></td>
                <td><%= user.getName() != null ? user.getName() : "-" %></td>
                <td><%= user.getEmail() != null ? user.getEmail() : "-" %></td>
                <td><%= user.getPhone() != null && !user.getPhone().isEmpty() ? user.getPhone() : "-" %></td>
                <td><span class="role-badge <%= "admin".equalsIgnoreCase(user.getRole()) ? "admin" : "" %>"><%= user.getRole() != null ? user.getRole() : "customer" %></span></td>
                <td><%= user.getCreatedAt() != null ? user.getCreatedAt() : "-" %></td>
                <td>
                    <a class="action-link" href="${pageContext.request.contextPath}/user?action=edit&id=<%= user.getUserId() %>">Edit</a>
                    <% if (loggedInUser == null || loggedInUser.getUserId() != user.getUserId()) { %>
                    <a class="delete-link" href="${pageContext.request.contextPath}/user?action=delete&id=<%= user.getUserId() %>" onclick="return confirm('Delete this user?')">Delete</a>
                    <% } else { %>
                    <span class="muted">Current account</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
            <% } %>
            </tbody>
        </table>
    </div>
</main>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-col brand-col">
            <div class="footer-logo"><img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;"> Ridkk's Eats</div>
            <div class="brand-desc-box"><p>Admin management panel for Ridkk's Eats.</p></div>
        </div>
        <div class="footer-col"><h4>Quick Links</h4><ul><li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li><li><a href="${pageContext.request.contextPath}/food">Menu</a></li></ul></div>
        <div class="footer-col"><h4>Contact Info</h4><ul class="contact-list"><li>Pokhara -17, Birauta</li><li>+977 9845342311</li><li>ridkk'seats@gmail.com</li></ul></div>
    </div>
    <div class="footer-bottom"><p>&copy; 2026 Ridkk's Eats. All rights reserved.</p></div>
</footer>
</body>
</html>
