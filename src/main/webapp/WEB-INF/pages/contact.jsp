<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>About Us - Vaidehi Dental</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/styles/global.css" />
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
@media (max-width: 992px) {
  .hero-content,
  .about-content {
    flex-direction: column;
  }

  .hero-image,
  .about-image {
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

@media (max-width: 768px) {
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

@media (max-width: 480px) {
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

.navbar-links a:hover,
.navbar-links a.active {
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


.contact-info-card {
	background-color: white;
	border-radius: 8px;
	padding: 30px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
}

.contact-icon {
	width: 60px;
	height: 60px;
	background-color: #ebf8ff;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	color: #4299e1;
	margin-bottom: 20px;
}

.contact-details h3 {
	color: #2d3748;
	font-size: 1.2rem;
	margin-bottom: 15px;
}

.contact-details p {
	color: #718096;
	margin-bottom: 5px;
}

.map-container {
	height: 400px;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.map-container iframe {
	width: 100%;
	height: 100%;
	border: none;
}

.contact-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 30px;
}

@media ( max-width : 768px) {
	.contact-layout {
		flex-direction: column;
	}
	.map-container {
		height: 300px;
		margin-top: 30px;
	}
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
				<div class="container">
					<div class="section-title">
						<h2>Contact Us</h2>
						<p>We're here to help with any questions or concerns you may
							have</p>
					</div>
				</div>
			</section>

			<!-- Contact Information -->
			<section class="about-section">
				<div class="container">
					<div class="contact-grid">
						<div class="contact-info-card">
							<div class="contact-icon">
								<i class="fas fa-map-marker-alt"></i>
							</div>
							<div class="contact-details">
								<h3>Our Location</h3>
								<p>123 Dental Street</p>
								<p>Cityville, State 12345</p>
								<p>United States</p>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-icon">
								<i class="fas fa-phone-alt"></i>
							</div>
							<div class="contact-details">
								<h3>Phone Numbers</h3>
								<p>Main: +1 (123) 456-7890</p>
								<p>Emergency: +1 (123) 456-7899</p>
								<p>Fax: +1 (123) 456-7891</p>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-icon">
								<i class="fas fa-envelope"></i>
							</div>
							<div class="contact-details">
								<h3>Email Us</h3>
								<p>General: info@vaidehidental.com</p>
								<p>Appointments: appointments@vaidehidental.com</p>
								<p>Support: support@vaidehidental.com</p>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-icon">
								<i class="fas fa-clock"></i>
							</div>
							<div class="contact-details">
								<h3>Office Hours</h3>
								<p>Monday - Friday: 9:00 AM - 6:00 PM</p>
								<p>Saturday: 9:00 AM - 2:00 PM</p>
								<p>Sunday: Closed</p>
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- Map and Contact Form -->
			<section class="features-section">
				<div class="container">
					<div class="section-title">
						<h2>Get in Touch</h2>
						<p>Have a question or ready to schedule an appointment? Reach
							out to us!</p>
					</div>

					<div style="display: flex; gap: 30px; flex-wrap: wrap"
						class="contact-layout">
						<div style="flex: 1; min-width: 300px">
							<form class="contact-form">
								<div class="form-group">
									<label for="name">Your Name</label> <input type="text"
										id="name" class="form-control"
										placeholder="Enter your full name" required />
								</div>
								<div class="form-group">
									<label for="email">Email Address</label> <input type="email"
										id="email" class="form-control"
										placeholder="Enter your email address" required />
								</div>
								<div class="form-group">
									<label for="phone">Phone Number</label> <input type="tel"
										id="phone" class="form-control"
										placeholder="Enter your phone number" />
								</div>
								<div class="form-group">
									<label for="subject">Subject</label> <select id="subject"
										class="form-control">
										<option value="">Select a subject</option>
										<option value="appointment">Schedule Appointment</option>
										<option value="question">General Question</option>
										<option value="feedback">Feedback</option>
										<option value="other">Other</option>
									</select>
								</div>
								<div class="form-group">
									<label for="message">Your Message</label>
									<textarea id="message" class="form-control"
										placeholder="Type your message here..." required></textarea>
								</div>
								<button type="submit" class="btn" style="width: 100%">
									Send Message</button>
							</form>
						</div>

						<div style="flex: 1; min-width: 300px">
							<div class="map-container">
								<iframe
									src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d317718.69319292053!2d-0.3817765050863085!3d51.528307984912544!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47d8a00baf21de75%3A0x52963a5addd52a99!2sLondon%2C%20UK!5e0!3m2!1sen!2sus!4v1654509424469!5m2!1sen!2sus"
									></iframe>
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- FAQ Section -->
			<section class="about-section">
				<div class="container">
					<div class="section-title">
						<h2>Frequently Asked Questions</h2>
						<p>Find quick answers to common questions about our services</p>
					</div>

					<div class="features-grid" style="grid-template-columns: 1fr">
						<div class="feature-card">
							<h3 class="feature-title">How do I schedule an appointment?</h3>
							<p class="feature-description">You can schedule an
								appointment by calling our office at +1 (123) 456-7890, using
								our online booking system, or sending us an email at
								appointments@vaidehidental.com.</p>
						</div>

						<div class="feature-card">
							<h3 class="feature-title">What insurance plans do you
								accept?</h3>
							<p class="feature-description">We accept most major dental
								insurance plans. Please contact our office to verify if we
								accept your specific plan. Our team will help you understand
								your coverage and benefits.</p>
						</div>

						<div class="feature-card">
							<h3 class="feature-title">What should I do in case of a
								dental emergency?</h3>
							<p class="feature-description">For dental emergencies during
								office hours, call us immediately at +1 (123) 456-7890. For
								after-hours emergencies, call our emergency line at +1 (123)
								456-7899, and our on-call dentist will assist you.</p>
						</div>

						<div class="feature-card">
							<h3 class="feature-title">Do you offer payment plans?</h3>
							<p class="feature-description">Yes, we offer flexible payment
								plans to help make dental care affordable for all our patients.
								Please speak with our financial coordinator to discuss your
								options.</p>
						</div>
					</div>
				</div>
			</section>

			
		</div>

		<!-- Footer Component -->
		<%@ include file="landing-footer.jsp"%>
	</div>



</body>
</html>
