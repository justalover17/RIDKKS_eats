<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "About Us | Ridkk's Eats");
    request.setAttribute("extraCss", "/static/css/about-us.css");
%>

<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<section class="about-hero">
    <div class="about-hero-bg"></div>
    <div class="about-hero-content">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <span>›</span>
            <span style="color: rgba(255,255,255,0.8);">About Us</span>
        </div>
        <h1>Our Story</h1>
        <p>Bringing the finest culinary experiences straight to your doorstep since 2026.</p>
    </div>
</section>

<section class="story-section">
    <div class="story-text fade-up">
        <h2>Who We Are</h2>
        <p>
            Ridkk's Eats started with one goal, bring the best local food in Pokhara
            straight to your door. We believed that a great meal should not require
            you to leave your home to enjoy it.
        </p>
        <p>
            Founded in 2026, we work with some of the finest kitchens in the city,
            carefully choosing every restaurant on our platform to make sure what
            reaches you is always fresh, hot, and worth every rupee.
        </p>
        <p>
            Food brings people together, and that is what we are really about.
            Whether it is a quiet dinner at home or feeding a whole group, we are
            here to make sure the food is the best part of your day.
        </p>
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary" style="margin-top: 1rem;">
            Explore Our Menu
        </a>
    </div>

    <div class="story-image-wrap fade-up">
        <img src="${pageContext.request.contextPath}/static/images/RidkksBreakfast.png" alt="Ridkk's Eats - Our Kitchen">
        <div class="story-badge">
            <span class="badge-num">2026</span>
            <span class="badge-label">Established</span>
        </div>
    </div>
</section>

<section class="stats-section">
    <div class="stats-inner">
        <div class="stat-item fade-up">
            <span class="stat-num">20+</span>
            <span class="stat-label">Menu Items</span>
        </div>
        <div class="stat-item fade-up">
            <span class="stat-num">20K+</span>
            <span class="stat-label">Happy Customers</span>
        </div>
        <div class="stat-item fade-up">
            <span class="stat-num">30 min</span>
            <span class="stat-label">Avg. Delivery Time</span>
        </div>
        <div class="stat-item fade-up">
            <span class="stat-num">4.8★</span>
            <span class="stat-label">Customer Rating</span>
        </div>
    </div>
</section>

<section class="values-section">
    <div class="values-inner">
        <div class="section-header fade-up">
            <h2>What We Stand For</h2>
            <p class="sub-header">The values that guide every order, every delivery, every day</p>
        </div>

        <div class="values-grid">

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                    </svg>
                </div>
                <h3>Quality First</h3>
                <p>We only work with restaurants that actually care about what they put on the plate.
                    Fresh ingredients, real recipes, no shortcuts. If we would not eat it ourselves,
                    we would not deliver it to you.</p>
            </div>

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                </div>
                <h3>Speed & Reliability</h3>
                <p>When you are hungry, waiting feels like forever. We get that. Our delivery
                    network is built to get your food to you hot, on time, every time, without
                    making you refresh the tracking page every two minutes.</p>
            </div>

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                </div>
                <h3>Community Focus</h3>
                <p>We are a Pokhara business through and through. We support local restaurants,
                    our riders are local, and the money stays in the community. When you order
                    from us, you are supporting real people, not a corporation.</p>
            </div>

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                    </svg>
                </div>
                <h3>Safe & Hygienic</h3>
                <p>Every kitchen we partner with is checked for hygiene standards. Our packaging
                    is sealed properly so what leaves the kitchen is exactly what arrives at
                    your door, nothing missing, nothing tampered with.</p>
            </div>

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <line x1="12" y1="1" x2="12" y2="23"></line>
                        <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                    </svg>
                </div>
                <h3>Transparent Pricing</h3>
                <p>The price you see is the price you pay. We are not fans of surprise charges
                    showing up at checkout either, so we made sure that does not happen here.
                    Simple, honest pricing from the start.</p>
            </div>

            <div class="value-card fade-up">
                <div class="value-icon">
                    <svg width="28" height="28" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 13a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 9.91a16 16 0 0 0 6.08 6.08l1.17-1.17a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"></path>
                    </svg>
                </div>
                <h3>Always Here</h3>
                <p>Something went wrong with your order? Talk to us. We actually respond,
                    and we actually fix things. No automated replies that go nowhere, just
                    real people sorting out real problems.</p>
            </div>

        </div>
    </div>
</section>

<section class="team-section">
    <div class="section-header fade-up">
        <h2>Meet the Team</h2>
        <p class="sub-header">The six people behind every great meal we deliver</p>
    </div>

    <div class="team-grid">

        <div class="team-card fade-up">
            <div class="team-avatar">K</div>
            <h4>Kushal Gurung</h4>
            <span>Co-Founder & CEO</span>
        </div>

        <div class="team-card fade-up">
            <div class="team-avatar">S</div>
            <h4>Sagun Gurung</h4>
            <span>Co-Founder & CTO</span>
        </div>

        <div class="team-card fade-up">
            <div class="team-avatar">I</div>
            <h4>Indra Bahadur Thakuri</h4>
            <span>Head of Design</span>
        </div>

        <div class="team-card fade-up">
            <div class="team-avatar">D</div>
            <h4>Dikshya Thapa</h4>
            <span>Operations Manager</span>
        </div>

        <div class="team-card fade-up">
            <div class="team-avatar">B</div>
            <h4>Bishnu Chhetri</h4>
            <span>Marketing Lead</span>
        </div>

        <div class="team-card fade-up">
            <div class="team-avatar">R</div>
            <h4>Rabina Pradhan</h4>
            <span>Finance & Support</span>
        </div>

    </div>
</section>

<section class="cta-section">
    <div class="cta-inner">
        <h2>Ready to Order?</h2>
        <p>Browse our full menu and get your favourite meal delivered straight to your door, hot, fresh, and fast.</p>
        <a href="${pageContext.request.contextPath}/food" class="btn btn-primary" style="font-size: 1.1rem; padding: 1rem 2.5rem;">
            Order Now
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/templates/footer.jsp" %>

<script>
    const fadeEls = document.querySelectorAll('.fade-up');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                const siblings = Array.from(entry.target.parentElement.querySelectorAll('.fade-up'));
                const delay = siblings.indexOf(entry.target) * 100;
                setTimeout(() => {
                    entry.target.classList.add('visible');
                }, delay);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.12 });

    fadeEls.forEach(el => observer.observe(el));
</script>

</body>
</html>