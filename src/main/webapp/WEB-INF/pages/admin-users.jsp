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
<title>Users - Dental Clinic Admin</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/global.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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

/* User Page Specific Styles */
.action-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.add-user-btn {
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

.add-user-btn i {
	margin-right: 8px;
}

.add-user-btn:hover {
	background-color: #3182ce;
}

.filter-container {
	display: flex;
	gap: 10px;
}

.filter-container select, .filter-container input {
	padding: 8px 12px;
	border: 1px solid #e2e8f0;
	border-radius: 5px;
	background-color: white;
	outline: none;
	color: #4a5568;
}

/* Table Styles */
.table-container {
	width: 100%;
	overflow-x: auto;
	margin-bottom: 20px;
	border-radius: 8px;
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

/* Action Buttons */
.actions {
	display: flex;
	gap: 5px;
}

.actions a {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 16px;
	width: 30px;
	height: 45px;
	border-radius: 5px;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.3s;
	text-decoration: none;
}

.actions a:hover {
	background-color: #edf2f7;
}

.actions a.info {
	color: #4299e1;
}

.actions a.edit {
	color: #48bb78;
}

.actions a.delete {
	color: #e53e3e;
}

/* user Avatar */
.user-avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
	object-fit: cover;
}

.user-info {
	display: flex;
	align-items: center;
}

/* Pagination */
.pagination {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 5px;
	margin-top: 20px;
}

.pagination a {
	width: 35px;
	height: 35px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #e2e8f0;
	background-color: white;
	border-radius: 5px;
	cursor: pointer;
	transition: all 0.3s;
	text-decoration: none;
	color: #4a5568;
}

.pagination a:hover {
	background-color: #edf2f7;
}

.pagination a.active {
	background-color: #4299e1;
	color: white;
	border-color: #4299e1;
}

/* Status indicator */
.status {
	display: inline-block;
	padding: 4px 8px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 500;
}

.status.active {
	background-color: #c6f6d5;
	color: #22543d;
}

.status.inactive {
	background-color: #fed7d7;
	color: #822727;
}

/* Custom scrollbar styles */
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
		<!-- Sidebar Navigation (loaded via JS) -->
		<%@ include file="admin-sidebar.jsp"%>


		<!-- Main Content Area -->
		<main class="main-content">
			<!-- Top Navigation Bar (loaded via JS) -->
			<%@ include file="admin-nav.jsp"%>

			<!-- Users Content -->
			<div class="dashboard-content">
				<section class="content-section">
				
				<div style="width: 100%; display: flex; justify-content: space-between; gap: 10px; margin-bottom: 20px">
					<span style="font-weight:700; font-size: 1.5rem;">User Management</span>
					<a href="/dentalClinic/admin/users/new">Add user</a>
				</div>


					<!-- Users Table -->
					<div class="table-container">
						<table class="data-table">
							<thead>
								<tr>
									<th>User</th>
									<th>Email</th>
									<th>Phone</th>
									<th>Address</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<User> users = (List<User>) request.getAttribute("users");
								if (users != null) {
									for (User user : users) {
								%>
								<tr>

									<td><%=user.getFirstName()%> <%=user.getLastName()%></td>

									<td><%=user.getEmail()%></td>
									<td><%=user.getPhone()%></td>
									<td><%=user.getAddress()%></td>
									<td>
										<div class="appointment-actions" style="display: flex; gap:20px">
											<a href="${pageContext.request.contextPath}/admin/users/:id">Edit</a>
											<form method="post"
												action="${pageContext.request.contextPath}/admin/users">
												<input type="hidden" name="action" value="delete" /> <input
													type="hidden" name="userId" value="<%=user.getUserId()%>">
												<button type="submit" class="appointment-action"
													onclick="return confirm('Are you sure you want to remove this user?');">
													<i class="fas fa-times-circle"></i> Delete
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
				</section>
			</div>
		</main>
	</div>

</body>
</html>
