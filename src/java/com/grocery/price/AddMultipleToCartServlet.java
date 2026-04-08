package com.grocery.price;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/AddMultipleToCartServlet")
public class AddMultipleToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);  // Create a new session if not exists
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Loop through the request parameters and check which products are selected
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("selected_")) {  // If the product is selected

                // Extract product ID
                int productId = Integer.parseInt(paramName.substring(9));  // Extract product_id from the parameter name

                // Get the quantity (ensure it's not null)
                String quantityParam = request.getParameter("quantity_" + productId);
                int quantity = 1;  // Default value is 1
                if (quantityParam != null && !quantityParam.trim().isEmpty()) {
                    try {
                        quantity = Integer.parseInt(quantityParam);
                    } catch (NumberFormatException e) {
                        // If parsing fails, keep the default quantity (1)
                    }
                }

                // Get the price (ensure it's not null)
                String priceParam = request.getParameter("price_" + productId);
                double price = 0.0;  // Default value is 0.0
                if (priceParam != null && !priceParam.trim().isEmpty()) {
                    try {
                        price = Double.parseDouble(priceParam);
                    } catch (NumberFormatException e) {
                        // If parsing fails, keep the default price (0.0)
                    }
                }

                // Get product name (ensure it's not null)
                String productName = request.getParameter("product_name_" + productId);
                if (productName == null || productName.trim().isEmpty()) {
                    productName = "Unknown Product";  // Default value
                }

                // Check if the product is already in the cart
                boolean found = false;
                for (Map<String, Object> item : cart) {
                    if ((int) item.get("product_id") == productId) {
                        // Product is already in the cart, increment quantity
                        int currentQuantity = (int) item.get("quantity");
                        item.put("quantity", currentQuantity + quantity);  // Increment by selected quantity
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
                    newItem.put("quantity", quantity);  // Add the specified quantity
                    cart.add(newItem);
                }
            }
        }

        // Redirect to the cart page
        response.sendRedirect("cart.jsp");
    }
}
