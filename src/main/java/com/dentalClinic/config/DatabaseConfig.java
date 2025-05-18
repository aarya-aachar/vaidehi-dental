package com.dentalClinic.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConfig{

	public static Connection createConnection() throws DatabaseConnectionException {
		try {

			// Load the mysql driver 
			Class.forName("com.mysql.cj.jdbc.Driver");

			// MySQL (Apache Credentials and DB endpoint)
			final String url = "jdbc:mysql://localhost:3306/dentalClinic";
			final String id = "root";
			final String password = "";
			
			// Establish Connection
			Connection con = DriverManager.getConnection(url, id, password);

			if (con == null || con.isClosed()) {
                throw new DatabaseConnectionException("Failed to create database connection");
            }
			return con;

		} catch (Exception e) {
            throw new DatabaseConnectionException("Failed to create database connection",e);
		}
	}
	
	public static class DatabaseConnectionException extends Exception {
		
        private static final long serialVersionUID = 1L;
        
		public DatabaseConnectionException(String message) {
            super(message);
        }
        public DatabaseConnectionException(String message, Throwable cause) {
            super(message, cause);
        }
    }

}
