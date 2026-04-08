<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QuickTap</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
            position: relative;
            height: 100vh;
            color: white;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .container {
            position: relative;
            z-index: 1;
            text-align: center;
            padding-top: 80px;
        }

        h1 {
            font-size: 3em;
            margin-bottom: 30px;
            background: linear-gradient(to right, #FFD700, #FF69B4, #00FFFF);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            margin-top: 50px;
        }

        .card {
            background: rgba(255, 255, 255, 0.15);
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            padding: 30px;
            width: 220px;
            text-align: center;
            transition: transform 0.3s ease, background 0.3s ease;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
        }

        .card:hover {
            transform: scale(1.08);
            background: rgba(255, 255, 255, 0.3);
        }

        .card a {
            text-decoration: none;
            color: #ffffff;
            font-size: 1.2em;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .card i {
            font-size: 2.5em;
            margin-bottom: 10px;
            color: #FFD700;
            transition: color 0.3s;
        }

        .card:hover i {
            color: #FF69B4;
        }

        @media (max-width: 768px) {
            .cards {
                flex-direction: column;
                align-items: center;
            }

            .card {
                width: 80%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>QuickTap System</h1>
        <div class="cards">
            <div class="card">
                <i class="fas fa-home"></i>
                <a href="home.jsp" title="Go to Home Page">Home</a>
            </div>
            
            <div class="card">
                <i class="fas fa-user-plus"></i>
                <a href="register.jsp" title="Register as a new user">Register</a>
            </div>
            
             <div class="card">
                <i class="fas fa-sign-in-alt"></i>
                <a href="userlogin.jsp" title="Login as a user">User Login</a>
            </div>
            <div class="card">
                <i class="fas fa-user-shield"></i>
                <a href="admin.jsp" title="Admin login">Admin Login</a>
            </div>
            <div class="card">
                <i class="fas fa-user-shield"></i>
                <a href="shoplogin.jsp" title="Shop login">Shop Login</a>
            </div>
            <div class="card">
                <i class="fas fa-user-shield"></i>
                <a href="shop_registration.jsp" title="Shop Registration">Shop Registration</a>
            </div>
        </div>
    </div>
</body>
</html>