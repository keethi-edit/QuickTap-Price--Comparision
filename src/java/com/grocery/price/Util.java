package com.grocery.price;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class Util {
    public static String getIPAddress() {
        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            return inetAddress.getHostAddress(); // Returns IP address as string
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return "127.0.0.1"; // fallback localhost
        }
    }

    public static void main(String[] args) {
        System.out.println("IP Address: " + getIPAddress());
    }
}