package com.grocery.price;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {
	private static final String JDBC_URL="jdbc:mysql://localhost:3306/grocery_db" ;
	private static final String DB_USER="root";
	private static final String DB_PASS="QuickTap@2026";
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
   

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String username = request.getParameter("username");
	        String password = request.getParameter("password");
	        String gender = request.getParameter("gender");
	        String address= request.getParameter("address");
	        String email = request.getParameter("email");
	        String mobile = request.getParameter("mobile");
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS);
	            String sql="INSERT INTO student(username,password,gender,address,email,mobile,status) VALUES" + "(?,?,?,?,?,?,?)";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, username);
	            stmt.setString(2, password);
	            stmt.setString(3, gender);
	            stmt.setString(4, address);
	            stmt.setString(5, email);
	            stmt.setString(6, mobile);
	            stmt.setInt(7, 0);
	            

	            int rowsInserted = stmt.executeUpdate();
	            

	            if (rowsInserted>0) {
	                out.println("<h2>Registration is successfull.</h2>");
	            } else {
	                out.println("<h2>,Registration is failed.Please try again </h2>");
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
}


	
	

