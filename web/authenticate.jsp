<%@page import="com.grocery.price.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
	int shop_id= Integer.parseInt(request.getParameter("shop_id"));
	PreparedStatement pst=DBConnection.getStatement("update shops set status=1 where shop_id=?");
	pst.setInt(1,shop_id);
	
	int ss=pst.executeUpdate();
	if(ss>0){
		response.sendRedirect("registered_shops.jsp?msg=updated");
	}else{
		response.sendRedirect("registered_shops.jsp?msg=not updated");
	}
%>