<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--
     CATEGORY FILTERS COMPONENT
     These are the small buttons that let the user click
     "Nepali", "Breakfast", etc. to filter the menu items.
     -->
<div class="category-filters" style="text-align: center; margin-bottom: 3rem;">
    <a href="${pageContext.request.contextPath}/food" class="btn btn-login" style="margin: 0 5px;">All</a>
    <a href="${pageContext.request.contextPath}/food?category=1" class="btn btn-login" style="margin: 0 5px;">Nepali</a>
    <a href="${pageContext.request.contextPath}/food?category=2" class="btn btn-login" style="margin: 0 5px;">Breakfast</a>
    <a href="${pageContext.request.contextPath}/food?category=3" class="btn btn-login" style="margin: 0 5px;">Desserts</a>
    <a href="${pageContext.request.contextPath}/food?category=4" class="btn btn-login" style="margin: 0 5px;">Drinks</a>
    <a href="${pageContext.request.contextPath}/food?category=5" class="btn btn-login" style="margin: 0 5px;">Italian</a>
</div>
