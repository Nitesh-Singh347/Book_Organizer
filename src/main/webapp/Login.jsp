<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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
        .signup-link {
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }
        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Login</h2>
        </div>
        <form id="loginForm" action="LoginServlet" method="post" onsubmit="return validateLoginForm()">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
                <div id="usernameError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <div id="passwordError" class="invalid-feedback"></div>
            </div>
            <div class="form-group">
                <input type="submit" value="Login">
            </div>
        </form>

        <div class="signup-link">
            <p>Don't have an account? <a href="Register.jsp">Sign up</a></p>
        </div>
    </div>

   
</body>
</html>
