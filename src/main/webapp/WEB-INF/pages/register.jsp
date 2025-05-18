<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Patient Registration - Medical Clinic</title>
	<style>
		:root {
			--primary: #1a73e8;
			--primary-dark: #0d47a1;
			--secondary: #34a853;
			--accent: #f1f8ff;
			--error: #ea4335;
			--text-primary: #202124;
			--text-secondary: #5f6368;
			--border: #dadce0;
			--background: #f8fafc;
			--card: #ffffff;
			--shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
		}

		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		}

		body {
			background-color: var(--background);
			color: var(--text-primary);
			line-height: 1.6;
			min-height: 100vh;
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			padding: 20px;
		}

		.container {
			width: 100%;
			max-width: 900px;
			margin: 40px auto;
			background-color: var(--card);
			border-radius: 16px;
			box-shadow: var(--shadow);
			overflow: hidden;
			display: flex;
			flex-direction: column;
		}

		.header {
			background-color: var(--primary);
			color: white;
			padding: 30px 40px;
			position: relative;
			overflow: hidden;
		}

		.header::before {
			content: '';
			position: absolute;
			top: -50%;
			left: -20%;
			width: 140%;
			height: 200%;
			background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%,
					rgba(255, 255, 255, 0) 70%);
			transform: rotate(15deg);
		}

		.logo {
			width: 60px;
			height: 60px;
			background-color: white;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
			margin-bottom: 15px;
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		}

		.logo-icon {
			color: var(--primary);
			font-size: 30px;
			font-weight: bold;
		}

		.header h1 {
			font-size: 28px;
			margin-bottom: 10px;
			position: relative;
		}

		.header p {
			opacity: 0.9;
			max-width: 500px;
			position: relative;
		}

		.form-container {
			padding: 40px;
		}

		.form-section {
			margin-bottom: 30px;
			padding-bottom: 25px;
			border-bottom: 1px solid var(--border);
		}

		.form-section:last-child {
			border-bottom: none;
			margin-bottom: 0;
			padding-bottom: 0;
		}

		.section-title {
			font-size: 18px;
			color: var(--primary);
			margin-bottom: 20px;
			display: flex;
			align-items: center;
		}

		.section-title::before {
			content: '';
			display: inline-block;
			width: 4px;
			height: 18px;
			background-color: var(--primary);
			margin-right: 10px;
			border-radius: 2px;
		}

		.form-row {
			display: flex;
			gap: 20px;
			margin-bottom: 20px;
		}

		.form-group {
			flex: 1;
			min-width: 0;
		}

		label {
			display: block;
			margin-bottom: 8px;
			font-weight: 500;
			color: var(--text-secondary);
			font-size: 14px;
		}

		.input-container {
			position: relative;
		}

		input,
		textarea,
		select {
			width: 100%;
			padding: 14px 16px;
			border: 1px solid var(--border);
			border-radius: 8px;
			font-size: 16px;
			transition: all 0.3s;
			background-color: white;
			color: var(--text-primary);
		}

		input:focus,
		textarea:focus,
		select:focus {
			border-color: var(--primary);
			box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
			outline: none;
		}

		.required::after {
			content: " *";
			color: var(--error);
		}

		.file-input-container {
			position: relative;
		}

		.file-input-label {
			display: flex;
			align-items: center;
			justify-content: center;
			background-color: var(--accent);
			color: var(--primary);
			padding: 14px;
			border-radius: 8px;
			border: 1px dashed var(--primary);
			cursor: pointer;
			width: 100%;
			text-align: center;
			transition: all 0.3s;
		}

		.file-input-label:hover {
			background-color: rgba(26, 115, 232, 0.1);
		}

		.file-input-label i {
			margin-right: 8px;
		}

		#profileImage {
			position: absolute;
			left: -9999px;
		}

		#fileName {
			margin-top: 8px;
			font-size: 14px;
			color: var(--text-secondary);
			text-align: center;
		}

		.preview-container {
			display: none;
			margin-top: 15px;
			text-align: center;
		}

		.image-preview {
			width: 100px;
			height: 100px;
			border-radius: 50%;
			object-fit: cover;
			border: 3px solid var(--primary);
		}

		.btn-submit {
			background-color: var(--primary);
			color: white;
			border: none;
			padding: 16px 24px;
			font-size: 16px;
			font-weight: 600;
			border-radius: 8px;
			cursor: pointer;
			width: 100%;
			transition: all 0.3s;
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.btn-submit:hover {
			background-color: var(--primary-dark);
			transform: translateY(-2px);
			box-shadow: 0 4px 12px rgba(26, 115, 232, 0.3);
		}

		.btn-submit:active {
			transform: translateY(0);
		}

		.form-footer {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-top: 20px;
			font-size: 14px;
		}

		.form-footer a {
			color: var(--primary);
			text-decoration: none;
			font-weight: 500;
		}

		.form-footer a:hover {
			text-decoration: underline;
		}

		.input-error {
			color: var(--error);
			font-size: 12px;
			margin-top: 5px;
			display: none;
		}

		input.error,
		textarea.error {
			border-color: var(--error);
		}

		.progress-container {
			display: flex;
			justify-content: space-between;
			margin-bottom: 30px;
			position: relative;
		}

		.progress-container::before {
			content: '';
			position: absolute;
			top: 15px;
			left: 0;
			width: 100%;
			height: 2px;
			background-color: var(--border);
			z-index: 1;
		}

		.progress-step {
			width: 32px;
			height: 32px;
			border-radius: 50%;
			background-color: white;
			border: 2px solid var(--border);
			display: flex;
			align-items: center;
			justify-content: center;
			font-weight: 600;
			color: var(--text-secondary);
			position: relative;
			z-index: 2;
		}

		.progress-step.active {
			background-color: var(--primary);
			border-color: var(--primary);
			color: white;
		}

		.progress-step.completed {
			background-color: var(--secondary);
			border-color: var(--secondary);
			color: white;
		}

		.progress-label {
			position: absolute;
			top: 40px;
			left: 50%;
			transform: translateX(-50%);
			font-size: 12px;
			color: var(--text-secondary);
			white-space: nowrap;
		}

		.progress-step.active .progress-label {
			color: var(--primary);
			font-weight: 500;
		}

		.progress-step.completed .progress-label {
			color: var(--secondary);
			font-weight: 500;
		}

		.progress-bar {
			position: absolute;
			top: 15px;
			left: 0;
			height: 2px;
			background-color: var(--secondary);
			z-index: 1;
			width: 0%;
			transition: width 0.3s;
		}

		@media (max-width : 768px) {
			.container {
				margin: 20px 0;
				border-radius: 12px;
			}

			.form-container {
				padding: 25px;
			}

			.header {
				padding: 25px;
			}

			.form-row {
				flex-direction: column;
				gap: 15px;
				margin-bottom: 15px;
			}

			.progress-container {
				overflow-x: auto;
				padding-bottom: 20px;
			}

			.progress-step {
				min-width: 32px;
			}
		}

		/* Animation */
		@ keyframes fadeIn {
			from {
				opacity: 0;
				transform: translateY(10px);
			}

			to {
				opacity: 1;
				transform: translateY(0);
			}

		}

		.form-section {
			animation: fadeIn 0.5s ease-out forwards;
		}

		.form-section:nth-child(2) {
			animation-delay: 0.1s;
		}

		.form-section:nth-child(3) {
			animation-delay: 0.2s;
		}
	</style>
</head>

<body>


	<%@ page contentType="text/html;charset=UTF-8" %>
		<% String error=(String) request.getAttribute("error"); %>

			<% if (error !=null) { %>
				<div id="errorBox">
					<%=error%>
				</div>

				<script>
					// Hide error box after 5 seconds
					setTimeout(function () {
						document.getElementById("errorBox").style.display = "none";
					}, 5000);
				</script>
				<% } %>

					<style>
						#errorBox {
							position: fixed;
							top: 10px;
							right: 10px;
							background-color: red;
							color: white;
							padding: 10px;
							border-radius: 5px;
							font-size: 14px;
							z-index: 1000;
							max-width: 300px;
							/* limit width */
							word-wrap: break-word;
							/* wrap long text */
							white-space: normal;
							/* ensure wrapping */
						}
					</style>




					<div class="container">
						<div class="header">
							<div class="logo">
								<span class="logo-icon">+</span>
							</div>
							<h1>Patient Registration</h1>
							<p>Join our clinic to receive personalized healthcare services
								and manage your appointments online.</p>
						</div>

						<div class="form-container">
							<!-- <div class="progress-container">
				<div class="progress-bar" id="progressBar"></div>
				<div class="progress-step active">
					<span>1</span> <span class="progress-label">Personal Info</span>
				</div>
				<div class="progress-step">
					<span>2</span> <span class="progress-label">Contact</span>
				</div>
				<div class="progress-step">
					<span>3</span> <span class="progress-label">Security</span>
				</div>
				<div class="progress-step">
					<span>4</span> <span class="progress-label">Complete</span>
				</div>
			</div> -->

							<form id="registrationForm" action="register" method="post" enctype="multipart/form-data">
								<div class="form-section" id="section1">
									<h2 class="section-title">Personal Information</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="firstName" class="required">First Name</label>
											<div class="input-container">
												<input type="text" id="first_name" name="first_name" required>
												<div class="input-error" id="firstNameError">Please enter
													your first name</div>
											</div>
										</div>
										<div class="form-group">
											<label for="lastName" class="required">Last Name</label>
											<div class="input-container">
												<input type="text" id="last_name" name="last_name" required>
												<div class="input-error" id="lastNameError">Please enter
													your last name</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="dob" class="required">Date of Birth</label>
										<div class="input-container">
											<input type="date" id="dob" name="dob" required>
											<div class="input-error" id="dobError">Please enter your
												date of birth</div>
										</div>
									</div>

									<div class="form-group">
										<label for="profileImage">Profile Image</label>
										<div class="file-input-container">
											<label for="profileImage" class="file-input-label"> <i>ð·</i>
												Choose a profile photo
											</label> <input type="file" id="profileImage" name="profile_image"
												accept="image/*">

											<div class="preview-container" id="imagePreviewContainer">
												<img src="#" alt="Profile preview" class="image-preview"
													id="imagePreview">
											</div>
										</div>
									</div>
								</div>

								<div class="form-section" id="section2">
									<h2 class="section-title">Contact Information</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="email" class="required">Email Address</label>
											<div class="input-container">
												<input type="email" id="email" name="email" required>
												<div class="input-error" id="emailError">Please enter a
													valid email address</div>
											</div>
										</div>
										<div class="form-group">
											<label for="phone" class="required">Phone Number</label>
											<div class="input-container">
												<input type="text" id="phone" name="phone" placeholder="+977-9812345678"
													required>


												<div class="input-error" id="phoneError">Please enter a
													valid phone number</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="address" class="required">Address</label>
										<div class="input-container">
											<textarea id="address" name="address" rows="3" required></textarea>
											<div class="input-error" id="addressError">Please enter
												your address</div>
										</div>
									</div>
								</div>

								<div class="form-section" id="section3">
									<h2 class="section-title">Account Security</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="password" class="required">Password</label>
											<div class="input-container">
												<input type="password" id="password" name="password" minlength="8"
													required>
												<div class="input-error" id="passwordError">Password must
													be at least 8 characters</div>
											</div>
										</div>
										<div class="form-group">
											<label for="confirmPassword" class="required">Confirm
												Password</label>
											<div class="input-container">
												<input type="password" id="confirm_password" name="confirm_password"
													minlength="8" required>
												<div class="input-error" id="confirmPasswordError">Passwords
													do not match</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<div class="input-container"
											style="display: flex; align-items: center; margin-top: 20px;">
											<input type="checkbox" id="terms" name="terms"
												style="width: auto; margin-right: 10px;" required> <label for="terms"
												class="required" style="margin-bottom: 0;">I
												agree to the Terms of Service and Privacy Policy</label>
										</div>
										<div class="input-error" id="termsError">You must agree to
											the terms</div>
									</div>
								</div>

								<div class="form-group">
									<button type="submit" class="btn-submit">Complete
										Registration</button>
								</div>

								<div class="form-footer">
									<span>Already have an account?</span> <a href="login">Sign in</a>
								</div>
							</form>
						</div>
					</div>


					<div style="display: none;">
						<div class="header">
							<div class="logo">
								<span class="logo-icon">+</span>
							</div>
							<h1>Patient Registration</h1>
							<p>Join our clinic to receive personalized healthcare services
								and manage your appointments online.</p>
						</div>

						<div class="form-container">
							<!-- <div class="progress-container">
				<div class="progress-bar" id="progressBar"></div>
				<div class="progress-step active">
					<span>1</span> <span class="progress-label">Personal Info</span>
				</div>
				<div class="progress-step">
					<span>2</span> <span class="progress-label">Contact</span>
				</div>
				<div class="progress-step">
					<span>3</span> <span class="progress-label">Security</span>
				</div>
				<div class="progress-step">
					<span>4</span> <span class="progress-label">Complete</span>
				</div>
			</div> -->

							<form id="registrationForm" action="register" method="post" enctype="multipart/form-data">
								<div class="form-section" id="section1">
									<h2 class="section-title">Personal Information</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="firstName" class="required">First Name</label>
											<div class="input-container">
												<input type="text" id="first_name" name="first_name" required>
												<div class="input-error" id="firstNameError">Please enter
													your first name</div>
											</div>
										</div>
										<div class="form-group">
											<label for="lastName" class="required">Last Name</label>
											<div class="input-container">
												<input type="text" id="last_name" name="last_name" required>
												<div class="input-error" id="lastNameError">Please enter
													your last name</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="dob" class="required">Date of Birth</label>
										<div class="input-container">
											<input type="date" id="dob" name="dob" required>
											<div class="input-error" id="dobError">Please enter your
												date of birth</div>
										</div>
									</div>

									<div class="form-group">
										<label for="profileImage">Profile Image</label>
										<div class="file-input-container">
											<label for="profileImage" class="file-input-label"> <i>ð·</i>
												Choose a profile photo
											</label> <input type="file" id="profileImage" name="profile_image"
												accept="image/*">

											<div class="preview-container" id="imagePreviewContainer">
												<img src="#" alt="Profile preview" class="image-preview"
													id="imagePreview">
											</div>
										</div>
									</div>
								</div>

								<div class="form-section" id="section2">
									<h2 class="section-title">Contact Information</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="email" class="required">Email Address</label>
											<div class="input-container">
												<input type="email" id="email" name="email" required>
												<div class="input-error" id="emailError">Please enter a
													valid email address</div>
											</div>
										</div>
										<div class="form-group">
											<label for="phone" class="required">Phone Number</label>
											<div class="input-container">
												<input type="text" id="phone" name="phone" placeholder="+977-9812345678"
													required>


												<div class="input-error" id="phoneError">Please enter a
													valid phone number</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<label for="address" class="required">Address</label>
										<div class="input-container">
											<textarea id="address" name="address" rows="3" required></textarea>
											<div class="input-error" id="addressError">Please enter
												your address</div>
										</div>
									</div>
								</div>

								<div class="form-section" id="section3">
									<h2 class="section-title">Account Security</h2>

									<div class="form-row">
										<div class="form-group">
											<label for="password" class="required">Password</label>
											<div class="input-container">
												<input type="password" id="password" name="password" minlength="8"
													required>
												<div class="input-error" id="passwordError">Password must
													be at least 8 characters</div>
											</div>
										</div>
										<div class="form-group">
											<label for="confirmPassword" class="required">Confirm
												Password</label>
											<div class="input-container">
												<input type="password" id="confirm_password" name="confirm_password"
													minlength="8" required>
												<div class="input-error" id="confirmPasswordError">Passwords
													do not match</div>
											</div>
										</div>
									</div>

									<div class="form-group">
										<div class="input-container"
											style="display: flex; align-items: center; margin-top: 20px;">
											<input type="checkbox" id="terms" name="terms"
												style="width: auto; margin-right: 10px;" required> <label for="terms"
												class="required" style="margin-bottom: 0;">I
												agree to the Terms of Service and Privacy Policy</label>
										</div>
										<div class="input-error" id="termsError">You must agree to
											the terms</div>
									</div>
								</div>

								<div class="form-group">
									<button type="submit" class="btn-submit">Complete
										Registration</button>
								</div>

								<div class="form-footer">
									<span>Already have an account?</span> <a href="login">Sign in</a>
								</div>
							</form>
						</div>
					</div>

</body>

</html>