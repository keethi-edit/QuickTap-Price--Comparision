<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registered Shops</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            padding: 40px;
            background: #f4f4f9;
        }
        h2 {
            color: #2c3e50;
            text-align: center;
        }
        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #2ecc71;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<h2>Registered Shops</h2>

<%
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

        // Check if a delete_id is passed to delete a shop
        String deleteId = request.getParameter("delete_id");
        if (deleteId != null) {
            pstmt = conn.prepareStatement("DELETE FROM shops WHERE shop_id = ?");
            pstmt.setInt(1, Integer.parseInt(deleteId));
            pstmt.executeUpdate();
        }

        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT shop_id, shop_name,status FROM shops");
%>

<table>
    <tr>
        <th>Shop ID</th>
        <th>Shop Name</th>
        <th>STATUS</th>
        <th>Action</th>
    </tr>
    <%
        while (rs.next()) {
            int shopId = rs.getInt("shop_id");
            String shopName = rs.getString("shop_name");
            int status = rs.getInt("status");
    %>
    
    <% String qrImagePath = (String) request.getAttribute("qrImagePath"); %>
<% if (qrImagePath != null) { %>
    <img src="<%= qrImagePath %>" alt="QR Code">
<% } else { %>
    <p>QR code image not found.</p>
<% } %>
    <tr>
        <td><%= shopId %></td>
        <td><%= shopName %></td>
        
            <%if(status==0){ %>
            	<td>
            		<a class="delete-btn" href="authenticate.jsp?shop_id=<%=shopId%>">waiting</a>
            		
            	</td>
        	
        	<%}else{%>
        		<td>Accepted</td>
        		
        	<%
        	}
        	%>
        
        <td>
            <a class="delete-btn" href="registered_shops.jsp?delete_id=<%= shopId %>" onclick="return confirm('Are you sure you want to delete this shop?');">Delete</a>
        </td>
    </tr>
    <%
        }
    %>
</table>

<%
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

</body>
</html>
