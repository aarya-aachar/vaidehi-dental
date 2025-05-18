package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.User;
import com.dentalClinic.service.AdminService;
import com.dentalClinic.service.UserService;

/**
 * Servlet implementation class AdminUsersServlet
 */
@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminUsersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			List<User> users = AdminService.getAllUsers();
			
			request.setAttribute("users", users);
		} catch (SQLException | DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/WEB-INF/pages/admin-users.jsp").forward(request, response);
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
	        else {
	            // Handle other POST actions if needed
	            doGet(request, response);
	        }
	    }

	    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        String userIdStr = request.getParameter("userId");
	        
	        try {
	            if (userIdStr == null || userIdStr.isEmpty()) {
	                request.setAttribute("errorMessage", "User ID is required");
	                doGet(request, response);
	                return;
	            }
	            
	            int userId = Integer.parseInt(userIdStr);
	            boolean isDeleted = UserService.deleteUser(userId);
	            
	            if (isDeleted) {
	                request.setAttribute("successMessage", "User deleted successfully");
	            } else {
	                request.setAttribute("errorMessage", "User not found or could not be deleted");
	            }
	        } catch (NumberFormatException e) {
	            request.setAttribute("errorMessage", "Invalid User ID");
	        } catch (SQLException | DatabaseConnectionException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "Database error while deleting user");
	        }
	        
	        doGet(request, response);
	    }}

