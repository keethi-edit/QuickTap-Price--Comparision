<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #fdf6f0;
        }

        .navbar {
            background-color: #d35400;
            overflow: hidden;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            color: white;
            margin: 0;
            font-size: 24px;
        }

        .menu {
            display: flex;
            gap: 20px;
        }

        .menu a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 12px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .menu a:hover {
            background-color: #a04000;
        }

        .content {
            padding: 40px;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <h1>QuickTap System</h1>
        <div class="menu">
            <a href="addproducts.jsp">Add Products</a>
            <a href="shopproducts.jsp">View Products</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <!-- Main content -->
    <div class="content">
        <h2>Welcome to your QuickTap System </h2>
        <p>Select an option from the menu above to get started.</p>
    </div>

</body>
</html>
