<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.dentalClinic.model.*"%>
<%@ page import="com.dentalClinic.service.*"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Dental Clinic Admin</title>
     <link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/global.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
    
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
  text-decoration: none;
}

body {
  background-color: #f5f6fa;
  color: #333;
}

/* Dashboard Container */
.dashboard-container {
  display: flex;
  min-height: 100vh;
}

/* Main Content Area */
.main-content {
  flex: 1;
  margin-left: 250px;
  transition: all 0.3s;
}

/* Dashboard Content */
.dashboard-content {
  padding: 20px;
  margin-top: 70px; /* Add margin to account for fixed navbar */
}

.content-section {
  margin-bottom: 30px;
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.content-section h1 {
  color: #1a365d;
  margin-bottom: 20px;
  font-weight: 600;
}

/* Common Status Styles */
.status {
  display: inline-block;
  padding: 5px 10px;
  border-radius: 15px;
  font-size: 12px;
  font-weight: 500;
}

.status.confirmed {
  background-color: #c6f6d5;
  color: #22543d;
}

.status.pending {
  background-color: #feebc8;
  color: #744210;
}

.status.cancelled {
  background-color: #fed7d7;
  color: #822727;
}

.status.completed {
  background-color: #e6fffa;
  color: #234e52;
}

.status.active {
  background-color: #c6f6d5;
  color: #22543d;
}

.status.inactive {
  background-color: #fed7d7;
  color: #822727;
}

/* Scrollbar styling for containers with scrollable content */

.scrollbar-hover {
  scrollbar-width: 6px; /* Firefox */
}

.scrollbar-hover * {
  transition: all 1s ease;
}

.scrollbar-hover::-webkit-scrollbar {
  width: 6px;
  display: none;
}

.scrollbar-hover:hover::-webkit-scrollbar {
  width: 6px;
  visibility: visible;
}

.scrollbar-hover:hover {
  scrollbar-width: thin;
}

.scrollbar-hover::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.scrollbar-hover::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 10px;
}

.scrollbar-hover::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

.scrollbar-none {
  scrollbar-width: none;
}

.scrollbar-none::-webkit-scrollbar {
  display: none;
}
    
    
      /* Dashboard-specific styles */
      .summary-cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
      }

      .summary-card {
        background: white;
        border-radius: 8px;
        padding: 20px;
        display: flex;
        flex-direction: column;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .summary-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        border-radius: 12px;
        margin-bottom: 15px;
        font-size: 24px;
        color: white;
      }

      .summary-icon.patients {
        background-color: #4299e1;
      }

      .summary-icon.appointments {
        background-color: #48bb78;
      }

      .summary-icon.doctors {
        background-color: #ed8936;
      }

      .summary-icon.revenue {
        background-color: #9f7aea;
      }

      .summary-details h3 {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 5px;
        color: #2d3748;
      }

      .summary-details p {
        color: #718096;
        font-size: 14px;
      }

      .summary-trend {
        margin-top: 15px;
        font-size: 14px;
        font-weight: 500;
        display: flex;
        align-items: center;
      }

      .summary-trend.up {
        color: #48bb78;
      }

      .summary-trend.down {
        color: #e53e3e;
      }

      .summary-trend.steady {
        color: #718096;
      }

      .summary-trend i {
        margin-right: 5px;
      }

      /* Charts Section */
      .charts-section {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
      }

      .chart-container {
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
      }

      .chart-header h3 {
        color: #2d3748;
        font-weight: 600;
      }

      .chart-period select {
        padding: 5px 10px;
        border-radius: 4px;
        border: 1px solid #e2e8f0;
        background-color: #f8f9fa;
        outline: none;
      }

      .chart-placeholder {
        display: flex;
        height: 250px;
        align-items: flex-end;
        justify-content: space-between;
        padding: 20px 0;
      }

      .chart-bars {
        display: flex;
        height: 100%;
        width: 100%;
        align-items: flex-end;
        justify-content: space-between;
      }

      .chart-bar {
        width: 30px;
        background-color: #4299e1;
        border-radius: 4px;
        position: relative;
        transition: height 0.5s;
      }

      .chart-bar span {
        position: absolute;
        bottom: -25px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 12px;
        color: #718096;
      }

      .pie-chart {
        position: relative;
      }

      .pie-chart-placeholder {
        width: 180px;
        height: 180px;
        margin: 0 auto;
        background: conic-gradient(
          #4299e1 0% 35%,
          #48bb78 35% 80%,
          #ed8936 80% 95%,
          #e53e3e 95% 100%
        );
        border-radius: 50%;
      }

      .pie-chart-legend {
        margin-top: 20px;
      }

      .legend-item {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
        font-size: 14px;
        color: #4a5568;
      }

      .color-box {
        width: 15px;
        height: 15px;
        border-radius: 3px;
        margin-right: 8px;
      }

      .color1 {
        background-color: #4299e1;
      }

      .color2 {
        background-color: #48bb78;
      }

      .color3 {
        background-color: #ed8936;
      }

      .color4 {
        background-color: #e53e3e;
      }

      /* Recent Activity */
      .recent-activity,
      .upcoming-appointments {
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }

      .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
      }

      .section-header h3 {
        color: #2d3748;
        font-weight: 600;
      }

      .view-all {
        color: #4299e1;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
      }

      .activity-list {
        display: flex;
        flex-direction: column;
        gap: 15px;
      }

      .activity-item {
        display: flex;
        align-items: center;
        padding: 12px;
        border-radius: 8px;
        background-color: #f8f9fa;
      }

      .activity-icon {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        color: white;
      }

      .activity-icon.appointment {
        background-color: #4299e1;
      }

      .activity-icon.patient {
        background-color: #48bb78;
      }

      .activity-icon.payment {
        background-color: #9f7aea;
      }

      .activity-icon.cancel {
        background-color: #e53e3e;
      }

      .activity-icon.treatment {
        background-color: #ed8936;
      }

      .activity-details {
        flex: 1;
      }

      .activity-details p {
        margin-bottom: 5px;
        font-size: 14px;
        color: #4a5568;
      }

      .activity-details .timestamp {
        font-size: 12px;
        color: #718096;
      }

      /* Data Table */
      /* FIXED: Table container styles for proper horizontal scrolling */
      .table-container {
        width: 100%;
        overflow-x: auto;
        margin-bottom: 20px;
        border-radius: 8px;
        /* Remove max-height to prevent vertical scrolling issues */
      }

      .data-table {
        width: 100%;
        min-width: 750px; /* Ensures horizontal scrolling when needed */
        border-collapse: collapse;
        white-space: nowrap;
      }

      .data-table thead {
        position: sticky;
        top: 0;
        background-color: #f8f9fa;
        z-index: 10;
      }

      .data-table th {
        padding: 12px 15px;
        text-align: left;
        color: #4a5568;
        font-weight: 600;
        border-bottom: 2px solid #e2e8f0;
      }

      .data-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #e2e8f0;
      }

      .data-table tr:hover {
        background-color: #f8f9fa;
      }

      /* Status indicators */
      .status {
        display: inline-block;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
      }

      .status.confirmed {
        background-color: #e6fffa;
        color: #38b2ac;
      }

      .status.pending {
        background-color: #fefcbf;
        color: #d69e2e;
      }

      /* Action Buttons */
      .actions {
        display: flex;
        gap: 5px;
      }

      .actions button {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 16px;
        width: 30px;
        height: 30px;
        border-radius: 5px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
      }

      .actions button:hover {
        background-color: #edf2f7;
      }

      /* Action Bar */
      .action-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }

      .add-btn {
        display: flex;
        align-items: center;
        background-color: #4299e1;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 500;
        transition: background-color 0.3s;
      }

      .add-btn i {
        margin-right: 8px;
      }

      .add-btn:hover {
        background-color: #3182ce;
      }

      .filter-container {
        display: flex;
        gap: 10px;
      }

      .filter-container select,
      .filter-container input {
        padding: 8px 12px;
        border: 1px solid #e2e8f0;
        border-radius: 5px;
        background-color: white;
        outline: none;
        color: #4a5568;
      }

      /* Responsive tweaks for dashboard */
      @media screen and (max-width: 768px) {
        .charts-section {
          grid-template-columns: 1fr;
        }

        .summary-cards {
          grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        }
      }

      @media screen and (max-width: 480px) {
        .summary-cards {
          grid-template-columns: 1fr;
        }
      }

      /* FIXED: Removed conflicting overflow settings */
      .dashboard-content {
        width: 100%;
      }

      /* FIXED: Custom scrollbar styles */
      .table-container::-webkit-scrollbar {
        height: 6px;
        width: 6px;
      }

      .table-container::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 3px;
      }

      .table-container::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 3px;
      }

      .table-container::-webkit-scrollbar-thumb:hover {
        background: #a1a1a1;
      }
    </style>
  </head>

  <body>
    <div class="dashboard-container">

       <%@ include file="admin-sidebar.jsp"%>
     

      <!-- Main Content Area -->
      <main class="main-content">

        <%@ include file="admin-nav.jsp"%>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
          <section class="content-section">
            <h1>Dashboard Overview</h1>

            <!-- Summary Cards -->
            <div class="summary-cards">
              <div class="summary-card">
                <div class="summary-icon patients">
                  <i class="fas fa-users"></i>
                </div>
                <div class="summary-details">
                  <h3>5,280</h3>
                  <p>Total Patients</p>
                </div>
                <div class="summary-trend up">
                  <i class="fas fa-arrow-up"></i> 12%
                </div>
              </div>

              <div class="summary-card">
                <div class="summary-icon appointments">
                  <i class="far fa-calendar-check"></i>
                </div>
                <div class="summary-details">
                  <h3>248</h3>
                  <p>Appointments This Week</p>
                </div>
                <div class="summary-trend up">
                  <i class="fas fa-arrow-up"></i> 8%
                </div>
              </div>

              <div class="summary-card">
                <div class="summary-icon doctors">
                  <i class="fas fa-user-md"></i>
                </div>
                <div class="summary-details">
                  <h3>16</h3>
                  <p>Active Doctors</p>
                </div>
                <div class="summary-trend steady">
                  <i class="fas fa-equals"></i> 0%
                </div>
              </div>

              <div class="summary-card">
                <div class="summary-icon revenue">
                  <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="summary-details">
                  <h3>$75,240</h3>
                  <p>Monthly Revenue</p>
                </div>
                <div class="summary-trend up">
                  <i class="fas fa-arrow-up"></i> 15%
                </div>
              </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
              <div class="chart-container">
                <div class="chart-header">
                  <h3>Appointments Overview</h3>
                  <div class="chart-period">
                    <select>
                      <option>Last 7 Days</option>
                      <option>Last 30 Days</option>
                      <option>Last 90 Days</option>
                    </select>
                  </div>
                </div>
                <div class="chart-placeholder">
                  <!-- Chart would go here in a real app -->
                  <div class="chart-bars">
                    <div class="chart-bar" style="height: 60%">
                      <span>Mon</span>
                    </div>
                    <div class="chart-bar" style="height: 80%">
                      <span>Tue</span>
                    </div>
                    <div class="chart-bar" style="height: 65%">
                      <span>Wed</span>
                    </div>
                    <div class="chart-bar" style="height: 90%">
                      <span>Thu</span>
                    </div>
                    <div class="chart-bar" style="height: 75%">
                      <span>Fri</span>
                    </div>
                    <div class="chart-bar" style="height: 45%">
                      <span>Sat</span>
                    </div>
                    <div class="chart-bar" style="height: 30%">
                      <span>Sun</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="chart-container">
                <div class="chart-header">
                  <h3>Revenue Breakdown</h3>
                  <div class="chart-period">
                    <select>
                      <option>This Month</option>
                      <option>Last Month</option>
                      <option>This Quarter</option>
                    </select>
                  </div>
                </div>
                <div class="chart-placeholder pie-chart">
                  <!-- Pie chart would go here in a real app -->
                  <div class="pie-chart-placeholder"></div>
                  <div class="pie-chart-legend">
                    <div class="legend-item">
                      <span class="color-box color1"></span> Consultations (35%)
                    </div>
                    <div class="legend-item">
                      <span class="color-box color2"></span> Treatments (45%)
                    </div>
                    <div class="legend-item">
                      <span class="color-box color3"></span> Surgeries (15%)
                    </div>
                    <div class="legend-item">
                      <span class="color-box color4"></span> Other (5%)
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Upcoming Appointments -->
            <div class="upcoming-appointments">
              <div class="section-header">
                <h3>All Appointments</h3>
               
              </div>
              
              <div class="table-container">
						<table class="data-table">
							<thead>
								<tr>
									<th>Patient</th>
									<th>Email</th>
									<th>Phone</th>
									<th>Doctor</th>
									<th>Date</th>
									<th>Time</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
								if (appointments != null) {
									for (Appointment appointment : appointments) {
										Doctor doctor = DoctorService.getDoctorById(appointment.getDoctorId());
										User patient = UserService.getUserById(appointment.getPatientId());
								%>
								<tr>
									<td> <%=patient.getFirstName()%> <%=patient.getLastName()%></td>
									<td> <%=patient.getEmail()%></td>
									<td> <%=patient.getPhone()%></td>
									<td>Dr. <%=doctor.getFirstName()%> <%=doctor.getLastName()%></td>
									<td><%=appointment.getAppointmentDate()%> </td>
									<td><%=appointment.getAppointmentTime()%> </td>

									<td>
										<div class="appointment-actions">
											<form method="post"
												action="${pageContext.request.contextPath}/admin/appointments">
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
          </section>
        </div>
      </main>
    </div>

  </body>
</html>
