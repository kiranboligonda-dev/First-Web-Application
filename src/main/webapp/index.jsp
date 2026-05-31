<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.kiran.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kiran Kumar Paints - Home</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
    /* ========== LOBBY WALL ========== */
    .lobby-section{width:100%;background:#1a1a2e;overflow:hidden;}
    .lobby-wall{display:flex;width:100%;height:280px;}
    .wall-panel{flex:1;position:relative;cursor:pointer;overflow:hidden;transition:flex 0.45s cubic-bezier(0.4,0,0.2,1);}
    .wall-panel:hover{flex:2.2;}
    .wall-sheen{position:absolute;top:0;left:0;width:30%;height:100%;background:rgba(255,255,255,0.07);pointer-events:none;}
    .wall-brush{position:absolute;top:0;right:0;width:5px;height:100%;background:rgba(255,255,255,0.13);}
    .wall-label{position:absolute;bottom:0;left:0;right:0;padding:10px 13px;background:rgba(0,0,0,0.52);opacity:0;transition:opacity 0.3s;}
    .wall-panel:hover .wall-label{opacity:1;}
    .wall-label p{color:#fff;font-size:13px;font-weight:700;margin:0 0 2px;}
    .wall-label span{color:#f5a623;font-size:11px;}
    .lobby-swatch-bar{background:#111;padding:13px 0 0;}
    .lobby-swatch-title{text-align:center;color:#f5a623;font-size:11px;letter-spacing:2px;text-transform:uppercase;padding-bottom:11px;font-family:Arial,sans-serif;}
    .lobby-swatches{display:flex;overflow-x:auto;scrollbar-width:none;}
    .lobby-swatches::-webkit-scrollbar{display:none;}
    .lobby-swatch{flex:1;min-width:68px;height:60px;display:flex;flex-direction:column;align-items:center;justify-content:flex-end;padding-bottom:5px;cursor:pointer;position:relative;transition:transform 0.2s;}
    .lobby-swatch:hover{transform:scaleY(1.15);transform-origin:bottom;}
    .swatch-ring{position:absolute;top:5px;left:50%;transform:translateX(-50%);width:10px;height:10px;border-radius:50%;background:white;display:none;}
    .lobby-swatch.active .swatch-ring{display:block;}
    .sw-name{font-size:9px;color:rgba(255,255,255,0.88);font-family:Arial,sans-serif;text-align:center;}
    .sw-code{font-size:8px;color:rgba(255,255,255,0.48);font-family:monospace;}
    .lobby-info-bar{background:#0d0d1a;padding:13px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;}
    .lobby-info-left{display:flex;align-items:center;gap:14px;}
    .lobby-color-dot{width:36px;height:36px;border-radius:50%;border:3px solid #f5a623;flex-shrink:0;transition:background 0.3s;}
    .lobby-color-name{color:#fff;font-size:14px;font-weight:700;margin:0;font-family:Arial,sans-serif;}
    .lobby-color-code{color:#888;font-size:11px;font-family:Arial,sans-serif;}
    .lobby-info-right{display:flex;align-items:center;gap:10px;flex-wrap:wrap;}
    .lobby-tag{padding:4px 12px;border-radius:20px;font-size:11px;font-weight:700;letter-spacing:0.5px;font-family:Arial,sans-serif;}
    .lobby-tag-finish{background:#f5a623;color:#1a1a2e;}
    .lobby-tag-type{background:#2C5F8A;color:#fff;}
    .lobby-browse-btn{padding:7px 16px;background:transparent;border:1.5px solid #f5a623;color:#f5a623;border-radius:6px;font-size:12px;font-weight:700;text-decoration:none;transition:background 0.2s,color 0.2s;font-family:Arial,sans-serif;}
    .lobby-browse-btn:hover{background:#f5a623;color:#1a1a2e;}

    /* ========== PAINTED SLIDER ========== */
    .painted-slider-section{padding:40px 0 32px;background:linear-gradient(180deg,#fffbf5 0%,#fff8ee 100%);overflow:hidden;}
    .ps-head{text-align:center;padding:0 16px;margin-bottom:12px;}
    .ps-cats{display:flex;justify-content:center;gap:8px;flex-wrap:wrap;padding:0 16px;margin:16px 0 20px;}
    .ps-cat{padding:6px 18px;font-size:13px;border:1.5px solid #d4b896;border-radius:24px;background:#fff;color:#7a4a1a;cursor:pointer;transition:all 0.2s;font-family:inherit;}
    .ps-cat.active,.ps-cat:hover{background:#e87820;color:#fff;border-color:#e87820;}
    .ps-outer{overflow:hidden;position:relative;width:100%;}
    .ps-outer::before,.ps-outer::after{content:'';position:absolute;top:0;bottom:0;width:80px;z-index:3;pointer-events:none;}
    .ps-outer::before{left:0;background:linear-gradient(to right,#fffbf5,transparent);}
    .ps-outer::after{right:0;background:linear-gradient(to left,#fffbf5,transparent);}
    .ps-track{display:flex;gap:16px;padding:6px 10px 10px;animation:ps-marquee 38s linear infinite;width:max-content;}
    .ps-track:hover,.ps-track.ps-paused{animation-play-state:paused;}
    @keyframes ps-marquee{0%{transform:translateX(0)}100%{transform:translateX(-50%)}}
    .ps-card{width:230px;flex-shrink:0;border-radius:14px;overflow:hidden;background:#fff;border:1px solid #ead9c4;cursor:pointer;transition:transform 0.25s ease,box-shadow 0.25s ease;text-decoration:none;display:block;}
    .ps-card:hover{transform:translateY(-7px);box-shadow:0 14px 36px rgba(100,50,0,0.16);}
    .ps-card img{width:230px;height:155px;object-fit:cover;display:block;background:#f0e8d8;}
    .ps-card-body{padding:10px 13px 13px;}
    .ps-badge{display:inline-block;font-size:10px;font-weight:600;padding:2px 9px;border-radius:10px;margin-bottom:6px;text-transform:uppercase;letter-spacing:0.4px;}
    .ps-badge-ext{background:#fff3e0;color:#b85a00;}
    .ps-badge-int{background:#e8f5e9;color:#1b6e2e;}
    .ps-badge-tex{background:#f3e5f5;color:#6a1b9a;}
    .ps-card-name{font-size:13px;font-weight:700;color:#3a2200;line-height:1.3;margin-bottom:4px;}
    .ps-card-shade{font-size:11px;color:#9a7a5a;display:flex;align-items:center;gap:5px;}
    .ps-color-dot{width:10px;height:10px;border-radius:50%;flex-shrink:0;border:1px solid rgba(0,0,0,0.1);display:inline-block;}
    .ps-nav{display:flex;justify-content:center;gap:12px;margin-top:16px;}
    .ps-nav-btn{width:36px;height:36px;border-radius:50%;border:1.5px solid #d4b896;background:#fff;color:#7a4a1a;font-size:15px;cursor:pointer;transition:all 0.2s;font-family:inherit;}
    .ps-nav-btn:hover{background:#e87820;color:#fff;border-color:#e87820;}
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- LOBBY WALL COLOUR SECTION -->
<div class="lobby-section">
    <div class="lobby-wall">
        <div class="wall-panel" style="background:#C8A882;" data-name="Sandy Dune"      data-code="KK-201" data-finish="Matte"  data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Sandy Dune</p><span>KK-201</span></div></div>
        <div class="wall-panel" style="background:#4A7FA5;" data-name="Ocean Mist"      data-code="KK-114" data-finish="Satin"  data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Ocean Mist</p><span>KK-114</span></div></div>
        <div class="wall-panel" style="background:#2E7D32;" data-name="Forest Green"    data-code="KK-388" data-finish="Matte"  data-type="Exterior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Forest Green</p><span>KK-388</span></div></div>
        <div class="wall-panel" style="background:#8B2635;" data-name="Royal Maroon"    data-code="KK-445" data-finish="Gloss"  data-type="Exterior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Royal Maroon</p><span>KK-445</span></div></div>
        <div class="wall-panel" style="background:#F5C842;" data-name="Sunshine Yellow" data-code="KK-302" data-finish="Satin"  data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Sunshine Yellow</p><span>KK-302</span></div></div>
        <div class="wall-panel" style="background:#5B4A8A;" data-name="Royal Violet"    data-code="KK-521" data-finish="Velvet" data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Royal Violet</p><span>KK-521</span></div></div>
        <div class="wall-panel" style="background:#E8825A;" data-name="Terracotta"      data-code="KK-178" data-finish="Matte"  data-type="Exterior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Terracotta</p><span>KK-178</span></div></div>
        <div class="wall-panel" style="background:#37474F;" data-name="Slate Storm"     data-code="KK-612" data-finish="Satin"  data-type="Exterior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Slate Storm</p><span>KK-612</span></div></div>
        <div class="wall-panel" style="background:#F0EAD6;" data-name="Pearl White"     data-code="KK-101" data-finish="Velvet" data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label" style="background:rgba(0,0,0,0.55);"><p>Pearl White</p><span>KK-101</span></div></div>
        <div class="wall-panel" style="background:#1A6B6B;" data-name="Teal Breeze"     data-code="KK-490" data-finish="Satin"  data-type="Interior"><div class="wall-sheen"></div><div class="wall-brush"></div><div class="wall-label"><p>Teal Breeze</p><span>KK-490</span></div></div>
    </div>
    <div class="lobby-swatch-bar">
        <p class="lobby-swatch-title">10,000+ Colour Shades — Hover to Preview</p>
        <div class="lobby-swatches">
            <div class="lobby-swatch active" style="background:#C8A882;" data-idx="0"><div class="swatch-ring"></div><span class="sw-name">Sandy Dune</span><span class="sw-code">KK-201</span></div>
            <div class="lobby-swatch" style="background:#4A7FA5;" data-idx="1"><div class="swatch-ring"></div><span class="sw-name">Ocean Mist</span><span class="sw-code">KK-114</span></div>
            <div class="lobby-swatch" style="background:#2E7D32;" data-idx="2"><div class="swatch-ring"></div><span class="sw-name">Forest Green</span><span class="sw-code">KK-388</span></div>
            <div class="lobby-swatch" style="background:#8B2635;" data-idx="3"><div class="swatch-ring"></div><span class="sw-name">Royal Maroon</span><span class="sw-code">KK-445</span></div>
            <div class="lobby-swatch" style="background:#F5C842;" data-idx="4"><div class="swatch-ring"></div><span class="sw-name">Sunshine</span><span class="sw-code">KK-302</span></div>
            <div class="lobby-swatch" style="background:#5B4A8A;" data-idx="5"><div class="swatch-ring"></div><span class="sw-name">Royal Violet</span><span class="sw-code">KK-521</span></div>
            <div class="lobby-swatch" style="background:#E8825A;" data-idx="6"><div class="swatch-ring"></div><span class="sw-name">Terracotta</span><span class="sw-code">KK-178</span></div>
            <div class="lobby-swatch" style="background:#37474F;" data-idx="7"><div class="swatch-ring"></div><span class="sw-name">Slate Storm</span><span class="sw-code">KK-612</span></div>
            <div class="lobby-swatch" style="background:#F0EAD6;" data-idx="8"><div class="swatch-ring"></div><span class="sw-name">Pearl White</span><span class="sw-code">KK-101</span></div>
            <div class="lobby-swatch" style="background:#1A6B6B;" data-idx="9"><div class="swatch-ring"></div><span class="sw-name">Teal Breeze</span><span class="sw-code">KK-490</span></div>
        </div>
    </div>
    <div class="lobby-info-bar">
        <div class="lobby-info-left">
            <div class="lobby-color-dot" id="lobbyDot" style="background:#C8A882;"></div>
            <div>
                <p class="lobby-color-name" id="lobbyName">Sandy Dune</p>
                <span class="lobby-color-code" id="lobbyCode">KK-201 &nbsp;|&nbsp; Hover any shade to explore</span>
            </div>
        </div>
        <div class="lobby-info-right">
            <span class="lobby-tag lobby-tag-finish" id="lobbyFinish">Matte</span>
            <span class="lobby-tag lobby-tag-type" id="lobbyType">Interior</span>
            <a href="products" class="lobby-browse-btn">Browse All Shades &rarr;</a>
        </div>
    </div>
</div>

<!-- TICKER -->
<div class="ticker">
    🚚 Free Delivery on orders above ₹2000 &nbsp;|&nbsp;
    🎨 10,000+ Colour Shades &nbsp;|&nbsp;
    🏆 Trusted Since 1995 &nbsp;|&nbsp;
    📞 Call: 8106584467 &nbsp;|&nbsp;
    🌏 Available All Over India
</div>

<!-- HERO SECTION -->
<div class="hero">
    <div class="hero-text">
        <h1>India's Trusted<br><span>Paint Store</span></h1>
        <p>From vibrant interiors to weather-proof exteriors — Kiran Kumar Paints brings you premium quality paints at unbeatable prices, delivered pan-India.</p>
        <div class="hero-badges">
            <span class="badge">✅ ISI Certified</span>
            <span class="badge">🌿 Eco-Friendly</span>
            <span class="badge">🏠 Pan India Delivery</span>
        </div>
        <div class="hero-search">
            <form method="get" action="products" class="hero-search-form">
                <input type="text" name="search" placeholder="Search paints, colours, brands..." class="hero-search-input" />
                <button type="submit" class="hero-search-btn">🔍 Search</button>
            </form>
            <div class="quick-links">
                <span>Popular:</span>
                <a href="products?search=Asian Paints">Asian Paints</a>
                <a href="products?search=Berger">Berger</a>
                <a href="products?category=Interior">Interior</a>
                <a href="products?category=Exterior">Exterior</a>
            </div>
        </div>
        <div class="hero-btns">
            <a href="products" class="btn-gold">Shop Now</a>
            <a href="products" class="btn-outline">Browse Colour Shades</a>
        </div>
    </div>
    <div class="hero-stats">
        <div class="stat-box"><div class="num">30+</div><div class="lbl">Years Experience</div></div>
        <div class="stat-box"><div class="num">50,000+</div><div class="lbl">Happy Customers</div></div>
        <div class="stat-box"><div class="num">500+</div><div class="lbl">Paint Products</div></div>
    </div>
</div>

<!-- CATEGORIES -->
<div class="section">
    <h2 class="section-title">Shop by Category</h2>
    <div class="underline"></div>
    <div class="cat-grid">
        <a href="products?category=Interior"    class="cat-card"><div class="cat-icon">🏠</div><h4>Interior Paints</h4><p>120+ shades</p></a>
        <a href="products?category=Exterior"    class="cat-card"><div class="cat-icon">🏗️</div><h4>Exterior Paints</h4><p>Weatherproof</p></a>
        <a href="products?category=Enamel"      class="cat-card"><div class="cat-icon">✨</div><h4>Enamel Paints</h4><p>High gloss</p></a>
        <a href="products?category=Primer"      class="cat-card"><div class="cat-icon">🎨</div><h4>Primers</h4><p>Better adhesion</p></a>
        <a href="products?category=WoodPolish"  class="cat-card"><div class="cat-icon">🪵</div><h4>Wood Polish</h4><p>Rich finish</p></a>
        <a href="products?category=Texture"     class="cat-card"><div class="cat-icon">🧱</div><h4>Texture Paint</h4><p>Decorative</p></a>
    </div>
</div>

<!-- COLOUR INSPIRATION SLIDER -->
<div class="painted-slider-section">
    <div class="ps-head">
        <h2 class="section-title">🏠 Colour Inspiration Gallery</h2>
        <p class="section-sub">Real homes painted beautifully — hover to pause, click to explore</p>
    </div>
    <div class="underline"></div>
    <div class="ps-cats">
        <button class="ps-cat active" onclick="psFilter('all',this)">All</button>
        <button class="ps-cat" onclick="psFilter('Exterior',this)">Exterior</button>
        <button class="ps-cat" onclick="psFilter('Interior',this)">Interior</button>
        <button class="ps-cat" onclick="psFilter('Texture',this)">Texture &amp; D&#233;cor</button>
    </div>
    <div class="ps-outer">
        <div class="ps-track" id="psTrack"></div>
    </div>
    <div class="ps-nav">
        <button class="ps-nav-btn" onclick="psNudge(-1)">&#8592;</button>
        <button class="ps-nav-btn" onclick="psToggle()" id="psPlayBtn">&#10074;&#10074;</button>
        <button class="ps-nav-btn" onclick="psNudge(1)">&#8594;</button>
    </div>
    <div style="text-align:center;margin-top:20px;">
        <a href="products" class="btn-gold">Explore All Paints &rarr;</a>
    </div>
</div>

<!-- FEATURED PRODUCTS -->
<div style="background:white;padding:8px 0;">
<div class="section">
    <h2 class="section-title">⭐ Top Rated Products</h2>
    <p class="section-sub">Best sellers — trusted by lakhs of Indian households</p>
    <div class="underline"></div>
    <div class="product-grid">
        <%
            List<Product> featured = (List<Product>) request.getAttribute("featuredProducts");
            if (featured != null) { for (Product p : featured) {
        %>
        <div class="product-card">
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>" class="product-img-real"
                 onerror="this.src='images/default-paint.png'; this.onerror=null;">
            <div class="product-body">
                <div class="product-brand">Kiran Kumar Paints</div>
                <div class="product-name"><%= p.getName() %></div>
                <div class="product-cat"><%= p.getCategory() %></div>
                <div class="stars">
                    <% double rating = p.getRating();
                       for (int s = 1; s <= 5; s++) { if (s <= rating) out.print("★"); else out.print("☆"); } %>
                    <%= rating %>
                </div>
                <div class="product-price">
                    &#8377;<%= String.format("%.0f", p.getPrice()) %>
                    <span>&#8377;<%= String.format("%.0f", p.getPrice() * 1.2) %></span>
                    <small>20% off</small>
                </div>
                <form method="post" action="cart">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn-cart">Add to Cart 🛒</button>
                </form>
            </div>
        </div>
        <% } } %>
    </div>
    <div style="text-align:center;margin-top:24px;">
        <a href="products" class="btn-gold">View All Products &rarr;</a>
    </div>
</div>
</div>

<!-- INTERIOR PRODUCTS -->
<%
    List<Product> interior = (List<Product>) request.getAttribute("interiorProducts");
    if (interior != null && !interior.isEmpty()) {
%>
<div class="section">
    <h2 class="section-title">🏠 Interior Paints</h2>
    <div class="underline"></div>
    <div class="product-grid">
        <% for (Product p : interior) { %>
        <div class="product-card">
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>" class="product-img-real"
                 onerror="this.src='images/default-paint.png'; this.onerror=null;">
            <div class="product-body">
                <div class="product-name"><%= p.getName() %></div>
                <div class="product-cat"><%= p.getCategory() %></div>
                <div class="stars">★★★★★ <%= p.getRating() %></div>
                <div class="product-price">&#8377;<%= String.format("%.0f", p.getPrice()) %></div>
                <form method="post" action="cart">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn-cart">Add to Cart 🛒</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
    <a href="products?category=Interior" class="see-all">See all Interior Paints &rarr;</a>
</div>
<% } %>

<!-- WHY CHOOSE US -->
<div style="background:#f9f9f6;padding:8px 0;">
<div class="section">
    <h2 class="section-title">Why Choose Kiran Kumar Paints?</h2>
    <div class="underline"></div>
    <div class="why-grid">
        <div class="why-card"><div class="why-icon">🏆</div><h4>30+ Years Trust</h4><p>Serving India since 1995 with quality you can rely on</p></div>
        <div class="why-card"><div class="why-icon">🌿</div><h4>Eco-Friendly</h4><p>Low VOC, lead-free paints safe for your family</p></div>
        <div class="why-card"><div class="why-icon">🚚</div><h4>Pan India Delivery</h4><p>Fast delivery to all states across India</p></div>
        <div class="why-card"><div class="why-icon">🎨</div><h4>10,000+ Shades</h4><p>Widest colour range for every taste and style</p></div>
        <div class="why-card"><div class="why-icon">💰</div><h4>Best Prices</h4><p>Direct from manufacturer — no middleman markup</p></div>
        <div class="why-card"><div class="why-icon">📞</div><h4>Expert Support</h4><p>Free colour consultation by our paint experts</p></div>
    </div>
</div>
</div>

<!-- CONTACT STRIP -->
<div class="contact-strip">
    <div class="contact-item"><div class="contact-icon">📞</div><h4>Call Us</h4><p>8106584467</p></div>
    <div class="contact-item"><div class="contact-icon">✉️</div><h4>Email Us</h4><p>kiranpaints@gmail.com</p></div>
    <div class="contact-item"><div class="contact-icon">📍</div><h4>Availability</h4><p>All Over India</p></div>
    <div class="contact-item"><div class="contact-icon">🕐</div><h4>Working Hours</h4><p>Mon–Sat: 9AM – 7PM</p></div>
</div>

<%@ include file="footer.jsp" %>

<script>
(function(){
    var panels=document.querySelectorAll('.wall-panel');
    var swatches=document.querySelectorAll('.lobby-swatch');
    var dot=document.getElementById('lobbyDot');
    var nameEl=document.getElementById('lobbyName');
    var codeEl=document.getElementById('lobbyCode');
    var finishEl=document.getElementById('lobbyFinish');
    var typeEl=document.getElementById('lobbyType');
    function activate(idx){
        swatches.forEach(function(s){s.classList.remove('active');});
        swatches[idx].classList.add('active');
        var p=panels[idx];
        dot.style.background=p.style.background;
        nameEl.textContent=p.dataset.name;
        codeEl.textContent=p.dataset.code+'  |  Hover any shade to explore';
        finishEl.textContent=p.dataset.finish;
        typeEl.textContent=p.dataset.type;
    }
    panels.forEach(function(p,i){p.addEventListener('mouseenter',function(){activate(i);});});
    swatches.forEach(function(s){s.addEventListener('click',function(){activate(parseInt(s.dataset.idx));});});
})();
</script>

<script>
(function(){
    var psSlides=[
        {name:"Vibrant Yellow Villa",     shade:"Golden Mustard", dot:"#F5C518", tag:"Exterior", img:"https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Teal Interior Bedroom",    shade:"Ocean Breeze",   dot:"#3AB4B4", tag:"Interior", img:"https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Classic Blue Exterior",    shade:"Royal Navy",     dot:"#1A4A8A", tag:"Exterior", img:"https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Warm Ivory Living Room",   shade:"Ivory Cream",    dot:"#E8D5A0", tag:"Interior", img:"https://images.pexels.com/photos/1080721/pexels-photo-1080721.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Terracotta Bungalow",      shade:"Burnt Sienna",   dot:"#C4622D", tag:"Exterior", img:"https://images.pexels.com/photos/2635038/pexels-photo-2635038.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Stone Grey Texture",       shade:"Ash Stone",      dot:"#8C8C8C", tag:"Texture",  img:"https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Bright White Modern Home", shade:"Arctic White",   dot:"#F0EDE6", tag:"Exterior", img:"https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Sage Green Bedroom",       shade:"Forest Sage",    dot:"#7DAF7D", tag:"Interior", img:"https://images.pexels.com/photos/1454806/pexels-photo-1454806.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Brick Red Facade",         shade:"Heritage Red",   dot:"#A63228", tag:"Exterior", img:"https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Pastel Blue Room",         shade:"Sky Mist",       dot:"#9AC8DE", tag:"Interior", img:"https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Venetian Beige Texture",   shade:"Venetian Beige", dot:"#C8A87A", tag:"Texture",  img:"https://images.pexels.com/photos/1571458/pexels-photo-1571458.jpeg?auto=compress&cs=tinysrgb&w=460"},
        {name:"Charcoal Dark Exterior",   shade:"Graphite Storm", dot:"#3A3A3A", tag:"Exterior", img:"https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=460"},
    ];
    var psPaused=false;
    var psTrack=document.getElementById('psTrack');
    if(!psTrack) return;
    function badgeClass(t){return t==='Exterior'?'ps-badge-ext':t==='Interior'?'ps-badge-int':'ps-badge-tex';}
    function psBuild(filter){
        psTrack.innerHTML='';
        var list=filter==='all'?psSlides:psSlides.filter(function(s){return s.tag===filter;});
        list.concat(list).forEach(function(s){
            var a=document.createElement('a');
            a.className='ps-card'; a.href='products?category='+encodeURIComponent(s.tag);
            a.innerHTML='<img src="'+s.img+'" alt="'+s.name+'" loading="lazy" onerror="this.src=\'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg?auto=compress&cs=tinysrgb&w=460\'">'
                +'<div class="ps-card-body"><span class="ps-badge '+badgeClass(s.tag)+'">'+s.tag+'</span>'
                +'<div class="ps-card-name">'+s.name+'</div>'
                +'<div class="ps-card-shade"><span class="ps-color-dot" style="background:'+s.dot+'"></span>'+s.shade+'</div></div>';
            psTrack.appendChild(a);
        });
        if(psPaused) psTrack.classList.add('ps-paused');
    }
    window.psFilter=function(f,btn){document.querySelectorAll('.ps-cat').forEach(function(b){b.classList.remove('active');});btn.classList.add('active');psBuild(f);};
    window.psToggle=function(){psPaused=!psPaused;psTrack.classList.toggle('ps-paused',psPaused);document.getElementById('psPlayBtn').innerHTML=psPaused?'&#9654;':'&#10074;&#10074;';};
    window.psNudge=function(dir){psTrack.style.animation='none';psTrack.classList.add('ps-paused');var cur=parseInt(psTrack.getAttribute('data-offset')||0);cur-=(dir*246);psTrack.style.transform='translateX('+cur+'px)';psTrack.setAttribute('data-offset',cur);setTimeout(function(){psTrack.style.transform='';psTrack.style.animation='';if(!psPaused)psTrack.classList.remove('ps-paused');},700);};
    psBuild('all');
})();
</script>

</body>
</html>
