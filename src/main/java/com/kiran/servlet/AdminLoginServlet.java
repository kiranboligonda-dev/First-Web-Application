package com.kiran.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    // Change these credentials as needed
    private static final String ADMIN_USERNAME = "dealer";
    private static final String ADMIN_PASSWORD = "kiran@1995";

    // Show login page
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("admin-login.jsp").forward(req, res);
    }

    // Handle login form submission
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("adminUser", username);
            res.sendRedirect("adminDashboard");
        } else {
            req.setAttribute("error", "Invalid username or password. Please try again.");
            req.getRequestDispatcher("admin-login.jsp").forward(req, res);
        }
    }
}
