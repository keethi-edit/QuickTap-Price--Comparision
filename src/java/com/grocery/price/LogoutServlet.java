package com.grocery.price;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session to log the user out
        HttpSession session = request.getSession();
        session.invalidate();

        // Redirect back to the login page (admin.jsp)
        response.sendRedirect("admin.jsp");
        response.sendRedirect("shoplogin.jsp");


    }
}
