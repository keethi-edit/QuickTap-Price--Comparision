<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registered Users</title>
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
            background-color: #3498db;
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

<h2>Registered Users</h2>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");

        // Check if delete is requested
        String email_id = request.getParameter("email_id");
        if (email_id!= null) {
            pstmt = conn.prepareStatement("DELETE FROM student WHERE email = ?");
            pstmt.setString(1, email_id);
            pstmt.executeUpdate();
        }

        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT username, email,status FROM student");
%>

<table>
    <tr>
        <th>User ID</th>
        <th>Email</th>
        <th>STATUS</th>        
        <th>Action</th>
    </tr>
<%
    while (rs.next()) {
        String username = rs.getString("username");
        String email = rs.getString("email");
        int status = rs.getInt("status");

%>
    <tr>
        <td><%= username %></td>
        <td><%= email %></td>
              <%if(status==0){ %>
            	<td>
            		<a class="delete-btn" href="authenticateUser.jsp?email_id=<%=email%>">waiting</a>
            		
            	</td>
        	
        	<%}else{%>
        		<td>Accepted</td>
        		
        	<%
        	}
        	%>
              
        <td>
            <a class="delete-btn" href="users_list.jsp?email_id=<%= email %>" onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
        </td>
    </tr>
<%
    }
%>
</table>

<%
    } catch (Exception e) {
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
