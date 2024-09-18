<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
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
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-group input[type="text"]:focus,
        .form-group input[type="number"]:focus {
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            Add New Book
        </div>
        <form action="AddBookController" method="post">
            <div class="form-group">
                <label for="booktitle">Book Title:</label>
                <input type="text" id="booktitle" name="booktitle" required>
            </div>
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" required>
            </div>
            <div class="form-group">
                <label for="isbn">ISBN:</label>
                <input type="text" id="isbn" name="isbn" required>
            </div>
            <div class="form-group">
                <label for="year_of_publish">Year of Publish:</label>
                <input type="number" id="year_of_publish" name="year_of_publish" required>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Add Book">
            </div>
        </form>
    </div>
</body>
</html>
