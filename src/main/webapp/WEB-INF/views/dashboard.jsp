<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coursework.entity.FoodItem" %>
<%@ page import="com.coursework.entity.Orders" %>

<%
    int totalFoodItems = request.getAttribute("totalFoodItems") != null ? (Integer) request.getAttribute("totalFoodItems") : 0;
    int totalCategories = request.getAttribute("totalCategories") != null ? (Integer) request.getAttribute("totalCategories") : 0;
    int totalOrders = request.getAttribute("totalOrders") != null ? (Integer) request.getAttribute("totalOrders") : 0;
    int ordersToday = request.getAttribute("ordersToday") != null ? (Integer) request.getAttribute("ordersToday") : 0;
    double totalRevenue = request.getAttribute("totalRevenue") != null ? (Double) request.getAttribute("totalRevenue") : 0;

    ArrayList<FoodItem> recentFoods = (ArrayList<FoodItem>) request.getAttribute("recentFoods");
    ArrayList<Orders> recentOrders = (ArrayList<Orders>) request.getAttribute("recentOrders");

    if (recentFoods == null) recentFoods = new ArrayList<>();
    if (recentOrders == null) recentOrders = new ArrayList<>();

    request.setAttribute("pageTitle", "Dashboard | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/dashboard.css");
%>

<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="dashboard-page">
    <section class="dashboard-title">
        <h1>Admin Dashboard</h1>
        <p>Overview of food items, orders and revenue in Ridkk's Eats.</p>
    </section>

    <section style="display:flex; justify-content:center; gap:1rem; flex-wrap:wrap; margin-bottom:2rem;">
        <a href="${pageContext.request.contextPath}/food?action=add" class="btn btn-primary">Add Food</a>
        <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Manage Food</a>
        <a href="${pageContext.request.contextPath}/user?action=list" class="btn btn-login">Manage Users</a>
        <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-login">Order History</a>
    </section>

    <section class="kpi-grid">
        <div class="kpi-card">
            <h3>Total Food Items</h3>
            <div class="metric"><%= totalFoodItems %></div>
        </div>

        <div class="kpi-card">
            <h3>Total Categories</h3>
            <div class="metric"><%= totalCategories %></div>
        </div>

        <div class="kpi-card">
            <h3>Total Orders</h3>
            <div class="metric"><%= totalOrders %></div>
        </div>

        <div class="kpi-card">
            <h3>Orders Today</h3>
            <div class="metric"><%= ordersToday %></div>
        </div>
    </section>

    <section class="revenue-card">
        <h3>Total Revenue</h3>
        <p>Rs. <%= String.format("%.2f", totalRevenue) %></p>
    </section>

    <section class="dashboard-grid">
        <div class="dashboard-box">
            <h3>Recent Food Items</h3>

            <table>
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
                <% } else { %>
                <% for (FoodItem food : recentFoods) { %>
                <tr>
                    <td><%= food.getName() %></td>
                    <td>Rs. <%= food.getPrice() %></td>
                </tr>
                <% } %>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="dashboard-box">
            <h3>Recent Orders</h3>

            <table>
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
                <% } else { %>
                <% for (Orders order : recentOrders) { %>
                <tr>
                    <td>#<%= order.getOrderId() %></td>
                    <td>Rs. <%= order.getTotalAmount() %></td>
                    <td><%= order.getStatus() %></td>
                </tr>
                <% } %>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <section class="chart-container">
        <h3>System Overview Chart</h3>

        <p style="color:#777; margin-top:0.4rem; margin-bottom:1rem;">
            This chart compares the main parts of the system such as food items, categories, total orders and today's orders.
        </p>

        <div class="chart-wrapper">
            <canvas id="overviewChart"></canvas>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const overviewCtx = document.getElementById('overviewChart');

    if (overviewCtx) {
        new Chart(overviewCtx, {
            type: 'bar',
            data: {
                labels: ['Food Items', 'Categories', 'Total Orders', "Today's Orders"],
                datasets: [{
                    label: 'System Count',
                    data: [
                        <%= totalFoodItems %>,
                        <%= totalCategories %>,
                        <%= totalOrders %>,
                        <%= ordersToday %>
                    ],
                    backgroundColor: [
                        '#e63946',
                        '#f77f00',
                        '#457b9d',
                        '#2a9d8f'
                    ],
                    borderColor: [
                        '#d62828',
                        '#cc6b00',
                        '#35647d',
                        '#21867a'
                    ],
                    borderWidth: 1,
                    borderRadius: 10,
                    barThickness: 70
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,

                plugins: {
                    legend: {
                        display: false
                    },

                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.label + ': ' + context.raw;
                            }
                        }
                    }
                },

                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        },
                        title: {
                            display: true,
                            text: 'Count'
                        }
                    },

                    x: {
                        title: {
                            display: true,
                            text: 'Dashboard Areas'
                        }
                    }
                }
            }
        });
    }
</script>

</body>
</html>