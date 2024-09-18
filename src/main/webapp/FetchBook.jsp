<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book Form</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #e0e0e0, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 20px 30px rgba(0, 0, 0, 0.2), 0 10px 15px rgba(0, 0, 0, 0.15);
            width: 300px;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 40px rgba(0, 0, 0, 0.3), 0 20px 25px rgba(0, 0, 0, 0.22);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: 500;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
            background: #f9f9f9;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #667eea;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            outline: none;
        }
        .add-btn {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            font-weight: 600;
            transition: background 0.3s, transform 0.2s;
        }
        .add-btn:hover {
            background: linear-gradient(to right, #764ba2, #667eea);
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Add Book</h2>
        <form action="FetchBookServlet" method="POST">
            <div class="form-group">
                <label for="bookid">Book ID</label>
                <input type="text" id="bookid" name="bookid" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            <button type="submit" class="add-btn">Add Book</button>
        </form>
    </div>

</body>
</html>
