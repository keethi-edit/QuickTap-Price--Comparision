<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    if (session == null || session.getAttribute("shop_id") == null) {
        response.sendRedirect("shoplogin.jsp");
        return;
    }

    int shopId = (int) session.getAttribute("shop_id");
    String shopName = (String) session.getAttribute("shop_name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #fff4e6, #ffecd2); /* Soft shop colors */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-box {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 380px;
        }

        .form-box h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #d35400;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1em;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #27ae60;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
        }

        input[type="submit"]:hover {
            background-color: #1e8449;
        }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Add Product for Shop: <%= shopName %></h2>

        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <label for="product_name">Product Name</label>
            <input type="text" name="product_name" id="product_name" required>

            <label for="description">Description</label>
            <input type="text" name="description" id="description" required>

            <label for="quantity">Quantity (e.g. 2kg, 500ml)</label>
            <input type="text" name="quantity" id="quantity" required>

            <label for="price">Price</label>
            <input type="number" step="0.01" name="price" id="price" required>
            
            <label for="Image">Product Image</label>
            <input type="file" name="image" required>

            <input type="submit" value="Add Product">
        </form>
    </div>
    <a href="shopHome.jsp">Back Home</a>
</body>
</html>
