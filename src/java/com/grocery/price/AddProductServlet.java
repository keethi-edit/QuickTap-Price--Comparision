package com.grocery.price;

import java.io.*;
import java.nio.file.Paths;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("shop_id") == null) {
            response.sendRedirect("shoplogin.jsp");
            return;
        }

        int shopId = (int) session.getAttribute("shop_id");

        String productName = request.getParameter("product_name");
        String description = request.getParameter("description");
        String quantity = request.getParameter("quantity"); // includes units
        double price = Double.parseDouble(request.getParameter("price"));
        //double price = 30;

        
        System.out.println(productName);
        System.out.println(description);
        System.out.println(quantity);
        System.out.println(price);
        
        String projectPath = "C:/Users/DELL/Desktop/upload/"; // Root of your Eclipse project

        // Get the uploaded file
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Project folder path
        String uploadPath = projectPath + File.separator + "web" + File.separator + "uploads";
        System.out.println("PATH : "+uploadPath);
        // Create uploads folder if not exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save file
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

            String sql = "INSERT INTO products (product_name, description, quantity, price, shop_id,image) VALUES (?, ?, ?, ?, ?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productName);
            stmt.setString(2, description);
            stmt.setString(3, quantity);
            stmt.setDouble(4, price);
            stmt.setInt(5, shopId);
            stmt.setString(6, fileName);

            int result = stmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>Product added successfully!</h3>");
            } else {
                out.println("<h3>Failed to add product.</h3>");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
