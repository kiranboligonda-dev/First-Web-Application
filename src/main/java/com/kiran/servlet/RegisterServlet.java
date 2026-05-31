package com.kiran.servlet;

import com.kiran.dao.UserDAO;
import com.kiran.model.User;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        User user = new User();
        user.setUsername(req.getParameter("username"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        UserDAO dao = new UserDAO();
        if (dao.registerUser(user)) {
            res.sendRedirect("login");
        } else {
            req.setAttribute("error", "Registration failed. Email may already exist.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, res);
    }
}