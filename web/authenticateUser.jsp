<%@page import="com.grocery.price.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
	String email_id=request.getParameter("email_id");
	PreparedStatement pst=DBConnection.getStatement("update student set status=1 where email=?");
	pst.setString(1,email_id);
	
	int ss=pst.executeUpdate();
	if(ss>0){
		response.sendRedirect("users_list.jsp?msg=updated");
	}else{
		response.sendRedirect("users_list.jsp?msg=not updated");
	}
%>