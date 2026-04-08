<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>QR Code Images</title>
    <style>
        .qr-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .qr-item {
            text-align: center;
        }
        .qr-item img {
            border: 1px solid #ccc;
            padding: 10px;
            width: 200px;
            height: 200px;
        }
    </style>
</head>
<body>
    <h2>QR Code Images</h2>

    <%
        // Get the real path to /qr-codes directory
        String qrDirPath = application.getRealPath("/shop-qr-codes");
        File qrDir = new File(qrDirPath);
        File[] files = qrDir.listFiles((dir, name) -> name.toLowerCase().endsWith(".png"));

        if (files != null && files.length > 0) {
    %>
        <div class="qr-container">
        <%
            for (File file : files) {
                String fileName = file.getName();
        %>
                <div class="qr-item">
                    <img src="shop-qr-codes/<%= fileName %>" alt="QR Code" />
                    <p><%= fileName %></p>
                </div>
        <%
            }
        %>
        </div>
    <%
        } else {
    %>
        <p>No QR code images found in the folder.</p>
    <%
        }
    %>

</body>
</html>
