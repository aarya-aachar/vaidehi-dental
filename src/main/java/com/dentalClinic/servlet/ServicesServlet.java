
package com.dentalClinic.servlet;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Services;
import com.dentalClinic.service.ServicesHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/services")
public class ServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServicesHandler servicesHandler;

    @Override
    public void init() throws ServletException {
        super.init();
        servicesHandler = new ServicesHandler();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceIdParam = request.getParameter("id");
        String searchParam = request.getParameter("search");
        String activeOnlyParam = request.getParameter("activeOnly");
        
        try {
            if (serviceIdParam != null) {
                // Get single service by ID
                if (!isValidId(serviceIdParam)) {
                    return;
                }
                int serviceId = Integer.parseInt(serviceIdParam);
                Services service = servicesHandler.getServiceById(serviceId);
                // Process service
            } 
            else if (searchParam != null) {
                // Search services
                if (!isValidSearchTerm(searchParam)) {
                    return;
                }
                List<Services> services = servicesHandler.searchServices(searchParam);
                // Process services
            } 
            else {
                // Get all services (active only or all)
                boolean activeOnly = activeOnlyParam == null || Boolean.parseBoolean(activeOnlyParam);
                List<Services> services = activeOnly ? 
                    servicesHandler.getAllActiveServices() : 
                    servicesHandler.getAllServices();
                // Process services
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String coverImage = request.getParameter("coverImage");
        
        // Validate input
        if (!isValidName(name) || !isValidDescription(description) || !isValidImageUrl(coverImage)) {
            return;
        }
        
        Services service = new Services(name, description, coverImage);
        try {
			int createdId = servicesHandler.createService(service);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Process created service
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceIdParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String coverImage = request.getParameter("coverImage");
        String isActiveParam = request.getParameter("isActive");
        
        // Validate input
        if (!isValidId(serviceIdParam) || 
            (name != null && !isValidName(name)) || 
            (description != null && !isValidDescription(description)) || 
            (coverImage != null && !isValidImageUrl(coverImage))) {
            return;
        }
        
        int serviceId = Integer.parseInt(serviceIdParam);
        Services existingService;
		try {
			existingService = servicesHandler.getServiceById(serviceId);
			
			 if (existingService != null) {
		            // Update only provided fields
		            if (name != null) existingService.setName(name);
		            if (description != null) existingService.setDescription(description);
		            if (coverImage != null) existingService.setCoverImage(coverImage);
		            if (isActiveParam != null) existingService.setIs_active(Boolean.parseBoolean(isActiveParam));
		            
		            try {
						boolean updated = servicesHandler.updateService(existingService);
					} catch (DatabaseConnectionException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		            // Process update result
		        }
			 
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
       
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceIdParam = request.getParameter("id");
        String action = request.getParameter("action"); // "deactivate" or "activate"
        
        // Validate input
        if (!isValidId(serviceIdParam) || (action != null && !isValidAction(action))) {
            return;
        }
        
        int serviceId = Integer.parseInt(serviceIdParam);
        boolean success = false;
        
        if (action == null || "deactivate".equalsIgnoreCase(action)) {
            try {
				success = servicesHandler.deactivateService(serviceId);
			} catch (DatabaseConnectionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } else if ("activate".equalsIgnoreCase(action)) {
            try {
				success = servicesHandler.activateService(serviceId);
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

    private boolean isValidDescription(String description) {
        return description != null && description.length() <= 500;
    }

    private boolean isValidImageUrl(String imageUrl) {
        return imageUrl != null && imageUrl.length() <= 255;
    }

    private boolean isValidSearchTerm(String searchTerm) {
        return searchTerm != null && !searchTerm.trim().isEmpty() && searchTerm.length() <= 100;
    }

    private boolean isValidAction(String action) {
        return action != null && ("activate".equalsIgnoreCase(action) || "deactivate".equalsIgnoreCase(action));
    }
}