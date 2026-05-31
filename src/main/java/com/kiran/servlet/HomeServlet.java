package com.kiran.servlet;

import com.kiran.dao.ProductDAO;
import com.kiran.model.Product;

import java.io.*;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();

        List<Product> featuredProducts = productDAO.getFeaturedProducts(4);
        List<Product> interiorProducts = productDAO.getProductsByCategory("Interior");
        List<Product> exteriorProducts = productDAO.getProductsByCategory("Exterior");
        List<Product> enamelProducts   = productDAO.getProductsByCategory("Enamel");
        List<Product> primerProducts   = productDAO.getProductsByCategory("Primer");

        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("interiorProducts", interiorProducts);
        request.setAttribute("exteriorProducts", exteriorProducts);
        request.setAttribute("enamelProducts",   enamelProducts);
        request.setAttribute("primerProducts",   primerProducts);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}