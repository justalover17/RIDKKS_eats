<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    request.setAttribute("pageTitle", "My Cart | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/page.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
    <section class="page-title">
        <h1>My Cart</h1>
        <p>Review your selected food items before checkout.</p>
    </section>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-card">
                <h2>Your cart is empty</h2>
                <p class="muted">Add food from the menu to start your order.</p>
                <br>
                <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">Browse Menu</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="cart-layout">
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="food" value="${foodMap[item.foodId]}" />

                        <c:if test="${not empty food}">
                            <c:set var="quote" value="'" />
                            <c:set var="safeName1" value="${fn:replace(food.name, quote, '')}" />
                            <c:set var="safeName2" value="${fn:replace(safeName1, ' ', '')}" />
                            <c:url value="/static/images/${safeName2}.png" var="foodImageUrl" />

                            <div class="cart-card">
                                <div class="cart-thumb">
                                    <img src="${foodImageUrl}" alt="${food.name}" onerror="this.src='${pageContext.request.contextPath}/static/images/logo.png'">
                                </div>

                                <div>
                                    <div class="cart-name">
                                        <c:out value="${food.name}" />
                                    </div>

                                    <div class="cart-price">
                                        Rs.
                                        <fmt:formatNumber value="${food.price}" minFractionDigits="2" maxFractionDigits="2" />
                                        each
                                    </div>

                                    <div class="cart-subtotal">
                                        Subtotal: Rs.
                                        <fmt:formatNumber value="${food.price * item.quantity}" minFractionDigits="2" maxFractionDigits="2" />
                                    </div>
                                </div>

                                <div class="cart-actions">
                                    <form action="${pageContext.request.contextPath}/cart?action=update" method="post" class="qty-row">
                                        <input type="hidden" name="cartDetailId" value="${item.cartDetailId}">
                                        <input type="number" name="quantity" class="qty-input" value="${item.quantity}" min="1" max="99">
                                        <button type="submit" class="btn btn-login" style="padding:0.55rem 1rem;">Update</button>
                                    </form>

                                    <form action="${pageContext.request.contextPath}/cart?action=remove" method="post">
                                        <input type="hidden" name="cartDetailId" value="${item.cartDetailId}">
                                        <button type="submit" class="delete-link" style="background:none; border:none; cursor:pointer;" onclick="return confirm('Remove this item?')">
                                            Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <aside class="summary-card">
                    <h3>Order Summary</h3>

                    <div class="summary-row">
                        <span>Items Total</span>
                        <span>
                            Rs.
                            <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                    </div>

                    <div class="summary-row">
                        <span>Delivery</span>
                        <span>Free</span>
                    </div>

                    <div class="summary-row total">
                        <span>Total</span>
                        <span>
                            Rs.
                            <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary" style="width:100%; margin-top:1rem;">
                        Proceed to Checkout
                    </a>

                    <a href="${pageContext.request.contextPath}/food" class="btn btn-login" style="width:100%; margin-top:0.8rem;">
                        Continue Shopping
                    </a>
                </aside>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>