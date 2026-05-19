<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coursework.entity.User" %>
<%@ page import="com.coursework.entity.FoodItem" %>
<%@ page import="com.coursework.entity.Orders" %>

<%
    User loggedInUser = (User) session.getAttribute("user");

    int totalFoodItems = request.getAttribute("totalFoodItems") != null
            ? (Integer) request.getAttribute("totalFoodItems") : 0;

    int totalCategories = request.getAttribute("totalCategories") != null
            ? (Integer) request.getAttribute("totalCategories") : 0;

    int totalOrders = request.getAttribute("totalOrders") != null
            ? (Integer) request.getAttribute("totalOrders") : 0;

    int ordersToday = request.getAttribute("ordersToday") != null
            ? (Integer) request.getAttribute("ordersToday") : 0;

    double totalRevenue = request.getAttribute("totalRevenue") != null
            ? (Double) request.getAttribute("totalRevenue") : 0;

    ArrayList<FoodItem> recentFoods =
            (ArrayList<FoodItem>) request.getAttribute("recentFoods");

    ArrayList<Orders> recentOrders =
            (ArrayList<Orders>) request.getAttribute("recentOrders");

    ArrayList<String> dates =
            (ArrayList<String>) request.getAttribute("dates");

    ArrayList<Integer> counts =
            (ArrayList<Integer>) request.getAttribute("counts");

    if (recentFoods == null) {
        recentFoods = new ArrayList<>();
    }

    if (recentOrders == null) {
        recentOrders = new ArrayList<>();
    }

    if (dates == null) {
        dates = new ArrayList<>();
    }

    if (counts == null) {
        counts = new ArrayList<>();
    }

    StringBuilder dateLabels = new StringBuilder();

    for (int i = 0; i < dates.size(); i++) {
        dateLabels.append("'").append(dates.get(i)).append("'");

        if (i < dates.size() - 1) {
            dateLabels.append(",");
        }
    }

    StringBuilder countValues = new StringBuilder();

    for (int i = 0; i < counts.size(); i++) {
        countValues.append(counts.get(i));

        if (i < counts.size() - 1) {
            countValues.append(",");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Ridkk's Eats</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .dashboard-wrapper {
            max-width: 1280px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }

        .dashboard-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .dashboard-title h1 {
            font-family: var(--font-heading);
            font-size: 3rem;
            color: var(--dark-bg);
            margin-bottom: 0.5rem;
        }

        .dashboard-title p {
            color: var(--text-muted);
            font-size: 1.05rem;
        }

        .dashboard-kpi-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .dashboard-card {
            background: var(--white);
            border-radius: 14px;
            padding: 1.8rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            transition: var(--transition);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .dashboard-card h3 {
            font-family: var(--font-body);
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 0.8rem;
        }

        .dashboard-card .number {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .revenue-box {
            background: var(--dark-bg);
            color: var(--white);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .revenue-box h3 {
            color: var(--white);
            font-family: var(--font-body);
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }

        .revenue-box .amount {
            color: var(--gold);
            font-size: 2.2rem;
            font-weight: 700;
        }

        .dashboard-data-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .dashboard-panel {
            background: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1.8rem;
            box-shadow: var(--shadow-sm);
        }

        .dashboard-panel h2 {
            font-family: var(--font-heading);
            color: var(--dark-bg);
            font-size: 1.5rem;
            margin-bottom: 1.2rem;
        }

        .dashboard-table {
            width: 100%;
            border-collapse: collapse;
        }

        .dashboard-table th {
            background: #f7f7f7;
            color: var(--text-muted);
            text-align: left;
            padding: 0.9rem;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .dashboard-table td {
            padding: 0.9rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.95rem;
        }

        .dashboard-table tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            display: inline-block;
            padding: 0.35rem 0.7rem;
            border-radius: 20px;
            background: #fff3cd;
            color: #856404;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .chart-panel {
            background: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1.8rem;
            box-shadow: var(--shadow-sm);
        }

        .chart-panel h2 {
            font-family: var(--font-heading);
            color: var(--dark-bg);
            font-size: 1.5rem;
            margin-bottom: 1.2rem;
        }

        .chart-wrapper {
            height: 360px;
        }

        @media (max-width: 1000px) {
            .dashboard-kpi-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .dashboard-data-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 600px) {
            .dashboard-kpi-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-title h1 {
                font-size: 2.3rem;
            }

            .revenue-box {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.7rem;
            }
        }
    </style>
</head>

<body>

<!-- HEADER SAME AS HOME -->
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
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                    </svg>
                </button>

                <div class="profile-dropdown-container" style="position: relative; display: inline-block;">
                    <button class="icon-btn" title="My Profile" onclick="toggleProfileDropdown()">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </button>

                    <div id="profileDropdown" class="profile-dropdown" style="display: none; position: absolute; right: -50px; top: 120%; background: white; border: 1px solid #ddd; padding: 15px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 150px; text-align: center; z-index: 100;">
                        <div style="font-size: 12px; color: #888; margin-bottom: 5px; text-transform: uppercase; font-weight: bold;">My Profile</div>

                        <div style="font-weight: 600; margin-bottom: 10px; color: #333;">
                            <%= (loggedInUser.getRole() != null && loggedInUser.getRole().equalsIgnoreCase("admin")) ? "Admin" : loggedInUser.getName() %>
                        </div>

                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary" style="display: block; width: 100%; padding: 8px 0; font-size: 14px;">Logout</a>
                    </div>
                </div>

                <% if (loggedInUser.getRole() != null && loggedInUser.getRole().equalsIgnoreCase("admin")) { %>
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

<!-- ONLY DASHBOARD MIDDLE CONTENT -->
<main class="dashboard-wrapper">

    <section class="dashboard-title">
        <h1>Admin Dashboard</h1>
        <p>Overview of food items, orders and revenue in Ridkk's Eats.</p>
    </section>

    <section class="dashboard-kpi-grid">

        <div class="dashboard-card">
            <h3>Total Food Items</h3>
            <div class="number"><%= totalFoodItems %></div>
        </div>

        <div class="dashboard-card">
            <h3>Total Categories</h3>
            <div class="number"><%= totalCategories %></div>
        </div>

        <div class="dashboard-card">
            <h3>Total Orders</h3>
            <div class="number"><%= totalOrders %></div>
        </div>

        <div class="dashboard-card">
            <h3>Orders Today</h3>
            <div class="number"><%= ordersToday %></div>
        </div>

    </section>

    <section class="revenue-box">
        <div>
            <h3>Total Revenue</h3>
            <div class="amount">Rs. <%= String.format("%.2f", totalRevenue) %></div>
        </div>

        <div>
            Sales Summary
        </div>
    </section>

    <section class="dashboard-data-grid">

        <div class="dashboard-panel">
            <h2>Recent Food Items</h2>

            <table class="dashboard-table">
                <thead>
                <tr>
                    <th>Food Name</th>
                    <th>Price</th>
                </tr>
                </thead>

                <tbody>
                <% if (recentFoods.isEmpty()) { %>
                <tr>
                    <td colspan="2">No food items found.</td>
                </tr>
                <% } else {
                    for (FoodItem food : recentFoods) {
                %>
                <tr>
                    <td><%= food.getName() %></td>
                    <td>Rs. <%= food.getPrice() %></td>
                </tr>
                <% }} %>
                </tbody>
            </table>
        </div>

        <div class="dashboard-panel">
            <h2>Recent Orders</h2>

            <table class="dashboard-table">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Total</th>
                    <th>Status</th>
                </tr>
                </thead>

                <tbody>
                <% if (recentOrders.isEmpty()) { %>
                <tr>
                    <td colspan="3">No orders found.</td>
                </tr>
                <% } else {
                    for (Orders order : recentOrders) {
                %>
                <tr>
                    <td>#<%= order.getOrderId() %></td>
                    <td>Rs. <%= order.getTotalAmount() %></td>
                    <td><span class="status-badge"><%= order.getStatus() %></span></td>
                </tr>
                <% }} %>
                </tbody>
            </table>
        </div>

    </section>

    <section class="chart-panel">
        <h2>Orders in Last 7 Days</h2>

        <div class="chart-wrapper">
            <canvas id="orderChart"></canvas>
        </div>
    </section>

</main>

<!-- FOOTER SAME AS HOME -->
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
                    <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"></path>
                    </svg>
                    Facebook
                </a>

                <a href="#" class="social-icon">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                        <path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37z"></path>
                        <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                    </svg>
                    Instagram
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

        if (dropdown) {
            dropdown.style.display =
                (dropdown.style.display === 'none' || dropdown.style.display === '')
                    ? 'block'
                    : 'none';
        }
    }

    window.addEventListener('click', function(e) {
        const container = document.querySelector('.profile-dropdown-container');

        if (container && !container.contains(e.target)) {
            const dropdown = document.getElementById('profileDropdown');

            if (dropdown) {
                dropdown.style.display = 'none';
            }
        }
    });

    const labels = [<%= dateLabels.toString() %>];
    const dataValues = [<%= countValues.toString() %>];

    const ctx = document.getElementById('orderChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Orders',
                data: dataValues,
                backgroundColor: '#e63946',
                borderColor: '#d62828',
                borderWidth: 1,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,

            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
</script>

</body>
</html>