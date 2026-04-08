<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Products</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .search-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .search-box {
            background: #ffffff;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        input[type="text"] {
            padding: 10px;
            width: 220px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1em;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        table {
            width: 95%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #f1f1f1;
        }

        input[type="number"] {
            width: 60px;
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .submit-cart {
            margin-top: 20px;
            padding: 12px 24px;
            font-size: 1em;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .submit-cart:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h2>All Products</h2>

<!-- Search Forms -->
<div class="search-container">
    <form class="search-box" method="get" action="user_home.jsp">
        <input type="text" name="search" placeholder="Search Product Name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <input type="submit" value="Search Product">
    </form>

    <form class="search-box" method="get" action="user_home.jsp">
        <input type="text" name="storeSearch" placeholder="Search Store Name" value="<%= request.getParameter("storeSearch") != null ? request.getParameter("storeSearch") : "" %>">
        <input type="submit" value="Search Store">
    </form>
    <a href="qrcodes1.jsp">📷 Scan QR to Browse Shops</a><br>
    
</div>

<%
    String searchQuery = request.getParameter("search");
    String storeSearchQuery = request.getParameter("storeSearch");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/grocery_db", "root", "root");

        String sql = "SELECT p.product_id, p.product_name, p.description, p.price, p.quantity,p.image, s.shop_name " +
                     "FROM products p JOIN shops s ON p.shop_id = s.shop_id";

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += " WHERE p.product_name LIKE ? ORDER BY p.price ASC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchQuery.trim() + "%");
        } else if (storeSearchQuery != null && !storeSearchQuery.trim().isEmpty()) {
            sql += " WHERE s.shop_name LIKE ? ORDER BY p.product_name ASC, p.price ASC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + storeSearchQuery.trim() + "%");
        } else {
            sql += " ORDER BY p.product_name ASC, p.price ASC";
            stmt = conn.prepareStatement(sql);
        }

        rs = stmt.executeQuery();
%>

<form method="post" action="AddMultipleToCartServlet">
<table>
    <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Image</th>
        <th>Shop</th>
        <th>Action</th>
    </tr>

<%
        boolean hasResults = false;
        while (rs.next()) {
            hasResults = true;
%>
    <tr>
        <td><%= rs.getInt("product_id") %></td>
        <td><%= rs.getString("product_name") %></td>
        <td><%= rs.getString("description") %></td>
        <td>
            <input type="number" name="quantity_<%= rs.getInt("product_id") %>" value="1" min="1">
        </td>
        <td>₹<%= rs.getDouble("price") %></td>
        <td><img src="uploads/<%= rs.getString("image") %>" height="100" width="100"></td>
        <td><%= rs.getString("shop_name") %></td>
        <td>
            <input type="hidden" name="product_id_<%= rs.getInt("product_id") %>" value="<%= rs.getInt("product_id") %>">
            <input type="hidden" name="product_name_<%= rs.getInt("product_id") %>" value="<%= rs.getString("product_name") %>">
            <input type="hidden" name="price_<%= rs.getInt("product_id") %>" value="<%= rs.getDouble("price") %>">
            <input type="checkbox" name="selected_<%= rs.getInt("product_id") %>" value="1"> Add to Cart
        </td>
    </tr>
<%
        }

        if (!hasResults) {
%>
    <tr><td colspan="7">No products found.</td></tr>
<%
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>

</table>
<input type="submit" class="submit-cart" value="Add Selected to Cart">
</form>
     <a href="index.jsp">← Back to Home</a>
     

</body>
</html>  