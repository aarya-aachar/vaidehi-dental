<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <%@ page import="com.dentalClinic.model.AuthUser" %>
  <%@ page import="com.dentalClinic.model.User" %>
  <%@ page import="com.dentalClinic.service.UserService" %>
 
 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmileCare Dental Clinic | Patient Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2a9d8f;
            --primary-dark: #1d7874;
            --secondary: #e9c46a;
            --accent: #f4a261;
            --dark: #264653;
            --light: #f8f9fa;
            --danger: #e76f51;
            --success: #2a9d8f;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: var(--dark);
            color: white;
            padding: 20px 0;
            transition: all 0.3s;
            position: fixed;
            height: 100vh;
            z-index: 1000;
        }
        
        .sidebar-header {
            display: flex;
            align-items: center;
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header img {
            height: 40px;
            margin-right: 10px;
        }
        
        .sidebar-header h2 {
            font-size: 18px;
        }
        
        .sidebar-header span {
            color: var(--secondary);
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        
        .menu-item:hover, .menu-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 3px solid var(--secondary);
        }
        
        .menu-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .menu-item .badge {
            margin-left: auto;
            background-color: var(--danger);
            color: white;
            border-radius: 10px;
            padding: 2px 8px;
            font-size: 12px;
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 250px;
            transition: all 0.3s;
        }
        
        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .search-bar {
            display: flex;
            align-items: center;
            background-color: #f0f0f0;
            border-radius: 30px;
            padding: 8px 15px;
            width: 300px;
        }
        
        .search-bar input {
            border: none;
            background: transparent;
            width: 100%;
            padding: 5px 10px;
            outline: none;
            font-family: 'Poppins', sans-serif;
        }
        
        .search-bar i {
            color: #777;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
        }
        
        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }
        
        .user-info {
            margin-right: 15px;
        }
        
        .user-info h4 {
            font-size: 14px;
            margin-bottom: 2px;
        }
        
        .user-info p {
            font-size: 12px;
            color: #777;
        }
        
        .notification-icon {
            position: relative;
            margin-right: 20px;
            color: #555;
            font-size: 18px;
        }
        
        .notification-icon .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: var(--danger);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
        }
        
        /* Dashboard Content */
        .dashboard-content {
            padding: 30px;
        }
        
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .welcome-text h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .welcome-text p {
            opacity: 0.9;
        }
        
        .welcome-image img {
            height: 120px;
        }
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .stat-card .icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .stat-card:nth-child(1) .icon {
            background-color: rgba(42, 157, 143, 0.1);
            color: var(--primary);
        }
        
        .stat-card:nth-child(2) .icon {
            background-color: rgba(233, 196, 106, 0.1);
            color: var(--secondary);
        }
        
        .stat-card:nth-child(3) .icon {
            background-color: rgba(244, 162, 97, 0.1);
            color: var(--accent);
        }
        
        .stat-card:nth-child(4) .icon {
            background-color: rgba(231, 111, 81, 0.1);
            color: var(--danger);
        }
        
        .stat-card h3 {
            font-size: 24px;
            margin-bottom: 5px;
        }
        
        .stat-card p {
            color: #777;
            font-size: 14px;
        }
        
        .dashboard-section {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .section-header h3 {
            font-size: 18px;
        }
        
        .section-header a {
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
        }
        
        .section-header a i {
            margin-left: 5px;
        }
        
        /* Appointments Table */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .appointments-table th {
            text-align: left;
            padding: 12px 15px;
            background-color: #f9f9f9;
            color: #555;
            font-weight: 500;
            font-size: 14px;
        }
        
        .appointments-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .appointments-table tr:last-child td {
            border-bottom: none;
        }
        
        .appointment-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-confirmed {
            background-color: rgba(42, 157, 143, 0.1);
            color: var(--primary);
        }
        
        .status-pending {
            background-color: rgba(233, 196, 106, 0.1);
            color: var(--secondary);
        }
        
        .status-cancelled {
            background-color: rgba(231, 111, 81, 0.1);
            color: var(--danger);
        }
        
        .btn {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
        }
        
        .btn-outline {
            background-color: transparent;
            border: 1px solid #ddd;
            color: #555;
        }
        
        .btn-outline:hover {
            background-color: #f9f9f9;
        }
        
        /* Dental Health Tips */
        .tips-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .tip-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .tip-image {
            height: 150px;
            background-color: #eee;
            background-size: cover;
            background-position: center;
        }
        
        .tip-content {
            padding: 20px;
            background-color: white;
        }
        
        .tip-content h4 {
            margin-bottom: 10px;
        }
        
        .tip-content p {
            color: #777;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .tip-meta {
            display: flex;
            align-items: center;
            font-size: 12px;
            color: #999;
        }
        
        .tip-meta i {
            margin-right: 5px;
        }
        
        .tip-meta span {
            margin-right: 15px;
        }
        
        /* Responsive Styles */
        @media (max-width: 1200px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }
            
            .sidebar-header h2, .menu-item span {
                display: none;
            }
            
            .menu-item {
                justify-content: center;
                padding: 15px 0;
            }
            
            .menu-item i {
                margin-right: 0;
                font-size: 18px;
            }
            
            .main-content {
                margin-left: 80px;
            }
        }
        
        @media (max-width: 992px) {
            .welcome-banner {
                flex-direction: column;
                text-align: center;
            }
            
            .welcome-image {
                margin-top: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .top-nav {
                flex-direction: column;
                align-items: flex-start;
                padding: 15px;
            }
            
            .search-bar {
                width: 100%;
                margin-bottom: 15px;
            }
            
            .user-profile {
                width: 100%;
                justify-content: space-between;
            }
            
            .dashboard-content {
                padding: 15px;
            }
            
            .appointments-table {
                display: block;
                overflow-x: auto;
            }
        }
        
        @media (max-width: 576px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                width: 250px;
                z-index: 1000;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: block;
                font-size: 20px;
                margin-right: 15px;
                cursor: pointer;
            }
            
            .stats-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <img src="https://via.placeholder.com/40x40" alt="SmileCare Logo">
                <h2>Smile<span>Care</span></h2>
            </div>
            
            <div class="sidebar-menu">
                <a href="#" class="menu-item active">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Appointments</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-tooth"></i>
                    <span>Dental Records</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <span>Billing</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-prescription-bottle-alt"></i>
                    <span>Prescriptions</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-bell"></i>
                    <span>Notifications</span>
                    <span class="badge">3</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-question-circle"></i>
                    <span>Help</span>
                </a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Navigation -->
            <div class="top-nav">
                <div class="menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </div>
                
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                
                <div class="user-profile">
                    <div class="notification-icon">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span>
                    </div>
                    
                    <div class="user-info">
                        <% 
                        AuthUser authUser = (AuthUser) session.getAttribute("user"); 
                        User user = UserService.getUserById(authUser.getUserId());
                        %>
                        <h4><%= user.getFullName() %></h4>
                        
                        <p>Patient</p>
                    </div>
                    
                    <%
                    String profilePic = UserService.getProfileImageById(user.getUserId());
                    System.out.println("Profile Pics  :  "+ profilePic);
                    System.out.println(request.getContextPath()+"/resources/images/"+profilePic);
                    
%>
                    
                    <img src="${pageContext.request.contextPath}/resources/images/${profilePic}" alt="User Profile">
                </div>
            </div>
            
            <!-- Dashboard Content -->
            <div class="dashboard-content">
                <!-- Welcome Banner -->
                <div class="welcome-banner">
                    <div class="welcome-text">
                        <h2>Welcome back, <%= user.getFirstName() %>!</h2>
                        <p>Your dental health is our priority. Here's what's happening with your care.</p>
                    </div>
                    <div class="welcome-image">
                        <img src="https://via.placeholder.com/120x120" alt="Welcome Image">
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3>2</h3>
                        <p>Upcoming Appointments</p>
                    </div>
                    
                    <div class="stat-card">
                        <div class="icon">
                            <i class="fas fa-tooth"></i>
                        </div>
                        <h3>5</h3>
                        <p>Completed Treatments</p>
                    </div>
                    
                    <div class="stat-card">
                        <div class="icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3>1</h3>
                        <p>Pending Requests</p>
                    </div>
                    
                    <div class="stat-card">
                        <div class="icon">
                            <i class="fas fa-comment-medical"></i>
                        </div>
                        <h3>3</h3>
                        <p>Unread Messages</p>
                    </div>
                </div>
                
                <!-- Upcoming Appointments -->
                <div class="dashboard-section">
                    <div class="section-header">
                        <h3>Upcoming Appointments</h3>
                        <a href="#">View All <i class="fas fa-chevron-right"></i></a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="appointments-table">
                            <thead>
                                <tr>
                                    <th>Date & Time</th>
                                    <th>Dentist</th>
                                    <th>Service</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <strong>May 15, 2023</strong><br>
                                        10:00 AM - 11:00 AM
                                    </td>
                                    <td>Dr. Sarah Johnson</td>
                                    <td>Dental Checkup</td>
                                    <td><span class="appointment-status status-confirmed">Confirmed</span></td>
                                    <td>
                                        <button class="btn btn-outline">Reschedule</button>
                                        <button class="btn btn-primary">View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>May 22, 2023</strong><br>
                                        2:00 PM - 3:00 PM
                                    </td>
                                    <td>Dr. Michael Chen</td>
                                    <td>Teeth Cleaning</td>
                                    <td><span class="appointment-status status-pending">Pending</span></td>
                                    <td>
                                        <button class="btn btn-outline">Cancel</button>
                                        <button class="btn btn-primary">View</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Dental Health Tips -->
                <div class="dashboard-section">
                    <div class="section-header">
                        <h3>Dental Health Tips</h3>
                        <a href="#">View All <i class="fas fa-chevron-right"></i></a>
                    </div>
                    
                    <div class="tips-container">
                        <div class="tip-card">
                            <div class="tip-image" style="background-image: url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');"></div>
                            <div class="tip-content">
                                <h4>Proper Brushing Techniques</h4>
                                <p>Learn the correct way to brush your teeth to maintain optimal oral health and prevent gum disease.</p>
                                <div class="tip-meta">
                                    <span><i class="far fa-clock"></i> 5 min read</span>
                                    <span><i class="far fa-calendar-alt"></i> May 5, 2023</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tip-card">
                            <div class="tip-image" style="background-image: url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');"></div>
                            <div class="tip-content">
                                <h4>Foods That Whiten Teeth</h4>
                                <p>Discover natural foods that can help keep your teeth white and bright between dental visits.</p>
                                <div class="tip-meta">
                                    <span><i class="far fa-clock"></i> 3 min read</span>
                                    <span><i class="far fa-calendar-alt"></i> April 28, 2023</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tip-card">
                            <div class="tip-image" style="background-image: url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');"></div>
                            <div class="tip-content">
                                <h4>Dealing With Tooth Sensitivity</h4>
                                <p>Effective strategies to manage tooth sensitivity and enjoy your favorite foods without discomfort.</p>
                                <div class="tip-meta">
                                    <span><i class="far fa-clock"></i> 4 min read</span>
                                    <span><i class="far fa-calendar-alt"></i> April 20, 2023</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Toggle sidebar on mobile
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.getElementById('sidebar');
        
        menuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
        
        // Simulate loading data
        document.addEventListener('DOMContentLoaded', function() {
            // You would typically fetch this data from your backend
            console.log('Dashboard loaded');
        });
    </script>
</body>
</html>