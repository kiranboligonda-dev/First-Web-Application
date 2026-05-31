<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.kiran.model.User" %>
<nav class="navbar">
    <div class="nav-logo">🎨 <span>Kiran Kumar</span> Paints</div>
    <div class="nav-search">
        <input type="text" placeholder="Search paints, colours, brands...">
        <button>🔍</button>
    </div>
    <div class="nav-links">
        <%
            User loggedUser = (User) session.getAttribute("loggedUser");
            if (loggedUser != null) {
        %>
            <span class="nav-hello">Hello, <%= loggedUser.getUsername() %></span>
            <a href="logout">Sign Out</a>
        <% } else { %>
            <a href="login">Sign In</a>
            <a href="register">Register</a>
        <% } %>
        <a href="cart" class="nav-cart">🛒 Cart</a>
    </div>
</nav>