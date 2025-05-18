<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.dentalClinic.model.Appointment"%>
<%@ page import="com.dentalClinic.service.DoctorService"%>
<%@ page import="com.dentalClinic.service.AdminService"%>


<%@ page import="com.dentalClinic.model.Doctor"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>User Portal - Vaidehi Dental</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/global.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<style>
body {
	margin: 0;
	font-family: "Poppins", sans-serif;
	background-color: #f5f6fa;
}

.portal-container {
	display: flex;
	min-height: 100vh;
}

/* Sidebar styles */
.sidebar {
	width: 250px;
	background-color: #2c3e50;
	color: white;
	position: fixed;
	height: 100%;
	overflow-y: auto;
}

.sidebar-header {
	padding: 20px;
	text-align: center;
	border-bottom: 1px solid #3c546c;
}

.sidebar-user {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px 0;
}

.user-avatar {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background-color: #4299e1;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 10px;
	font-size: 32px;
	color: white;
}

.user-name {
	font-weight: 600;
	margin-bottom: 5px;
}

.user-email {
	font-size: 12px;
	color: #cbd5e0;
}

.sidebar-nav {
	padding: 0;
	list-style-type: none;
}

.sidebar-nav li {
	padding: 0;
}

.sidebar-nav li a {
	display: flex;
	align-items: center;
	padding: 15px 20px;
	color: #cbd5e0;
	text-decoration: none;
	transition: all 0.3s;
}

.sidebar-nav li a i {
	margin-right: 10px;
	width: 20px;
	text-align: center;
}

.sidebar-nav li a:hover, .sidebar-nav li.active a {
	background-color: #34495e;
	color: white;
}

.sidebar-nav li.active a {
	border-left: 4px solid #4299e1;
}

.logout-link {
	margin-top: 30px;
	border-top: 1px solid #3c546c;
}

/* Main content styles */
.main-content {
	flex: 1;
	margin-left: 250px;
	padding: 20px;
}

.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.page-title {
	font-size: 24px;
	font-weight: 600;
	color: #2d3748;
}

.portal-cards {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.portal-card {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	transition: transform 0.3s;
}

.portal-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.portal-card-header {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

.portal-card-icon {
	width: 45px;
	height: 45px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 15px;
	font-size: 18px;
	color: white;
}

.icon-blue {
	background-color: #4299e1;
}

.icon-green {
	background-color: #48bb78;
}

.icon-orange {
	background-color: #ed8936;
}

.icon-purple {
	background-color: #9f7aea;
}

.portal-card-title {
	margin: 0;
	font-size: 18px;
	font-weight: 600;
	color: #2d3748;
}

.portal-card-content {
	margin-bottom: 15px;
	color: #718096;
}

.portal-card-action {
	display: inline-block;
	padding: 8px 16px;
	background-color: #ebf8ff;
	color: #4299e1;
	border-radius: 5px;
	text-decoration: none;
	font-weight: 500;
	transition: background-color 0.3s;
}

.portal-card-action:hover {
	background-color: #bee3f8;
}

/* Appointments section */
.appointments-section {
	background-color: white;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.section-title {
	font-size: 18px;
	font-weight: 600;
	color: #2d3748;
}

.view-all {
	font-size: 14px;
	color: #4299e1;
	text-decoration: none;
}

.view-all:hover {
	text-decoration: underline;
}

.appointments-table {
	width: 100%;
	border-collapse: collapse;
}

.appointments-table th {
	text-align: left;
	padding: 12px 15px;
	border-bottom: 1px solid #e2e8f0;
	color: #718096;
	font-weight: 500;
}

.appointments-table td {
	padding: 12px 15px;
	border-bottom: 1px solid #e2e8f0;
}

.appointments-table tr:last-child td {
	border-bottom: none;
}

.appointment-actions {
	display: flex;
	gap: 10px;
}

.appointment-action {
	background: none;
	border: none;
	font-size: 14px;
	color: #4299e1;
	cursor: pointer;
	padding: 5px;
}

.appointment-action.cancel {
	color: #e53e3e;
}

.appointment-action.reschedule {
	color: #ed8936;
}

.status-badge {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 500;
}

.status-confirmed {
	background-color: #c6f6d5;
	color: #22543d;
}

.status-pending {
	background-color: #feebc8;
	color: #744210;
}

.status-cancelled {
	background-color: #fed7d7;
	color: #822727;
}

.status-completed {
	background-color: #e2e8f0;
	color: #2d3748;
}

/* Mobile responsiveness */
@media ( max-width : 768px) {
	.portal-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
		position: relative;
	}
	.main-content {
		margin-left: 0;
	}
	.portal-cards {
		grid-template-columns: 1fr;
	}
	.appointments-table {
		display: block;
		overflow-x: auto;
	}
}
</style>
</head>

<body>
	<div class="portal-container">
		<!-- Sidebar -->
		<div class="sidebar">
			<div class="sidebar-header">
				<h3>Vaidehi Dental</h3>
			</div>


			<div class="sidebar-user">
				<img
					src="${pageContext.request.contextPath}/images/<%=request.getAttribute("profile_image")%>"
					width="100" height="100"
					style="border-radius: 50%; object-fit: cover; aspect-ratio: 1; margin-bottom:10px" />
				<div class="user-name"><%=request.getAttribute("first_name")%>
					<%=request.getAttribute("last_name")%>
				</div>
				<div class="user-email"><%=request.getAttribute("email")%></div>
			</div>

			<ul class="sidebar-nav">
				<li class="active"><a href="/dentalClinic/patient"> <i
						class="fas fa-home"></i> Dashboard
				</a></li>
				<li><a href="/dentalClinic/patient/appointments"> <i
						class="fas fa-calendar-alt"></i> My Appointments
				</a></li>
				<li><a href="/dentalClinic/patient/appointments/new"> <i
						class="fas fa-plus-circle"></i> Book Appointment
				</a></li>
				<li class=""><a href="/dentalClinic/patient/testimonial"> <i
                        class="fas fa-comment-medical"></i> Give Testimonial
                </a></li>
				<li><a href="/dentalClinic/patient/profile"> <i
						class="fas fa-user-circle"></i> My Profile
				</a></li>

				<li class="logout-link"><a href="/dentalClinic/logout"> <i
						class="fas fa-sign-out-alt"></i> Logout
				</a></li>
			</ul>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<div class="page-header">
				<h1 class="page-title">Patient Dashboard</h1>
				<div class="current-date" id="currentDate"></div>
			</div>

			<!-- Quick Access Cards -->
			<div class="portal-cards">
				<div class="portal-card">
					<div class="portal-card-header">
						<div class="portal-card-icon icon-blue">
							<i class="fas fa-calendar-plus"></i>
						</div>
						<h3 class="portal-card-title">Book Appointment</h3>
					</div>
					<div class="portal-card-content">Schedule a new appointment
						with our dental specialists.</div>
					<a href="/dentalClinic/patient/appointments/new"
						class="portal-card-action">Book Now</a>
				</div>

				<div class="portal-card">
					<div class="portal-card-header">
						<div class="portal-card-icon icon-green">
							<i class="fas fa-calendar-check"></i>
						</div>
						<h3 class="portal-card-title">My Appointments</h3>
					</div>
					<div class="portal-card-content">View or cancel your
						appointments.</div>
					<a href="/dentalClinic/patient/appointments"
						class="portal-card-action">View All</a>
				</div>

				<div class="portal-card">
					<div class="portal-card-header">
						<div class="portal-card-icon icon-orange">
							<i class="fas fa-user-edit"></i>
						</div>
						<h3 class="portal-card-title">Update Profile</h3>
					</div>
					<div class="portal-card-content">Keep your personal and
						contact information up to date.</div>
					<a href="/dentalClinic/patient/profile" class="portal-card-action">Edit
						Profile</a>
				</div>
			</div>

			<!-- Upcoming Appointments Section -->
			<div class="appointments-section">
				<div class="section-header">
					<h2 class="section-title">My Appointments</h2>
					<a href="/dentalClinic/patient/appointments" class="view-all">View
						All</a>
				</div>

				<table class="appointments-table">
					<thead>
						<tr>
							<th>Date and Time</th>
							<th>Doctor</th>


							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
						if (appointments != null) {
							for (Appointment appointment : appointments) {
								Doctor doctor = DoctorService.getDoctorById(appointment.getDoctorId());
						%>
						<tr>
							<td><%=appointment.getAppointmentDate()%> - <%=appointment.getAppointmentTime()%></td>
							<td>Dr. <%=doctor.getFirstName()%> <%=doctor.getLastName()%></td>

							<td>
								<div class="appointment-actions">
									<form method="post"
										action="${pageContext.request.contextPath}/patient/appointments">
										<input type="hidden" name="action" value="delete"> <input
											type="hidden" name="appointmentId"
											value="<%=appointment.getAppointmentId()%>">
										<button type="submit" class="appointment-action cancel"
											onclick="return confirm('Are you sure you want to cancel this appointment?');">
											<i class="fas fa-times-circle"></i> Cancel
										</button>
									</form>
								</div>
							</td>
						</tr>
						<%
						}
						}
						%>

					</tbody>
				</table>
			</div>
		</div>
	</div>


</body>
</html>
