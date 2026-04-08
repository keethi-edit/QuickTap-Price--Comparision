package com.grocery.price;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/BuyCartServlet")
public class BuyCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp"); // Nothing to purchase
            return;
        }

        // TODO: Add actual purchase logic here (e.g., save order to DB)

        // Clear the cart after purchase
        cart.clear();
        session.setAttribute("cart", cart);

        // Redirect to success page
        response.sendRedirect("purchaseSuccess.jsp");
    }
}
