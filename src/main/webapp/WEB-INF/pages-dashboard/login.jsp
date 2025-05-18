<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmileCare Dental Clinic | Patient Login</title>
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
        
        .login-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }
        
        .login-left {
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
        
        .login-left::after {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .login-left::before {
            content: '';
            position: absolute;
            bottom: -100px;
            left: -100px;
            width: 300px;
            height: 300px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 1;
        }
        
        .logo img {
            height: 50px;
            margin-right: 10px;
        }
        
        .logo h1 {
            color: white;
            font-size: 24px;
            font-weight: 700;
        }
        
        .logo span {
            color: var(--secondary);
        }
        
        .login-content {
            max-width: 500px;
            position: relative;
            z-index: 1;
        }
        
        .login-content h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .login-content p {
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
        
        .login-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background-color: white;
        }
        
        .login-form-container {
            max-width: 400px;
            width: 100%;
        }
        
        .login-form-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-form-header h2 {
            font-size: 28px;
            color: var(--dark);
            margin-bottom: 10px;
        }
        
        .login-form-header p {
            color: #666;
        }
        
        .login-form {
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
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input {
            margin-right: 8px;
        }
        
        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
        }
        
        .forgot-password:hover {
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
        
        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: #999;
        }
        
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }
        
        .divider-text {
            padding: 0 15px;
        }
        
        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .social-btn {
            flex: 1;
            padding: 10px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: white;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .social-btn i {
            margin-right: 8px;
            font-size: 18px;
        }
        
        .social-btn.google {
            background-color: #DB4437;
        }
        
        .social-btn.facebook {
            background-color: #4267B2;
        }
        
        .social-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .register-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
        
        .register-link a:hover {
            text-decoration: underline;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-left {
                padding: 40px;
                text-align: center;
            }
            
            .login-content {
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
            .login-left {
                padding: 30px;
            }
            
            .login-content h2 {
                font-size: 28px;
            }
            
            .feature-item {
                flex: 1 0 100%;
                max-width: 100%;
            }
            
            .social-login {
                flex-direction: column;
            }
        }
        
        @media (max-width: 576px) {
            .login-left, .login-right {
                padding: 20px;
            }
            
            .logo h1 {
                font-size: 20px;
            }
            
            .login-content h2 {
                font-size: 24px;
            }
            
            .login-form-header h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        
        <!-- Right Side with Login Form -->
        <div class="login-right">
            <div class="login-form-container">
                <div class="login-form-header">
                    <h2>Patient Login</h2>
                    <p>Sign in to access your dental care dashboard</p>
                </div>
                
                <form class="login-form" action="login" method="post">
    <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
    </div>
    
    <div class="form-group">
        <label for="password">Password</label>
        <div class="password-field">
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
            <i class="fas fa-eye toggle-password" id="togglePassword"></i>
        </div>
    </div>
    
    <div class="remember-forgot">
        <div class="remember-me">
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">Remember me</label>
        </div>
        <a href="#" class="forgot-password">Forgot password?</a>
    </div>
    
    <button type="submit" class="btn">Login</button>
    
    <div class="divider">
        <span class="divider-text">or continue with</span>
    </div>
    
    <div class="social-login">
        <a href="#" class="social-btn google">
            <i class="fab fa-google"></i>
            Google
        </a>
        <a href="#" class="social-btn facebook">
            <i class="fab fa-facebook-f"></i>
            Facebook
        </a>
    </div>
    
    <div class="register-link">
        <p>Don't have an account? <a href="<%=request.getContextPath()%>/register">Register here</a></p>
    </div>
</form>

            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');
        
        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
        
        // Form submission
        const loginForm = document.querySelector('.login-form');
        
    </script>
</body>
</html>