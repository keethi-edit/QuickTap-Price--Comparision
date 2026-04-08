<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        body { font-family: Arial; text-align: center; }
        table { margin: auto; border-collapse: collapse; width: 80%; }
        th, td { border: 1px solid #333; padding: 10px; }
        th { background-color: #f2f2f2; }
        .btn { padding: 6px 10px; margin-top: 20px; cursor: pointer; }
    </style>
</head>
<body>

<h2>Your Cart</h2>

<%
    HttpSession cartSession = request.getSession(false);
    if (cartSession == null || cartSession.getAttribute("cart") == null) {
%>
    <p>Your cart is empty.</p>
<%
    } else {
        List<Map<String, Object>> cart = (List<Map<String, Object>>) cartSession.getAttribute("cart");
        if (cart.isEmpty()) {
%>
        <p>Your cart is empty.</p>
<%
        } else {
%>
<table>
    <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
    </tr>
<%
    double total = 0;
    for (Map<String, Object> item : cart) {
        int quantity = (int) item.get("quantity");
        double price = (double) item.get("price");
        double subtotal = price * quantity;
        total += subtotal;
%>
    <tr>
        <td><%= item.get("product_id") %></td>
        <td><%= item.get("product_name") %></td>
        <td><%= price %></td>
        <td><%= quantity %></td>
        <td><%= subtotal %></td>
    </tr>
<%
    }
%>
    <tr>
        <th colspan="4">Total</th>
        <th><%= total %></th>
    </tr>
</table>

<form method="post" action="BuyCartServlet">
    <input class="btn" type="submit" value="Buy">
</form>
     <a href="index.jsp">  Back to Home</a>

<%
        }
    }
%>

</body>
</html>
