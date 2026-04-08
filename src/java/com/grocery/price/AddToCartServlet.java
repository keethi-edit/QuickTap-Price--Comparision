package com.grocery.price;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);  // Create a new session if not exists
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        int productId = Integer.parseInt(request.getParameter("product_id"));
        String productName = request.getParameter("product_name");
        double price = Double.parseDouble(request.getParameter("price"));

        boolean found = false;

        // Check if the product is already in the cart
        for (Map<String, Object> item : cart) {
            if ((int) item.get("product_id") == productId) {
                // Product is already in the cart, increment quantity
                int currentQuantity = (int) item.get("quantity");
                item.put("quantity", currentQuantity + 1);  // Increment quantity
                found = true;
                break;
            }
        }

        if (!found) {
            // If product not found in cart, add new product
            Map<String, Object> newItem = new HashMap<>();
            newItem.put("product_id", productId);
            newItem.put("product_name", productName);
            newItem.put("price", price);
            newItem.put("quantity", 1);  // Initial quantity is 1
            cart.add(newItem);
        }

        // Redirect to cart page
        response.sendRedirect("cart.jsp");
    }
}
