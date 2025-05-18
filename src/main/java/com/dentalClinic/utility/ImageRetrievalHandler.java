package com.dentalClinic.utility;


import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ImageRetrievalHandler {

    private static final String BASE_IMAGE_DIR = "/WEB-INF/resources/images/";

    public static void sendImage(String appRealPath, String imagePath, HttpServletResponse response) {
        try {
            // Build full image path
            Path fullPath = Paths.get(appRealPath, BASE_IMAGE_DIR, imagePath);
            File imageFile = fullPath.toFile();

            // Check if file exists
            if (!imageFile.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Set content type based on file extension
            String contentType = getContentType(imagePath);
            response.setContentType(contentType);

            // Copy file to response
            try (FileInputStream in = new FileInputStream(imageFile);
                 OutputStream out = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        } catch (Exception e) {
            try {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private static String getContentType(String filename) {
        if (filename.endsWith(".png")) return "image/png";
        if (filename.endsWith(".jpg") || filename.endsWith(".jpeg")) return "image/jpeg";
        if (filename.endsWith(".gif")) return "image/gif";
        return "application/octet-stream";
    }
}