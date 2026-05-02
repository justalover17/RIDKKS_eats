<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Register Modal -->
<div class="modal" id="registerModal">
    <button class="close-btn">&times;</button>
    <div class="modal-split">
        <div class="modal-img" style="background-image: url('${pageContext.request.contextPath}/static/images/login.png');"></div>
        <div class="modal-content">
            <h2>Create Account</h2>
            <p>Join Riddik's Eats today.</p>
            <div id="registerErrorMsg" style="color:red; display:none; margin-bottom:10px; text-align:center; font-weight:600;"></div>
            <form action="${pageContext.request.contextPath}/register" method="post" class="modal-form" id="registerForm">
                <!-- Hidden input for the combined name the backend expects -->
                <input type="hidden" name="name" id="combinedName">

                <div class="input-row">
                    <div class="input-group">
                        <label>First Name</label>
                        <input type="text" id="firstName" placeholder="Sita" required>
                    </div>
                    <div class="input-group">
                        <label>Last Name</label>
                        <input type="text" id="lastName" placeholder="Gurung" required>
                    </div>
                </div>
                <div class="input-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="user@gmail.com" required>
                </div>
                <div class="input-group">
                    <label>Mobile Number</label>
                    <input type="tel" name="phone" placeholder="+977 9800000000" required>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label>Password</label>
                        <input type="password" name="password" id="regPassword" placeholder="••••••••" required>
                    </div>
                    <div class="input-group">
                        <label>Confirm Password</label>
                        <input type="password" id="confirmPassword" placeholder="••••••••" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
            <p class="modal-switch">Already have an account? <a href="#" id="toLogin">Sign In</a></p>
        </div>
    </div>
</div>