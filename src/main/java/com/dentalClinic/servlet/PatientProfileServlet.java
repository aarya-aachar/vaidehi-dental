package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


import java.sql.Timestamp;
import java.time.LocalDateTime;

import java.io.IOException;
import java.sql.SQLException;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.User;
import com.dentalClinic.service.UserService;
import com.dentalClinic.utility.CookieUtility;
import com.dentalClinic.utility.ImageHandler;

/**
 * Servlet implementation class PatientProfileServlet
 */
@WebServlet("/patient/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, 
maxFileSize = 1024 * 1024 * 10, // 4 MB
maxRequestSize = 1024 * 1024 * 50) // 20 MB
public class PatientProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PatientProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userId = CookieUtility.getCookieValue(request, "user_id");
		
		if(userId != null)
		{
			try {
				User user = UserService.getUserById(Integer.parseInt(userId));
				
				request.setAttribute("first_name", user.getFirstName());
				request.setAttribute("last_name", user.getLastName());
				request.setAttribute("email",user.getEmail());
				request.setAttribute("phone_number", user.getPhone());
				request.setAttribute("address", user.getAddress());
				request.setAttribute("profile_image", user.getProfileImage());
			
				Timestamp timestamp = user.getCreatedAt(); 
				LocalDateTime dateTime = timestamp.toLocalDateTime();
				int year = dateTime.getYear();

				request.setAttribute("created_at", year);


				
				
			} catch (NumberFormatException | SQLException | DatabaseConnectionException e) {
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("/WEB-INF/pages/patient-profile.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    // 1. Get current user from session
//	    HttpSession session = request.getSession(false);
//	    if (session == null) {
//	        response.sendRedirect(request.getContextPath() + "/login");
//	        return;
//	    }
//	    
//	    Integer userId = (Integer) session.getAttribute("user_id");
//	    if (userId == null) {
//	        response.sendRedirect(request.getContextPath() + "/login");
//	        return;
//	    }

	    try {
	    	
	    	Integer userId = Integer.parseInt(CookieUtility.getCookieValue(request, "user_id"));
	        // 2. Get the existing user from database
	        User user = UserService.getUserById(userId);
	        System.out.print(user.toString());

//	        if (user == null) {
//	            request.setAttribute("errorMessage", "User not found");
//	            request.getRequestDispatcher("/error.jsp").forward(request, response);
//	            return;
//	        }

	        // 3. Update user fields from request parameters
	        String firstName = request.getParameter("first_name");
	        String lastName = request.getParameter("last_name");
	        String phone = request.getParameter("phone_number");
	        String email = request.getParameter("email");
	        String address = request.getParameter("address");

	        System.out.println("\n\nFirst Name: " + firstName);
	        System.out.println("Last Name: " + lastName);
	        System.out.println("Phone Number: " + phone);
	        System.out.println("Address: " + address);

	        user.setFirstName(firstName);
	        user.setLastName(lastName);
	        user.setPhone(phone);
	        user.setAddress(address);
	        user.setEmail(email);

	        System.out.print(user.toString());

	        
	        Part filePart = request.getPart("profile_image"); // image is the name attribute in the form

	        if (filePart == null || filePart.getSize() == 0 || filePart.getSubmittedFileName() == null) {
	            System.out.println("No image uploaded.");
	        } else {
	            System.out.println("Image uploaded: " + filePart.getSubmittedFileName());
	            String profileImage = ImageHandler.uploadImageToSubfolder(request.getPart("profile_image"), request, "users");
	        	user.setProfileImage(profileImage);
	        }

	        
	  


	        // 5. Save updated user
	        boolean isUpdated = UserService.updateUser(user);
	        
	        // 6. Handle response
//	        if (isUpdated) {
//	            session.setAttribute("successMessage", "Profile updated successfully!");
//	            // Update session with new name if needed
//	            session.setAttribute("user_name", user.getFirstName() + " " + user.getLastName());
//	        } else {
//	            session.setAttribute("errorMessage", "Failed to update profile");
//	        }
//	        
	        response.sendRedirect(request.getContextPath() + "/patient/profile");

	    } catch (Exception e) {
	    	
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Error updating profile: " + e.getMessage());
	        request.getRequestDispatcher("/user/edit-profile.jsp").forward(request, response);
	    }
	}

}
