<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login - QuickTap</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #ffecd2, #fcb69f, #ff9a9e, #f9f9f9);
            background-size: 400% 400%;
            animation: animateBG 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        @keyframes animateBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .glass-container {
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.88);
            border-radius: 25px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            padding: 40px 35px;
            text-align: center;
            width: 90%;
            max-width: 600px;
            color: #333;
            border: 2px solid rgba(255, 255, 255, 0.5);
            animation: fadeIn 1s ease-out, glowBorder 6s ease-in-out infinite;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes glowBorder {
            0%, 100% {
                border-color: rgba(255, 255, 255, 0.5);
                box-shadow: 0 0 20px rgba(255, 87, 34, 0.2);
            }
            50% {
                border-color: rgba(255, 87, 34, 0.8);
                box-shadow: 0 0 30px rgba(255, 87, 34, 0.4);
            }
        }

        h2 {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 25px;
            color: #2c3e50;
            text-transform: uppercase;
            letter-spacing: 3px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        input, select, textarea {
            display: block;
            width: 90%;
            padding: 12px;
            margin: 15px auto;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1.1em;
            color: #333;
            background: rgba(255, 255, 255, 0.9);
            transition: box-shadow 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(255, 87, 34, 0.5);
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #ff5722, #ff8c00);
            color: white;
            border: none;
            cursor: pointer;
            padding: 15px 25px;
            font-size: 1.2em;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #ff8c00, #ff5722);
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s;
        }

        a:hover {
            background: #218838;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .glass-container {
                padding: 25px;
            }

            h2 {
                font-size: 2em;
            }

            input, select, textarea {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <div class="glass-container">
        <h2>User Login</h2>

        

        <form method="post" action="LoginServlet">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>

        <a href="index.jsp">← Back to Home</a>
    </div>
</body>
</html>
