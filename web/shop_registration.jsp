<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Shop Registration</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #ffe0c3, #ffd8a8); /* Soft warm tones */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 400px;
        }

        .form-box h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #e67e22;
        }

        label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
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
            background-color: #219150;
        }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Shop Registration Form</h2>
        <form action="Shop_registration" method="post">
            <label for="shop_id">Shop ID</label>
            <input type="text" name="shop_id" id="shop_id" required>

            <label for="shop_name">Shop Name</label>
            <input type="text" name="shop_name" id="shop_name" required>

            <label for="address">Address</label>
            <input type="text" name="address" id="address" required>

            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>

            <label for="mobile">Mobile</label>
            <input type="text" name="mobile" id="mobile" required>

            <input type="submit" value="Add">
        </form>
    </div>
</body>
</html>
