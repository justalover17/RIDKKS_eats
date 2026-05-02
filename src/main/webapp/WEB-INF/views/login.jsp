<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Login Modal -->
<div class="modal" id="loginModal">
    <button class="close-btn">&times;</button>
    <div class="modal-split">
        <div class="modal-img" style="background-image: url('${pageContext.request.contextPath}/static/images/login.png');"></div>
        <div class="modal-content">
            <h2>Welcome Back</h2>
            <p>Login to your Riddik's Eats account.</p>
            <div id="loginErrorMsg" style="color:red; display:none; margin-bottom:10px; text-align:center; font-weight:600;"></div>
            <form action="${pageContext.request.contextPath}/login" method="post" class="modal-form">
                <div class="input-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="user@gmail.com" required>
                </div>
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
            <p class="modal-switch">Don't have an account? <a href="#" id="toRegister">Register</a></p>
        </div>
    </div>
</div>