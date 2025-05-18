package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Testimonial;
import com.dentalClinic.service.TestimonialService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/testimonials")
public class TestimonialServlet extends HttpServlet 
{
    private static final long serialVersionUID = 1L;
    private TestimonialService testimonialService;

    @Override
    public void init() throws ServletException {
        super.init();
        testimonialService = new TestimonialService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientIdParam = request.getParameter("patientId");
        String content = request.getParameter("content");
        String ratingParam = request.getParameter("rating");
        String doctorIdParam = request.getParameter("doctorId");
        
        // Validate input
        if (!isValidId(patientIdParam) || !isValidContent(content) || 
            !isValidRating(ratingParam) || (doctorIdParam != null && !isValidId(doctorIdParam))) {
            return;
        }
        
        int patientId = Integer.parseInt(patientIdParam);
        int rating = Integer.parseInt(ratingParam);
        Integer doctorId = doctorIdParam != null ? Integer.parseInt(doctorIdParam) : null;
        
        Testimonial testimonial = new Testimonial(patientId, content, rating, doctorId);
        try {
			int createdId = testimonialService.createTestimonial(testimonial);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Process created testimonial
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String content = request.getParameter("content");
        String ratingParam = request.getParameter("rating");
        String doctorIdParam = request.getParameter("doctorId");
        String approvedParam = request.getParameter("approved");
        
        // Validate input
        if (!isValidId(idParam) || !isValidContent(content) || 
            !isValidRating(ratingParam) || (doctorIdParam != null && !isValidId(doctorIdParam))) {
            return;
        }
        
        int id = Integer.parseInt(idParam);
        Testimonial existingTestimonial;
		try {
			existingTestimonial = testimonialService.getTestimonialById(id);
			
			if (existingTestimonial != null) {
	            existingTestimonial.setContent(content);
	            existingTestimonial.setRating(Integer.parseInt(ratingParam));
	            existingTestimonial.setDoctorId(doctorIdParam != null ? Integer.parseInt(doctorIdParam) : null);
	            if (approvedParam != null) {
	                existingTestimonial.setApproved(Boolean.parseBoolean(approvedParam));
	            }
	            
	            try {
					boolean updated = testimonialService.updateTestimonial(existingTestimonial);
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
        String idParam = request.getParameter("id");
        
        // Validate input
        if (!isValidId(idParam)) {
            return;
        }
        
        int id = Integer.parseInt(idParam);
        try {
			boolean deleted = testimonialService.deleteTestimonial(id);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Process delete result
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

    private boolean isValidContent(String content) {
        return content != null && !content.trim().isEmpty() && content.length() <= 1000;
    }

    private boolean isValidRating(String ratingParam) {
        if (ratingParam == null) return false;
        try {
            int rating = Integer.parseInt(ratingParam);
            return rating >= 1 && rating <= 5;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}