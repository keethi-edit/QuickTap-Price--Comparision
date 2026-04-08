<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shop Products</title>
    <style>
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        input[type=number] { width: 60px; }
        .btn { padding: 10px 20px; background-color: #28a745; color: white; border: none; cursor: pointer; border-radius: 5px; }
        .btn:hover { background-color: #218838; }
    </style>
</head>
<body>

<%
    String shopId = request.getParameter("shop_id");
    if (shopId == null || shopId.trim().isEmpty()) {
%>
    <p>Invalid Shop ID.</p>
<%
    } else {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

            String sql = "SELECT product_id, product_name, description, price, quantity FROM products WHERE shop_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, shopId);
            rs = ps.executeQuery();
%>

<h2>Products for Shop ID: <%= shopId %></h2>

<form method="post" action="AddMultipleToCartServlet">
<table>
    <tr>
        <th>Select</th>
        <th>Product Name</th>
        <th>Description</th>
        <th>Available Qty</th>
        <th>Price (₹)</th>
        <th>Order Qty</th>
    </tr>
<%
            boolean hasProducts = false;
            while(rs.next()) {
                hasProducts = true;
                int productId = rs.getInt("product_id");
%>
    <tr>
        <td><input type="checkbox" name="selected_<%= productId %>" value="1"></td>
        <td><%= rs.getString("product_name") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getString("quantity") %></td>
        <td><%= rs.getDouble("price") %></td>
       <td><input type="number" name="quantity_<%= productId %>" min="1" max="100" value="1"></td>

        <input type="hidden" name="product_id_<%= productId %>" value="<%= productId %>">
        <input type="hidden" name="product_name_<%= productId %>" value="<%= rs.getString("product_name") %>">
        <input type="hidden" name="price_<%= productId %>" value="<%= rs.getDouble("price") %>">
        <input type="hidden" name="shop_id" value="<%= shopId %>">
    </tr>
<%
            }
            if (!hasProducts) {
%>
    <tr><td colspan="6">No products found for this shop.</td></tr>
<%
            }
%>
</table>

<% if (hasProducts) { %>
    <br/>
    <input type="submit" class="btn" value="Add Selected to Cart">
</form>
<form action="CheckoutServlet" method="post" style="margin-top:20px; text-align:center;">
    <input type="hidden" name="shop_id" value="<%= shopId %>">
    <input type="submit" class="btn" value="Buy All Products">
</form>
<% } %>

<%
        } catch(Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
%>

</body>
</html>
