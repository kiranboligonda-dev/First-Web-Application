<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Register - Kiran Kumar Paints</title>
<link rel="stylesheet" href="css/style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div class="auth-container">
    <h2>Create Account</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <form method="post" action="register">
        <label>Full Name</label>
        <input type="text" name="username" required>
        <label>Email</label>
        <input type="email" name="email" required>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn-primary">Create Account</button>
    </form>
    <p>Already have an account? <a href="login">Sign In</a></p>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>