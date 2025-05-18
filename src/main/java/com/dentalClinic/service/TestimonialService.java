package com.dentalClinic.service;


import com.dentalClinic.model.Testimonial;
import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestimonialService {

    // Create a new testimonial
    public int createTestimonial(Testimonial testimonial) throws DatabaseConnectionException {
        String sql = "INSERT INTO testimonials (patient_id, content, rating, doctor_id, created_at, is_approved) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        int generatedId = 0;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, testimonial.getPatientId());
            stmt.setString(2, testimonial.getContent());
            stmt.setInt(3, testimonial.getRating());
            if (testimonial.getDoctorId() != null) {
                stmt.setInt(4, testimonial.getDoctorId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }
            stmt.setTimestamp(5, testimonial.getCreatedAt());
            stmt.setBoolean(6, testimonial.isApproved());
            
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

    // Get testimonial by ID
    public Testimonial getTestimonialById(int id) throws DatabaseConnectionException {
        String sql = "SELECT * FROM testimonials WHERE id = ?";
        Testimonial testimonial = null;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    testimonial = mapResultSetToTestimonial(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testimonial;
    }

    // Get all approved testimonials
    public List<Testimonial> getApprovedTestimonials() throws DatabaseConnectionException {
        String sql = "SELECT * FROM testimonials WHERE is_approved = true ORDER BY created_at DESC";
        return getTestimonialsByQuery(sql);
    }

    // Get all testimonials (for admin)
    public List<Testimonial> getAllTestimonials() throws DatabaseConnectionException {
        String sql = "SELECT * FROM testimonials ORDER BY created_at DESC";
        return getTestimonialsByQuery(sql);
    }

    // Get testimonials by patient ID
    public List<Testimonial> getTestimonialsByPatient(int patientId) throws DatabaseConnectionException {
        String sql = "SELECT * FROM testimonials WHERE patient_id = ? ORDER BY created_at DESC";
        List<Testimonial> testimonials = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, patientId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    testimonials.add(mapResultSetToTestimonial(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testimonials;
    }

    // Update testimonial
    public boolean updateTestimonial(Testimonial testimonial) throws DatabaseConnectionException {
        String sql = "UPDATE testimonials SET content = ?, rating = ?, doctor_id = ?, is_approved = ? WHERE id = ?";
        boolean updated = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, testimonial.getContent());
            stmt.setInt(2, testimonial.getRating());
            if (testimonial.getDoctorId() != null) {
                stmt.setInt(3, testimonial.getDoctorId());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            stmt.setBoolean(4, testimonial.isApproved());
            stmt.setInt(5, testimonial.getTestimonialId());
            
            int affectedRows = stmt.executeUpdate();
            updated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }

    // Approve testimonial
    public boolean approveTestimonial(int id) throws DatabaseConnectionException {
        String sql = "UPDATE testimonials SET is_approved = true WHERE id = ?";
        return executeSingleIdUpdate(sql, id);
    }

    // Delete testimonial
    public boolean deleteTestimonial(int id) throws DatabaseConnectionException {
        String sql = "DELETE FROM testimonials WHERE id = ?";
        return executeSingleIdUpdate(sql, id);
    }

    // Helper method for queries that return multiple testimonials
    private List<Testimonial> getTestimonialsByQuery(String sql) throws DatabaseConnectionException {
        List<Testimonial> testimonials = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                testimonials.add(mapResultSetToTestimonial(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return testimonials;
    }

    // Helper method for single ID updates
    private boolean executeSingleIdUpdate(String sql, int id) throws DatabaseConnectionException {
        boolean success = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            success = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Helper method to map ResultSet to Testimonial object
    private Testimonial mapResultSetToTestimonial(ResultSet rs) throws SQLException {
        Testimonial testimonial = new Testimonial(
            rs.getInt("patient_id"),
            rs.getString("content"),
            rs.getInt("rating"),
            rs.getObject("doctor_id") != null ? rs.getInt("doctor_id") : null
        );
        testimonial.setTestimonialId(rs.getInt("id"));
        testimonial.setCreatedAt(rs.getTimestamp("created_at"));
        testimonial.setApproved(rs.getBoolean("is_approved"));
        return testimonial;
    }
}