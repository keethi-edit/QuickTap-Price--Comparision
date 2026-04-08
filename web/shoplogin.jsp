<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- Ensure the session is enabled -->
<!DOCTYPE html>
<html>
<head>
    <title>Shop Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #fff4e6, #ffecd2); /* soft shop-related tones */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            background-color: #ffffff;
            padding: 35px 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 350px;
            text-align: center;
        }

        .login-box h2 {
            margin-bottom: 25px;
            color: #d35400;
        }

        input[type="text"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
        }

        input[type="submit"] {
            background-color: #27ae60;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #1e8449;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
            text-align: left;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container button {
            padding: 10px 15px;
            margin: 5px;
            font-size: 1em;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            background-color: #3498db;
            color: white;
        }

        .button-container button:hover {
            background-color: #2980b9;
        }

        .logout-btn {
            background-color: #e74c3c;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

    </style>
</head>
<body>

    <div class="login-box">
        <form action="ShopLoginServlet" method="post">
            <h2>Shop Login</h2>

            <label for="shop_id">Shop ID</label>
            <input type="text" name="shop_id" id="shop_id" required>

            <label for="shop_name">Shop Name</label>
            <input type="text" name="shop_name" id="shop_name" required>

            <input type="submit" value="Login">
        </form>
    </div>
    

    
</body>
</html>
