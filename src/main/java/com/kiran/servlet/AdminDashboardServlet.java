package com.kiran.servlet;

import com.kiran.dao.ProductDAO;
import com.kiran.model.Product;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Security check
        if (req.getSession().getAttribute("adminUser") == null) {
            res.sendRedirect("adminLogin");
            return;
        }

        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();
        req.setAttribute("products", products);
        req.getRequestDispatcher("admin-dashboard.jsp").forward(req, res);
    }
}
