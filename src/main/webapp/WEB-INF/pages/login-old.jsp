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
        overflow-y: auto;
        max-width: 600px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.18);
        padding: 60px 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      header {
        text-align: center;
        margin-bottom: 10px;
      }

      h1 {
        color: #3d8b99;
        font-size: 1.5rem;
        font-weight: 600;
        /* margin-bottom: 5px; */
      }

      .subtitle {
        color: #718096;
        font-size: 1rem;
        margin-bottom: 30px;
      }

      .form-group {
        position: relative;
        display: flex;
        flex-direction: column;
        gap: 15px;
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

      .btn {
        display: block;
        width: 100%;
        padding: 12px;
        background-color: #3d8b99;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .btn:hover {
        background-color: #2d6b79;
      }

      .register-link {
        margin-top: 15px;
        text-align: center;
        font-size: 0.85rem;
        color: #718096;
      }

      .register-link a {
        color: #eab308;
        text-decoration: none;
        font-weight: 600;
      }

      .register-link a:hover {
        text-decoration: underline;
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
        <!-- <h1>Vote-sphere</h1> -->
        <img src="${pageContext.request.contextPath}/resources/icons/logo-new.png" alt="logo" width="150" />
        <p class="subtitle">Login to your account</p>
      </header>

      <form id="login" action="#" method="post">
        <div class="form-group">
          <input
            type="text"
            id="voter_id"
            name="voter_id"
            placeholder="Voter ID *"
            required
          />

          <div class="password-container">
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password *"
              required
            />
            <span class="toggle-password" onclick="togglePassword('password')">
              <svg
                class="eye-icon"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
              </svg>
            </span>
          </div>

          <button type="submit" class="btn">Login</button>
        </div>

        <div class="register-link">
          Don't have an account? <a href="<%=request.getContextPath()%>/register">Register</a>
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
    </script>
  </body>
</html>
