<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Registration</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: white;
            font-family: 'Roboto', sans-serif;
            color: #333;
        }
        .container {
            background-color: white;
            padding: 50px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2), 0 6px 6px rgba(0, 0, 0, 0.15);
            max-width: 400px;
            width: 100%;
            transform: translateZ(0);
            transition: transform 0.2s ease-in-out;
        }
        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3), 0 10px 10px rgba(0, 0, 0, 0.22);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #222;
            font-weight: 600;
            font-size: 24px;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 15px;
            margin: 15px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-group input[type="text"]:focus,
        .form-group input[type="email"]:focus,
        .form-group input[type="password"]:focus {
            border-color: #667eea;
            outline: none;
        }
        .form-group input[type="submit"] {
            width: 100%;
            padding: 15px;
            margin: 20px 0;
            border: none;
            border-radius: 8px;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        .form-group input[type="submit"]:hover {
            background: linear-gradient(to right, #764ba2, #667eea);
        }
        .invalid-feedback {
            color: red;
            margin-top: -10px;
            font-size: 14px;
        }
        .login-link {
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Registration</h2>
        </div>
        <form id="registrationForm" action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <div id="usernameError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <div id="emailError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <label for="contact">Contact:</label>
                <input type="text" id="contact" name="contact" required>
                <div id="contactError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <div id="passwordError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <input type="submit" value="Register">
            </div>
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="Login.jsp">Login</a></p>
        </div>
    </div>

    <script>
        function validateForm() {
            var username = document.getElementById("username").value.trim();
            var email = document.getElementById("email").value.trim();
            var contact = document.getElementById("contact").value.trim();
            var password = document.getElementById("password").value.trim();

            var isValid = true;

            // Reset previous error messages
            document.getElementById("usernameError").innerHTML = "";
            document.getElementById("emailError").innerHTML = "";
            document.getElementById("contactError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";

            // Validate username
            if (username.length < 3) {
                document.getElementById("usernameError").innerHTML = "Username must be at least 3 characters long";
                isValid = false;
            }

            // Validate email
            if (!validateEmail(email)) {
                document.getElementById("emailError").innerHTML = "Please enter a valid email address";
                isValid = false;
            }

            // Validate contact number
            if (!validateContact(contact)) {
                document.getElementById("contactError").innerHTML = "Please enter a valid 10-digit contact number";
                isValid = false;
            }

            // Validate password
            if (password.length < 6) {
                document.getElementById("passwordError").innerHTML = "Password must be at least 6 characters long";
                isValid = false;
            }

            return isValid;
        }

        function validateEmail(email) {
            // Regular expression for basic email validation
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }

        function validateContact(contact) {
            // Regular expression for 10-digit numeric validation
            var re = /^\d{10}$/;
            return re.test(contact);
        }
    </script>
</body>
</html>
