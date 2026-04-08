package com.grocery.price;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShopProductsServlet
 */
@WebServlet("/ShopProductsServlet")
public class ShopProductsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session check - Ensure that the user is logged in (check session variable)
        HttpSession session = request.getSession(false);  // Get the session without creating a new one
        if (session == null || session.getAttribute("shop_id") == null) {
            // If the session is invalid or user is not logged in, redirect to login page
            response.sendRedirect("shoplogin.jsp");
            return;
        }

        // Retrieve shop_id from session
        Integer shopId = (Integer) session.getAttribute("shop_id");  // Cast to Integer
        if (shopId == null) {
            response.sendRedirect("shoplogin.jsp");  // If shopId is null, redirect to login page
            return;
        }

        // Retrieve any messages from the request (like success or failure messages)
        String msg = request.getParameter("message");
        
        // Set the message as a request attribute to be displayed on the JSP
        request.setAttribute("message", msg);

        // Fetch the products for the shop from the database
        List<Map<String, Object>> products = getProductsByShopId(shopId);
        
        // Set the products as a request attribute to be displayed on the JSP
        request.setAttribute("products", products);

        // Forward the request to the JSP page to display products
        RequestDispatcher dispatcher = request.getRequestDispatcher("shopproducts.jsp");
        dispatcher.forward(request, response);
    }

    private List<Map<String, Object>> getProductsByShopId(int shopId) {
        List<Map<String, Object>> products = new ArrayList<>();
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

            // Prepare SQL query to fetch products for the given shopId
            String sql = "SELECT product_id, product_name, description, quantity, price FROM products WHERE shop_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, shopId);  // Set the shop_id in the query
            ResultSet rs = stmt.executeQuery();  // Execute the query

            // Iterate over the result set and add products to the list
            while (rs.next()) {
                // Store each product's data in a Map
                Map<String, Object> product = new HashMap<>();
                product.put("product_id", rs.getInt("product_id"));
                product.put("product_name", rs.getString("product_name"));
                product.put("description", rs.getString("description"));
                product.put("quantity", rs.getString("quantity"));
                product.put("price", rs.getDouble("price"));
                
                // Add the product Map to the list of products
                products.add(product);
            }

            // Close the ResultSet, PreparedStatement, and Connection
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            // Handle database exceptions and log the error
            e.printStackTrace();
        }
        return products;
    }
}
