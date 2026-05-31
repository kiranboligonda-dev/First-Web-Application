package com.kiran.dao;

import com.kiran.db.DBConnection;
import com.kiran.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Get ALL products
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapProduct(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Get products by category
    public List<Product> getProductsByCategory(String category) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapProduct(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Search products by name, description or category
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ? OR category LIKE ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            String like = "%" + keyword + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapProduct(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Get product by ID
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapProduct(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Get top rated featured products
    public List<Product> getFeaturedProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY rating DESC LIMIT ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapProduct(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // ✅ ADD new product
    public void addProduct(Product p) {
        String sql = "INSERT INTO products (name, description, price, stock, category, image_url, rating) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getCategory());
            ps.setString(6, p.getImageUrl());
            ps.setDouble(7, p.getRating());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // ✅ UPDATE existing product
    public void updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, description=?, price=?, stock=?, category=?, image_url=?, rating=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getCategory());
            ps.setString(6, p.getImageUrl());
            ps.setDouble(7, p.getRating());
            ps.setInt(8, p.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // ✅ DELETE product
    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Helper to map ResultSet → Product
    private Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setStock(rs.getInt("stock"));
        p.setCategory(rs.getString("category"));
        p.setRating(rs.getDouble("rating"));
        String imageUrl = rs.getString("image_url");
        p.setImageUrl((imageUrl == null || imageUrl.trim().isEmpty()) ? "images/default-paint.png" : imageUrl);
        return p;
    }
}