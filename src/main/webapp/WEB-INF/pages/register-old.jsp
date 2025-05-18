<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Registration - Vote sphere</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/fonts.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/global.css" />
    <style>
        body {
            /* background-color: #f5f7fa; */
            background-image: url("${pageContext.request.contextPath}/resources/images/register-bg.png");
            background-size: contain;
            background-position: center;
            background-repeat: no-repeat;
            color: #4a5568;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .container {
            width: 100%;
            height: 100%;
            overflow-y: auto;
            max-width: 600px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.18);
            padding: 60px 40px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
        }

        h1 {
            color: #3d8b99;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #718096;
            font-size: 1rem;
            margin-bottom: 30px;
            margin-top: 10px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            color: #3d8b99;
            font-size: 1.2rem;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        label {
            display: block;
            /* margin-bottom: 5px; */
            /* font-weight: 500; */
            color: #4a5568;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"],
        textarea,
        select {
            width: 100%;
            padding: 15px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            color: #4a5568;
            transition: all 0.3s;
            background-color: #fff;
            resize: none;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="tel"]:focus,
        textarea:focus,
        select:focus {
            border-color: #3d8b99;
            outline: none;
            box-shadow: 0 0 0 3px rgba(61, 139, 153, 0.1);
        }

        .required::after {
            content: " *";
            color: #e53e3e;
        }

        .password-container {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #a0aec0;
        }

        .file-input-container {
            margin-top: 5px;
        }

        .file-input-label {
            display: inline-block;
            padding: 12px 20px;
            background-color: #3d8b99;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 0.9rem;
        }

        .file-input-label:hover {
            background-color: #2d6b79;
        }

        input[type="file"] {
            display: none;
        }

        .file-name {
            display: block;
            margin-top: 8px;
            font-size: 0.9rem;
            color: #718096;
        }

        .radio-group {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-top: 5px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .radio-label {
            font-size: 0.9rem;
            color: #4a5568;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            /* margin-top: 5px; */
            user-select: none;
        }

        input[type="checkbox"] {
            margin-right: 10px;
            /* margin-top: 3px; */
            width: 18px;
            height: 18px;
            accent-color: #3d8b99;
        }

        .checkbox-label {
            font-size: 0.85rem;
            color: #4a5568;
            display: block;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #3d8b99;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 550;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 30px;
        }

        .btn:hover {
            background-color: #2d6b79;
        }

        .login-link {
            margin-top: 25px;
            text-align: center;
            font-size: 1rem;
            color: #718096;
        }

        .login-link a {
            color: #eab308;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .eye-icon {
            width: 20px;
            height: 20px;
        }

        @media (max-width: 640px) {


            
            .container {
                padding: 30px 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .subtitle {
                font-size: 0.9rem;
            }
            
        }
    </style>
</head>

<body>
    <div class="container scrollbar-none">
        <header>
            <img src="${pageContext.request.contextPath}/resources/icons/logo-new.png" alt="logo" width="130" />
            <p class="subtitle">Register for the Online Voting System</p>
        </header>

        <form id="registrationForm" action="register" method="post" enctype="multipart/form-data">
            <!-- Personal Information -->
            <div class="form-section">
                <h2 class="section-title">Personal Information</h2>

                <div class="form-row">
                    <div class="form-group">

                        <input type="text" id="first_name" name="first_name" placeholder="First name *" required />
                    </div>
                    <div class="form-group">

                        <input type="text" id="last_name" name="last_name" placeholder="Last name *" required />
                    </div>
                </div>

                <div class="form-group">

                    <input type="email" id="email" name="email" placeholder="Email *" required />
                </div>

                <div class="form-group">

                    <input type="text" id="voter_id_number" name="voter_id_number" placeholder="Voter ID Number *"
                        required />
                </div>

                <div class="form-group">

                    <input type="tel" id="phone" name="phone" placeholder="Phone Number *" required />
                </div>

                <div class="form-group">

                    <input type="text" id="address" name="address" placeholder="Address *" required></input>
                </div>

                <div class="form-group">
                    <label for="gender">Gender</label>
                    <div class="radio-group">
                        <div class="radio-option">
                            <input type="radio" id="gender-male" name="gender" value="male" required>
                            <label for="gender-male" class="radio-label">Male</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" id="gender-female" name="gender" value="female">
                            <label for="gender-female" class="radio-label">Female</label>
                        </div>
                        <div class="radio-option">
                            <input type="radio" id="gender-other" name="gender" value="other">
                            <label for="gender-other" class="radio-label">Other</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Account Security -->
            <div class="form-section">
                <h2 class="section-title">Account Security</h2>

                <div class="form-group">
                   
                    <div class="password-container">
                        <input type="password" id="password" name="password" placeholder="Password *" required />
                        <span class="toggle-password" onclick="togglePassword('password')">
                            <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                   
                    <div class="password-container">
                        <input type="password" id="confirm_password" name="confirm_password"
                            placeholder="Confirm Password *" required />
                        <span class="toggle-password" onclick="togglePassword('confirm_password')">
                            <svg class="eye-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Document Uploads -->
            <div class="form-section">
                <h2 class="section-title">Document Uploads</h2>

                <div class="form-row">
                    <div class="form-group">
                    
                        <div class="file-input-container">
                            <label for="voter_card_front" class="file-input-label">Upload Voter Card Front *</label>
                            <input type="file" id="voter_card_front" name="voter_card_front" accept="image/*"
                                required />
                            <span class="file-name" id="frontCardName">No file chosen</span>
                        </div>
                    </div>

                    <div class="form-group">
                     
                        <div class="file-input-container">
                            <label for="voter_card_back" class="file-input-label">Upload Voter Card Back *</label>
                            <input type="file" id="voter_card_back" name="voter_card_back" accept="image/*" required />
                            <span class="file-name" id="backCardName">No file chosen</span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                  
                    <div class="file-input-container">
                        <label for="profileImage" class="file-input-label">Passport size photo</label>
                        <input type="file" id="profileImage" name="profileImage" accept="image/*" required />
                        <span class="file-name" id="profileImageName">No file chosen</span>
                    </div>
                </div>
            </div>

            <!-- Terms and Conditions -->
            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="isTermsAndConditionsAccepted" name="isTermsAndConditionsAccepted"
                        required />
                    <label for="isTermsAndConditionsAccepted" class="checkbox-label required">I agree to the T&C and Privacy Policy</label>
                </div>
            </div>

            <!-- Hidden fields that will be handled by the backend -->

            <button type="submit" class="btn">Apply</button>

            <div class="login-link">
                Already have an account? <a href="<%=request.getContextPath()%>/login">Login</a>
            </div>
        </form>
    </div>

    <script>
        // Toggle password visibility
        function togglePassword(inputId) {
            const passwordInput = document.getElementById(inputId);
            const icon = passwordInput.nextElementSibling.querySelector("svg");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.innerHTML =
                    '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line>';
            } else {
                passwordInput.type = "password";
                icon.innerHTML =
                    '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle>';
            }
        }

        // Show file names when files are selected
        document
            .getElementById("profileImage")
            .addEventListener("change", function () {
                document.getElementById("profileImageName").textContent = this
                    .files[0]
                    ? this.files[0].name
                    : "No file chosen";
            });

        document
            .getElementById("voter_card_front")
            .addEventListener("change", function () {
                document.getElementById("frontCardName").textContent = this.files[0]
                    ? this.files[0].name
                    : "No file chosen";
            });

        document
            .getElementById("voter_card_back")
            .addEventListener("change", function () {
                document.getElementById("backCardName").textContent = this.files[0]
                    ? this.files[0].name
                    : "No file chosen";
            });
    </script>
</body>

</html>