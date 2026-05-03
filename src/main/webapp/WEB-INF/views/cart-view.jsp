<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.coursework.entity.CartDetails" %>
<%@ page import="com.coursework.entity.FoodItem" %>
<%@ page import="com.coursework.dao.FoodItemDaoImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart — Riddik's Eats</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --red:      #e8294a;
            --green:    #2a9d4e;
            --bg:       #f5f5f5;
            --white:    #ffffff;
            --border:   #e8e8e8;
            --text:     #1a1a1a;
            --muted:    #888888;
            --radius:   14px;
        }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        /* ── NAV ── */
        nav {
            background: var(--white);
            border-bottom: 1px solid var(--border);
            padding: 0 48px;
            height: 68px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 1px 6px rgba(0,0,0,0.06);
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        .logo-icon {
            width: 38px; height: 38px;
            background: var(--red);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem;
        }
        .logo-text {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--red);
        }
        .nav-back {
            color: var(--muted);
            text-decoration: none;
            font-size: 0.88rem;
            font-weight: 500;
            transition: color .2s;
        }
        .nav-back:hover { color: var(--text); }

        /* ── PAGE ── */
        .page {
            max-width: 1060px;
            margin: 0 auto;
            padding: 40px 24px 80px;
        }
        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 6px;
        }
        .page-subtitle {
            color: var(--muted);
            font-size: 0.9rem;
            margin-bottom: 32px;
        }

        /* ── LAYOUT ── */
        .layout {
            display: grid;
            grid-template-columns: 1fr 320px;
            gap: 24px;
            align-items: start;
        }

        /* ── EMPTY ── */
        .cart-empty {
            background: var(--white);
            border-radius: var(--radius);
            border: 1px solid var(--border);
            text-align: center;
            padding: 80px 32px;
        }
        .cart-empty .icon { font-size: 3.5rem; margin-bottom: 16px; }
        .cart-empty h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin-bottom: 8px;
        }
        .cart-empty p { color: var(--muted); margin-bottom: 28px; font-size: 0.92rem; }

        /* ── CART CARD ── */
        .cart-items { display: flex; flex-direction: column; gap: 14px; }

        .cart-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px 24px;
            display: grid;
            grid-template-columns: 64px 1fr auto;
            gap: 16px;
            align-items: center;
            transition: box-shadow .2s;
            animation: fadeUp .3s ease both;
        }
        .cart-card:hover { box-shadow: 0 4px 20px rgba(0,0,0,0.08); }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .food-thumb {
            width: 64px; height: 64px;
            border-radius: 10px;
            background: #f2f2f2;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem;
            flex-shrink: 0;
        }

        .food-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 4px;
        }
        .food-unit { color: var(--muted); font-size: 0.82rem; }
        .food-subtotal {
            color: var(--red);
            font-weight: 600;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        .card-right {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        /* Qty controls */
        .qty-form { display: flex; align-items: center; gap: 6px; }

        .qty-btn {
            width: 30px; height: 30px;
            border-radius: 50%;
            border: 1px solid var(--border);
            background: var(--white);
            color: var(--text);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            transition: border-color .2s, color .2s;
        }
        .qty-btn:hover { border-color: var(--red); color: var(--red); }

        .qty-input {
            width: 42px;
            text-align: center;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            padding: 5px 4px;
            color: var(--text);
        }
        .qty-input:focus { outline: none; border-color: var(--green); }

        .update-btn {
            padding: 5px 12px;
            border-radius: 8px;
            border: 1.5px solid var(--green);
            background: transparent;
            color: var(--green);
            font-family: 'Inter', sans-serif;
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s, color .2s;
        }
        .update-btn:hover { background: var(--green); color: #fff; }

        .remove-btn {
            font-size: 0.78rem;
            color: var(--muted);
            text-decoration: none;
            font-weight: 500;
            display: flex; align-items: center; gap: 4px;
            transition: color .2s;
        }
        .remove-btn:hover { color: var(--red); }

        /* ── SUMMARY ── */
        .summary {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 28px 24px;
            position: sticky;
            top: 88px;
        }
        .summary h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 14px;
            border-bottom: 1px solid var(--border);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.875rem;
            padding: 8px 0;
            color: var(--muted);
            border-bottom: 1px solid #f2f2f2;
        }
        .summary-row span:last-child { color: var(--text); font-weight: 500; }

        .summary-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0 4px;
        }
        .t-label { font-weight: 600; font-size: 0.95rem; }
        .t-amount {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--red);
        }

        .btn-checkout {
            display: block;
            width: 100%;
            margin-top: 20px;
            padding: 14px;
            background: var(--green);
            color: #fff;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: opacity .2s, transform .15s;
        }
        .btn-checkout:hover { opacity: .88; transform: translateY(-1px); }

        .btn-continue {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 13px;
            background: transparent;
            color: var(--red);
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.92rem;
            border: 1.5px solid var(--red);
            border-radius: var(--radius);
            text-align: center;
            text-decoration: none;
            transition: background .2s, color .2s;
        }
        .btn-continue:hover { background: var(--red); color: #fff; }

        .btn-browse {
            display: inline-block;
            padding: 13px 32px;
            background: var(--green);
            color: #fff;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            border-radius: var(--radius);
            text-decoration: none;
            transition: opacity .2s;
        }
        .btn-browse:hover { opacity: .85; }

        @media (max-width: 760px) {
            nav { padding: 0 16px; }
            .layout { grid-template-columns: 1fr; }
            .summary { position: static; }
            .cart-card { grid-template-columns: 56px 1fr; }
            .card-right { flex-direction: row; justify-content: space-between; grid-column: 1/-1; }
        }
    </style>
</head>
<body>

<%
    com.coursework.dao.FoodItemDao foodItemDao = new com.coursework.dao.FoodItemDaoImpl();
%>

<nav>
    <a href="${pageContext.request.contextPath}/" class="logo">
        <span class="logo-text">Riddik's Eats</span>
    </a>
    <a href="${pageContext.request.contextPath}/menu" class="nav-back">← Back to Menu</a>
</nav>

<div class="page">

    <h1 class="page-title">My Cart</h1>
    <p class="page-subtitle">
        <c:choose>
            <c:when test="${not empty cartItems}">
                ${cartItems.size()} item<c:if test="${cartItems.size() != 1}">s</c:if> in your cart
            </c:when>
            <c:otherwise>Your cart is empty</c:otherwise>
        </c:choose>
    </p>

    <c:choose>

        <c:when test="${empty cartItems}">
            <div class="cart-empty">
                <div class="icon">🛒</div>
                <h2>Nothing here yet</h2>
                <p>Browse our menu and add something delicious.</p>
                <a href="${pageContext.request.contextPath}/menu" class="btn-browse">Browse Menu</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="layout">

                <!-- Items -->
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}" varStatus="loop">
                        <%
                            com.coursework.entity.CartDetails ci =
                                    (com.coursework.entity.CartDetails) pageContext.getAttribute("item");
                            com.coursework.entity.FoodItem fi =
                                    foodItemDao.findFoodById(ci.getFoodId());
                            pageContext.setAttribute("fi", fi);
                            double lineTotal = fi != null ? fi.getPrice() * ci.getQuantity() : 0;
                            pageContext.setAttribute("lineTotal", lineTotal);
                        %>
                        <div class="cart-card" style="animation-delay:${loop.index * 60}ms">

                            <div class="food-thumb">🍴</div>

                            <div>
                                <div class="food-name">
                                    <c:choose>
                                        <c:when test="${not empty fi}">${fi.name}</c:when>
                                        <c:otherwise>Item #${item.foodId}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="food-unit">
                                    <c:if test="${not empty fi}">
                                        Rs. <fmt:formatNumber value="${fi.price}" maxFractionDigits="2"/> each
                                    </c:if>
                                </div>
                                <div class="food-subtotal">
                                    Rs. <fmt:formatNumber value="${lineTotal}" maxFractionDigits="2"/>
                                </div>
                            </div>

                            <div class="card-right">
                                <form method="get" action="${pageContext.request.contextPath}/cart" class="qty-form">
                                    <input type="hidden" name="action" value="update"/>
                                    <input type="hidden" name="cartDetailId" value="${item.cartDetailId}"/>
                                    <button type="button" class="qty-btn" onclick="adj(this,-1)">−</button>
                                    <input type="number" name="quantity" value="${item.quantity}"
                                           min="1" max="99" class="qty-input"/>
                                    <button type="button" class="qty-btn" onclick="adj(this,1)">+</button>
                                    <button type="submit" class="update-btn">Update</button>
                                </form>
                                <a href="${pageContext.request.contextPath}/cart?action=remove&cartDetailId=${item.cartDetailId}"
                                   class="remove-btn"
                                   onclick="return confirm('Remove this item?')">🗑 Remove</a>
                            </div>

                        </div>
                    </c:forEach>
                </div>

                <!-- Summary -->
                <div class="summary">
                    <h2>Order Summary</h2>

                    <c:forEach var="item" items="${cartItems}">
                        <%
                            com.coursework.entity.CartDetails si =
                                    (com.coursework.entity.CartDetails) pageContext.getAttribute("item");
                            com.coursework.entity.FoodItem sf =
                                    foodItemDao.findFoodById(si.getFoodId());
                            pageContext.setAttribute("sf", sf);
                            double summaryLine = sf != null ? sf.getPrice() * si.getQuantity() : 0;
                            pageContext.setAttribute("summaryLine", summaryLine);
                        %>
                        <div class="summary-row">
                            <span>
                                <c:choose>
                                    <c:when test="${not empty sf}">${sf.name}</c:when>
                                    <c:otherwise>Item #${item.foodId}</c:otherwise>
                                </c:choose>
                                &times; ${item.quantity}
                            </span>
                            <span>Rs. <fmt:formatNumber value="${summaryLine}" maxFractionDigits="2"/></span>
                        </div>
                    </c:forEach>

                    <div class="summary-total-row">
                        <span class="t-label">Total</span>
                        <span class="t-amount">Rs. <fmt:formatNumber value="${total}" maxFractionDigits="2"/></span>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Proceed to Checkout</a>
                    <a href="${pageContext.request.contextPath}/menu" class="btn-continue">+ Add More Items</a>
                </div>

            </div>
        </c:otherwise>
    </c:choose>

</div>

<script>
    function adj(btn, delta) {
        const input = btn.closest('form').querySelector('input[name="quantity"]');
        let v = parseInt(input.value) + delta;
        if (v < 1) v = 1;
        if (v > 99) v = 99;
        input.value = v;
    }
</script>

</body>
</html>
