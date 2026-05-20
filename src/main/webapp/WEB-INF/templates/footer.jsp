<footer class="footer">
  <div class="footer-container">
    <div class="footer-col brand-col">
      <div class="footer-logo">
        <img src="${pageContext.request.contextPath}/static/images/logo.png" alt="Ridkk's Eats" style="height: 35px; margin-right: 10px;">
        Ridkk's Eats
      </div>

      <div class="brand-desc-box">
        <p>Bringing the finest culinary experiences straight to your doorstep. Fresh, fast, and full of flavor.</p>
      </div>
    </div>

    <div class="footer-col">
      <h4>Information</h4>
      <ul>
        <li><a href="${pageContext.request.contextPath}/aboutus.jsp">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a></li>
        <li><a href="${pageContext.request.contextPath}/food">Menu</a></li>
        <li><a href="${pageContext.request.contextPath}/cart?action=view">Cart</a></li>
      </ul>
    </div>

    <div class="footer-col">
      <h4>Contact Info</h4>
      <ul class="contact-list">
        <li>Pokhara -17, Birauta</li>
        <li>+977 9845342311</li>
        <li>ridkk'seats@gmail.com</li>
      </ul>
    </div>

    <div class="footer-col">
      <h4>Social Media</h4>
      <div class="social-links">
        <a href="#" class="social-icon">
          <svg width="20" height="20" fill="currentColor" viewBox="0 0 24 24">
            <path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"></path>
          </svg>
          Facebook
        </a>

        <a href="#" class="social-icon">
          <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
            <path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37z"></path>
            <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
          </svg>
          Instagram
        </a>
      </div>
    </div>
  </div>

  <div class="footer-bottom">
    <p>&copy; 2026 Ridkk's Eats. All rights reserved.</p>
  </div>
</footer>

<script>
  function toggleProfileDropdown() {
    const dropdown = document.getElementById('profileDropdown');

    if (dropdown) {
      dropdown.style.display =
              dropdown.style.display === 'none' || dropdown.style.display === ''
                      ? 'block'
                      : 'none';
    }
  }

  window.addEventListener('click', function (event) {
    const container = document.querySelector('.profile-dropdown-container');
    const dropdown = document.getElementById('profileDropdown');

    if (container && dropdown && !container.contains(event.target)) {
      dropdown.style.display = 'none';
    }
  });
</script>