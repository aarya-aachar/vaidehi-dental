package com.dentalClinic.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.FAQ;

public class FaqService 
{

	 // Create a new FAQ
    public static int createFAQ(FAQ faq) throws DatabaseConnectionException {
        String sql = "INSERT INTO faqs (question, answer, is_active, created_at) VALUES (?, ?, ?, ?)";
        int generatedId = 0;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, faq.getQuestion());
            stmt.setString(2, faq.getAnswer());
            stmt.setBoolean(3, faq.isActive());
            stmt.setTimestamp(4, faq.getCreatedAt());
            
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

    // Get FAQ by ID
    public static FAQ getFAQById(int faqId) throws DatabaseConnectionException {
        String sql = "SELECT * FROM faqs WHERE faq_id = ?";
        FAQ faq = null;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, faqId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    faq = new FAQ(
                        rs.getString("question"),
                        rs.getString("answer")
                    );
                    faq.setFaqId(rs.getInt("faq_id"));
                    faq.setActive(rs.getBoolean("is_active"));
                    faq.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faq;
    }

    // Get all active FAQs
    public static List<FAQ> getAllActiveFAQs() throws DatabaseConnectionException {
        String sql = "SELECT * FROM faqs WHERE is_active = true ORDER BY created_at DESC";
        List<FAQ> faqs = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                FAQ faq = new FAQ(
                    rs.getString("question"),
                    rs.getString("answer")
                );
                faq.setFaqId(rs.getInt("faq_id"));
                faq.setActive(rs.getBoolean("is_active"));
                faq.setCreatedAt(rs.getTimestamp("created_at"));
                faqs.add(faq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }

    // Get all FAQs (including inactive)
    public static List<FAQ> getAllFAQs() throws DatabaseConnectionException {
        String sql = "SELECT * FROM faqs ORDER BY created_at DESC";
        List<FAQ> faqs = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                FAQ faq = new FAQ(
                    rs.getString("question"),
                    rs.getString("answer")
                );
                faq.setFaqId(rs.getInt("faq_id"));
                faq.setActive(rs.getBoolean("is_active"));
                faq.setCreatedAt(rs.getTimestamp("created_at"));
                faqs.add(faq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }

    // Update FAQ
    public static boolean updateFAQ(FAQ faq) throws DatabaseConnectionException {
        String sql = "UPDATE faqs SET question = ?, answer = ?, is_active = ? WHERE faq_id = ?";
        boolean updated = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, faq.getQuestion());
            stmt.setString(2, faq.getAnswer());
            stmt.setBoolean(3, faq.isActive());
            stmt.setInt(4, faq.getFaqId());
            
            int affectedRows = stmt.executeUpdate();
            updated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }

    // Delete FAQ (soft delete by setting is_active to false)
    public static boolean deleteFAQ(int faqId) throws DatabaseConnectionException {
        String sql = "UPDATE faqs SET is_active = false WHERE faq_id = ?";
        boolean deleted = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, faqId);
            
            int affectedRows = stmt.executeUpdate();
            deleted = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deleted;
    }

    // Permanently delete FAQ from database
    public static boolean permanentlyDeleteFAQ(int faqId) throws DatabaseConnectionException {
        String sql = "DELETE FROM faqs WHERE faq_id = ?";
        boolean deleted = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, faqId);
            
            int affectedRows = stmt.executeUpdate();
            deleted = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deleted;
    }

    // Search FAQs by keyword in question or answer
    public static List<FAQ> searchFAQs(String keyword) throws DatabaseConnectionException {
        String sql = "SELECT * FROM faqs WHERE (question LIKE ? OR answer LIKE ?) AND is_active = true";
        List<FAQ> faqs = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FAQ faq = new FAQ(
                        rs.getString("question"),
                        rs.getString("answer")
                    );
                    faq.setFaqId(rs.getInt("faq_id"));
                    faq.setActive(rs.getBoolean("is_active"));
                    faq.setCreatedAt(rs.getTimestamp("created_at"));
                    faqs.add(faq);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }
    
}
