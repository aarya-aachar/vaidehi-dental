<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmileCare Dental Clinic | Patient Registration</title>
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
            display: flex;
            min-height: 100vh;
        }
        
        .register-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }
        
        .register-left {
            flex: 1;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80') no-repeat center center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 0 60px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .register-left::after {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .register-left::before {
            content: '';
            position: absolute;
            bottom: -100px;
            left: -100px;
            width: 300px;
            height: 300px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
      
        
       
        
       
        
      
        
        .register-content {
            max-width: 500px;
            position: relative;
            z-index: 1;
        }
        
        .register-content h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .register-content p {
            font-size: 16px;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .features {
            margin-top: 40px;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .feature-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .feature-text h4 {
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .feature-text p {
            font-size: 14px;
            margin: 0;
            opacity: 0.8;
        }
        
        .register-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background-color: white;
            overflow-y: auto;
        }
        
        .register-form-container {
            max-width: 500px;
            width: 100%;
        }
        
        .register-form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .register-form-header h2 {
            font-size: 28px;
            color: var(--dark);
            margin-bottom: 10px;
        }
        
        .register-form-header p {
            color: #666;
        }
        
        .register-form {
            background-color: white;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        
     
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(42, 157, 143, 0.2);
        }
        
        .password-field {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            cursor: pointer;
        }
        
        .name-fields {
            display: flex;
            gap: 15px;
        }
        
        .name-fields .form-group {
            flex: 1;
        }
        
        .profile-image-upload {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .profile-image-preview {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #f0f0f0;
            margin-right: 20px;
            overflow: hidden;
            position: relative;
            border: 2px solid #ddd;
        }
        
        .profile-image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-image-preview .default-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #999;
            font-size: 30px;
        }
        
        .upload-btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .upload-btn:hover {
            background-color: var(--primary-dark);
        }
        
        .file-input {
            display: none;
        }
        
        .terms-conditions {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .terms-conditions input {
            margin-right: 10px;
            margin-top: 3px;
        }
        
        .terms-conditions label {
            font-size: 14px;
            color: #666;
        }
        
        .terms-conditions a {
            color: var(--primary);
            text-decoration: none;
        }
        
        .terms-conditions a:hover {
            text-decoration: underline;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s;
            width: 100%;
        }
        
        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            .register-container {
                flex-direction: column;
            }
            
            .register-left {
                padding:0px  40px;
                text-align: center;
            }
            
            .register-content {
                max-width: 100%;
            }
            
            .features {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }
            
            .feature-item {
                flex: 1 0 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }
        
        @media (max-width: 768px) {
            .register-left {
                padding: 30px;
            }
            
            .register-content h2 {
                font-size: 28px;
            }
            
            .name-fields {
                flex-direction: column;
                gap: 0;
            }
            
            .feature-item {
                flex: 1 0 100%;
                max-width: 100%;
            }
        }
        
        @media (max-width: 576px) {
            .register-left, .register-right {
                padding: 20px;
            }
            
           
            
            .register-content h2 {
                font-size: 24px;
            }
            
            .register-form-header h2 {
                font-size: 24px;
            }
            
            .profile-image-upload {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .profile-image-preview {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
      
        
        <!-- Right Side with Registration Form -->
        <div class="register-right">
            <div class="register-form-container">
                <div class="register-form-header">
                    <h2>Create Your Account</h2>
                    <p>Fill in your details to get started</p>
                </div>
                
                <form class="register-form" action="register" method="post" enctype="multipart/form-data">
                    <div class="profile-image-upload ">
                        <div class="profile-image-preview" id="imagePreview">
                            <div class="default-icon">
                                <i class="fas fa-user"></i>
                            </div>
                        </div>
                        <div >
                            <button type="button" class="upload-btn" id="uploadBtn">Upload Photo</button>
                            <input type="file" id="profileImage" name="profile_image" class="file-input" accept="image/*">
                        </div>
                    </div>
                    
                    <div class="name-fields">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="first_name" class="form-control" placeholder="Enter your first name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="last_name" class="form-control" placeholder="Enter your last name" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your phone number">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" class="form-control" placeholder="Enter your address">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="password-field">
                            <input type="password" id="password" name="password" class="form-control" placeholder="Create a password" required>
                            <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <div class="password-field">
                            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm your password" required>
                            <i class="fas fa-eye toggle-password" id="toggleConfirmPassword"></i>
                        </div>
                    </div>
                    
                    <div class="terms-conditions">
                        <input type="checkbox" id="terms" required>
                        <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                    </div>
                    
                    <button type="submit" class="btn">Create Account</button>
                    
                    <div class="login-link">
                        <p>Already have an account? <a href="<%=request.getContextPath()%>/login">Login here</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        
        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
        
        toggleConfirmPassword.addEventListener('click', function() {
            const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPassword.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
        
        // Profile image upload preview
        const uploadBtn = document.getElementById('uploadBtn');
        const profileImage = document.getElementById('profileImage');
        const imagePreview = document.getElementById('imagePreview');
        
        uploadBtn.addEventListener('click', function() {
            profileImage.click();
        });
        
        profileImage.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                
                reader.addEventListener('load', function() {
                    imagePreview.innerHTML = '';
                    const img = document.createElement('img');
                    img.src = this.result;
                    imagePreview.appendChild(img);
                });
                
                reader.readAsDataURL(file);
            }
        });
        
        // Form validation
        const registerForm = document.querySelector('.register-form');
        
        registerForm.addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            const termsChecked = document.getElementById('terms').checked;
            if (!termsChecked) {
                e.preventDefault();
                alert('You must agree to the terms and conditions');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>