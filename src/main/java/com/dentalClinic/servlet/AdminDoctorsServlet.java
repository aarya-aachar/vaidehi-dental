package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.service.AdminService;
import com.dentalClinic.service.DoctorService;

/**
 * Servlet implementation class DoctorsServlet
 */

@WebServlet("/admin/doctors")
@MultipartConfig(
	    maxFileSize = 1024 * 1024 * 5,      // 5MB max file size
	    maxRequestSize = 1024 * 1024 * 30   // 10MB max total request size
	)
public class AdminDoctorsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDoctorsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			DoctorService.getAllDoctors(request, response);


		} catch (ServletException | IOException | DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/WEB-INF/pages/admin-doctors.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        String action = String.valueOf(request.getParameter("action"));
	        
	        if(action.equalsIgnoreCase("delete")) {

	            doDelete(request, response);
	        } 
	        
	    }

	    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        String doctorIdStr = request.getParameter("doctorId");
	        
	        try {
	            if (doctorIdStr == null || doctorIdStr.isEmpty()) {
	                request.setAttribute("errorMessage", "Doctor ID is required");
	                doGet(request, response);
	                return;
	            }
	            
	            int doctorId = Integer.parseInt(doctorIdStr);
	            boolean isDeleted = AdminService.deleteDoctor(doctorId);
	            
	            if (isDeleted) {
	                request.setAttribute("successMessage", "Doctor deleted successfully");
	            } else {
	                request.setAttribute("errorMessage", "Doctor not found or could not be deleted");
	            }
	        } catch (NumberFormatException e) {
	            request.setAttribute("errorMessage", "Invalid Doctor ID");
	        } catch (SQLException | DatabaseConnectionException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "Database error while deleting doctor");
	        }
	        
	        doGet(request, response);
	    }

}
	