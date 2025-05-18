<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add New Appointment</title>

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

/* Form Styles */
form {
    max-width: 800px;
    margin: 0 auto;
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

@media (max-width: 768px) {
    .form-row {
        flex-direction: column;
        gap: 0;
    }
    .main-content {
        margin-left: 0;
    }
}
</style>
</head>
<body>
    <div class="dashboard-container">
        <%@ include file="admin-sidebar.jsp"%>

        <main class="main-content">
            <%@ include file="admin-nav.jsp"%>

            <div class="dashboard-content">
                <form action="/dentalClinic/admin/appointments/new" method="post">
                    <h1>Add New Appointment</h1>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="user_id" class="required">Patient</label>
                            <select id="user_id" name="user_id" required>
                                <option value="">Select Patient</option>
                                <!-- These options would be populated from your database -->
                                <option value="1">John Doe (john@example.com)</option>
                                <option value="2">Jane Smith (jane@example.com)</option>
                                <option value="3">Robert Johnson (robert@example.com)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="doctor_id" class="required">Doctor</label>
                            <select id="doctor_id" name="doctor_id" required>
                                <option value="">Select Doctor</option>
                                <!-- These options would be populated from your database -->
                                <option value="101">Dr. Sarah Williams (Dentist)</option>
                                <option value="102">Dr. Michael Brown (Orthodontist)</option>
                                <option value="103">Dr. Emily Davis (Pediatric Dentist)</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="appointment_date" class="required">Appointment Date</label>
                            <input type="date" id="appointment_date" name="appointment_date" required>
                        </div>
                        <div class="form-group">
                            <label for="appointment_time" class="required">Appointment Time</label>
                            <input type="time" id="appointment_time" name="appointment_time" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="status" class="required">Status</label>
                        <select id="status" name="status" required>
                            <option value="">Select Status</option>
                            <option value="pending">Pending</option>
                            <option value="confirmed">Confirmed</option>
                            <option value="completed">Completed</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="patient_description">Patient Description</label>
                        <textarea id="patient_description" name="patient_description" placeholder="Enter patient's symptoms or concerns"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="doctor_prescription">Doctor's Prescription</label>
                        <textarea id="doctor_prescription" name="doctor_prescription" placeholder="Enter doctor's prescription notes"></textarea>
                        <div class="hint">This can be filled after the appointment</div>
                    </div>

                    <div class="form-group">
                        <input type="submit" value="Create Appointment">
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>