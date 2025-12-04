--Q1. Explain the fundamental differences between DDL, DML, and DQL commands in SQL.
-- Provide one example for each type of command.

--A1. DDL EXAMPLE
CREATE TABLE Employees (
   EmployeeID INT PRIMARY KEY,
   FirstName VARCHAR(50),
   LastName VARCHAR(50)
);

-- DML EXAMPLE
INSERT INTO Employees (EmployeeID,FirstName, LastName)
VALUES ('1','John', 'Doe');

--DQL EXAMPLE
GRANT SELECT, UPDATE ON Employees TO FirstName;

-- Q3.

USE users;
SELECT * FROM employee2
ORDER BY employee_id
LIMIT 10 OFFSET 20;


-- Q6. Categories Table

CREATE TABLE Categories(
                CategoryID INT PRIMARY KEY, 
                CategoryName VARCHAR(50) NOT NULL UNIQUE);
INSERT INTO categories(CategoryID,CategoryName)
          VALUES(1,'Electronics'),
		         (2,'Books'),
				 (3,'Home Goods'),
				 (4,'Apparel');

SELECT * FROM Categories;


--Products Table
CREATE TABLE Products(
                 ProductID INT PRIMARY KEY, 
                 ProductName VARCHAR(100) NOT NULL UNIQUE, 
                 CategoryID INT, 
				 FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
                 Price DECIMAL(10,2) NOT NULL,
                 StockQuantity INT
);

INSERT INTO Products(ProductID,ProductName,CategoryID,Price,StockQuantity)
          VALUES(101,'Laptop Pro',1,1200.00,50),
		         (102,'Handbook',2,45.50,200),
				 (103,'Smart Speaker',1,99.99,150),
				 (104,'Coffee Maker',3,75.00,80),
				 (105,'Novel:The Great SQL',3,25.00,120),
				 (106,'Wireless Earbuds ',1,150.00,100),
				 (107,'Blender X',3,120.00,60),
				 (108,'T-Shirt Casual',4,20.00,300);

SELECT * FROM Products;

--Customers Table
CREATE TABLE Customers(
            CustomerID INT PRIMARY KEY, 
            CustomerName VARCHAR(100) NOT NULL, 
            Email VARCHAR(100) UNIQUE,
            JoinDate DATE
);

INSERT INTO Customers(CustomerID,CustomerName,Email,JoinDate)
          VALUES(1,'Alice Wonderland','alice@example.com','2023-01-10'),
                (2,'Bob The Builder','bob@example.com','2022-11-25'),
                (3,'Charlie Chaplin','charlie@example.com','2023-03-01'),
				(4,'Diana Prince','diana@example.com','2021-04-26');

SELECT * FROM Customers;
	
-- Orders 
CREATE TABLE Orders(
             OrderID INT PRIMARY KEY,
             CustomerID INT,
			 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
             OrderDate DATE NOT NULL,
             TotalAmount DECIMAL(10,2)
);

INSERT INTO Orders(OrderID,CustomerID,OrderDate,TotalAmount)
          VALUES(1001,1,'2023-04-26',1245.50),
                 (1002,2,'2023-10-12',99.99),
				 (1003,1,'2023-07-01',145.00),
				 (1004,3,'2023-01-14',150.00),
				 (1005,2,'2023-09-24',120.00),
				 (1006,1,'2023-06-19',20.00);

SELECT * FROM Orders;


--Q7. 
SELECT
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberofOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY c.CustomerName;


--Q8. 
SELECT
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName;


--Q9
WITH RankedProducts AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (PARTITION BY c.CategoryName ORDER BY p.Price DESC) AS rn
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
)
SELECT CategoryName, ProductName, Price
FROM RankedProducts
WHERE rn <= 2;


--Q10

		  