package com.dentalClinic.service;

import java.sql.*;
import java.util.*;

import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.User;

public class UserService {
	

	    // Get all users
	    public static List<User> getAllUsers() throws SQLException, DatabaseConnectionException {
	        List<User> users = new ArrayList<>();
	        String sql = "SELECT * FROM users";

	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql);
	             ResultSet rs = stmt.executeQuery()) {

	            while (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setFirstName(rs.getString("first_name"));
	                user.setLastName(rs.getString("last_name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setPassword(rs.getString("password"));
	                user.setRole(rs.getString("role"));
	                user.setProfileImage(rs.getString("profile_image"));
	                user.setActive(rs.getBoolean("is_active"));
	                user.setCreatedAt(rs.getTimestamp("created_at"));
	                users.add(user);
	            }
	        }

	        return users;
	    }

	    public static User registerUser(User user) throws DatabaseConnectionException {
	        try (Connection connection = DatabaseConfig.createConnection()) {
	            connection.setAutoCommit(true); // No manual transaction handling

	            // Check if email already exists
	            if (emailExists(user.getEmail(), connection)) {
	                return null;
	            }

	            String userSql = "INSERT INTO users (first_name, last_name, email, phone, address, " +
	                             "password, role, profile_image, is_active, created_at) " +
	                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	            
	            try (PreparedStatement stmt = connection.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS)) {
	                stmt.setString(1, user.getFirstName());
	                stmt.setString(2, user.getLastName());
	                stmt.setString(3, user.getEmail());
	                stmt.setString(4, user.getPhone());
	                stmt.setString(5, user.getAddress());
	                stmt.setString(6, user.getPassword());
	                stmt.setString(7, user.getRole());
	                stmt.setString(8, user.getProfileImage());
	                stmt.setBoolean(9, user.isActive());
	                stmt.setTimestamp(10, user.getCreatedAt());

	                int affectedRows = stmt.executeUpdate();
	                if (affectedRows == 0) {
	                    return null;
	                }

	                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
	                    if (generatedKeys.next()) {
	                        user.setUserId(generatedKeys.getInt(1));
	                    }
	                }
		            System.out.println("USER CREATED");

	                return user;
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return null;
	        }
	    }


	    private static boolean emailExists(String email, Connection connection) throws SQLException {
	        String query = "SELECT 1 FROM users WHERE email = ?";
	        try (PreparedStatement stmt = connection.prepareStatement(query)) {
	            stmt.setString(1, email);
	            try (ResultSet rs = stmt.executeQuery()) {
	                return rs.next();
	            }
	        }
	    }


	    // Delete user
	    public static boolean deleteUser(int userId) throws SQLException, DatabaseConnectionException {
	        String sql = "DELETE FROM users WHERE user_id = ?";
	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setInt(1, userId);
	            return stmt.executeUpdate() > 0;
	        }
	    }

	    // Get user by ID
	    public static User getUserById(int userId) throws SQLException, DatabaseConnectionException {
	        String sql = "SELECT * FROM users WHERE user_id = ?";
	        User user = null;
	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setInt(1, userId);
	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	                user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setFirstName(rs.getString("first_name"));
	                user.setLastName(rs.getString("last_name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setPassword(rs.getString("password"));
	                user.setDob(rs.getTimestamp("dob"));
	                user.setRole(rs.getString("role"));
	                user.setProfileImage(rs.getString("profile_image"));
	                user.setActive(rs.getBoolean("is_active"));
	                user.setCreatedAt(rs.getTimestamp("created_at"));
	            }
	        }
	        return user;
	    }
	    
	    
	    // Get User by Email
	    public static User getUserByEmail(String email) throws SQLException, DatabaseConnectionException {
	        String sql = "SELECT * FROM users WHERE email = ?";
	        User user = null;
	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setString(1, email);
	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	                user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setFirstName(rs.getString("first_name"));
	                user.setLastName(rs.getString("last_name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setPassword(rs.getString("password"));
	                user.setRole(rs.getString("role"));
	                user.setProfileImage(rs.getString("profile_image"));
	                user.setActive(rs.getBoolean("is_active"));
	                user.setCreatedAt(rs.getTimestamp("created_at"));
	            }
	        }
	        return user;
	    }
	    
	    
	    public static String getProfileImageById(int userId) throws SQLException, DatabaseConnectionException {
	        String sql = "SELECT profile_image FROM users WHERE user_id = ?";
	        String profileImage = null;
	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setInt(1, userId); // Set userId parameter
	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	                profileImage = rs.getString("profile_image");
	            }
	        }
	        System.out.print(profileImage);
	        return profileImage;
	    }


	    // Update user
	    public static boolean updateUser(User user) throws SQLException, DatabaseConnectionException {
	        String sql = "UPDATE users SET first_name = ?, last_name = ?, email = ?, phone = ?, address = ?, password = ?, role = ?, profile_image = ?, is_active = ? WHERE user_id = ?";
	        try (Connection conn = DatabaseConfig.createConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setString(1, user.getFirstName());
	            stmt.setString(2, user.getLastName());
	            stmt.setString(3, user.getEmail());
	            stmt.setString(4, user.getPhone());
	            stmt.setString(5, user.getAddress());
	            stmt.setString(6, user.getPassword());
	            stmt.setString(7, user.getRole());
	            stmt.setString(8, user.getProfileImage());
	            stmt.setBoolean(9, user.isActive());
	            stmt.setInt(10, user.getUserId());

	            return stmt.executeUpdate() > 0;
	        }
	    }
	}
