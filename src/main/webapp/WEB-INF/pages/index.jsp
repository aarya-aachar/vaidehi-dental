<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Vaidehi Dental - Expert Dental Care</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/landing.css" />

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Poppins", sans-serif;
}

body {
	background-color: #f9fafb;
	color: #333;
	line-height: 1.6;
}

.landing-container {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.landing-content {
	flex: 1;
	margin-top: 80px; /* To account for fixed navbar */
}

section {
	padding: 80px 0;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

.section-title {
	text-align: center;
	margin-bottom: 50px;
}

.section-title h2 {
	color: #1a365d;
	font-size: 2.2rem;
	font-weight: 700;
	margin-bottom: 15px;
}

.section-title p {
	color: #718096;
	max-width: 700px;
	margin: 0 auto;
}

.btn {
	display: inline-block;
	padding: 12px 25px;
	background-color: #4299e1;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	font-weight: 500;
	transition: all 0.3s;
	border: none;
	cursor: pointer;
}

.btn:hover {
	background-color: #3182ce;
	transform: translateY(-2px);
}

.btn-outline {
	background-color: transparent;
	border: 2px solid #4299e1;
	color: #4299e1;
}

.btn-outline:hover {
	background-color: #4299e1;
	color: white;
}

/* Hero Section Styles */
.hero-section {
	background-color: #ebf8ff;
	position: relative;
	overflow: hidden;
	padding: 120px 0 80px;
}

.hero-content {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 40px;
}

.hero-text {
	flex: 1;
}

.hero-text h1 {
	font-size: 3rem;
	font-weight: 700;
	color: #1a365d;
	margin-bottom: 20px;
	line-height: 1.2;
}

.hero-text p {
	color: #4a5568;
	margin-bottom: 30px;
	font-size: 1.1rem;
}

.hero-image {
	flex: 1;
	text-align: right;
}

.hero-image img {
	max-width: 100%;
	border-radius: 10px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.hero-buttons {
	display: flex;
	gap: 15px;
}

/* Features Section Styles */
.features-section {
	background-color: white;
}

.features-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
}

.feature-card {
	padding: 30px;
	background-color: #f9fafb;
	border-radius: 8px;
	transition: all 0.3s;
	text-align: center;
}

.feature-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.feature-icon {
	width: 70px;
	height: 70px;
	margin: 0 auto 20px;
	background-color: #ebf8ff;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.8rem;
	color: #4299e1;
}

.feature-title {
	font-size: 1.2rem;
	font-weight: 600;
	color: #2d3748;
	margin-bottom: 15px;
}

.feature-description {
	color: #718096;
}

/* About Section Styles */
.about-section {
	background-color: #f9fafb;
}

.about-content {
	display: flex;
	align-items: center;
	gap: 50px;
}

.about-image {
	flex: 1;
}

.about-image img {
	max-width: 100%;
	border-radius: 10px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.about-text {
	flex: 1;
}

.about-text h2 {
	color: #1a365d;
	font-size: 2rem;
	font-weight: 700;
	margin-bottom: 20px;
}

.about-text p {
	color: #4a5568;
	margin-bottom: 20px;
}

.about-stats {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-top: 30px;
}

.stat-item {
	text-align: center;
}

.stat-number {
	font-size: 2rem;
	font-weight: 700;
	color: #4299e1;
	margin-bottom: 5px;
}

.stat-label {
	color: #718096;
	font-size: 0.9rem;
}

/* Contact Form Styles */
.contact-form {
	background-color: white;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
	color: #2d3748;
}

.form-control {
	width: 100%;
	padding: 12px 15px;
	background-color: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 5px;
	transition: all 0.3s;
	color: #4a5568;
}

.form-control:focus {
	outline: none;
	border-color: #4299e1;
	box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
}

textarea.form-control {
	resize: vertical;
	min-height: 120px;
}

/* Blog Styles */
.blog-card {
	background-color: white;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s, box-shadow 0.3s;
}

.blog-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.blog-image {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.blog-content {
	padding: 20px;
}

.blog-category {
	display: inline-block;
	background-color: #ebf8ff;
	color: #4299e1;
	padding: 5px 10px;
	border-radius: 20px;
	font-size: 0.8rem;
	margin-bottom: 10px;
}

.blog-title {
	font-size: 1.3rem;
	font-weight: 600;
	color: #1a365d;
	margin-bottom: 10px;
}

.blog-excerpt {
	color: #718096;
	margin-bottom: 15px;
	line-height: 1.6;
}

.blog-meta {
	display: flex;
	justify-content: space-between;
	color: #a0aec0;
	font-size: 0.85rem;
}

/* Responsive Styles */
@media ( max-width : 992px) {
	.hero-content, .about-content {
		flex-direction: column;
	}
	.hero-image, .about-image {
		order: -1;
		margin-bottom: 30px;
	}
	.hero-text h1 {
		font-size: 2.5rem;
	}
	section {
		padding: 60px 0;
	}
	.footer-content {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 768px) {
	.hero-text h1 {
		font-size: 2rem;
	}
	.section-title h2 {
		font-size: 1.8rem;
	}
	.about-stats {
		grid-template-columns: repeat(2, 1fr);
	}
	.hero-buttons {
		flex-direction: column;
		gap: 10px;
	}
	.btn {
		width: 100%;
		text-align: center;
	}
	.navbar-menu {
		position: fixed;
		top: 70px;
		left: -100%;
		width: 100%;
		height: calc(100vh - 70px);
		background-color: white;
		flex-direction: column;
		align-items: center;
		justify-content: flex-start;
		padding: 40px 0;
		transition: left 0.3s ease;
		gap: 20px;
	}
	.navbar-menu.active {
		left: 0;
	}
	.navbar-links {
		flex-direction: column;
		text-align: center;
	}
	.navbar-toggle {
		display: block;
	}
	.footer-content {
		grid-template-columns: 1fr;
		gap: 30px;
	}
}

@media ( max-width : 480px) {
	.feature-card {
		padding: 20px;
	}
	.about-stats {
		grid-template-columns: 1fr;
	}
	.section-title h2 {
		font-size: 1.5rem;
	}
}

/* Navbar Styles */
.navbar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background-color: white;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	z-index: 1000;
	padding: 15px 0;
}

.navbar-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.navbar-logo a {
	text-decoration: none;
}

.navbar-logo h2 {
	color: #1a365d;
	font-weight: 700;
	margin: 0;
}

.navbar-menu {
	display: flex;
	align-items: center;
	gap: 40px;
}

.navbar-links {
	display: flex;
	list-style: none;
	gap: 30px;
	margin: 0;
	padding: 0;
}

.navbar-links a {
	text-decoration: none;
	color: #4a5568;
	font-weight: 500;
	transition: color 0.3s;
	position: relative;
}

.navbar-links a:hover, .navbar-links a.active {
	color: #4299e1;
}

.navbar-links a.active::after {
	content: "";
	position: absolute;
	bottom: -5px;
	left: 0;
	width: 100%;
	height: 2px;
	background-color: #4299e1;
}

.navbar-toggle {
	display: none;
	font-size: 1.5rem;
	color: #4a5568;
	cursor: pointer;
}

/* Footer Styles */
.footer {
	background-color: #1a365d;
	color: white;
	padding: 60px 0 20px;
}

.footer-content {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 40px;
}

.footer-section h3 {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 20px;
	position: relative;
	padding-bottom: 10px;
}

.footer-section h3::after {
	content: "";
	position: absolute;
	bottom: 0;
	left: 0;
	width: 50px;
	height: 2px;
	background-color: #4299e1;
}

.footer-section p {
	margin-bottom: 15px;
	color: #cbd5e0;
}

.contact-info p {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 10px;
}

.contact-info i {
	color: #4299e1;
}

.social-links {
	display: flex;
	gap: 15px;
	margin-top: 20px;
}

.social-links a {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 35px;
	height: 35px;
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 50%;
	color: white;
	text-decoration: none;
	transition: all 0.3s;
}

.social-links a:hover {
	background-color: #4299e1;
	transform: translateY(-3px);
}

.footer-section ul {
	list-style: none;
	padding: 0;
}

.footer-section ul li {
	margin-bottom: 10px;
}

.footer-section ul a {
	color: #cbd5e0;
	text-decoration: none;
	transition: color 0.3s;
}

.footer-section ul a:hover {
	color: #4299e1;
	padding-left: 5px;
}

.subscribe-form {
	display: flex;
	margin-top: 15px;
}

.subscribe-form input {
	flex: 1;
	padding: 10px 15px;
	border: none;
	border-radius: 5px 0 0 5px;
	outline: none;
}

.subscribe-form button {
	border-radius: 0 5px 5px 0;
	padding: 10px 15px;
}

.footer-bottom {
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid rgba(255, 255, 255, 0.1);
	text-align: center;
}

.footer-bottom p {
	color: #cbd5e0;
	font-size: 0.9rem;
}
</style>

</head>

<body>
	<div class="landing-container">
		<!-- Navbar Component -->
		<%@ include file="landing-nav.jsp"%>
		<!-- Landing Content -->
		<div class="landing-content">
			<!-- Hero Section -->
			<section class="hero-section">
				<div class="container hero-content">
					<div class="hero-text">
						<h1>Your Trusted Partner for Dental Health</h1>
						<p>At Vaidehi Dental, we provide comprehensive dental care
							with a gentle touch. Our expert team is committed to giving you
							the healthy and beautiful smile you deserve.</p>
						<div class="hero-buttons">


							<%
							String userRole_ = null;
							Cookie[] cookiess = request.getCookies();
							if (cookies != null) {
								for (Cookie cookie : cookiess) {
									if ("user_role".equals(cookie.getName())) {
								userRole_ = cookie.getValue();
								break;
									}
								}
							}

							if ("patient".equals(userRole_)) {
							%>
							<a href="<%=request.getContextPath()%>/patient/appointments/new"
								class="btn">Book an Appointment</a>
							<%
							} else if ("admin".equals(userRole_)) {
							%>
							<a href="<%=request.getContextPath()%>/admin/appointments"
								class="btn">View All Appointments</a>
							<%
							} else {
							// Default or no role case
							%>
							<a href="<%=request.getContextPath()%>/login" class="btn">Book
								an Appointment</a>
							<%
							}
							%>
						</div>
					</div>
					<div class="hero-image">
						<img
							src="https://images.unsplash.com/photo-1606811971618-4486d14f3f99?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80"
							alt="Dental Care" />
					</div>
				</div>
			</section>

			<!-- Features Section -->
			<section class="features-section">
				<div class="container">
					<div class="section-title">
						<h2>Why Choose Vaidehi Dental?</h2>
						<p>We combine advanced technology with personalized care to
							ensure you receive the best dental treatment possible.</p>
					</div>

					<div class="features-grid">
						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-tooth"></i>
							</div>
							<h3 class="feature-title">Expert Dentists</h3>
							<p class="feature-description">Our team consists of highly
								qualified and experienced dental professionals dedicated to
								providing exceptional care.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-clinic-medical"></i>
							</div>
							<h3 class="feature-title">Modern Facilities</h3>
							<p class="feature-description">We utilize the latest dental
								technology and equipment to deliver precise and comfortable
								treatments.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-smile"></i>
							</div>
							<h3 class="feature-title">Comfortable Experience</h3>
							<p class="feature-description">Patient comfort is our
								priority. We ensure a relaxing environment and pain-free
								procedures for all ages.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- Services Preview Section -->
			<section class="services-section">
				<div class="container">
					<div class="section-title">
						<h2>Our Dental Services</h2>
						<p>Comprehensive dental care for your entire family under one
							roof.</p>
					</div>

					<div class="features-grid">
						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-teeth"></i>
							</div>
							<h3 class="feature-title">General Dentistry</h3>
							<p class="feature-description">Regular check-ups, cleanings,
								and preventive care to maintain optimal oral health.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-magic"></i>
							</div>
							<h3 class="feature-title">Cosmetic Dentistry</h3>
							<p class="feature-description">Transform your smile with
								teeth whitening, veneers, and other aesthetic treatments.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-teeth-open"></i>
							</div>
							<h3 class="feature-title">Orthodontics</h3>
							<p class="feature-description">Straighten your teeth and
								correct bite issues with braces and aligners.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-child"></i>
							</div>
							<h3 class="feature-title">Pediatric Dentistry</h3>
							<p class="feature-description">Specialized dental care for
								children in a friendly, comfort-focused environment.</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-tooth"></i>
							</div>
							<h3 class="feature-title">Dental Implants</h3>
							<p class="feature-description">Permanent replacement for
								missing teeth that look, feel, and function like natural teeth.
							</p>
						</div>

						<div class="feature-card">
							<div class="feature-icon">
								<i class="fas fa-user-md"></i>
							</div>
							<h3 class="feature-title">Oral Surgery</h3>
							<p class="feature-description">Safe and effective procedures
								including extractions, wisdom teeth removal, and more.</p>
						</div>
					</div>
				</div>
			</section>

			<!-- Testimonials Section -->
			<section class="testimonials-section about-section">
				<div class="container">
					<div class="section-title">
						<h2>What Our Patients Say</h2>
						<p>We take pride in providing exceptional dental care and
							building lasting relationships with our patients.</p>
					</div>

					<div class="features-grid">
						<div class="feature-card">
							<p class="feature-description">"The entire team at Vaidehi
								Dental is amazing! They made me feel comfortable throughout my
								treatment, and the results are fantastic."</p>
							<div class="blog-meta" style="margin-top: 15px">
								<span>Sarah Johnson</span> <span>★★★★★</span>
							</div>
						</div>

						<div class="feature-card">
							<p class="feature-description">"I've been coming to Vaidehi
								Dental for years, and I wouldn't go anywhere else. Their
								attention to detail and gentle approach is unmatched."</p>
							<div class="blog-meta" style="margin-top: 15px">
								<span>Michael Chen</span> <span>★★★★★</span>
							</div>
						</div>

						<div class="feature-card">
							<p class="feature-description">"My children used to be afraid
								of the dentist, but they actually look forward to visits at
								Vaidehi Dental. The pediatric team is fantastic!"</p>
							<div class="blog-meta" style="margin-top: 15px">
								<span>Lisa Rodriguez</span> <span>★★★★★</span>
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- Call to Action -->
			<section class="cta-section"
				style="background-color: #ebf8ff; padding: 60px 0">
				<div class="container" style="text-align: center">
					<h2 style="color: #1a365d; font-size: 2rem; margin-bottom: 20px">
						Ready to Schedule Your Visit?</h2>
					<p style="color: #4a5568; max-width: 700px; margin: 0 auto 30px">
						Take the first step towards a healthier smile today. Our friendly
						team is ready to assist you!</p>
				

						<%
						

						if ("patient".equals(userRole_)) {
						%>
						<a href="<%=request.getContextPath()%>/patient/appointments/new"
							class="btn">Book an Appointment</a>
						<%
						} else if ("admin".equals(userRole_)) {
						%>
						<a href="<%=request.getContextPath()%>/admin/appointments"
							class="btn">View All Appointments</a>
						<%
						} else {
						// Default or no role case
						%>
						<a href="<%=request.getContextPath()%>/login" class="btn">Book
							an Appointment</a>
						<%
						}
						%>
					
				</div>
			</section>
		</div>

		<!-- Footer Component -->
		<%@ include file="landing-footer.jsp"%>

	</div>
</body>
</html>
