package com.kiran.servlet;

import com.kiran.dao.ProductDAO;
import com.kiran.model.Product;
import java.io.*;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String category = req.getParameter("category");
        String search   = req.getParameter("search");

        ProductDAO dao = new ProductDAO();
        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            // Search by name or description
            products = dao.searchProducts(search.trim());
            req.setAttribute("searchQuery", search.trim());
        } else if (category != null && !category.isEmpty()) {
            products = dao.getProductsByCategory(category);
            req.setAttribute("selectedCategory", category);
        } else {
            products = dao.getAllProducts();
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("products.jsp").forward(req, res);
    }
}
