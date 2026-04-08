package com.grocery.price;


import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.ByteMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/generateQr")
public class QrCodeGeneratorServlet extends HttpServlet {

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("hallticket") == null) {
            response.getWriter().println("Hall ticket not found in session.");
            return;
        }

        String hallTicket = session.getAttribute("hallticket").toString();
        String qrFileName = "qr_" + hallTicket + ".png";

        
        String qrFolderPath = getServletContext().getRealPath("/qr-codes");
        File qrFolder = new File(qrFolderPath);
        if (!qrFolder.exists()) {
            qrFolder.mkdirs();
        }

        File qrFile = new File(qrFolder, qrFileName);

        try {
        	generateQrCodeImage("http://" + Util.getIPAddress() + ":8080/grocery_price_comparison_system/", qrFile);

            // Pass image relative path to JSP
            String qrImagePath = "qr-codes/" + qrFileName;
            request.setAttribute("qrImagePath", qrImagePath);

            // Forward to attendance.jsp
           //
            request.getRequestDispatcher("attendance.jsp").forward(request, response);

           
        } catch (WriterException e) {
            e.printStackTrace();
            response.getWriter().println("Error generating QR Code: " + e.getMessage());
           

        }
    }
}