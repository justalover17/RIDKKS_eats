<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridkk's Eats — Menu</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400&family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --ink: #1a1209;
            --paper: #faf6ef;
            --cream: #f2ead8;
            --gold: #c9952a;
            --gold-light: #e8c46a;
            --gold-dim: rgba(201,149,42,0.12);
            --rust: #c0432a;
            --rust-dim: rgba(192,67,42,0.1);
            --muted: #8a7d6a;
            --border: #e0d5c0;
            --radius: 8px;
        }

        body {
            background: var(--paper);
            color: var(--ink);
            font-family: 'Outfit', sans-serif;
            min-height: 100vh;
        }

        /* Grain texture overlay */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 100;
        }

        /* Top banner */
        .top-bar {
            background: var(--ink);
            color: var(--gold-light);
            text-align: center;
            padding: 0.5rem;
            font-size: 0.7rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
        }

        /* Nav */
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.25rem 3rem;
            border-bottom: 1px solid var(--border);
            background: var(--paper);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .nav-logo {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--ink);
            text-decoration: none;
            letter-spacing: -0.02em;
        }

        .nav-logo span { color: var(--gold); }

        .nav-right { display: flex; align-items: center; gap: 1rem; }

        .btn {
            padding: 0.55rem 1.25rem;
            border-radius: var(--radius);
            font-family: 'Outfit', sans-serif;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            letter-spacing: 0.02em;
        }

        .btn-primary {
            background: var(--ink);
            color: var(--gold-light);
        }
        .btn-primary:hover { background: #2d1f0a; transform: translateY(-1px); }

        .btn-sm {
            padding: 0.3rem 0.75rem;
            font-size: 0.78rem;
            border-radius: 5px;
        }

        .btn-edit {
            background: var(--gold-dim);
            color: var(--gold);
            border: 1px solid rgba(201,149,42,0.25);
        }
        .btn-edit:hover { background: rgba(201,149,42,0.2); }

        .btn-delete {
            background: var(--rust-dim);
            color: var(--rust);
            border: 1px solid rgba(192,67,42,0.2);
        }
        .btn-delete:hover { background: rgba(192,67,42,0.18); }

        /* Hero section */
        .hero {
            padding: 3.5rem 3rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            border-bottom: 1px solid var(--border);
        }

        .hero-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 3.5rem;
            font-weight: 600;
            line-height: 1;
            letter-spacing: -0.03em;
            color: var(--ink);
        }

        .hero-title em {
            font-style: italic;
            color: var(--gold);
        }

        .hero-sub {
            color: var(--muted);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        /* Stats bar */
        .stats-bar {
            display: flex;
            gap: 2rem;
            padding: 1.25rem 3rem;
            border-bottom: 1px solid var(--border);
            background: var(--cream);
        }

        .stat { display: flex; flex-direction: column; }
        .stat-num { font-size: 1.4rem; font-weight: 600; color: var(--ink); font-family: 'Cormorant Garamond', serif; }
        .stat-label { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--muted); }

        /* Main content */
        .content { padding: 2rem 3rem; }

        /* Table */
        .table-wrap {
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 20px rgba(26,18,9,0.06);
        }

        table { width: 100%; border-collapse: collapse; }

        thead { background: var(--ink); }

        th {
            padding: 0.9rem 1.25rem;
            text-align: left;
            font-size: 0.7rem;
            font-weight: 500;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--gold-light);
        }

        td {
            padding: 1rem 1.25rem;
            border-top: 1px solid var(--border);
            font-size: 0.9rem;
            vertical-align: middle;
            background: var(--paper);
        }

        tr:hover td { background: var(--cream); transition: background 0.15s; }

        .food-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--ink);
        }

        .food-desc {
            font-size: 0.78rem;
            color: var(--muted);
            margin-top: 0.15rem;
            max-width: 280px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .price-tag {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.15rem;
            font-weight: 600;
            color: var(--gold);
        }

        .price-currency {
            font-size: 0.7rem;
            font-family: 'Outfit', sans-serif;
            color: var(--muted);
            margin-right: 0.1rem;
        }

        .id-pill {
            background: var(--cream);
            border: 1px solid var(--border);
            color: var(--muted);
            border-radius: 20px;
            font-size: 0.7rem;
            padding: 0.2rem 0.6rem;
            font-weight: 500;
        }

        .cat-pill {
            background: var(--gold-dim);
            color: var(--gold);
            border-radius: 20px;
            font-size: 0.72rem;
            padding: 0.2rem 0.65rem;
            font-weight: 500;
            border: 1px solid rgba(201,149,42,0.2);
        }

        .actions-cell { display: flex; gap: 0.4rem; }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: var(--paper);
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.5rem;
            color: var(--ink);
            margin-bottom: 0.5rem;
        }

        .empty-state p { color: var(--muted); font-size: 0.875rem; }

        /* Footer */
        footer {
            text-align: center;
            padding: 2rem;
            border-top: 1px solid var(--border);
            color: var(--muted);
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            margin-top: 3rem;
        }

        /* Animations */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hero { animation: fadeUp 0.5s ease both; }
        .stats-bar { animation: fadeUp 0.5s 0.1s ease both; }
        .content { animation: fadeUp 0.5s 0.2s ease both; }
    </style>
</head>
<body>

<div class="top-bar">Est. 2024 &nbsp;·&nbsp; Ridkk's Eats &nbsp;·&nbsp; Kathmandu, Nepal</div>

<nav>
    <a class="nav-logo" href="#">Ridkk<span>'</span>s Eats</a>
    <div class="nav-right">
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
            <a href="${pageContext.request.contextPath}/food?action=add" class="btn btn-primary">
                + Add Item
            </a>
        </c:if>
    </div>
</nav>

<div class="hero">
    <div>
        <h1 class="hero-title">Our <em>Menu</em></h1>
        <p class="hero-sub">Freshly crafted, every day</p>
    </div>
</div>

<div class="stats-bar">
    <div class="stat">
        <span class="stat-num">${foods.size()}</span>
        <span class="stat-label">Total Items</span>
    </div>
    <div class="stat">
        <span class="stat-num">4</span>
        <span class="stat-label">Categories</span>
    </div>
    <div class="stat">
        <span class="stat-num">NPR</span>
        <span class="stat-label">Currency</span>
    </div>
</div>

<div class="content">
    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Item</th>
                <th>Price</th>
                <th>Category</th>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                    <th>Actions</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty foods}">
                    <tr>
                        <td colspan="5">
                            <div class="empty-state">
                                <div class="empty-icon">🍽️</div>
                                <h3>No items yet</h3>
                                <p>Add your first menu item using the button above.</p>
                            </div>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="food" items="${foods}">
                        <tr>
                            <td><span class="id-pill">${food.foodId}</span></td>
                            <td>
                                <div class="food-name">${food.name}</div>
                                <div class="food-desc">${food.description}</div>
                            </td>
                            <td>
                                    <span class="price-tag">
                                        <span class="price-currency">NPR</span>${food.price}
                                    </span>
                            </td>
                            <td><span class="cat-pill">Cat #${food.categoryId}</span></td>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                                <td>
                                    <div class="actions-cell">
                                        <a href="${pageContext.request.contextPath}/food?action=edit&id=${food.foodId}" class="btn btn-sm btn-edit">Edit</a>
                                        <a href="${pageContext.request.contextPath}/food?action=delete&id=${food.foodId}"
                                           class="btn btn-sm btn-delete"
                                           onclick="return confirm('Delete ${food.name}?')">Delete</a>
                                    </div>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<footer>
    &copy; 2024 Ridkk's Eats &nbsp;·&nbsp; All rights reserved
</footer>

</body>
</html>
