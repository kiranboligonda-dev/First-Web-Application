<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.kiran.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products - Kiran Kumar Paints</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="main-layout">
    <!-- Sidebar Filter -->
    <aside class="sidebar">
        <h3>Filter by Category</h3>
        <ul>
            <li><a href="products">All Products</a></li>
            <li><a href="products?category=Interior">Interior</a></li>
            <li><a href="products?category=Exterior">Exterior</a></li>
            <li><a href="products?category=Enamel">Enamel</a></li>
            <li><a href="products?category=Primer">Primer</a></li>
        </ul>

        <!-- Sidebar Search -->
        <h3>Search</h3>
        <form method="get" action="products" class="sidebar-search">
            <input type="text" name="search"
                   value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>"
                   placeholder="Search paints..." class="sidebar-search-input"/>
            <button type="submit" class="sidebar-search-btn">🔍</button>
        </form>

        <h3>Price Range</h3>
        <input type="range" min="0" max="2000" value="2000" id="priceRange"
               oninput="document.getElementById('priceLabel').innerText = '₹' + this.value">
        <p>Up to <span id="priceLabel">₹2000</span></p>
    </aside>

    <!-- Product Grid -->
    <div class="product-section">

        <!-- ✅ Show search heading or category heading -->
        <%
            String searchQuery = (String) request.getAttribute("searchQuery");
            String selectedCat = (String) request.getAttribute("selectedCategory");
            List<Product> products = (List<Product>) request.getAttribute("products");
        %>

        <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
            <h2>Search Results for "<%= searchQuery %>"
                <small style="font-size:14px; color:#888;">
                    (<%= products != null ? products.size() : 0 %> results)
                </small>
            </h2>
            <a href="products" style="font-size:13px; color:#f5a623;">← Clear search</a>
        <% } else if (selectedCat != null) { %>
            <h2><%= selectedCat %> Paints</h2>
        <% } else { %>
            <h2>All Paints</h2>
        <% } %>

        <!-- ✅ No results message -->
        <% if (products == null || products.isEmpty()) { %>
            <div class="no-results">
                <div style="font-size:60px;">🎨</div>
                <h3>No products found</h3>
                <% if (searchQuery != null) { %>
                    <p>No results for "<%= searchQuery %>". Try a different keyword.</p>
                <% } else { %>
                    <p>No products available in this category yet.</p>
                <% } %>
                <a href="products" class="btn-gold">View All Products</a>
            </div>
        <% } else { %>
        <div class="product-grid">
            <%
                for (Product p : products) {
            %>
            <div class="product-card">
                <img src="<%= p.getImageUrl() %>"
                     alt="<%= p.getName() %>"
                     class="product-img-real"
                     onerror="this.src='images/default-paint.png'; this.onerror=null;">
                <div class="product-info">
                    <h4><%= p.getName() %></h4>
                    <p class="category"><%= p.getCategory() %></p>
                    <div class="rating">
                        ⭐ <%= p.getRating() %> / 5
                    </div>
                    <div class="price">₹<%= String.format("%.2f", p.getPrice()) %></div>
                    <p class="description"><%= p.getDescription() %></p>
                    <form method="post" action="cart">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <input type="hidden" name="action" value="add">
                        <button type="submit" class="btn-add-cart">Add to Cart 🛒</button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
