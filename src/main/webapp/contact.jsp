<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("pageTitle", "Contact Us | Ridkk's Eats");
  request.setAttribute("extraCss", "/static/css/page.css");
%>

<%@ include file="/WEB-INF/templates/head.jsp" %>
<body>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<main class="page-wrapper">
  <section class="page-title">
    <h1>Contact Us</h1>
    <p>Have a question or need help? Contact Ridkk's Eats support team.</p>
  </section>

  <section style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; align-items: start;">
    <div class="info-card" style="padding: 2rem;">
      <h2 style="margin-bottom: 1rem;">Get in Touch</h2>

      <p class="muted" style="line-height: 1.7; margin-bottom: 1.5rem;">
        Ridkk's Eats is always ready to help customers with food orders,
        menu information, delivery support, and general inquiries.
      </p>

      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <div style="padding: 1rem; background: #fff5f5; border-radius: 12px; border: 1px solid #ffd6d6;">
          <h4 style="margin-bottom: 0.3rem;">Address</h4>
          <p class="muted">Pokhara-17, Birauta, Nepal</p>
        </div>

        <div style="padding: 1rem; background: #fff5f5; border-radius: 12px; border: 1px solid #ffd6d6;">
          <h4 style="margin-bottom: 0.3rem;">Phone</h4>
          <p class="muted">+977 9845342311</p>
        </div>

        <div style="padding: 1rem; background: #fff5f5; border-radius: 12px; border: 1px solid #ffd6d6;">
          <h4 style="margin-bottom: 0.3rem;">Email</h4>
          <p class="muted">ridkk'seats@gmail.com</p>
        </div>

        <div style="padding: 1rem; background: #fff5f5; border-radius: 12px; border: 1px solid #ffd6d6;">
          <h4 style="margin-bottom: 0.3rem;">Opening Hours</h4>
          <p class="muted">Sunday - Friday: 9:00 AM - 9:00 PM</p>
        </div>
      </div>
    </div>

    <div class="form-card" style="max-width: 100%; margin: 0;">
      <h2 style="margin-bottom: 1.5rem;">Send Message</h2>

      <form onsubmit="showContactMessage(event)">
        <div class="field">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name" placeholder="Enter your full name" required>
        </div>

        <div class="field">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="Enter your email address" required>
        </div>

        <div class="field">
          <label for="subject">Subject</label>
          <input type="text" id="subject" name="subject" placeholder="Enter message subject" required>
        </div>

        <div class="field">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="6" placeholder="Write your message here..." required></textarea>
        </div>

        <button type="submit" class="btn btn-primary" style="width: 100%;">
          Submit Message
        </button>
      </form>

      <div id="contactSuccess"
           style="display:none; margin-top: 1rem; padding: 1rem; background:#e9f9ef; color:#166534; border:1px solid #bbf7d0; border-radius:12px; font-weight:600;">
        Your message has been submitted successfully.
      </div>
    </div>
  </section>
</main>

<%@ include file="/WEB-INF/templates/footer.jsp" %>

<script>
  function showContactMessage(event) {
    event.preventDefault();

    const successBox = document.getElementById("contactSuccess");

    if (successBox) {
      successBox.style.display = "block";
    }

    event.target.reset();
  }
</script>

</body>
</html>