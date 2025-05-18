<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Registration Form</title>
<link rel="stylesheet" href="../../styles/global.css" />
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

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background-color: #f5f8fa;
	color: #333;
	line-height: 1.6;
	padding: 20px;
}

form {
	max-width: 800px;
	margin: 200px 100px;
	background-color: #fff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	color: #2c3e50;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #2c3e50;
}

.required::after {
	content: " *";
	color: #e74c3c;
}

input, textarea, select {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 16px;
	transition: border 0.3s;
}

input:focus, textarea:focus, select:focus {
	outline: none;
	border-color: #3498db;
	box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
}

textarea {
	resize: vertical;
	min-height: 100px;
}

input[type="file"] {
	padding: 10px;
	background-color: #f9f9f9;
}

input[type="submit"] {
	background-color: #2c3e50;
	color: white;
	border: none;
	padding: 14px 20px;
	cursor: pointer;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #1a252f;
}

.form-row {
	display: flex;
	gap: 20px;
}

.form-row .form-group {
	flex: 1;
}

.hint {
	font-size: 14px;
	color: #7f8c8d;
	margin-top: 5px;
}

@media ( max-width : 768px) {
	.form-row {
		flex-direction: column;
		gap: 0;
	}
	.container {
		padding: 20px;
	}
}
</style>
</head>
<body>
	<div class="dashboard-container">

		<%@ include file="admin-sidebar.jsp"%>


		<main class="main-content">

			<%@ include file="admin-nav.jsp"%>

			<form action="/dentalClinic/admin/doctors/new" method="post"
				enctype="multipart/form-data" class="dashboard-content">
				<div class="form-row">
					<div class="form-group">
						<label for="first_name" class="required">First Name</label> <input
							type="text" id="first_name" name="first_name" required>
					</div>
					<div class="form-group">
						<label for="last_name" class="required">Last Name</label> <input
							type="text" id="last_name" name="last_name" required>
					</div>
				</div>

				<div class="form-group">
					<label for="email" class="required">Email</label> <input
						type="email" id="email" name="email" required>
					<div class="hint">This will be used as your unique identifier</div>
				</div>

				<div class="form-row">
					<div class="form-group">
						<label for="phone">Phone Number</label> <input type="tel"
							id="phone" name="phone">
					</div>
					<div class="form-group">
						<label for="specialization" class="required">Specialization</label>
						<select id="specialization" name="specialization" required>
							<option value="">Select Specialization</option>
							<option value="General Dentist">General Dentist</option>
							<option value="Orthodontist">Orthodontist</option>
							<option value="Pediatric Dentist">Pediatric Dentist</option>
							<option value="Periodontist">Periodontist</option>
							<option value="Endodontist">Endodontist</option>
							<option value="Oral Surgeon">Oral Surgeon</option>
							<option value="Prosthodontist">Prosthodontist</option>
							<option value="Cosmetic Dentist">Cosmetic Dentist</option>
							<option value="Oral Pathologist">Oral Pathologist</option>
							<option value="Public Health Dentist">Public Health
								Dentist</option>
							<option value="Forensic Odontologist">Forensic
								Odontologist</option>
							<option value="Other">Other</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label for="address">Address</label> <input type="text"
						id="address" name="address">
				</div>

				<div class="form-group">
					<label for="qualifications">Qualifications</label>
					<textarea id="qualifications" name="qualifications"></textarea>
					<div class="hint">List your degrees, certifications, and
						relevant experience</div>
				</div>

				<div class="form-group">
					<label for="consultationFee" class="required">Consultation
						Fee</label> <input type="text" id="consultationFee" name="consultationFee"
						required>
					<div class="hint">Enter amount in dollars</div>
				</div>

				<div class="form-group">
					<label for="profile_image">Profile Image</label> <input type="file"
						id="profile_image" name="profile_image" accept="image/*">
				</div>

				<div class="form-group">
					<input type="submit" value="Register">
				</div>

			</form>

		</main>

	</div>

</body>
</html>