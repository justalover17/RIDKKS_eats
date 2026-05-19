<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}" default="Ridkk's Eats" /></title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">

    <c:if test="${not empty extraCss}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}${extraCss}">
    </c:if>

    <c:if test="${not empty extraCss2}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}${extraCss2}">
    </c:if>

    <c:if test="${not empty extraCss3}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}${extraCss3}">
    </c:if>
</head>