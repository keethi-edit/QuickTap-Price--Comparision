package com.grocery.price;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnection {

    public static PreparedStatement getStatement(String query) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3308/grocery_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "root"
            );

            return con.prepareStatement(query);

        } catch (Exception e) {
            e.printStackTrace();   // WILL SHOW REAL ERROR IN TOMCAT LOG
            throw new RuntimeException("Database connection failed", e);
        }
    }
}
