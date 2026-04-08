package com.grocery.price;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("shop_id") == null) {
            response.sendRedirect("shoplogin.jsp");
            return;
        }

        int shopId = (Integer) session.getAttribute("shop_id");
        String productIdParam = request.getParameter("product_id");
        String message = "";

        if (productIdParam != null) {
            int productId = Integer.parseInt(productIdParam);

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

                String checkSql = "SELECT product_id FROM products WHERE product_id = ? AND shop_id = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setInt(1, productId);
                checkStmt.setInt(2, shopId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    String deleteSql = "DELETE FROM products WHERE product_id = ?";
                    PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                    deleteStmt.setInt(1, productId);
                    int rows = deleteStmt.executeUpdate();
                    if (rows > 0) {
                        message = "Product deleted successfully.";
                    } else {
                        message = "Failed to delete the product.";
                    }
                    deleteStmt.close();
                } else {
                    message = "Unauthorized delete attempt.";
                }

                rs.close();
                checkStmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                message = "Error occurred: " + e.getMessage();
            }
        } else {
            message = "Invalid product ID.";
        }

        response.sendRedirect("shopproducts.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
}
