package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Appointment;
import com.dentalClinic.model.User;
import com.dentalClinic.service.AdminService;
import com.dentalClinic.service.UserService;
import com.dentalClinic.utility.CookieUtility;

/**
 * Servlet implementation class PatientDashboardServlet
 */
@WebServlet("/patient")
public class PatientDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PatientDashboardServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userId = CookieUtility.getCookieValue(request, "user_id");

		if (userId != null) {
			try {
				User user = UserService.getUserById(Integer.parseInt(userId));

				request.setAttribute("first_name", user.getFirstName());
				request.setAttribute("last_name", user.getLastName());
				request.setAttribute("email", user.getEmail());
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

		try {

			List<Appointment> appointments = AdminService.getAppointmentsByPatient(1);

			System.out.print(appointments);

			request.setAttribute("appointments", appointments);

		} catch (SQLException | DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.getRequestDispatcher("/WEB-INF/pages/patient-dashboard.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
