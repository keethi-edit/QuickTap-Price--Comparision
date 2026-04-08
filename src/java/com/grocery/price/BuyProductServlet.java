package com.grocery.price;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BuyProductServlet")
public class BuyProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("userlogin.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");
        String productIdParam = request.getParameter("product_id");

        try {
            int productId = Integer.parseInt(productIdParam);

            // Example: Store the purchase (actual logic depends on your DB)
            // This is just a placeholder message for now.
            String message = "Product with ID " + productId + " has been purchased successfully!";

            response.sendRedirect("user_home.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
        } catch (Exception e) {
            response.sendRedirect("user_home.jsp?message=" + java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
        }
    }
}
