# ---------------------------------------------------------------------- #
# Target DBMS:       MySQL 8                                        #
# Project name:      Northwind                                       #
# Author:            Sachin Prabhu                                  #
# ---------------------------------------------------------------------- #


# 1. List all the products with cost above the average price of the products.

SELECT DISTINCT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT avg(UnitPrice) FROM Products)
ORDER BY UnitPrice;

# 2. Give the identifier, name, and total sales of employees, ordered by
#the employee identifier for employees who have sold more than 70 different products.

SELECT e.EmployeeID, e.LastName, e.FirstName, COUNT(od.Quantity) 
FROM Employees e
LEFT JOIN Orders o ON o.EmployeeID = e.EmployeeID
LEFT JOIN Order_details od ON od.OrderID = o.OrderID
GROUP BY e.EmployeeID, e.LastName, e.FirstName
HAVING COUNT(DISTINCT od.ProductID) > 70
ORDER BY e.EmployeeID;


#3. Identify the customers who have active orders.

SELECT Orders.OrderID, Customers.CustomerID
FROM Orders, Customers
WHERE Orders.Customerid = Customers.Customerid;


# 4. Find the customer with maximum number of orders
SELECT CustomerID, COUNT(DISTINCT OrderID), MAX(Freight) 
FROM Orders 
GROUP BY CustomerID
ORDER BY 2 DESC;



#5. List all the employees who have sold at least one of
# the products ‘Gravad Lax’ or ‘Mishi Kobe Niku

SELECT DISTINCT Employees.EmployeeID,Employees.LastName, Employees.FirstName, Employees.Title
FROM Employees
INNER JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN Order_details ON Order_details.OrderID = Orders.OrderID
INNER JOIN Products ON Order_details.ProductID = Products.ProductID
WHERE Products.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku')
ORDER BY 1 ASC;





#Reference for 5th qn

# Get the ProductID's for product name being Gravad Lax and Mishi Kobe Niku
SELECT ProductID from products
WHERE Products.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku');


#Get orderdetails for product id 37 and 9
SELECT * 
FROM order_details
WHERE ProductID in (37,9)
ORDER BY 1 ASC;

#get order id for product id being 37 and 9
SELECT DISTINCT  order_details.OrderID, Products.ProductID
From order_details
INNER JOIN Products ON Order_details.ProductID = Products.ProductID
WHERE Products.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku')
ORDER BY 1 ASC;

SELECT DISTINCT orders.EmployeeID
FROM orders
INNER JOIN Order_details ON Order_details.OrderID = Orders.OrderID
INNER JOIN Products ON Order_details.ProductID = Products.ProductID
WHERE Products.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku')
ORDER BY 1 asc;
