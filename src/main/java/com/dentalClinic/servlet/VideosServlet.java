package com.dentalClinic.servlet;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Videos;
import com.dentalClinic.service.VideosService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/videos")
public class VideosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VideosService videosService;

    @Override
    public void init() throws ServletException {
        super.init();
        videosService = new VideosService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String videoIdParam = request.getParameter("id");
        String searchParam = request.getParameter("search");
        String activeOnlyParam = request.getParameter("activeOnly");
        
        try {
            if (videoIdParam != null) {
                // Get single video by ID
                if (!isValidId(videoIdParam)) {
                    return;
                }
                int videoId = Integer.parseInt(videoIdParam);
                Videos video = videosService.getVideoById(videoId);
                // Process video
            } 
            else if (searchParam != null) {
                // Search videos
                if (!isValidSearchTerm(searchParam)) {
                    return;
                }
                List<Videos> videos = videosService.searchVideos(searchParam);
                // Process videos
            } 
            else {
                // Get all videos (active only or all)
                boolean activeOnly = activeOnlyParam == null || Boolean.parseBoolean(activeOnlyParam);
                List<Videos> videos = activeOnly ? 
                    videosService.getAllActiveVideos() : 
                    videosService.getAllVideos();
                // Process videos
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String link = request.getParameter("link");
        
        // Validate input
        if (!isValidName(name) || !isValidVideoLink(link)) {
            return;
        }
        
        Videos video = new Videos(name, link);
        try {
			int createdId = videosService.createVideo(video);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Process created video
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String videoIdParam = request.getParameter("id");
        String name = request.getParameter("name");
        String link = request.getParameter("link");
        String isActiveParam = request.getParameter("isActive");
        
        // Validate input
        if (!isValidId(videoIdParam) || 
            (name != null && !isValidName(name)) || 
            (link != null && !isValidVideoLink(link))) {
            return;
        }
        
        int videoId = Integer.parseInt(videoIdParam);
        Videos existingVideo;
		try {
			existingVideo = videosService.getVideoById(videoId);
			if (existingVideo != null) {
	            // Update only provided fields
	            if (name != null) existingVideo.setName(name);
	            if (link != null) existingVideo.setLink(link);
	            if (isActiveParam != null) existingVideo.setIs_active(Boolean.parseBoolean(isActiveParam));
	            
	            boolean updated = videosService.updateVideo(existingVideo);
	            // Process update result
	        }
		} catch (DatabaseConnectionException e) {

			e.printStackTrace();
		}
        
        
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String videoIdParam = request.getParameter("id");
        String action = request.getParameter("action"); // "deactivate" or "activate"
        
        // Validate input
        if (!isValidId(videoIdParam) || (action != null && !isValidAction(action))) {
            return;
        }
        
        int videoId = Integer.parseInt(videoIdParam);
        boolean success = false;
        
        if (action == null || "deactivate".equalsIgnoreCase(action)) {
            try {
				success = videosService.deactivateVideo(videoId);
			} catch (DatabaseConnectionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } else if ("activate".equalsIgnoreCase(action)) {
            try {
				success = videosService.activateVideo(videoId);
			} catch (DatabaseConnectionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        // Process result
    }

    // Validation helper methods
    private boolean isValidId(String idParam) {
        if (idParam == null) return false;
        try {
            int id = Integer.parseInt(idParam);
            return id > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.length() <= 100;
    }

    private boolean isValidVideoLink(String link) {
        return link != null && !link.trim().isEmpty() && 
               (link.startsWith("http://") || link.startsWith("https://")) &&
               link.length() <= 500;
    }

    private boolean isValidSearchTerm(String searchTerm) {
        return searchTerm != null && !searchTerm.trim().isEmpty() && searchTerm.length() <= 100;
    }

    private boolean isValidAction(String action) {
        return action != null && ("activate".equalsIgnoreCase(action) || "deactivate".equalsIgnoreCase(action));
    }
}