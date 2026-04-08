package com.grocery.price;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.ByteMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;

@WebServlet("/Shop_registration")
public class Shop_registration extends HttpServlet {

	

	private void generateQrCodeImage(String text, File outputFile)
	        throws WriterException, IOException {
	    int width = 300;
	    int height = 300;
	    QRCodeWriter qrCodeWriter = new QRCodeWriter();
	    ByteMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
	    try (OutputStream out = new FileOutputStream(outputFile)) {
	        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
	    }
	}
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // 1. Get data from form
        int shop_id = Integer.parseInt(request.getParameter("shop_id"));
        String shop_name = request.getParameter("shop_name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        // 2. DB connection parameters
        String url = "jdbc:mysql://localhost:3306/grocery_db";  // Replace with your DB
        String user = "root";                             // Replace with your DB username
        String password = "QuickTap@2026";                         // Replace with your DB password

        // 3. JDBC logic
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "INSERT INTO shops (shop_id, shop_name, address, email, mobile,status) VALUES (?, ?, ?, ?, ?,?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, shop_id);
            stmt.setString(2, shop_name);
            stmt.setString(3, address);
            stmt.setString(4, email);
            stmt.setString(5, mobile);
            stmt.setInt(6, 0);
            int result = stmt.executeUpdate();

            if (result > 0) {
            	// QR code generation path
            	String qrFolderPath = getServletContext().getRealPath("/shop-qr-codes");
            	File qrFolder = new File(qrFolderPath);
            	if (!qrFolder.exists()) {
            	    qrFolder.mkdirs();
            	}
            	
            	String Ip_Address=Util.getIPAddress();
            	String qrText = "http://"+Ip_Address+":8080/grocery_price_comparison_system/getShopProducts.jsp?shop_id="+shop_id;
            	String qrFileName = "shop_" + shop_id + ".png";
            	File qrFile = new File(qrFolder, qrFileName);

            	try {
            	    generateQrCodeImage(qrText, qrFile);
            	    out.println("<h3>QR Code generated for shop.</h3>");
            	} catch (Exception e) {
            	    out.println("<h3>Shop registered but failed to generate QR code: " + e.getMessage() + "</h3>");
            	    e.printStackTrace(out);
            	}
                out.println("<h3>Shop registered successfully!</h3>");
            } else {
                out.println("<h3>Failed to register shop.</h3>");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace(out);
        }
    }
}
