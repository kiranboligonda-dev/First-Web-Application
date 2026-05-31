<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Login - Kiran Kumar Paints</title>
<link rel="stylesheet" href="css/style.css"></head>
<body>
<%@ include file="navbar.jsp" %>
<div class="auth-container">
    <h2>Sign In</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <form method="post" action="login">
        <label>Email</label>
        <input type="email" name="email" required>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn-primary">Sign In</button>
    </form>
    <p>New customer? <a href="register">Create account</a></p>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>