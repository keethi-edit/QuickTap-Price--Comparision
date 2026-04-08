package com.grocery.price;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/ShopLoginServlet")
public class ShopLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int shopId = Integer.parseInt(request.getParameter("shop_id"));
        String shopName = request.getParameter("shop_name");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_db", "root", "QuickTap@2026");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM shops WHERE shop_id = ? AND shop_name = ?");
            ps.setInt(1, shopId);
            ps.setString(2, shopName);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	
            	int authentication=rs.getInt("status");
            	if(authentication==1) {
            		HttpSession session = request.getSession();
                    session.setAttribute("shop_id", shopId);
                    response.sendRedirect("shopHome.jsp");
            	}else {
            		response.sendRedirect("shoplogin.jsp?msg=not Authorized");
            	}
                
            } else {
        		response.sendRedirect("shoplogin.jsp?msg=invalid UserName or Password");

            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
