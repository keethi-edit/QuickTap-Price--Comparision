package com.grocery.price;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Connection variables
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // Admin login validation
        try {
            // Load the database driver and establish the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

            // SQL query to check for admin credentials
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            // Execute query
            rs = stmt.executeQuery();

            if (rs.next()) {
                // If credentials match, set session attribute and redirect to admin dashboard
                HttpSession session = request.getSession();
                session.setAttribute("adminLoggedIn", "true");
                response.sendRedirect("admin.jsp"); // Redirect to the admin dashboard page
            } else {
                // If credentials do not match, redirect back to login page with error message
                request.setAttribute("errorMessage", "Invalid username or password.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Handle any database or other errors
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred during the login process.");
        } finally {
            // Clean up and close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to the login page (just in case a GET request is made to the servlet)
        response.sendRedirect("admin.jsp");
    }
}
