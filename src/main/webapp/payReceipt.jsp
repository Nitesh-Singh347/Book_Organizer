<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Receipt</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            margin: 0;
            background-color: #f4f4f4;
            font-family: 'Roboto', sans-serif;
            color: #333;
        }

        .container {
            background-color: white;
            padding: 50px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2), 0 6px 6px rgba(0, 0, 0, 0.15);
            max-width: 600px;
            width: 100%;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 28px;
            color: #222;
            font-weight: 700;
        }

        .customer-details {
            margin-bottom: 30px;
            font-size: 18px;
        }

        .customer-details label {
            font-weight: 600;
            color: #555;
        }

        .added-books table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .added-books table th, .added-books table td {
            padding: 14px;
            border: 1px solid #ddd;
            font-size: 16px;
        }

        .added-books table th {
            background-color: #f1f1f1;
            color: #667eea;
            font-weight: 700;
        }

        .total-price {
            text-align: right;
            font-size: 20px;
            font-weight: 600;
            margin-top: 20px;
        }

        button {
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

        button:hover {
            background: linear-gradient(to right, #764ba2, #667eea);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bill Receipt</h2>

        <!-- Customer details section -->
        <div class="customer-details">
            <label>Customer Name: </label>
            <span><%= session.getAttribute("customerName") %></span><br>
           
        </div>

        <!-- Added books table -->
        <div class="added-books">
            <h3>Purchased Books</h3>
            <table>
                <thead>
                    <tr>
                        <th>Book Title</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> books = (List<String[]>) session.getAttribute("books");
                        double totalPrice = 0;
                        int totalbook=0;
                        if (books != null) {
                            for (String[] book : books) {
                                String bookTitle = book[0];
                                String price = book[4];
                                int quantity = Integer.parseInt(book[9]);
                                double bookPrice = Double.parseDouble(price) * quantity;
                                totalPrice += bookPrice;
                                totalbook+=quantity;
                                
                    %>
                    <tr>
                        <td><%= bookTitle %></td>
                        <td>$<%= price %></td>
                        <td><%= quantity %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="3" style="text-align:center;">No books added.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Total price -->
        <div class="total-price">
            Total: $<%= String.format("%.2f", totalPrice) %>
        </div>

        <!-- Save Bill button -->
        <form action="SaveReceiptServlet" method="post">
            <button type="submit">Save Bill</button>
        </form>
    </div>
</body>
</html>
