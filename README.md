Book Organizer

Book Organizer is a Java-based application designed to help users manage their book collection effectively. This system allows users to add, view, update, and delete book records, making book organization easier and more efficient.

Features

Add new books to the collection with details such as title, author, ISBN, and price.
Edit and update book information.
Delete books from the collection.
View a list of all books with details like title, author, price, etc.
Inventory management to track the number of books available.
Simple and user-friendly interface.

Technologies Used

Frontend: HTML, CSS, Bootstrap (for UI design)
Backend: Java (Servlets, JSP)
Database: MySQL
IDE: Eclipse/IntelliJ IDEA
Version Control: Git & GitHub

Prerequisites

Before you can run this project, make sure you have the following installed:
Java Development Kit (JDK)
Apache Tomcat (or another web server)
MySQL Database
MySQL Connector for Java (for database connectivity)

Getting Started
Step 1: Clone the Repository
Clone the repository to your local machine using the following command:
git clone https://github.com/Nitesh-Singh347/Book_Organizer.git

Step 2: Set Up the MySQL Database
Log in to your MySQL server using your preferred method (MySQL Workbench, phpMyAdmin, or command line).

Create the database using the following command:
CREATE DATABASE bookorganizer;

Use the newly created database:
USE BookStoreDB;

Create the required tables by executing the following SQL statements:
Customers Table

CREATE TABLE customers (
    customerid INT NOT NULL AUTO_INCREMENT,
    customername VARCHAR(255) NOT NULL,
    customercontact VARCHAR(20) NOT NULL,
    totalpurchase DECIMAL(10,2) NOT NULL,
    purchasequantity INT NOT NULL,
    purchase_date DATE NOT NULL,
    PRIMARY KEY (customerid)
);
Register Table

CREATE TABLE register (
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Contact VARCHAR(20),
    Password VARCHAR(100) NOT NULL
);
inventoryrecords table 

CREATE TABLE inventoryrecords (
    id INT NOT NULL AUTO_INCREMENT,
    booktitle VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    year_of_publish INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (id)
);

Step 3: Configure the Database Connection
In the Java code, update the database connection URL, username, and password as per your MySQL configuration. The connection string should look like this:


String url = "jdbc:mysql://localhost:3306/BookStoreDB";
String user = "root";
String password = "yourpassword";

Step 4: Running the Application
Open the project in your preferred IDE (Eclipse, IntelliJ IDEA, etc.).
Set up your Apache Tomcat server in the IDE.
Build and deploy the project to the Tomcat server.
Open your web browser and access the application at http://localhost:8080/Book_Organizer.

Once the application is running, you can:

Add new books to the database by filling out the form.
View all books in the inventory.
Update or delete existing book records.
Track customer information and purchase history.

Contributing

Contributions to this project are welcome. To contribute, follow these steps:

Fork the repository.
Create a new branch:
git checkout -b feature-branch

Commit your changes:
git commit -m "Add new feature"

Push to the branch:
git push origin feature-branch

Submit a pull request to the main branch.

License
This project is licensed under the MIT License. See the LICENSE file for more information.

Contact
For any inquiries or support, please contact the project maintainer:

GitHub: Nitesh-Singh347
