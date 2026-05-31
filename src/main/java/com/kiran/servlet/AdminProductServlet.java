package com.kiran.servlet;

import com.kiran.dao.ProductDAO;
import com.kiran.model.Product;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.util.List;

@WebServlet("/adminProduct")
public class AdminProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Security check
        if (req.getSession().getAttribute("adminUser") == null) {
            res.sendRedirect("adminLogin");
            return;
        }

        String action = req.getParameter("action");
        ProductDAO dao = new ProductDAO();
        String message = null;
        boolean success = false;

        try {
            if ("add".equals(action)) {
                Product p = new Product();
                p.setName(req.getParameter("name"));
                p.setCategory(req.getParameter("category"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setStock(Integer.parseInt(req.getParameter("stock")));
                p.setDescription(req.getParameter("description"));
                p.setImageUrl(req.getParameter("imageUrl"));
                String ratingStr = req.getParameter("rating");
                p.setRating(ratingStr != null && !ratingStr.isEmpty() ? Double.parseDouble(ratingStr) : 4.0);

                dao.addProduct(p);
                message = "Product '" + p.getName() + "' added successfully!";
                success = true;

            } else if ("update".equals(action)) {
                Product p = new Product();
                p.setId(Integer.parseInt(req.getParameter("id")));
                p.setName(req.getParameter("name"));
                p.setCategory(req.getParameter("category"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setStock(Integer.parseInt(req.getParameter("stock")));
                p.setDescription(req.getParameter("description"));
                p.setImageUrl(req.getParameter("imageUrl"));
                String ratingStr = req.getParameter("rating");
                p.setRating(ratingStr != null && !ratingStr.isEmpty() ? Double.parseDouble(ratingStr) : 4.0);

                dao.updateProduct(p);
                message = "Product '" + p.getName() + "' updated successfully!";
                success = true;

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteProduct(id);
                message = "Product deleted successfully!";
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
            success = false;
        }

        // Reload dashboard with message
        List<Product> products = dao.getAllProducts();
        req.setAttribute("products", products);
        req.setAttribute(success ? "success" : "error", message);
        req.getRequestDispatcher("admin-dashboard.jsp").forward(req, res);
    }
}
