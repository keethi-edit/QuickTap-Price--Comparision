package com.grocery.price;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final String JDBC_URL="jdbc:mysql://localhost:3306/grocery_db" ;
	private static final String DB_USER="root";
	private static final String DB_PASS="QuickTap@2026";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
   
        // TODO Auto-generated constructor stub
    

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS);
            String sql="select *from student where email=? and password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            

            if (rs.next()) {
            	int status=rs.getInt("status");
            	if(status==1) {
            		out.println("<h2>Login is successfull.</h2>");
            		HttpSession session=request.getSession(true);
            		session.setAttribute("email", rs.getString("email"));
            		response.sendRedirect("user_home.jsp");
            	}else {
            		response.sendRedirect("userlogin.jsp?msg=Not Authorized");

            	}
                
            } else {
        		response.sendRedirect("userlogin.jsp?msg=Invalid Username and password");
            }
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            
            e.printStackTrace();
            out.println("<h2>Error"+e.getMessage()+"</h2>");
        }finally {
        	out.close();
        }
}







		// TODO Auto-generated method stub
	}