CREATE DATABASE TechShop;
USE TechShop;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak Ave'),
    (3, 'Bob', 'Johnson', 'bob.johnson@example.com', '5551234567', '789 Pine St'),
    (4, 'Alice', 'Williams', 'alice.williams@example.com', '7778889999', '321 Elm St'),
    (5, 'Charlie', 'Brown', 'charlie.brown@example.com', '4445556666', '654 Birch Ave'),
    (6, 'Eva', 'Miller', 'eva.miller@example.com', '111222333', '987 Cedar St'),
    (7, 'David', 'Jones', 'david.jones@example.com', '9990001111', '234 Oak St'),
    (8, 'Grace', 'Taylor', 'grace.taylor@example.com', '6667778888', '876 Maple Ave'),
    (9, 'Frank', 'White', 'frank.white@example.com', '2223334444', '543 Pine St'),
    (10, 'Olivia', 'Davis', 'olivia.davis@example.com', '3334445555', '765 Birch Ave');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);



INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES
    (1, 'Widget A', 'High-quality widget', 19.99),
    (2, 'Gadget B', 'Feature-rich gadget', 29.99),
    (3, 'Tool X', 'Versatile tool for various tasks', 39.99),
    (4, 'Appliance Y', 'Efficient home appliance', 49.99),
    (5, 'Accessory Z', 'Useful accessory for everyday use', 9.99),
    (6, 'Tech Gizmo', 'Cutting-edge technology gizmo', 79.99),
    (7, 'Outdoor Gear', 'Durable outdoor gear for adventures', 59.99),
    (8, 'Home Decor', 'Stylish home decor item', 14.99),
    (9, 'Kitchen Utensil', 'Essential kitchen utensil', 8.99),
    (10, 'Fitness Equipment', 'Effective fitness equipment', 99.99);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 1, '2023-01-01', 39.98),
    (2, 2, '2023-02-01', 59.98),
    (3, 3, '2023-03-01', 79.97),
    (4, 4, '2023-04-01', 99.96),
    (5, 5, '2023-05-01', 119.95),
    (6, 6, '2023-06-01', 139.94),
    (7, 7, '2023-07-01', 159.93),
    (8, 8, '2023-08-01', 179.92),
    (9, 9, '2023-09-01', 199.91),
    (10, 10, '2023-10-01', 219.90);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
    (1, 1, 1, 2),
    (2, 1, 2, 1),
    (3, 2, 3, 3),
    (4, 2, 4, 1),
    (5, 3, 5, 2),
    (6, 3, 6, 1),
    (7, 4, 7, 3),
    (8, 4, 8, 1),
    (9, 5, 9, 2),
    (10, 5, 10, 1);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES
    (1, 1, 100, '2023-01-01 12:00:00'),
    (2, 2, 50, '2023-02-01 10:30:00'),
    (3, 3, 75, '2023-03-01 15:45:00'),
    (4, 4, 30, '2023-04-01 08:20:00'),
    (5, 5, 60, '2023-05-01 14:10:00'),
    (6, 6, 25, '2023-06-01 11:55:00'),
    (7, 7, 40, '2023-07-01 09:30:00'),
    (8, 8, 90, '2023-08-01 13:25:00'),
    (9, 9, 55, '2023-09-01 16:05:00'),
    (10, 10, 20, '2023-10-01 07:40:00');

--------------------------------------------------------------
--1
SELECT FirstName, LastName, Email
FROM Customers;

---------------------------------------------------------------
--2
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

---------------------------------------------------------------
--3
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address)
VALUES (11, 'NewFirstName', 'NewLastName', 'new.email@example.com', 'NewAddress');

-----------------------------------------------------------------
--4
ALTER TABLE Products
ADD Category VARCHAR(50);

UPDATE Products
SET Category = CAST(Description AS VARCHAR(50));

ALTER TABLE Products
DROP COLUMN Description;


UPDATE Products
SET Price = Price * 1.10
select ProductName, Price from Products;

select * from products;
--------------------------------------------------------------------------
--5
DECLARE @OrderIDToDelete INT = 1;

DELETE FROM OrderDetails WHERE OrderID = @OrderIDToDelete;
DELETE FROM Orders WHERE OrderID = @OrderIDToDelete;

---------------------------------------------------------------------------
--6

DECLARE @CustomerID INT = 1;  -- Replace with the actual customer ID
DECLARE @OrderID INT = 11;  -- Replace with the actual unique order ID
DECLARE @OrderDate DATE = '2023-11-28';  -- Replace with the actual order date
SET @OrderID = (SELECT MAX(OrderID) + 1 FROM Orders);

----------------------------------------------------------------------------------
--7
DECLARE @CustomerIDToUpdate INT = 4;

UPDATE Customers
SET Email = 'new.email@example.com', Address = 'New Address'
WHERE CustomerID = @CustomerIDToUpdate;

DECLARE @OrderID INT = 1;

-- Insert the order
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES (@OrderID, @CustomerID, @OrderDate);



--------------------------------------------------------------------

--8
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Quantity * Products.Price)
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
);

------------------------------------------------------------------------
--9
DECLARE @CustomerIDToDelete INT = 5;

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerIDToDelete);
DELETE FROM Orders WHERE CustomerID = @CustomerIDToDelete;

---------------------------------------------------------------------
--10
INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES (11, 'NewGadget', 'Cutting-edge electronic gadget', 49.99);

------------------------------------------------------------------------
--11
-- Add a new column 'Status' to the "Orders" table with a default value of 'Pending'.
ALTER TABLE Orders
ADD Status NVARCHAR(50) DEFAULT 'Pending'; -- Adjust the size of NVARCHAR based on your needs

UPDATE Orders
SET Status = 'Pending'
WHERE Status IS NULL;

-- Update the status of a specific order in the "Orders" table.
-- Allow users to input the order ID and the new status.
DECLARE @OrderIDToUpdate INT = 2;  -- Replace with the actual order ID
DECLARE @NewStatus NVARCHAR(50) = 'Shipped';  -- Replace with the new status

UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @OrderIDToUpdate;

select * from Orders;
select * from OrderDetails;


------------------------------------------------------------------------------------
--12
-- Add a new column 'NumOrders' to the "Customers" table.
ALTER TABLE Customers
ADD NumOrders INT;
-- Update the number of orders placed by each customer in the "Customers" table.
UPDATE Customers
SET NumOrders = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);



--aggregate function queries ...
-----------------------------------------------------
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;
-----------------------------------------------------
SELECT COUNT(*) AS TotalProducts
FROM Products;
-----------------------------------------------------
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;
-----------------------------------------------------
DECLARE @CategoryName NVARCHAR(50) = 'Electronics';

SELECT AVG(Quantity) AS AverageQuantity
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = @CategoryName;

Select * from Products;

-------------------------------------------------------
DECLARE @CustomerID INT = 2;  -- Replace with the actual customer ID

SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE CustomerID = @CustomerID;
-------------------------------------------------------

SELECT TOP 1 WITH TIES Customers.CustomerID, Customers.FirstName, Customers.LastName, COUNT(*) AS OrderCount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY OrderCount DESC;

---------------------------------------------------------

SELECT TOP 1 WITH TIES Products.Category, SUM(Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.Category
ORDER BY TotalQuantityOrdered DESC;
---------------------------------------------------------

SELECT TOP 1 WITH TIES Customers.CustomerID, Customers.FirstName, Customers.LastName, SUM(TotalAmount) AS TotalSpending
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronics'
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY TotalSpending DESC;

-------------------------------------------------------------

SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

-------------------------------------------------------------

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;
-------------------------------------------------------------------
---------------------------------------------------------------------


--joins assignment 1
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Customers.Email, Orders.OrderDate, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

----------------------------------------------------

Select * from Products;

SELECT Products.ProductName, Products.Category, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronics'
GROUP BY Products.ProductName, Products.Category;

-----------------------------------------------------------

SELECT DISTINCT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone, Customers.Address
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

------------------------------------------------------------

SELECT TOP 1 WITH TIES Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronics'
GROUP BY Products.ProductName
ORDER BY TotalQuantityOrdered DESC;

--------------------------------------------------------------

SELECT ProductName, Category
FROM Products
WHERE Category = 'Electronics';

---------------------------------------------------------------

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

-------------------------------------------------------------------

SELECT TOP 1 WITH TIES Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY TotalAmount DESC;

----------------------------------------------------------------------

SELECT Products.ProductName, COUNT(OrderDetails.OrderID) AS NumberOfOrders
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronics'
GROUP BY Products.ProductName;

--------------------------------------------------------------------------

Select * from Products;


DECLARE @ProductName NVARCHAR(100) = 'Tool X';  -- Replace with the actual product name

SELECT DISTINCT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone, Customers.Address
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = @ProductName;

-----------------------------------------------------------------------------

DECLARE @StartDate DATE = '2023-01-01'; 
DECLARE @EndDate DATE = '2023-12-31';  

SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate;


--------------------------------------------------------------------------------






