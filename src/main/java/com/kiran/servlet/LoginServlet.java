package com.kiran.servlet;

import com.kiran.dao.UserDAO;
import com.kiran.model.User;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);
        if (user != null) {
            req.getSession().setAttribute("loggedUser", user);
            res.sendRedirect("products");
        } else {
            req.setAttribute("error", "Invalid email or password!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, res);
    }
}