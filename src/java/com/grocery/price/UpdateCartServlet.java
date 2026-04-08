package com.grocery.price;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                String action = request.getParameter("action");

                for (Map<String, Object> item : cart) {
                    if ((int) item.get("product_id") == productId) {
                        int quantity = (int) item.get("quantity");

                        if ("increment".equals(action)) {
                            item.put("quantity", quantity + 1);  // Increment quantity
                        } else if ("decrement".equals(action) && quantity > 1) {
                            item.put("quantity", quantity - 1);  // Decrement quantity
                        }
                        break;
                    }
                }

                // Update the cart session
                session.setAttribute("cart", cart);
            }
        }
        response.sendRedirect("cart.jsp");
    }
}
