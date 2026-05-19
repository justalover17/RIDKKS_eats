<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    request.setAttribute("pageTitle", "Edit Food Item | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/page.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
    <c:choose>
        <c:when test="${empty food}">
            <section class="page-title">
                <h1>Food Not Found</h1>
                <p>The selected food item could not be loaded.</p>
            </section>

            <div style="text-align:center;">
                <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">Back to Menu</a>
            </div>
        </c:when>

        <c:otherwise>
            <section class="page-title">
                <h1>Edit Food Item</h1>
                <p>Update the selected food item details and image.</p>
            </section>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <c:out value="${error}" />
                </div>
            </c:if>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/food" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${food.foodId}">

                    <div class="field">
                        <label for="name">Food Name</label>
                        <input type="text" id="name" name="name" value="${food.name}" required>
                    </div>

                    <div class="field">
                        <label for="price">Price (Rs.)</label>
                        <input type="number" id="price" name="price" value="${food.price}" step="0.01" min="1" required>
                    </div>

                    <div class="field">
                        <label for="categoryId">Category</label>
                        <select id="categoryId" name="categoryId" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryId}" ${cat.categoryId == food.categoryId ? 'selected' : ''}>
                                    <c:out value="${cat.categoryName}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="field">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="5"><c:out value="${food.description}" /></textarea>
                    </div>

                    <div class="field">
                        <label>Current Image</label>

                        <c:choose>
                            <c:when test="${not empty food.imagePath}">
                                <img src="${pageContext.request.contextPath}/uploads/${food.imagePath}"
                                     alt="${food.name}"
                                     style="width:160px; height:120px; object-fit:cover; border-radius:12px; border:1px solid #ddd;">
                            </c:when>

                            <c:otherwise>
                                <c:set var="quote" value="'" />
                                <c:set var="safeName1" value="${fn:replace(food.name, quote, '')}" />
                                <c:set var="safeName2" value="${fn:replace(safeName1, ' ', '')}" />

                                <img src="${pageContext.request.contextPath}/static/images/${safeName2}.png"
                                     alt="${food.name}"
                                     style="width:160px; height:120px; object-fit:cover; border-radius:12px; border:1px solid #ddd;"
                                     onerror="this.src='${pageContext.request.contextPath}/static/images/logo.png'">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="field">
                        <label for="image">Choose New Image</label>
                        <input type="file" id="image" name="image" accept=".jpg,.jpeg,.png,.webp">
                        <small class="muted">Leave empty if you want to keep the current image.</small>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Cancel</a>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>