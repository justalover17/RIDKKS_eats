<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "Ridkk's Eats | Fine Delivery");
%>
<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<section class="home" id="homeSection">
    <div class="home-bg" id="homeBg" style="background-image: url('${pageContext.request.contextPath}/static/images/Homepage.png');"></div>

    <div class="home-content">
        <h1>Find your perfect meal.</h1>
        <p>Search your favorite cuisine</p>

        <form class="search-bar-container" action="${pageContext.request.contextPath}/food" method="get">
            <input type="text" name="search" class="search-input" id="homeSearchInput" placeholder="e.g. Momo, Pizza, Burgers...">
            <button type="submit" class="search-btn">
                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </form>
    </div>
</section>

<section class="cuisine-section">
    <div class="section-header">
        <h2>Popular Cuisine</h2>
        <p class="sub-header">Crowd favorite at Ridkk's Eats</p>
    </div>

    <div class="cuisine-grid">
        <a href="${pageContext.request.contextPath}/food?action=view&id=1" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Burger.png');"></div>
            <div class="card-info">
                <h3>Burger</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=26" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Pizza.png');"></div>
            <div class="card-info">
                <h3>Pizza</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=11" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/RidkksBreakfast.png');"></div>
            <div class="card-info">
                <h3>Ridkk's Breakfast</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=27" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Spaghetti.png');"></div>
            <div class="card-info">
                <h3>Spaghetti</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=12" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/VanillaWaffle.png');"></div>
            <div class="card-info">
                <h3>Vanilla Waffle</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=10" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Clubsandwich.png');"></div>
            <div class="card-info">
                <h3>Club Sandwich</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=9" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Padthai.png');"></div>
            <div class="card-info">
                <h3>Pad Thai</h3>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/food?action=view&id=28" class="cuisine-card">
            <div class="card-img" style="background-image: url('${pageContext.request.contextPath}/static/images/Sirloinsteak.png');"></div>
            <div class="card-info">
                <h3>Sirloin Steak</h3>
            </div>
        </a>
    </div>

    <div class="menu-btn-container">
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary">View Full Menu</a>
    </div>
</section>

<%@ include file="/WEB-INF/templates/footer.jsp" %>
</body>
</html>