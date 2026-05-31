<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, java.util.Map, com.kiran.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Cart - Kiran Kumar Paints</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="cart-container">
    <h2>🛒 My Shopping Cart</h2>
    <%
        List<Product> cartProducts = (List<Product>) request.getAttribute("cartProducts");
        Map<Integer, Integer> cartMap = (Map<Integer, Integer>) request.getAttribute("cartMap");
        Double total = (Double) request.getAttribute("total");
        if (cartProducts == null || cartProducts.isEmpty()) {
    %>
        <p class="empty-cart">Your cart is empty. <a href="products">Shop Now</a></p>
    <% } else { %>
    <div class="cart-layout">
        <div class="cart-items">
            <% for (Product p : cartProducts) {
                int qty = cartMap.getOrDefault(p.getId(), 1); %>
            <div class="cart-item">
                <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                <div class="cart-item-details">
                    <h4><%= p.getName() %></h4>
                    <p>Category: <%= p.getCategory() %></p>
                    <p>Qty: <%= qty %></p>
                    <p class="price">₹<%= String.format("%.2f", p.getPrice() * qty) %></p>
                </div>
                <form method="post" action="cart">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="hidden" name="action" value="remove">
                    <button type="submit" class="btn-remove">Remove</button>
                </form>
            </div>
            <% } %>
        </div>
        <div class="cart-summary">
            <h3>Order Summary</h3>
            <p>Subtotal: <strong>₹<%= String.format("%.2f", total) %></strong></p>
            <p>Delivery: <strong>₹50.00</strong></p>
            <hr>
            <p>Total: <strong>₹<%= String.format("%.2f", total + 50) %></strong></p>
            <button class="btn-checkout">Proceed to Checkout</button>
        </div>
    </div>
    <% } %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>