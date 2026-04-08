<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #fbc2eb, #a6c1ee, #fbc2eb, #f9f9f9);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .glass-container {
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.85);
            border-radius: 25px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            padding: 40px 35px;
            text-align: center;
            width: 90%;
            max-width: 700px;
            color: #333;
            border: 2px solid rgba(255, 255, 255, 0.4);
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
                box-shadow: 0 0 20px rgba(142, 36, 170, 0.2);
            }
            50% {
                border-color: rgba(142, 36, 170, 0.8);
                box-shadow: 0 0 30px rgba(142, 36, 170, 0.4);
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

        input {
            display: block;
            width: 90%;
            padding: 12px;
            margin: 15px auto;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1.1em;
            color: #333;
            background: rgba(255, 255, 255, 0.95);
            transition: box-shadow 0.3s ease;
        }

        input:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(142, 36, 170, 0.3);
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #8e24aa, #6a1b9a);
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
            background: linear-gradient(135deg, #6a1b9a, #8e24aa);
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

        .dashboard {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .dashboard a {
            background-color: #3498db;
            color: white;
            font-size: 1.1em;
            text-decoration: none;
            border-radius: 6px;
            padding: 15px;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        .dashboard a:hover {
            background-color: #2980b9;
            transform: scale(1.03);
        }

        .logout {
            background-color: #d9534f !important;
        }

        .logout:hover {
            background-color: #c9302c !important;
        }

        @media (max-width: 768px) {
            .glass-container {
                padding: 25px;
            }

            h2 {
                font-size: 2em;
            }

            input, .dashboard a {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>

<%
    String adminLoggedIn = (String) session.getAttribute("adminLoggedIn");
    if (adminLoggedIn == null || !adminLoggedIn.equals("true")) {
%>
    <!-- Admin Login Form -->
    <div class="glass-container">
        <h2>Admin Login</h2>
        <form action="AdminServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login as Admin">
        </form>
        <a href="index.jsp">← Back to Home</a>
    </div>
<%
    } else {
%>
    <!-- Admin Dashboard -->
    <div class="glass-container">
        <h2>Welcome, Admin</h2>
       <div class="dashboard">
    <a href="users_list.jsp">View Users List</a>
    <a href="registered_shops.jsp">View Registered Shops</a>
            <a href="logout.jsp">Logout</a>
</div>

    </div>
<% } %>

</body>
</html>
