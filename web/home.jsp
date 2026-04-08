<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - QuickTap</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #f9f9f9, #ffecd2, #fcb69f, #ff9a9e);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .glass-container {
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.85);
            border-radius: 25px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            padding: 60px 45px;
            text-align: center;
            width: 90%;
            max-width: 750px;
            color: #333333;
            border: 2px solid rgba(255, 255, 255, 0.5);
            z-index: 1;
            animation: fadeIn 1s ease-out, pulseBorder 6s infinite;
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

        @keyframes pulseBorder {
            0%, 100% { border-color: rgba(255, 255, 255, 0.5); }
            50% { border-color: rgba(255, 165, 0, 0.8); }
        }

        h2 {
            font-size: 2.8em;
            font-weight: 700;
            margin-bottom: 25px;
            color: #2c3e50;
            text-transform: uppercase;
            letter-spacing: 3px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.4);
        }

        p {
            font-size: 1.4em;
            margin-bottom: 30px;
            color: #444444;
            line-height: 1.5;
        }

        ul {
            list-style: none;
            text-align: left;
            margin-bottom: 35px;
            font-size: 1.2em;
            font-weight: 500;
        }

        ul li {
            margin: 18px 0;
            position: relative;
            padding-left: 35px;
            transition: transform 0.3s ease;
        }

        ul li:hover {
            transform: translateX(10px);
        }

        ul li::before {
            content: "✔";
            position: absolute;
            left: 0;
            color: #1abc9c;
            font-weight: bold;
            font-size: 1.5em;
            animation: pulseCheck 2s infinite;
        }

        @keyframes pulseCheck {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }

        a {
            padding: 18px 40px;
            background: linear-gradient(135deg, #ff8c00, #ff5722);
            color: white;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.3em;
            font-weight: bold;
            transition: all 0.4s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        a::after {
            content: '';
            position: absolute;
            top: -8px;
            bottom: -8px;
            left: -12px;
            right: -12px;
            border-radius: 60px;
            background: rgba(255, 140, 0, 0.4);
            z-index: -1;
            filter: blur(10px);
            opacity: 0;
            transition: opacity 0.4s;
        }

        a:hover::after {
            opacity: 1;
        }

        a:hover {
            background: linear-gradient(135deg, #ff5722, #ff8c00);
            transform: scale(1.1);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 2em;
            }

            p, ul li, a {
                font-size: 1em;
            }

            .glass-container {
                padding: 35px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="glass-container">
        <h2>Welcome to QuickTap</h2>
        <p>Save time and money with our real-time comparison tool!</p>
        <ul>
            <li>Compare prices across multiple stores instantly</li>
            <li>Find the best discounts and offers</li>
            <li>Track your savings and make informed choices</li>
            <li>Enjoy personalized grocery shopping</li>
        </ul>
        <a href="index.jsp">← Back to Main Page</a>
    </div>
</body>
</html>
