package com.grocery.price;

import javax.servlet.*;
import javax.servlet.annotation.WebListener;
import java.io.File;

@WebListener
public class QrFolderInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();

        String qrFolderPath = context.getRealPath("/shop-qr-codes");
        File qrFolder = new File(qrFolderPath);

        if (!qrFolder.exists()) {
            boolean created = qrFolder.mkdirs();
            System.out.println("QR folder created: " + created + " at " + qrFolder.getAbsolutePath());
        } else {
            System.out.println("QR folder already exists at: " + qrFolder.getAbsolutePath());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Do nothing on shutdown
    }
}
