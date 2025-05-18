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
 * Servlet implementation class PatientAppointmentsServlet
 */
@WebServlet("/patient/appointments")
public class PatientAppointmentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PatientAppointmentsServlet() {
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

			request.setAttribute("appointments", appointments);

		} catch (SQLException | DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/WEB-INF/pages/patient-appointments.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String action = String.valueOf(request.getParameter("action"));

		if (action.equalsIgnoreCase("delete")) {
			doDelete(request, response);
		} else {

			doGet(request, response);

		}
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String appointmentIdStr = request.getParameter("appointmentId");

		try {
			if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Appointment ID is required");
				return;
			}

			int appointmentId = Integer.parseInt(appointmentIdStr);
			boolean isDeleted = AdminService.deleteAppointment(appointmentId);

			if (isDeleted) {
				response.setStatus(HttpServletResponse.SC_OK);
				doGet(request,response);
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found or already cancelled");
			}
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid appointment ID");
		} catch (SQLException | DatabaseConnectionException e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"Database error while cancelling appointment");
		}

	}

}
