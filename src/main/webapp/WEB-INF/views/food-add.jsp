<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    request.setAttribute("pageTitle", "Add Food Item | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/page.css");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
    <section class="page-title">
        <h1>Add Food Item</h1>
        <p>Fill in the details and choose a food image.</p>
    </section>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <c:out value="${error}" />
        </div>
    </c:if>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/food" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="insert">

            <div class="field">
                <label for="name">Food Name</label>
                <input type="text" id="name" name="name" placeholder="Example: Chicken Burger" required>
            </div>

            <div class="field">
                <label for="price">Price (Rs.)</label>
                <input type="number" id="price" name="price" step="0.01" min="1" placeholder="Example: 350" required>
            </div>

            <div class="field">
                <label for="categoryId">Category</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="" disabled selected>Select category</option>

                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}">
                            <c:out value="${cat.categoryName}" />
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="field">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="5" placeholder="Write short food description..."></textarea>
            </div>

            <div class="field">
                <label for="image">Food Image</label>
                <input type="file" id="image" name="image" accept=".jpg,.jpeg,.png,.webp">
                <small class="muted">Allowed files: .jpg, .jpeg, .png, .webp</small>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/food" class="btn btn-login">Cancel</a>
                <button type="submit" class="btn btn-primary">Add Food</button>
            </div>
        </form>
    </div>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>