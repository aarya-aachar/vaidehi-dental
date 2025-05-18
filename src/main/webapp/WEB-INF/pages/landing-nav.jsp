<!DOCTYPE html>

<html>




<div data-landing-component="navbar">
	<nav class="navbar">
		<div class="container navbar-container">
			<div class="navbar-logo">
				<a href="/dentalClinic">
					<h2>Vaidehi Dental</h2>
				</a>
			</div>
			<div class="navbar-menu">
				<ul class="navbar-links">
					<li><a href="/dentalClinic">Home</a></li>
					<li><a href="/dentalClinic/about">About Us</a></li>

					<!-- <li><a href="/dentalClinic/blogs">Blog</a></li> -->
					<li><a href="/dentalClinic/contact">Contact</a></li>
				</ul>


				<div class="navbar-buttons">
					<%
					String userRole = null;
					Cookie[] cookies = request.getCookies();
					if (cookies != null) {
						for (Cookie cookie : cookies) {
							if ("user_role".equals(cookie.getName())) {
						userRole = cookie.getValue();
						break;
							}
						}
					}

					if ("patient".equals(userRole)) {
					%>
					<a href="<%=request.getContextPath()%>/patient" class="btn">Dashboard</a>
					<%
					} else if ("admin".equals(userRole)) {
					%>
					<a href="<%=request.getContextPath()%>/admin/dashboard" class="btn">Dashboard</a>
					<%
					} else {
					// Default or no role case
					%>
					<a href="<%=request.getContextPath()%>/login" class="btn">Login</a>
					<%
					}
					%>
				</div>
			</div>
			<div class="navbar-toggle">
				<i class="fas fa-bars"></i>
			</div>
		</div>
	</nav>
</div>
</html>