<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Login - Medical Clinic</title>
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
	max-width: 450px;
	margin: 40px auto;
	background-color: var(--card);
	border-radius: 16px;
	box-shadow: var(--shadow);
	overflow: hidden;
	display: flex;
	flex-direction: column;
	animation: fadeIn 0.5s ease-out forwards;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.header {
	background-color: var(--primary);
	color: white;
	padding: 30px 40px;
	position: relative;
	overflow: hidden;
	text-align: center;
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
	margin: 0 auto 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	position: relative;
	z-index: 2;
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
	z-index: 2;
}

.header p {
	opacity: 0.9;
	position: relative;
	z-index: 2;
}

.form-container {
	padding: 40px;
}

.form-group {
	margin-bottom: 25px;
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

input {
	width: 100%;
	padding: 14px 16px;
	border: 1px solid var(--border);
	border-radius: 8px;
	font-size: 16px;
	transition: all 0.3s;
	background-color: white;
	color: var(--text-primary);
}

input:focus {
	border-color: var(--primary);
	box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
	outline: none;
}

.required::after {
	content: " *";
	color: var(--error);
}

.btn-login {
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

.btn-login:hover {
	background-color: var(--primary-dark);
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(26, 115, 232, 0.3);
}

.btn-login:active {
	transform: translateY(0);
}

.form-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
	font-size: 14px;
}

.form-footer a {
	color: var(--primary);
	text-decoration: none;
	font-weight: 500;
	transition: all 0.2s;
}

.form-footer a:hover {
	text-decoration: underline;
	color: var(--primary-dark);
}

.forgot-password {
	text-align: right;
	margin-top: -15px;
	margin-bottom: 25px;
}

.forgot-password a {
	color: var(--primary);
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
}

.forgot-password a:hover {
	text-decoration: underline;
}

.input-error {
	color: var(--error);
	font-size: 12px;
	margin-top: 5px;
	display: none;
}

input.error {
	border-color: var(--error);
}

.divider {
	display: flex;
	align-items: center;
	margin: 30px 0;
	color: var(--text-secondary);
	font-size: 14px;
}

.divider::before, .divider::after {
	content: '';
	flex: 1;
	height: 1px;
	background-color: var(--border);
}

.divider::before {
	margin-right: 15px;
}

.divider::after {
	margin-left: 15px;
}

.social-login {
	display: flex;
	gap: 15px;
	margin-bottom: 30px;
}

.social-btn {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 12px;
	border-radius: 8px;
	border: 1px solid var(--border);
	background-color: white;
	cursor: pointer;
	transition: all 0.2s;
}

.social-btn:hover {
	background-color: var(--accent);
	border-color: var(--primary);
}

.social-icon {
	font-size: 20px;
	margin-right: 10px;
}

@media ( max-width : 768px) {
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
	.form-footer {
		flex-direction: column;
		gap: 15px;
		text-align: center;
	}
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="logo">
				<span class="logo-icon">+</span>
			</div>
			<h1>Patient Login</h1>
			<p>Access your health records and appointments</p>
		</div>

		<div class="form-container">
			<form id="loginForm" action="login" method="post">
				<div class="form-group">
					<label for="email" class="required">Email Address</label>
					<div class="input-container">
						<input type="email" id="email" name="email" required>
						<div class="input-error" id="emailError">Please enter a
							valid email address</div>
					</div>
				</div>

				<div class="form-group">
					<label for="password" class="required">Password</label>
					<div class="input-container">
						<input type="password" id="password" name="password" required>
						<div class="input-error" id="passwordError">Please enter
							your password</div>
					</div>
				</div>

				

				<div class="form-group">
					<button type="submit" class="btn-login">Log In</button>
				</div>





				<div class="form-footer">
					<span>Don't have an account?</span> <a href="register">Register
						Now</a>
				</div>
			</form>
		</div>







	</div>
	<%@ page contentType="text/html;charset=UTF-8"%>
	<%
	String error = (String) request.getAttribute("error");
	%>

	<%
	if (error != null) {
	%>
	<div id="errorBox"><%=error%></div>

	<script>
		// Hide error box after 5 seconds
		setTimeout(function() {
			document.getElementById("errorBox").style.display = "none";
		}, 5000);
	</script>
	<%
	}
	%>

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
	max-width: 300px; /* limit width */
	word-wrap: break-word; /* wrap long text */
	white-space: normal; /* ensure wrapping */
}
</style>


</body>
</html>