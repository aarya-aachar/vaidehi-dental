package com.dentalClinic.service;


import com.dentalClinic.model.Videos;
import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VideosService {

    // Create a new video
    public int createVideo(Videos video) throws DatabaseConnectionException {
        String sql = "INSERT INTO videos (name, link, is_active, created_at) " +
                     "VALUES (?, ?, ?, ?)";
        int generatedId = 0;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, video.getName());
            stmt.setString(2, video.getLink());
            stmt.setBoolean(3, video.isIs_active());
            stmt.setTimestamp(4, video.getCreatedAt());
            
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

    // Get video by ID
    public Videos getVideoById(int videoId) throws DatabaseConnectionException {
        String sql = "SELECT * FROM videos WHERE video_id = ?";
        Videos video = null;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, videoId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    video = mapResultSetToVideo(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return video;
    }

    // Get all active videos
    public List<Videos> getAllActiveVideos() throws DatabaseConnectionException {
        String sql = "SELECT * FROM videos WHERE is_active = true ORDER BY created_at DESC";
        return getVideosByQuery(sql);
    }

    // Get all videos (including inactive)
    public List<Videos> getAllVideos() throws DatabaseConnectionException {
        String sql = "SELECT * FROM videos ORDER BY created_at DESC";
        return getVideosByQuery(sql);
    }

    // Update video
    public boolean updateVideo(Videos video) throws DatabaseConnectionException {
        String sql = "UPDATE videos SET name = ?, link = ?, is_active = ? WHERE video_id = ?";
        boolean updated = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, video.getName());
            stmt.setString(2, video.getLink());
            stmt.setBoolean(3, video.isIs_active());
            stmt.setInt(4, video.getVideoId());
            
            int affectedRows = stmt.executeUpdate();
            updated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }

    // Deactivate video (soft delete)
    public boolean deactivateVideo(int videoId) throws DatabaseConnectionException {
        String sql = "UPDATE videos SET is_active = false WHERE video_id = ?";
        return executeSingleIdUpdate(sql, videoId);
    }

    // Activate video
    public boolean activateVideo(int videoId) throws DatabaseConnectionException {
        String sql = "UPDATE videos SET is_active = true WHERE video_id = ?";
        return executeSingleIdUpdate(sql, videoId);
    }

    // Search videos by name
    public List<Videos> searchVideos(String keyword) throws DatabaseConnectionException {
        String sql = "SELECT * FROM videos WHERE name LIKE ? AND is_active = true";
        List<Videos> videos = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    videos.add(mapResultSetToVideo(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    // Helper methods
    private List<Videos> getVideosByQuery(String sql) throws DatabaseConnectionException {
        List<Videos> videos = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                videos.add(mapResultSetToVideo(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    private boolean executeSingleIdUpdate(String sql, int videoId) throws DatabaseConnectionException {
        boolean success = false;
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, videoId);
            int affectedRows = stmt.executeUpdate();
            success = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    private Videos mapResultSetToVideo(ResultSet rs) throws SQLException {
        Videos video = new Videos(
            rs.getString("name"),
            rs.getString("link")
        );
        video.setVideoId(rs.getInt("video_id"));
        video.setIs_active(rs.getBoolean("is_active"));
        video.setCreatedAt(rs.getTimestamp("created_at"));
        return video;
    }
}