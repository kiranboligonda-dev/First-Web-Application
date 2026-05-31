<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.kiran.model.Product" %>
<%
    // Security check - redirect if not logged in
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
    String successMsg = (String) request.getAttribute("success");
    String errorMsg = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dealer Dashboard - Kiran Kumar Paints</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: #f4f6fb; color: #333; }

        /* TOP NAV */
        .topnav {
            background: #1a1a2e;
            color: white;
            padding: 14px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .topnav h1 { font-size: 18px; }
        .topnav h1 span { color: #f5a623; }
        .topnav-right { display: flex; gap: 16px; align-items: center; font-size: 13px; }
        .topnav-right a {
            color: #f5a623;
            text-decoration: none;
            padding: 6px 14px;
            border: 1px solid #f5a623;
            border-radius: 6px;
            font-size: 12px;
        }
        .topnav-right a:hover { background: #f5a623; color: #1a1a2e; }

        /* LAYOUT */
        .container { max-width: 1200px; margin: 0 auto; padding: 28px 20px; }

        /* STATS */
        .stats-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 28px; }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            border-left: 4px solid #f5a623;
        }
        .stat-card .num { font-size: 28px; font-weight: 700; color: #1a1a2e; }
        .stat-card .lbl { font-size: 12px; color: #888; margin-top: 4px; }

        /* ALERTS */
        .alert-success {
            background: #e8f8f0; border: 1px solid #4caf50; color: #2e7d32;
            padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 14px;
        }
        .alert-error {
            background: #fff0f0; border: 1px solid #f44336; color: #c62828;
            padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 14px;
        }

        /* ADD PRODUCT FORM */
        .card {
            background: white;
            border-radius: 12px;
            padding: 28px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            margin-bottom: 28px;
        }
        .card h2 { font-size: 17px; font-weight: 600; margin-bottom: 20px; color: #1a1a2e; border-bottom: 2px solid #f5a623; padding-bottom: 10px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full { grid-column: 1 / -1; }
        label { font-size: 12px; font-weight: 600; color: #555; }
        input, select, textarea {
            padding: 10px 12px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: 13px;
            font-family: 'Poppins', sans-serif;
            outline: none;
            transition: border-color 0.2s;
        }
        input:focus, select:focus, textarea:focus { border-color: #f5a623; }
        textarea { resize: vertical; min-height: 70px; }

        /* Image preview */
        .img-preview-row { display: flex; gap: 12px; align-items: flex-start; }
        .img-preview-row input { flex: 1; }
        .img-preview {
            width: 60px; height: 60px;
            border-radius: 8px;
            object-fit: cover;
            border: 2px solid #eee;
            background: #f9f9f9;
        }

        .btn-add {
            background: #f5a623; color: #1a1a2e;
            border: none; padding: 11px 28px;
            border-radius: 8px; font-size: 14px;
            font-weight: 700; cursor: pointer;
            font-family: 'Poppins', sans-serif;
            margin-top: 16px;
        }
        .btn-add:hover { background: #e69400; }

        /* PRODUCT TABLE */
        .table-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .search-bar input {
            padding: 9px 14px; border: 1.5px solid #e0e0e0;
            border-radius: 8px; font-size: 13px; width: 240px;
        }
        table { width: 100%; border-collapse: collapse; font-size: 13px; }
        th {
            background: #1a1a2e; color: white;
            padding: 12px 14px; text-align: left;
            font-weight: 600; font-size: 12px;
        }
        td { padding: 12px 14px; border-bottom: 1px solid #f0f0f0; vertical-align: middle; }
        tr:hover td { background: #fffdf5; }
        .prod-img { width: 48px; height: 48px; object-fit: cover; border-radius: 6px; border: 1px solid #eee; }
        .cat-badge {
            padding: 3px 10px; border-radius: 20px;
            font-size: 11px; font-weight: 600;
            background: #fff3e0; color: #e65100;
        }
        .btn-edit {
            padding: 5px 12px; background: #e3f2fd;
            color: #1565c0; border: none; border-radius: 6px;
            cursor: pointer; font-size: 12px; font-weight: 600;
            font-family: 'Poppins', sans-serif; margin-right: 4px;
        }
        .btn-delete {
            padding: 5px 12px; background: #ffebee;
            color: #c62828; border: none; border-radius: 6px;
            cursor: pointer; font-size: 12px; font-weight: 600;
            font-family: 'Poppins', sans-serif;
        }
        .btn-edit:hover { background: #bbdefb; }
        .btn-delete:hover { background: #ffcdd2; }

        /* EDIT MODAL */
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); z-index: 1000;
            align-items: center; justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal {
            background: white; border-radius: 16px;
            padding: 32px; width: 580px; max-width: 95%;
            max-height: 90vh; overflow-y: auto;
            box-shadow: 0 24px 60px rgba(0,0,0,0.3);
        }
        .modal h2 { font-size: 17px; margin-bottom: 20px; color: #1a1a2e; border-bottom: 2px solid #f5a623; padding-bottom: 10px; }
        .modal-btns { display: flex; gap: 12px; margin-top: 20px; }
        .btn-save {
            flex: 1; padding: 11px; background: #f5a623;
            color: #1a1a2e; border: none; border-radius: 8px;
            font-size: 14px; font-weight: 700; cursor: pointer;
            font-family: 'Poppins', sans-serif;
        }
        .btn-cancel {
            flex: 1; padding: 11px; background: #f0f0f0;
            color: #555; border: none; border-radius: 8px;
            font-size: 14px; font-weight: 600; cursor: pointer;
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body>

<!-- TOP NAV -->
<div class="topnav">
    <h1>🎨 Kiran Kumar <span>Paints</span> — Dealer Dashboard</h1>
    <div class="topnav-right">
        <span>👤 <%= session.getAttribute("adminUser") %></span>
        <a href="home">🏠 View Store</a>
        <a href="adminLogout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- ALERTS -->
    <% if (successMsg != null) { %><div class="alert-success">✅ <%= successMsg %></div><% } %>
    <% if (errorMsg != null) { %><div class="alert-error">❌ <%= errorMsg %></div><% } %>

    <!-- STATS -->
    <div class="stats-row">
        <div class="stat-card">
            <div class="num"><%= products != null ? products.size() : 0 %></div>
            <div class="lbl">Total Products</div>
        </div>
        <div class="stat-card">
            <div class="num"><%
                int interior = 0;
                if (products != null) for (Product p : products) if ("Interior".equals(p.getCategory())) interior++;
                out.print(interior);
            %></div>
            <div class="lbl">Interior Paints</div>
        </div>
        <div class="stat-card">
            <div class="num"><%
                int exterior = 0;
                if (products != null) for (Product p : products) if ("Exterior".equals(p.getCategory())) exterior++;
                out.print(exterior);
            %></div>
            <div class="lbl">Exterior Paints</div>
        </div>
        <div class="stat-card">
            <div class="num"><%
                int lowStock = 0;
                if (products != null) for (Product p : products) if (p.getStock() < 10) lowStock++;
                out.print(lowStock);
            %></div>
            <div class="lbl">Low Stock Items</div>
        </div>
    </div>

    <!-- ADD PRODUCT FORM -->
    <div class="card">
        <h2>➕ Add New Product</h2>
        <form method="post" action="adminProduct">
            <input type="hidden" name="action" value="add">
            <div class="form-grid">
                <div class="form-group">
                    <label>Product Name *</label>
                    <input type="text" name="name" placeholder="e.g. Asian Paints Apcolite" required />
                </div>
                <div class="form-group">
                    <label>Category *</label>
                    <select name="category" required>
                        <option value="">-- Select --</option>
                        <option value="Interior">Interior</option>
                        <option value="Exterior">Exterior</option>
                        <option value="Enamel">Enamel</option>
                        <option value="Primer">Primer</option>
                        <option value="WoodPolish">Wood Polish</option>
                        <option value="Texture">Texture Paint</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (₹) *</label>
                    <input type="number" name="price" placeholder="e.g. 850" step="0.01" min="0" required />
                </div>
                <div class="form-group">
                    <label>Stock (units) *</label>
                    <input type="number" name="stock" placeholder="e.g. 50" min="0" required />
                </div>
                <div class="form-group">
                    <label>Rating (1-5)</label>
                    <input type="number" name="rating" placeholder="e.g. 4.5" step="0.1" min="1" max="5" />
                </div>
                <div class="form-group">
                    <label>Image URL (from web) *</label>
                    <div class="img-preview-row">
                        <input type="text" name="imageUrl" id="addImageUrl"
                               placeholder="Paste image URL here"
                               oninput="document.getElementById('addPreview').src=this.value" />
                        <img id="addPreview" src="images/default-paint.png" class="img-preview"
                             onerror="this.src='images/default-paint.png'">
                    </div>
                </div>
                <div class="form-group full">
                    <label>Description</label>
                    <textarea name="description" placeholder="Brief product description..."></textarea>
                </div>
            </div>
            <button type="submit" class="btn-add">➕ Add Product</button>
        </form>
    </div>

    <!-- PRODUCT LIST TABLE -->
    <div class="card">
        <div class="table-header">
            <h2 style="border:none; padding:0; margin:0;">📋 All Products</h2>
            <div class="search-bar">
                <input type="text" id="tableSearch" placeholder="🔍 Filter products..."
                       onkeyup="filterTable()">
            </div>
        </div>
        <table id="productTable">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Rating</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% if (products != null) { for (Product p : products) { %>
            <tr>
                <td><img src="<%= p.getImageUrl() %>" class="prod-img"
                         onerror="this.src='images/default-paint.png'"></td>
                <td><strong><%= p.getName() %></strong></td>
                <td><span class="cat-badge"><%= p.getCategory() %></span></td>
                <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                <td style="color: <%= p.getStock() < 10 ? "#e53935" : "#333" %>; font-weight: <%= p.getStock() < 10 ? "600" : "400" %>;">
                    <%= p.getStock() %><%= p.getStock() < 10 ? " ⚠️" : "" %>
                </td>
                <td>⭐ <%= p.getRating() %></td>
                <td>
                    <button class="btn-edit" onclick="openEdit(
                        '<%= p.getId() %>',
                        '<%= p.getName().replace("'", "\\'") %>',
                        '<%= p.getCategory() %>',
                        '<%= p.getPrice() %>',
                        '<%= p.getStock() %>',
                        '<%= p.getRating() %>',
                        '<%= p.getImageUrl() %>',
                        '<%= p.getDescription() != null ? p.getDescription().replace("'", "\\'") : "" %>'
                    )">✏️ Edit</button>
                    <form method="post" action="adminProduct" style="display:inline"
                          onsubmit="return confirm('Delete <%= p.getName() %>?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <button type="submit" class="btn-delete">🗑️ Delete</button>
                    </form>
                </td>
            </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <h2>✏️ Edit Product</h2>
        <form method="post" action="adminProduct">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editId">
            <div class="form-grid">
                <div class="form-group full">
                    <label>Product Name</label>
                    <input type="text" name="name" id="editName" required />
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" id="editCategory">
                        <option value="Interior">Interior</option>
                        <option value="Exterior">Exterior</option>
                        <option value="Enamel">Enamel</option>
                        <option value="Primer">Primer</option>
                        <option value="WoodPolish">Wood Polish</option>
                        <option value="Texture">Texture Paint</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price" id="editPrice" step="0.01" required />
                </div>
                <div class="form-group">
                    <label>Stock</label>
                    <input type="number" name="stock" id="editStock" required />
                </div>
                <div class="form-group">
                    <label>Rating</label>
                    <input type="number" name="rating" id="editRating" step="0.1" min="1" max="5" />
                </div>
                <div class="form-group full">
                    <label>Image URL</label>
                    <div class="img-preview-row">
                        <input type="text" name="imageUrl" id="editImageUrl"
                               oninput="document.getElementById('editPreview').src=this.value" />
                        <img id="editPreview" class="img-preview"
                             onerror="this.src='images/default-paint.png'">
                    </div>
                </div>
                <div class="form-group full">
                    <label>Description</label>
                    <textarea name="description" id="editDescription"></textarea>
                </div>
            </div>
            <div class="modal-btns">
                <button type="button" class="btn-cancel" onclick="closeEdit()">Cancel</button>
                <button type="submit" class="btn-save">💾 Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
function openEdit(id, name, category, price, stock, rating, imageUrl, description) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editCategory').value = category;
    document.getElementById('editPrice').value = price;
    document.getElementById('editStock').value = stock;
    document.getElementById('editRating').value = rating;
    document.getElementById('editImageUrl').value = imageUrl;
    document.getElementById('editPreview').src = imageUrl;
    document.getElementById('editDescription').value = description;
    document.getElementById('editModal').classList.add('active');
}
function closeEdit() {
    document.getElementById('editModal').classList.remove('active');
}
function filterTable() {
    const q = document.getElementById('tableSearch').value.toLowerCase();
    document.querySelectorAll('#productTable tbody tr').forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(q) ? '' : 'none';
    });
}
// Close modal on outside click
document.getElementById('editModal').addEventListener('click', function(e) {
    if (e.target === this) closeEdit();
});
</script>
</body>
</html>
