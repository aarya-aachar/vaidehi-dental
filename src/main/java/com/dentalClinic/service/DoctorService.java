package com.dentalClinic.service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Doctor;
import com.dentalClinic.utility.ImageHandler;
import com.mysql.cj.xdevapi.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class DoctorService {

	
	public static void deleteDoctor(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    try {
	        // 1. Get doctor ID from request parameter
	        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
	        
	        // 2. Call the service method to perform soft delete
	        boolean isDeleted = AdminService.deleteDoctor(doctorId);
	        
	        // 3. Handle response based on operation result
	        if (isDeleted) {
	            // Set success message and redirect
	            request.getSession().setAttribute("successMessage", "Doctor deactivated successfully");
	            response.sendRedirect(request.getContextPath() + "/admin/doctors?success=true");
	        } else {
	            // Set error message and redirect back
	            request.getSession().setAttribute("errorMessage", "Failed to deactivate doctor");
	            response.sendRedirect(request.getContextPath() + "/admin/doctors?error=true");
	        }
	        
	    } catch (NumberFormatException e) {
	        // Handle invalid ID format
	        request.getSession().setAttribute("errorMessage", "Invalid doctor ID format");
	        response.sendRedirect(request.getContextPath() + "/admin/doctors?error=true");
	        
	    } catch (Exception e) {
	        // Handle database errors
	        e.printStackTrace();
	        request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
	        response.sendRedirect(request.getContextPath() + "/admin/doctors?error=true");
	    }
	}
	
	
	public static void updateDoctor(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    try {
	    
	        // 1. Get all parameters from the request
	        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
	        String firstName = request.getParameter("firstName");
	        String lastName = request.getParameter("lastName");
	        String email = request.getParameter("email");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	        String specialization = request.getParameter("specialization");
	        String qualifications = request.getParameter("qualifications");
	        Integer consultationFee = Integer.parseInt(request.getParameter("consultationFee"));
	        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
	       
	        // 2. Handle profile image upload
	        String profileImagePath = null;
	        Part filePart = request.getPart("profileImage");
	        
	        profileImagePath = ImageHandler.uploadImageToSubfolder(filePart, request, "doctor/profile-pic");
	        
	        // 3. Create Doctor object with updated data
	        Doctor doctor = new Doctor();
	        doctor.setDoctorId(doctorId);
	        doctor.setFirstName(firstName);
	        doctor.setLastName(lastName);
	        doctor.setEmail(email);
	        doctor.setPhone(phone);
	        doctor.setAddress(address);
	        doctor.setSpecialization(specialization);
	        doctor.setQualifications(qualifications);
	        doctor.setConsultationFee(consultationFee);
	        doctor.setProfileImage(profileImagePath);
	        doctor.setActive(isActive);
	        
	        // 4. Call the service method to update doctor
	        boolean isUpdated = AdminService.updateDoctor(doctor);
	        
	        // 5. Handle response based on operation result
	        if (isUpdated) {
	            request.getSession().setAttribute("successMessage", "Doctor updated successfully");
	        } else {
	            request.getSession().setAttribute("errorMessage", "Failed to update doctor");
	        }
	        
	        response.sendRedirect(request.getContextPath() + "/admin/doctors/edit?doctorId=" + doctorId);
	        
	    } catch (NumberFormatException e) {
	        request.getSession().setAttribute("errorMessage", "Invalid input format");
	        response.sendRedirect(request.getContextPath() + "/admin/doctors");
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
	        response.sendRedirect(request.getContextPath() + "/admin/doctors");
	    }
	}

	
	
	public static void getAllDoctors(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, DatabaseConnectionException {
        
      try {
            List<Doctor> doctors = AdminService.getAllDoctors();
            
            // 2. Set doctors list as request attribute
            request.setAttribute("doctors", doctors);
            
            // 3. Forward to JSP
//            request.getRequestDispatcher("/admin/doctors-list.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
	
//	
//	public static Doctor getDoctorById(HttpServletRequest request, HttpServletResponse response, int doctorId) throws SQLException, DatabaseConnectionException {
//        try  {
//            
//        	Doctor doctor = AdminService.getDoctorById(doctorId);
//        	request.setAttribute("doctor",doctor);
//         
//        }catch (SQLException e) {
//            e.printStackTrace();
//            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
//        }
//		return null;
//    }
//	
	
	
	public static Doctor getDoctorById(int doctorId) throws SQLException, DatabaseConnectionException {
        try  {
            
        	Doctor doctor = AdminService.getDoctorById(doctorId);

    		return doctor;

        }catch (SQLException e) {
            e.printStackTrace();
        }
		return null;
    }


	  
	public static void addDoctor(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
		
		
	    	// Get all parameter names and values
	    	Enumeration<String> params = request.getParameterNames();
	    	while(params.hasMoreElements()) {
	    	    String paramName = params.nextElement();
	    	    String[] paramValues = request.getParameterValues(paramName);
	    	    
	    	    System.out.print(paramName + " = ");
	    	    for(String val : paramValues) {
	    	        System.out.print(val + " ");
	    	    }
	    	    System.out.println();
	    	}
	    try {
	        // Extract parameters from request
	        String firstName = request.getParameter("first_name");
	        String lastName = request.getParameter("last_name");
	        String email = request.getParameter("email");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	        String specialization = request.getParameter("specialization");
	        String qualifications = request.getParameter("qualifications");
	        Integer consultationFee = Integer.parseInt(request.getParameter("consultationFee"));
	        
	        // Handle file upload for profile image
//	        Part profileImagePart = request.getPart("profileImage");
//	        
	        
	         String profileImagePath = ImageHandler.uploadImageToSubfolder(request.getPart("profile_image"), request, "doctor");
	        
	        // Create Doctor object
	        Doctor doctor = new Doctor();
	        doctor.setFirstName(firstName);
	        doctor.setLastName(lastName);
	        doctor.setEmail(email);
	        doctor.setPhone(phone);
	        doctor.setAddress(address);
	        doctor.setSpecialization(specialization);
	        doctor.setQualifications(qualifications);
	        doctor.setConsultationFee(consultationFee);
	        doctor.setProfileImage(profileImagePath);
	        
	        System.out.print(profileImagePath);
	        
	        // Call your service method
	        AdminService.addDoctor(doctor);
	        
//	        if (doctorId > 0) {
	            // Success - redirect or set success message
//	            request.getSession().setAttribute("successMessage", "Doctor added successfully!");
//	            response.sendRedirect(request.getContextPath() + "/admin/doctors?success=true");
//	        } else {
//	            // Failure - set error message
//	            request.setAttribute("errorMessage", "Failed to add doctor");
//	            request.getRequestDispatcher("/admin/add-doctor.jsp").forward(request, response);
//	        }
	        System.out.print(doctor);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error adding doctor: " + e.getMessage());
	        request.getRequestDispatcher("/admin/add-doctor.jsp").forward(request, response);
	    }
	}
}
