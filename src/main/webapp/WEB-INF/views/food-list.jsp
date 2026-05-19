<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    request.setAttribute("pageTitle", "Menu | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/food-list.css");
%>

<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="food-page">
    <section class="section-header" style="padding-top: 4rem;">
        <h2>Our Menu</h2>
        <p class="sub-header">Choose your favorite food and order easily.</p>
    </section>

    <%@ include file="category-filters.jsp" %>

    <c:if test="${sessionScope.user.role == 'admin'}">
        <div style="text-align:center; margin-bottom: 2rem;">
            <a href="${pageContext.request.contextPath}/food?action=add" class="btn btn-primary">
                Add New Food
            </a>
        </div>
    </c:if>

    <div class="food-grid">
        <c:choose>
            <c:when test="${empty foods}">
                <div style="grid-column: 1 / -1; text-align:center; padding:4rem 2rem;">
                    <h3>No food items found.</h3>
                    <p class="sub-header">Try another category or search keyword.</p>
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach var="food" items="${foods}">

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

                    <div class="food-item-card">
                        <a href="${pageContext.request.contextPath}/food?action=view&id=${food.foodId}">
                            <div class="food-item-img">
                                <img src="${foodImageUrl}"
                                     alt="${food.name}"
                                     style="width:100%; height:100%; object-fit:cover;"
                                     onerror="this.src='${pageContext.request.contextPath}/static/images/logo.png'">
                            </div>
                        </a>

                        <div class="food-item-content">
                            <h3>
                                <c:out value="${food.name}" />
                            </h3>

                            <p class="food-item-desc">
                                <c:out value="${food.description}" />
                            </p>

                            <div class="food-item-footer">
                                <span class="food-price">
                                    Rs. <c:out value="${food.price}" />
                                </span>

                                <a href="${pageContext.request.contextPath}/food?action=view&id=${food.foodId}"
                                   class="btn btn-primary btn-add">
                                    View
                                </a>
                            </div>

                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <div style="display:flex; gap:10px; margin-top:1rem;">
                                    <a href="${pageContext.request.contextPath}/food?action=edit&id=${food.foodId}"
                                       class="btn btn-login">
                                        Edit
                                    </a>

                                    <a href="${pageContext.request.contextPath}/food?action=delete&id=${food.foodId}"
                                       class="btn btn-primary"
                                       onclick="return confirm('Delete this food item?')">
                                        Delete
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>

                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>