<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    // Session check
    // HttpSession //session = request.getSession(false);
    if (session == null || session.getAttribute("shop_id") == null) {
        response.sendRedirect("shoplogin.jsp");
        return;
    }

    int shopId = (Integer) session.getAttribute("shop_id");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Shop Products</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #fdfcfb, #e2d1c3);
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .message {
            text-align: center;
            font-size: 1em;
            margin-bottom: 20px;
            font-weight: bold;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            margin: auto;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #f7f7f7;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #fcfcfc;
        }

        input[type="submit"] {
            padding: 8px 16px;
            background-color: #e74c3c;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<%
    String msg = request.getParameter("message");
    if (msg != null && !msg.isEmpty()) {
        String color = msg.toLowerCase().contains("unauthorized") || msg.toLowerCase().contains("fail") ? "red" : "green";
%>
    <div class="message" style="color: <%= color %>;"><%= msg %></div>
<%
    }
%>

<h2>Products for Your Shop</h2>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

        String sql = "SELECT product_id, product_name, description, quantity, price,image FROM products WHERE shop_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, shopId);
        ResultSet rs = stmt.executeQuery();
%>

<table>
    <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Action</th>
    </tr>

<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("product_id") %></td>
        <td><%= rs.getString("product_name") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getString("quantity") %> ></td>       
        <td>₹<%= rs.getDouble("price") %></td>
        <td><img src="uploads/<%= rs.getString("image") %>"></td>
        <td>
            <form action="DeleteProductServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
                <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>">
                <input type="submit" value="Delete">
            </form>
        </td>
    </tr>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<p style='text-align: center; color: red;'>Error: " + e.getMessage() + "</p>");
}
%>

</table>
<a href="shopHome.jsp">Back Home</a>
</body>
</html>  