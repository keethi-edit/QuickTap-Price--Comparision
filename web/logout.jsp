<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    session.invalidate();  // Clears the session
    response.sendRedirect("index.jsp");  // Redirects the user to the homepage
%>
