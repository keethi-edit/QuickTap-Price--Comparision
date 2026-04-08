package com.grocery.price;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("shoplogin.jsp");
            return;
        }

        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Get the product name to remove
        String productName = request.getParameter("product_name");

        // Remove item from cart
        cart.removeIf(item -> item.get("product_name").equals(productName));

        // Store updated cart in session
        session.setAttribute("cart", cart);

        // Redirect back to cart page
        response.sendRedirect("cart.jsp");
    }
}
