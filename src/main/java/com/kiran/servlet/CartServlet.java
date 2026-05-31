package com.kiran.servlet;

import com.kiran.dao.ProductDAO;
import com.kiran.model.Product;
import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        int productId = Integer.parseInt(req.getParameter("productId"));

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) cart = new HashMap<>();

        if ("add".equals(action)) {
            cart.put(productId, cart.getOrDefault(productId, 0) + 1);
        } else if ("remove".equals(action)) {
            cart.remove(productId);
        }

        session.setAttribute("cart", cart);
        res.sendRedirect("cart");
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        List<Product> cartProducts = new ArrayList<>();
        double total = 0;

        if (cart != null) {
            ProductDAO dao = new ProductDAO();
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product p = dao.getProductById(entry.getKey());
                if (p != null) {
                    cartProducts.add(p);
                    total += p.getPrice() * entry.getValue();
                }
            }
        }

        req.setAttribute("cartProducts", cartProducts);
        req.setAttribute("cartMap", cart);
        req.setAttribute("total", total);
        req.getRequestDispatcher("cart.jsp").forward(req, res);
    }
}