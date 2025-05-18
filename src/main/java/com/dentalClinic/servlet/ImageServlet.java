package com.dentalClinic.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.dentalClinic.utility.ImageRetrievalHandler;



@WebServlet("/images/*")  // Handles all URLs starting with /images/
public class ImageServlet extends HttpServlet {
    
    private static final long serialVersionUID = -1032030194806528368L;
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
//            throws IOException {
//        
//        // 1. Get the image path from URL (e.g., "/images/profile_pics/abc123.jpg")
//        String imagePath = request.getPathInfo();  
//        
//        // 2. Check if path is valid
//        if (imagePath == null || imagePath.equals("/")) {
//            response.sendError(404);  // Send "Not Found" error
//            return;
//        }
//        
//        // 3. Remove any dangerous path characters
//        String safePath = imagePath.replaceAll("\\.\\.", "");  // Block "../" hacks
//        
//        // 4. Build the full file path on server
//        String serverPath = getServletContext().getRealPath("/WEB-INF/images" + safePath);
//        
//        // 5. Check if file exists
//        File imageFile = new File(serverPath);
//        if (!imageFile.exists()) {
//            response.sendError(404);
//            return;
//        }
//        
//        // 6. Set the correct image type (e.g., "image/jpeg")
//        String mimeType = getServletContext().getMimeType(serverPath);
//        response.setContentType(mimeType != null ? mimeType : "image/jpeg");
//        
//        // 7. Send the image to browsers
//        try (InputStream in = new FileInputStream(imageFile);
//             OutputStream out = response.getOutputStream()) {
//            
//            byte[] buffer = new byte[1024];
//            int bytesRead;
//            while ((bytesRead = in.read(buffer)) != -1) {
//                out.write(buffer, 0, bytesRead);
//            }
//        }
//    }
//	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException  {
        String imagePath = request.getPathInfo().substring(1); // Remove leading slash
        String appPath = request.getServletContext().getRealPath("");
        ImageRetrievalHandler.sendImage(appPath, imagePath, response);
    }
}