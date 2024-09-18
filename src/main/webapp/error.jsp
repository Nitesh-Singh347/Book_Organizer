<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error Page</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<style>
body {
    background-color: #f8f9fa;
}

.error-container {
    margin: 50px auto;
    max-width: 600px;
    padding: 20px;
    text-align: center;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.error-container h1 {
    color: #dc3545;
}

.error-container p {
    color: #343a40;
}

.btn-home {
    margin-top: 20px;
}
</style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <h1>Error</h1>
            <p><%= request.getAttribute("errorMessage") %></p>
            <a href="inventryHomePage.jsp" class="btn btn-primary btn-home">Go to Home Page</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies (jQuery and Popper.js) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
