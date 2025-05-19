package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.User;
import com.dentalClinic.service.UserService;
import com.dentalClinic.utility.CookieUtility;
import com.dentalClinic.utility.ImageHandler;
import com.dentalClinic.utility.ValidationUtil;

import at.favre.lib.crypto.bcrypt.BCrypt;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/user-register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, 
		maxFileSize = 1024 * 1024 * 10, // 4 MB
		maxRequestSize = 1024 * 1024 * 50) // 20 MB
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {


	    // Collect values
	    String firstName = request.getParameter("first_name");
	    String lastName = request.getParameter("last_name");
	    String email = request.getParameter("email");
	    String phone = request.getParameter("phone");
	    String address = request.getParameter("address");
	    String dobString = request.getParameter("dob");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirm_password");

	    // Validate fields one by one and return with an error if any fail
	    if (ValidationUtil.isNullOrEmpty(firstName)) {
	        request.setAttribute("error", "Please enter a valid first name.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    if (ValidationUtil.isNullOrEmpty(lastName) || !ValidationUtil.isAlphabetic(lastName)) {
	        request.setAttribute("error", "Please enter a valid last name.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    if (!ValidationUtil.isValidEmail(email)) {
	        request.setAttribute("error", "Please enter a valid email address.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }
	    
	    System.out.println(phone.substring(5));

//	    if (!ValidationUtil.isValidPhoneNumber(phone.substring(5))) {
//	        request.setAttribute("error", "Please enter a valid Nepali phone number starting with 98.");
//	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
//	        return;
//	    }

	    if (ValidationUtil.isNullOrEmpty(address)) {
	        request.setAttribute("error", "Please enter your address.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    System.out.print(dobString);
	    
	    // Validate DOB
	    Timestamp dob = null;
	    if (dobString == null || dobString.isEmpty()) {
	        request.setAttribute("error", "Please enter your date of birth.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    } else {
	        try {
	            LocalDate localDate = LocalDate.parse(dobString);
	            if (!ValidationUtil.isAgeAtLeast16(localDate)) {
	                request.setAttribute("error", "You must be at least 16 years old to register.");
	                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	                return;
	            }
	            dob = Timestamp.valueOf(localDate.atStartOfDay());
	        } catch (Exception e) {
	    	    System.out.print(dobString +"erweruewrtewur");

	            request.setAttribute("error", "Invalid date format.");
	            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	            return;
	        }
	    }
	    System.out.print(dobString);


	    if (!ValidationUtil.isValidPassword(password)) {
	        request.setAttribute("error", "Password must be at least 8 characters long and include an uppercase letter, a digit, and a special character.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
	        request.setAttribute("error", "Passwords do not match.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }
	    
	    String imagePath = ImageHandler.uploadImageToSubfolder(request.getPart("profile_image"), request, "users");

	    // All validation passed, proceed to create the user
	    User user = new User();
	    user.setFirstName(firstName);
	    user.setLastName(lastName);
	    user.setEmail(email);
	    user.setPhone(phone);
	    user.setAddress(address);
	    System.out.print(dob);
	    user.setDob(dob);
	    user.setPassword(BCrypt.withDefaults().hashToString(12, password.toCharArray()));
	    user.setProfileImage(imagePath);
	    user.setActive(true);
	    user.setCreatedAt(new Timestamp(Instant.now().toEpochMilli()));

	    try {
	    	System.out.print(user);
	    	
	        User returnedUser = UserService.registerUser(user);
		    System.out.print("ewjhgewgjhgejhere");


	        if (returnedUser != null) {
	            
	        	createUserSession(request,returnedUser);

	        	Cookie roleCookie = CookieUtility.createCookie("user_role", user.getRole(),23000,true);
				System.out.print("Role   :  "  + user.getRole());
				
				response.addCookie(roleCookie);

				System.out.print("Role   :  "  + CookieUtility.getCookieValue(request, "user_role"));
				Cookie userIdCookie = CookieUtility.createCookie("user_id", String.valueOf(user.getUserId()));
				
				response.addCookie(userIdCookie);

	            response.sendRedirect("/dentalClinic/patient");
	            
	        } else {
	            request.setAttribute("error", "Registration failed. Please try again.");
	            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        }
	    } catch (DatabaseConnectionException e) {
	        e.printStackTrace();
	        request.setAttribute("error", "Server error occurred. Please try again later.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	    }
	}
	
	

	private void createUserSession(HttpServletRequest request, User user) {
		
		HttpSession session = request.getSession();
		session.setAttribute("user_id", user.getUserId());
		session.setAttribute("user_email", user.getEmail());
		session.setAttribute("user_fname", user.getFirstName());
		session.setAttribute("user_lname", user.getLastName());
		session.setAttribute("created_at", Instant.now());

	}

	


}
