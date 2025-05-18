package com.dentalClinic.utility;

import java.io.*;
import java.nio.file.*;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;




public class ImageHandler {
    // Base image directory (relative to web application)
    private static final String BASE_IMAGE_DIR = "/WEB-INF/resources/images/";
    
    /**
     * Uploads image to specified subfolder and returns relative path for DB storage
     * @param filePart The file part from form submission
     * @param request The HttpServletRequest
     * @param subfolder The subfolder name (e.g., "profile-pic", "doctor-pic")
     * @return Relative path for DB storage (e.g., "profile-pic/filename.jpg")
     */
    public static String uploadImageToSubfolder(Part filePart, HttpServletRequest request, 
                                              String subfolder) throws IOException, ServletException {
        
        // Get the application's real path
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + BASE_IMAGE_DIR + subfolder + "/";
        
        // Create directories if they don't exist
        Files.createDirectories(Paths.get(uploadPath));
        
        // Get original filename and validate
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!fileName.matches("(?i).*\\.(jpg|jpeg|png|gif)$")) {
            throw new ServletException("Only JPG, PNG, or GIF images are allowed");
        }
        
        // Generate unique filename
        String uniqueFileName = System.currentTimeMillis() + "_" + UUID.randomUUID()+fileName.substring( fileName.length() -5);
        String dbStoragePath = subfolder + "/" + uniqueFileName;
        
        // Save the file
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadPath + uniqueFileName), 
                     StandardCopyOption.REPLACE_EXISTING);
        }
        
        System.out.print(uploadPath);
        
        return dbStoragePath;
    }
    
    /**
     * Gets the full server path for an image (for file operations)
     * @param dbStoragePath The path stored in DB (e.g., "profile-pic/filename.jpg")
     * @param request The HttpServletRequest
     * @return Full filesystem path
     */
    public static String getServerImagePath(String dbStoragePath, HttpServletRequest request) {
        return request.getServletContext().getRealPath("") + BASE_IMAGE_DIR + dbStoragePath;
    }
    
    /**
     * Gets the web-accessible URL for an image (for HTML display)
     * @param dbStoragePath The path stored in DB
     * @param request The HttpServletRequest
     * @return Web-accessible URL
     */
    public static String getImageUrl(String dbStoragePath, HttpServletRequest request) {
        return request.getContextPath() + "/resources/images/" + dbStoragePath;
    }
    
    /**
     * Deletes an image from server
     * @param dbStoragePath The path stored in DB
     * @param request The HttpServletRequest
     * @return true if deletion succeeded
     */
    public static boolean deleteImage(String dbStoragePath, HttpServletRequest request) {
        try {
            Path path = Paths.get(getServerImagePath(dbStoragePath, request));
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            return false;
        }
    }
}