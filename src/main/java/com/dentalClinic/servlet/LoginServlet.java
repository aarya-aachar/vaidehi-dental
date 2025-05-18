package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.Instant;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.User;
import com.dentalClinic.service.UserService;
import com.dentalClinic.utility.CookieUtility;
import com.dentalClinic.utility.ValidationUtil;

import at.favre.lib.crypto.bcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

//		 Step 2: Basic validation
		if (ValidationUtil.isNullOrEmpty(email)) {
			setErrorAndReturn("Email cannot be empty.", request, response);
			return;
		}

		if (!ValidationUtil.isValidEmail(email)) {
			setErrorAndReturn("The email address is not in a valid format.", request, response);
			return;
		}

		if (ValidationUtil.isNullOrEmpty(password)) {
			setErrorAndReturn("Password cannot be empty.", request, response);
			return;
		}

		if (!ValidationUtil.isValidPassword(password)) {
			setErrorAndReturn(
					"Password must be at least 8 characters long and contain a mix of letters, numbers and symbols.",
					request, response);
			return;
		}

//		 Step 3: Authentication
		try {
			User user = authenticate(email, password);
			
			System.out.print(user);
			
			CookieUtility.deleteAllCookies(request, response);
			
		

			if (user != null) {
				createUserSession(request, response, user);
				Cookie roleCookie = CookieUtility.createCookie("user_role", user.getRole(),23000,true);
				System.out.print("Role   :  "  + user.getRole());
				
				response.addCookie(roleCookie);

				System.out.print("Role   :  "  + CookieUtility.getCookieValue(request, "user_role"));
				Cookie userIdCookie = CookieUtility.createCookie("user_id", String.valueOf(user.getUserId()));
				
				response.addCookie(userIdCookie);

				
			
				

				System.out.print(user.getRole().repeat(5));
				
				
				if(user.getRole().equals("patient"))
				{
					System.out.print("patient");
					response.sendRedirect("patient");

				}else if(user.getRole().equals("admin"))
				{
					System.out.print("hello");
					response.sendRedirect("admin/dashboard");

				} else {
					System.out.print("invalid role");
				}

			} else {

				setErrorAndReturn("Incorrect email or password. Please try again.", request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			setErrorAndReturn("A database error occurred while processing your request. Please try again later.",
					request, response);
		} catch (DatabaseConnectionException e) {
			e.printStackTrace();
			setErrorAndReturn("Could not connect to the database. Please contact support or try again later.", request,
					response);
		} catch (Exception e) {
			e.printStackTrace();
			setErrorAndReturn("An unexpected error occurred. Please try again later.", request, response);
		}
	}

	private User authenticate(String email, String password) throws SQLException, DatabaseConnectionException {
		
		User user = UserService.getUserByEmail(email);

		if (user == null) {
			return null; 
		}

		boolean passwordMatches = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword()).verified;
		return passwordMatches ? user : null;
	}

	
	
	private void createUserSession(HttpServletRequest request, HttpServletResponse response,  User user) {
		
		
		clearExistingSession(request,response);

		
		HttpSession session = request.getSession();
		
		
		session.setAttribute("user_id", user.getUserId());
		session.setAttribute("user_email", user.getEmail());
		session.setAttribute("user_fname", user.getFirstName());
		session.setAttribute("user_lname", user.getLastName());
		session.setAttribute("created_at", Instant.now());
	}
	
	

private void clearExistingSession(HttpServletRequest request, HttpServletResponse response) {
    // Invalidate existing session if any
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        existingSession.invalidate();
    }
    
}

	
	
	
	private void setErrorAndReturn(String errorMessage, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("error", errorMessage);
		request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	}
}
