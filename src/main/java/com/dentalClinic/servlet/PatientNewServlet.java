package com.dentalClinic.servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.Appointment;
import com.dentalClinic.model.Doctor;
import com.dentalClinic.model.User;
import com.dentalClinic.service.AdminService;
import com.dentalClinic.service.DoctorService;
import com.dentalClinic.service.UserService;
import com.dentalClinic.utility.CookieUtility;

/**
 * Servlet implementation class PatientNewServlet
 */
@WebServlet("/patient/appointments/new")
public class PatientNewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PatientNewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

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

			// Check if there's an 'id' parameter
			String doctorId = request.getParameter("id");

			if (doctorId == null || doctorId.isEmpty()) {
				// No ID parameter found - return list of doctors

				List<Doctor> doctors = AdminService.getAllDoctors();

				for (Doctor doctor : doctors) {
					System.out.print(doctor.toString());
				}
				request.setAttribute("doctors", doctors);

			} else {
				// ID parameter exists - handle single doctor case
				try {
					Doctor doctor = DoctorService.getDoctorById(Integer.parseInt(doctorId));
					request.setAttribute("doctor", doctor);
				} catch (NumberFormatException e) {
					request.setAttribute("errorMessage", "Invalid doctor ID format");
				} catch (Exception e) {
					request.setAttribute("errorMessage", "Error fetching doctor: " + e.getMessage());
				}
			}

			// Forward to JSP page
			request.getRequestDispatcher("/WEB-INF/pages/patient-appointments-new.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Error processing request: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.print("in here guys tyutuytuy ");

		try {
			// 1. Get parameters from request
			int doctorId = Integer.parseInt(request.getParameter("doctor_id"));
			System.out.print(request.getParameter("appointment_date"));
			System.out.print(request.getParameter("appointment_time"));

			Date appointmentDate = Date.valueOf(request.getParameter("appointment_date"));
			Time appointmentTime = Time.valueOf(request.getParameter("appointment_time") + ":00"); // Ensure time format
			String patientDescription = request.getParameter("patient_description");
			System.out.print("in here guys 4564564 ");

//            HttpSession session = request.getSession(false);

			Integer patientId;
			String patientIdString = "1";

//            if(session != null)
//            {
//                 patientIdString = String.valueOf(session.getAttribute("user_id"));
//
//            }
			System.out.print("in here guys hffghf ");

			patientId = Integer.parseInt(patientIdString);

			System.out.print("in here guys ");
			// 2. Create Appointment object
			Appointment appointment = new Appointment();
			appointment.setDoctorId(doctorId);
			appointment.setPatientId(patientId);
			appointment.setAppointmentDate(appointmentDate);
			appointment.setAppointmentTime(appointmentTime);
			appointment.setPatientDescription(patientDescription);

			System.out.print(appointment.toString());

			// Status defaults to 'pending' in service layer

			// 3. Check if time slot is available
			if (!AdminService.isTimeSlotAvailable(doctorId, appointmentDate, appointmentTime)) {
				request.setAttribute("errorMessage", "This time slot is already booked. Please choose another time.");
				request.getRequestDispatcher("/book-appointment.jsp").forward(request, response);
				return;
			}

			// 4. Save appointment
			boolean created = AdminService.createAppointment(appointment);

			System.out.print(created);

			// 5. Handle response
			if (created) {
				request.getSession().setAttribute("successMessage", "Appointment booked successfully!");
				response.sendRedirect(request.getContextPath() + "/patient/appointments");
			} else {
				request.setAttribute("errorMessage", "Failed to book appointment. Please try again.");
				request.getRequestDispatcher("/book-appointment.jsp").forward(request, response);
			}

		} catch (IllegalArgumentException e) {
			System.out.print("in her576e guys ");

			// Handle invalid date/time format
			request.setAttribute("errorMessage",
					"Invalid date or time format. Please use YYYY-MM-DD and HH:MM format.");
			request.getRequestDispatcher("/book-appointment.jsp").forward(request, response);

		} catch (SQLException | DatabaseConnectionException e) {
			System.out.print("in 5555656 guys ");

			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error: " + e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

}
