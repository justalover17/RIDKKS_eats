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
    <title>Checkout — Ridkk's Eats</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --red:    #e8294a;
            --green:  #2a9d4e;
            --bg:     #f5f5f5;
            --white:  #ffffff;
            --border: #e8e8e8;
            --text:   #1a1a1a;
            --muted:  #888888;
            --radius: 14px;
        }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        /* NAV */
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
        .logo-text {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--red);
            text-decoration: none;
        }
        .nav-back {
            color: var(--muted);
            text-decoration: none;
            font-size: 0.88rem;
            font-weight: 500;
            transition: color .2s;
        }
        .nav-back:hover { color: var(--text); }

        /* PAGE */
        .page {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px 80px;
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

        /* GRID */
        .grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 24px;
            align-items: start;
        }

        /* CARD */
        .card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 28px;
            box-shadow: 0 1px 4px rgba(0,0,0,.05);
        }
        .card h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 14px;
            border-bottom: 1px solid var(--border);
        }

        /* FORM */
        .field { margin-bottom: 16px; }
        .field label {
            display: block;
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .field input,
        .field textarea,
        .field select {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 12px;
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
            color: var(--text);
            outline: none;
            background: #fafafa;
            transition: border-color .2s;
        }
        .field input:focus,
        .field textarea:focus,
        .field select:focus {
            border-color: var(--green);
            background: var(--white);
        }
        .field textarea { resize: vertical; min-height: 80px; }

        /* SUMMARY */
        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.875rem;
            padding: 9px 0;
            color: var(--muted);
            border-bottom: 1px solid #f2f2f2;
        }
        .summary-row span:last-child { color: var(--text); font-weight: 500; }
        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0 4px;
            margin-top: 4px;
        }
        .t-label { font-weight: 700; font-size: 0.95rem; }
        .t-amount {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--red);
        }

        /* BUTTONS */
        .btn-place {
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
            transition: opacity .2s, transform .15s;
        }
        .btn-place:hover { opacity: .88; transform: translateY(-1px); }

        .btn-back {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 13px;
            background: transparent;
            color: var(--red);
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.9rem;
            border: 1.5px solid var(--red);
            border-radius: var(--radius);
            text-align: center;
            text-decoration: none;
            transition: background .2s, color .2s;
        }
        .btn-back:hover { background: var(--red); color: #fff; }

        /* ── PAYMENT PANELS ── */

        /* eSewa QR panel */
        .esewa-panel {
            display: none;
            margin-top: 4px;
            padding: 20px;
            border: 1.5px solid #60bb46;
            border-radius: 12px;
            background: #f6fdf4;
            text-align: center;
        }
        .esewa-panel .esewa-logo {
            font-size: 1rem;
            font-weight: 700;
            color: #3a8a2a;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }
        .esewa-panel .qr-wrap {
            display: inline-block;
            padding: 10px;
            background: #fff;
            border-radius: 10px;
            border: 1px solid #d4edda;
            margin-bottom: 10px;
        }
        .esewa-panel .qr-wrap img {
            width: 160px;
            height: 160px;
            display: block;
        }
        .esewa-panel .esewa-note {
            font-size: 0.78rem;
            color: #3a8a2a;
            line-height: 1.5;
        }
        .esewa-panel .esewa-id {
            font-weight: 700;
            font-size: 0.95rem;
            color: #2a6e1e;
            margin-top: 6px;
        }

        /* Card payment panel */
        .card-panel {
            display: none;
            margin-top: 4px;
            padding: 20px;
            border: 1.5px solid var(--border);
            border-radius: 12px;
            background: #fafbff;
        }
        .card-panel .card-panel-title {
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .card-panel .card-panel-title span {
            font-size: 1.1rem;
        }
        .card-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        .card-field { margin-bottom: 12px; }
        .card-field label {
            display: block;
            font-size: 0.72rem;
            font-weight: 600;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 5px;
        }
        .card-field input {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 9px 11px;
            font-family: 'Inter', sans-serif;
            font-size: 0.88rem;
            color: var(--text);
            outline: none;
            background: var(--white);
            transition: border-color .2s;
        }
        .card-field input:focus { border-color: #4a6cf7; background: var(--white); }
        .card-icons {
            display: flex;
            gap: 6px;
            margin-bottom: 12px;
        }
        .card-icons span {
            font-size: 1.4rem;
        }

        /* ── CONFIRMATION SCREEN ── */
        .confirm-screen {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 68px);
        }
        .confirm-box {
            background: var(--white);
            border-radius: 20px;
            border: 1px solid var(--border);
            padding: 60px 48px;
            text-align: center;
            max-width: 460px;
            width: 100%;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            animation: pop .4s ease;
        }
        @keyframes pop {
            from { opacity: 0; transform: scale(.95) translateY(20px); }
            to   { opacity: 1; transform: scale(1)  translateY(0); }
        }
        .confirm-icon {
            width: 80px; height: 80px;
            background: #e8f5e9;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
            font-size: 2.2rem;
            color: var(--green);
        }
        .confirm-box h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 12px;
        }
        .confirm-box p {
            color: var(--muted);
            font-size: 0.95rem;
            line-height: 1.7;
            margin-bottom: 32px;
        }
        .btn-order-more {
            display: block;
            background: var(--green);
            color: #fff;
            padding: 14px;
            border-radius: 12px;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 12px;
            transition: opacity .2s;
        }
        .btn-order-more:hover { opacity: .87; }
        .btn-view-cart {
            display: block;
            border: 1.5px solid var(--border);
            color: var(--muted);
            padding: 13px;
            border-radius: 12px;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            font-size: 0.9rem;
            transition: border-color .2s, color .2s;
        }
        .btn-view-cart:hover { border-color: var(--muted); color: var(--text); }

        .error-box {
            background: #fff3f3;
            border: 1px solid #ffd0d0;
            color: #b42318;
            padding: 14px 16px;
            border-radius: 12px;
            margin: 0 auto 20px;
            max-width: 900px;
            font-family: 'Inter', sans-serif;
            font-size: .95rem;
        }

        @media (max-width: 700px) {
            nav { padding: 0 16px; }
            .grid { grid-template-columns: 1fr; }
            .page { padding: 0 16px 40px; }
            .confirm-box { padding: 40px 24px; }
        }
    </style>
</head>
<body>

<%--
     CASE 1 — ORDER SUCCESS CONFIRMATION SCREEN
     Shows when CheckoutServlet redirects to ?status=success
      --%>
<c:if test="${param.status == 'success'}">
    <% session.removeAttribute("orderSuccess"); %>

    <nav>
        <a href="${pageContext.request.contextPath}/food" class="logo-text">Ridkk's Eats</a>
    </nav>

    <div class="confirm-screen">
        <div class="confirm-box">
            <div class="confirm-icon">✓</div>
            <h1>Order Placed!</h1>
            <p>
                Thank you for your order.<br>
                We're preparing your food and<br>will deliver it to you soon.
            </p>
            <a href="${pageContext.request.contextPath}/food" class="btn-order-more">
                Order More Food
            </a>
            <a href="${pageContext.request.contextPath}/cart?action=view" class="btn-view-cart">
                View Cart
            </a>
        </div>
    </div>
</c:if>

<%--
     CASE 2 — NORMAL CHECKOUT FORM
      --%>
<c:if test="${param.status != 'success'}">

    <nav>
        <a href="${pageContext.request.contextPath}/food" class="logo-text">Ridkk's Eats</a>
        <a href="${pageContext.request.contextPath}/cart?action=view" class="nav-back">← Back to Cart</a>
    </nav>

    <%
        com.coursework.dao.FoodItemDao foodItemDao = new com.coursework.dao.FoodItemDaoImpl();
    %>

    <div class="page">
        <h1 class="page-title">Checkout</h1>
        <p class="page-subtitle">Almost there — fill in your details below.</p>

        <c:if test="${not empty error}">
            <div class="error-box">${error}</div>
        </c:if>

        <div class="grid">

                <%-- DELIVERY DETAILS --%>
            <div class="card">
                <h2>Delivery Details</h2>
                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">

                    <div class="field">
                        <label>Full Name</label>
                        <input type="text" name="fullName"
                               value="${sessionScope.user.name}"
                               placeholder="Your full name" required>
                    </div>

                    <div class="field">
                        <label>Phone Number</label>
                        <input type="tel" name="phone"
                               value="${sessionScope.user.phone}"
                               placeholder="98XXXXXXXX" required>
                    </div>

                    <div class="field">
                        <label>Delivery Address</label>
                        <textarea name="address" placeholder="Street, City, Landmark…" required></textarea>
                    </div>

                    <div class="field">
                        <label>Payment Method</label>
                        <select name="paymentMethod" id="paymentMethod" onchange="handlePaymentChange(this.value)">
                            <option value="cash">Cash on Delivery</option>
                            <option value="esewa">eSewa</option>
                            <option value="card">Card Payment</option>
                        </select>
                    </div>

                        <%-- ── eSewa QR Panel (hidden by default) ── --%>
                    <div class="esewa-panel" id="esewaPanel">
                        <div class="esewa-logo"> eSewa Payment</div>
                        <div class="qr-wrap">
                                <%--
                                    Replace the src below with your actual eSewa QR code image.
                                    Put it in: src/main/webapp/images/esewa-qr.png
                                    Then use: src="${pageContext.request.contextPath}/images/esewa-qr.png"
                                --%>
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=160x160&data=esewa-ridkkseats-9800000000"
                                 alt="eSewa QR Code">
                        </div>
                        <div class="esewa-note">
                            Scan this QR code with your eSewa app to pay.<br>
                            After payment, click <strong>Place Order</strong>.
                        </div>
                        <div class="esewa-id">eSewa ID: 9800000000</div>
                    </div>

                        <%-- ── Card Payment Panel (hidden by default) ── --%>
                    <div class="card-panel" id="cardPanel">
                        <div class="card-panel-title">
                            <span>💳</span> Card Details
                        </div>
                        <div class="card-icons">
                            <span title="Visa"></span>

                        </div>
                        <div class="card-field">
                            <label>Cardholder Name</label>
                            <input type="text" id="cardName" name="cardName"
                                   placeholder="Name on card">
                        </div>
                        <div class="card-field">
                            <label>Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber"
                                   placeholder="1234 5678 9012 3456"
                                   maxlength="19"
                                   oninput="formatCardNumber(this)">
                        </div>
                        <div class="card-row">
                            <div class="card-field">
                                <label>Expiry Date</label>
                                <input type="text" id="cardExpiry" name="cardExpiry"
                                       placeholder="MM / YYYY" maxlength="7"
                                       oninput="formatExpiry(this)">
                            </div>
                            <div class="card-field">
                                <label>CVV</label>
                                <input type="password" id="cardCvv" name="cardCvv"
                                       placeholder="•••" maxlength="4">
                            </div>
                        </div>
                    </div>

                    <div class="field">
                        <label>Special Instructions (optional)</label>
                        <textarea name="notes" placeholder="Any special requests…"></textarea>
                    </div>

                    <button type="submit" class="btn-place" onclick="return validatePayment()">✓ Place Order</button>
                </form>
                <a href="${pageContext.request.contextPath}/food" class="btn-back">+ Add More Items</a>
            </div>

                <%-- ORDER SUMMARY --%>
            <div class="card">
                <h2>Order Summary</h2>

                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="item" items="${cartItems}">
                            <%
                                com.coursework.entity.CartDetails ci =
                                        (com.coursework.entity.CartDetails) pageContext.getAttribute("item");
                                com.coursework.entity.FoodItem fi =
                                        foodItemDao.findFoodById(ci.getFoodId());
                                pageContext.setAttribute("fi", fi);
                                double line = fi != null ? fi.getPrice() * ci.getQuantity() : 0;
                                pageContext.setAttribute("line", line);
                            %>
                            <div class="summary-row">
                                <span>
                                    <c:choose>
                                        <c:when test="${not empty fi}">${fi.name}</c:when>
                                        <c:otherwise>Item #${item.foodId}</c:otherwise>
                                    </c:choose>
                                    &times; ${item.quantity}
                                </span>
                                <span>Rs. <fmt:formatNumber value="${line}" maxFractionDigits="2"/></span>
                            </div>
                        </c:forEach>

                        <div class="summary-total">
                            <span class="t-label">Total</span>
                            <span class="t-amount">
                                Rs. <fmt:formatNumber value="${total}" maxFractionDigits="2"/>
                            </span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p style="color:var(--muted); font-size:.875rem; text-align:center; padding:20px 0;">
                            No items found.
                            <a href="${pageContext.request.contextPath}/food" style="color:var(--red);">Browse menu</a>
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>

</c:if>

<script>
    // Show/hide payment panels based on selected method
    function handlePaymentChange(value) {
        document.getElementById('esewaPanel').style.display = 'none';
        document.getElementById('cardPanel').style.display  = 'none';

        if (value === 'esewa') {
            document.getElementById('esewaPanel').style.display = 'block';
        } else if (value === 'card') {
            document.getElementById('cardPanel').style.display  = 'block';
        }
        // cash → nothing extra shown
    }

    // Validate card fields before submit
    function validatePayment() {
        const method = document.getElementById('paymentMethod').value;
        if (method !== 'card') return true;

        const name   = document.getElementById('cardName').value.trim();
        const number = document.getElementById('cardNumber').value.replace(/\s/g,'');
        const expiry = document.getElementById('cardExpiry').value.trim();
        const cvv    = document.getElementById('cardCvv').value.trim();

        if (!name) { alert('Please enter the cardholder name.'); return false; }
        if (number.length < 16) { alert('Please enter a valid 16-digit card number.'); return false; }
        if (!expiry.match(/^\d{2}\s*\/\s*\d{2}$/)) { alert('Please enter expiry in MM / YY format.'); return false; }
        if (cvv.length < 3) { alert('Please enter a valid CVV.'); return false; }
        return true;
    }

    // Auto-format card number: "1234 5678 9012 3456"
    function formatCardNumber(input) {
        let v = input.value.replace(/\D/g, '').substring(0, 16);
        input.value = v.replace(/(.{4})/g, '$1 ').trim();
    }

    // Auto-format expiry: "MM / YY"
    function formatExpiry(input) {
        let v = input.value.replace(/\D/g, '').substring(0, 4);
        if (v.length >= 3) {
            input.value = v.substring(0,2) + ' / ' + v.substring(2);
        } else {
            input.value = v;
        }
    }
</script>

</body>
</html>
