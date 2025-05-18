package com.dentalClinic.service;


import com.dentalClinic.model.Services;
import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicesHandler {

    // Create a new service
    public int createService(Services service) throws DatabaseConnectionException {
        String sql = "INSERT INTO services (name, description, cover_image, is_active, created_at) " +
                     "VALUES (?, ?, ?, ?, ?)";
        int generatedId = 0;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, service.getName());
            stmt.setString(2, service.getDescription());
            stmt.setString(3, service.getCoverImage());
            stmt.setBoolean(4, service.isIs_active());
            stmt.setTimestamp(5, service.getCreatedAt());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // Get service by ID
    public Services getServiceById(int serviceId) throws DatabaseConnectionException {
        String sql = "SELECT * FROM services WHERE service_id = ?";
        Services service = null;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serviceId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    service = mapResultSetToService(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return service;
    }

    // Get all active services
    public List<Services> getAllActiveServices() throws DatabaseConnectionException {
        String sql = "SELECT * FROM services WHERE is_active = true ORDER BY created_at DESC";
        return getServicesByQuery(sql);
    }

    // Get all services (including inactive)
    public List<Services> getAllServices() throws DatabaseConnectionException {
        String sql = "SELECT * FROM services ORDER BY created_at DESC";
        return getServicesByQuery(sql);
    }

    // Update service
    public boolean updateService(Services service) throws DatabaseConnectionException {
        String sql = "UPDATE services SET name = ?, description = ?, cover_image = ?, is_active = ? " +
                     "WHERE service_id = ?";
        boolean updated = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, service.getName());
            stmt.setString(2, service.getDescription());
            stmt.setString(3, service.getCoverImage());
            stmt.setBoolean(4, service.isIs_active());
            stmt.setInt(5, service.getServiceId());
            
            int affectedRows = stmt.executeUpdate();
            updated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }

    // Deactivate service (soft delete)
    public boolean deactivateService(int serviceId) throws DatabaseConnectionException {
        String sql = "UPDATE services SET is_active = false WHERE service_id = ?";
        return executeSingleIdUpdate(sql, serviceId);
    }

    // Activate service
    public boolean activateService(int serviceId) throws DatabaseConnectionException {
        String sql = "UPDATE services SET is_active = true WHERE service_id = ?";
        return executeSingleIdUpdate(sql, serviceId);
    }

    // Search services by name or description
    public List<Services> searchServices(String keyword) throws DatabaseConnectionException {
        String sql = "SELECT * FROM services WHERE (name LIKE ? OR description LIKE ?) AND is_active = true";
        List<Services> services = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    services.add(mapResultSetToService(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Helper methods
    private List<Services> getServicesByQuery(String sql) throws DatabaseConnectionException {
        List<Services> services = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    private boolean executeSingleIdUpdate(String sql, int serviceId) throws DatabaseConnectionException {
        boolean success = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serviceId);
            int affectedRows = stmt.executeUpdate();
            success = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    private Services mapResultSetToService(ResultSet rs) throws SQLException {
        Services service = new Services(
            rs.getString("name"),
            rs.getString("description"),
            rs.getString("cover_image")
        );
        service.setServiceId(rs.getInt("service_id"));
        service.setIs_active(rs.getBoolean("is_active"));
        service.setCreatedAt(rs.getTimestamp("created_at"));
        return service;
    }
}