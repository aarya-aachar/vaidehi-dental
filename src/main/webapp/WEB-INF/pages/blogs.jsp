<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Dental Health Blogs - Vaidehi Dental</title>
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


.blog-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 40px;
}

.blog-search {
	position: relative;
	width: 300px;
}

.blog-search input {
	width: 100%;
	padding: 12px 15px;
	padding-right: 40px;
	background-color: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 5px;
	transition: all 0.3s;
	color: #4a5568;
}

.blog-search input:focus {
	outline: none;
	border-color: #4299e1;
	box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
}

.blog-search button {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	color: #a0aec0;
	cursor: pointer;
}

.blog-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
	gap: 30px;
	margin-bottom: 40px;
}

.blog-categories {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 30px;
}

.blog-category-pill {
	padding: 8px 15px;
	background-color: #f8fafc;
	border-radius: 20px;
	color: #4a5568;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s;
}

.blog-category-pill:hover, .blog-category-pill.active {
	background-color: #4299e1;
	color: white;
}

.blog-pagination {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 40px;
}

.page-link {
	width: 40px;
	height: 40px;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #f8fafc;
	border: 1px solid #e2e8f0;
	border-radius: 5px;
	color: #4a5568;
	text-decoration: none;
	transition: all 0.3s;
}

.page-link:hover {
	background-color: #e2e8f0;
}

.page-link.active {
	background-color: #4299e1;
	color: white;
	border-color: #4299e1;
}

.featured-blog {
	display: flex;
	background-color: white;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	margin-bottom: 40px;
}

.featured-blog-image {
	flex: 1;
	min-height: 300px;
	background-size: cover;
	background-position: center;
}

.featured-blog-content {
	flex: 1;
	padding: 30px;
}

.featured-blog-tag {
	display: inline-block;
	background-color: #ebf8ff;
	color: #4299e1;
	padding: 5px 10px;
	border-radius: 20px;
	font-size: 0.8rem;
	margin-bottom: 15px;
}

.featured-blog-title {
	font-size: 1.8rem;
	color: #2d3748;
	margin-bottom: 15px;
	line-height: 1.3;
}

.featured-blog-excerpt {
	color: #718096;
	margin-bottom: 20px;
	line-height: 1.6;
}

.blog-meta-info {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.blog-author-img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.blog-author-name {
	font-weight: 500;
	color: #2d3748;
}

.blog-date {
	color: #a0aec0;
	font-size: 0.9rem;
	margin-left: 15px;
}

@media ( max-width : 992px) {
	.featured-blog {
		flex-direction: column;
	}
	.featured-blog-image {
		height: 200px;
	}
}

@media ( max-width : 768px) {
	.blog-header {
		flex-direction: column;
		gap: 20px;
	}
	.blog-search {
		width: 100%;
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
						<h2>Dental Health Blog</h2>
						<p>Stay informed with the latest dental care tips and insights
							from our experts</p>
					</div>
				</div>
			</section>

			<!-- Blog Content -->
			<section class="features-section">
				<div class="container">
					<!-- Blog Header with Search -->
					<div class="blog-header">
						<div>
							<h2 style="color: #2d3748; margin-bottom: 15px">Latest
								Articles</h2>
							<p style="color: #718096">Explore our collection of dental
								health resources</p>
						</div>
						<div class="blog-search">
							<input type="text" placeholder="Search articles..." />
							<button>
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>

					<!-- Featured Blog -->
					<div class="featured-blog">
						<div class="featured-blog-image"
							style="background-image: url('https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-4.0.3&amp;ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&amp;auto=format&amp;fit=crop&amp;w=1170&amp;q=80');"></div>
						<div class="featured-blog-content">
							<span class="featured-blog-tag">Category 1</span>
							<h2 class="featured-blog-title">10 Tips for Maintaining Good
								Oral Health</h2>

							<p class="featured-blog-excerpt">Learn the most effective
								ways to keep your teeth and gums healthy with these expert tips
								from our dental professionals. Regular checkups, proper brushing
								techniques, and more...</p>
							<a href="#" class="btn">Read More</a>
						</div>
					</div>

					<!-- Blog Grid -->
					<div class="blog-grid">
						<!-- Blog Card 1 -->
						<div class="blog-card">
							<img
								src="https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
								alt="Blog Image" class="blog-image" />
							<div class="blog-content">
								<span class="blog-category">Oral Hygiene</span>
								<h3 class="blog-title">The Connection Between Oral Health
									and Overall Wellness</h3>
								<p class="blog-excerpt">Research reveals strong links
									between oral health and systemic conditions. Learn how taking
									care of your mouth can benefit your overall health and prevent
									serious diseases...</p>
								<div class="blog-meta">
									<span> Michael Patel</span> <span>Sep 25, 2023</span>
								</div>
							</div>
						</div>

						<!-- Blog Card 2 -->
						<div class="blog-card">
							<img
								src="https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
								alt="Blog Image" class="blog-image" />
							<div class="blog-content">
								<span class="blog-category">Oral Hygiene</span>
								<h3 class="blog-title">The Connection Between Oral Health
									and Overall Wellness</h3>
								<p class="blog-excerpt">Research reveals strong links
									between oral health and systemic conditions. Learn how taking
									care of your mouth can benefit your overall health and prevent
									serious diseases...</p>
								<div class="blog-meta">
									<span> Michael Patel</span> <span>Sep 25, 2023</span>
								</div>
							</div>
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
