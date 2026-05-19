<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    request.setAttribute("pageTitle", "Food Details | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/food-view.css");
%>

<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<c:choose>
    <c:when test="${empty food}">
        <main class="page-wrapper" style="min-height:65vh; text-align:center; padding:4rem 2rem;">
            <h1>Food Not Found</h1>
            <p class="sub-header">The selected food item could not be loaded.</p>
            <br>
            <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">
                Back to Menu
            </a>
        </main>
    </c:when>

    <c:otherwise>
        <c:choose>
            <c:when test="${not empty food.imagePath}">
                <c:url value="/uploads/${food.imagePath}" var="foodImageUrl" />
            </c:when>

            <c:otherwise>
                <c:set var="quote" value="'" />
                <c:set var="safeName1" value="${fn:replace(food.name, quote, '')}" />
                <c:set var="safeName2" value="${fn:replace(safeName1, ' ', '')}" />
                <c:url value="/static/images/${safeName2}.png" var="foodImageUrl" />
            </c:otherwise>
        </c:choose>

        <div class="view-container">
            <div class="view-image" style="background-image: url('${foodImageUrl}');">
                <img src="${foodImageUrl}"
                     style="display:none;"
                     alt="${food.name}"
                     onerror="this.parentElement.style.backgroundImage='url(${pageContext.request.contextPath}/static/images/logo.png)'">
            </div>

            <div class="view-details">
                <a href="${pageContext.request.contextPath}/food"
                   style="color: var(--text-muted); margin-bottom: 1rem; display: inline-block;">
                    &larr; Back to Menu
                </a>

                <h1 class="view-title">
                    <c:out value="${food.name}" />
                </h1>

                <div class="view-price">
                    Rs. <c:out value="${food.price}" />
                </div>

                <p class="view-desc">
                    <c:out value="${food.description}" />
                </p>

                <form action="${pageContext.request.contextPath}/cart?action=add"
                      method="post"
                      class="add-cart-form">

                    <input type="hidden" name="foodId" value="${food.foodId}">

                    <div class="quantity-selector">
                        <button type="button" class="qty-btn" id="decreaseQty">-</button>

                        <input type="number"
                               name="quantity"
                               id="qtyInput"
                               class="qty-input"
                               value="1"
                               min="1"
                               max="20"
                               readonly>

                        <button type="button" class="qty-btn" id="increaseQty">+</button>
                    </div>

                    <div style="display:flex; gap:15px; margin-top:1rem;">
                        <button type="submit"
                                class="btn"
                                style="background-color:#28a745; color:white; padding:1rem 2rem; font-size:1.1rem; border:none; border-radius:5px; cursor:pointer; flex:1; font-weight:600;">
                            Buy
                        </button>

                        <button type="submit"
                                class="btn btn-primary"
                                style="padding:1rem 2rem; font-size:1.1rem; flex:1;">
                            Add
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/templates/footer.jsp" %>

<script>
    const decreaseBtn = document.getElementById('decreaseQty');
    const increaseBtn = document.getElementById('increaseQty');
    const qtyInput = document.getElementById('qtyInput');

    if (decreaseBtn && increaseBtn && qtyInput) {
        decreaseBtn.addEventListener('click', function () {
            let current = parseInt(qtyInput.value);

            if (current > 1) {
                qtyInput.value = current - 1;
            }
        });

        increaseBtn.addEventListener('click', function () {
            let current = parseInt(qtyInput.value);

            if (current < 20) {
                qtyInput.value = current + 1;
            }
        });
    }
</script>

</body>
</html>