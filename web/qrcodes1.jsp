<%@ page import="java.io.File,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shop QR Codes</title>
    <style>
        .qr-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .qr-item {
            text-align: center;
            width: 220px;
            border: 1px solid #ddd;
            padding: 10px;
            box-sizing: border-box;
        }
        .qr-item img {
            width: 200px;
            height: 200px;
            border: 1px solid #ccc;
            padding: 5px;
            margin-bottom: 10px;
        }
        .no-qr {
            font-style: italic;
            color: #a00;
        }
    </style>
</head>
<body>
    <h2>Shop QR Codes</h2>

<%
    // DB connection info — replace with your actual DB details
    String dbURL = "jdbc:mysql://localhost:3306/grocery_db";
    String dbUser = "root";
    String dbPass = "QuickTap@2026";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String qrDirPath = application.getRealPath("/shop-qr-codes");
    File qrDir = new File(qrDirPath);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT shop_id FROM shops");

%>
    <div class="qr-container">
<%
        while (rs.next()) {
            String shopId = rs.getString("shop_id");
            System.out.println("SHOP_ID :"+shopId);
            String fileName = "shop_"+shopId+".png";
            File qrFile = new File(qrDir, fileName);

            if (qrFile.exists()) {
%>
            <div class="qr-item">
                <img src="shop-qr-codes/<%= fileName %>" alt="QR Code for Shop <%= shopId %>" />
                <p>Shop ID: <%= shopId %></p>
            </div>
<%
            } else {
%>
            <div class="qr-item">
                <p>Shop ID: <%= shopId %></p>
                <p class="no-qr">QR code not found</p>
            </div>
<%
            }
        }
%>
    </div>
<%
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

</body>
</html>
