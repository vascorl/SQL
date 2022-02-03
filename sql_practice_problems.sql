#1)Which shippers do we have?
SELECT *
FROM Shippers;

#2)In the Categories table, selecting all the fields using this SQL: Select * from Categories…will return 4 columns. We only want to see two columns, CategoryName and Description.
SELECT CategoryName, Description
FROM Categories;

#3)We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. Write a SQL statement that returns only those employees.
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative';

#4)Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also are in the United States.
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative' AND Country = 'USA';

#5)Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5
SELECT orderid
FROM orders o
JOIN employees e
ON o.employeeid = e.employeeid
WHERE e.employeeid = 5;

#6)In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager
SELECT supplierid, contactname, contacttitle
FROM suppliers
WHERE contacttitle != 'Marketing Manager';

#7)In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”
SELECT productid, productname
FROM products
WHERE productname LIKE '%queso%';

#8)Looking at the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either France or Belgium
SELECT orderid, customerid, shipcountry
FROM orders
WHERE shipcountry = 'France' OR shipcountry = 'Belgium';

#9)Now, instead of just wanting to return all the orders from France of Belgium, we want to show all the orders from any Latin American country
SELECT orderid, customerid, shipcountry
FROM orders
WHERE shipcountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

#10)For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first
SELECT firstname, lastname, title, birthdate
FROM employees
ORDER BY birthdate;

#11)In the output of the query above, showing the Employees in order of BirthDate, we see the time of the BirthDate field, which we don’t want. Show only the date portion of the BirthDate field
SELECT firstname, lastname, title, CONVERT(birthdate, DATE)
FROM employees
ORDER BY birthdate;

#12)Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between
SELECT firstname, lastname, CONCAT(firstname, ' ', lastname) AS fullname
FROM employees;

#13)In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll ignore the Discount field for now.
#In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.
SELECT orderid, productid, unitprice, quantity, (unitprice * quantity) AS totalprice
FROM order_details
ORDER BY orderid, productid;

#14)How many customers do we have in the Customers table? Show one value only, and don’t rely on getting the recordcount at the end of a resultset
SELECT COUNT(*) AS totalcustomers
FROM customers;

#15)Show the date of the first order ever made in the Orders table
SELECT MIN(orderdate)
FROM orders;

#16)Show a list of countries where the Northwind company has customers
SELECT country
FROM customers
GROUP BY country;

#17)Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle
SELECT ContactTitle, COUNT(*) AS number_titles
FROM customers
GROUP BY ContactTitle
ORDER BY number_titles DESC;

#18)We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID
SELECT p.productid, p.productname, s.companyname
FROM products p
JOIN suppliers s
ON p.supplierid = s.supplierid
ORDER BY p.productid;

#19)We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.
#In order to not show all the orders (there’s more than 800), show only those rows with an OrderID of less than 10300.
SELECT o.orderid, CONVERT(o.orderdate, DATE) AS date, s.companyname
FROM orders o
JOIN order_details od
ON o.orderid = od.orderid
JOIN products p
ON od.productid = p.productid
JOIN suppliers s
ON p.supplierid = s.supplierid
WHERE o.orderid < 10300;

#20)For this problem, we’d like to see the total number of products in each category. Sort the results by the total number of products, in descending order
SELECT c.categoryname, COUNT(*) AS number_products
FROM categories c
JOIN products p
ON c.categoryid = p.categoryid
GROUP BY c.categoryname
ORDER BY number_products DESC;

#21)In the Customers table, show the total number of customers per Country and City
SELECT country, city, COUNT(*) AS number_customers
FROM customers
GROUP BY country, city
ORDER BY number_customers DESC;

#22)What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued.
#Order the results by ProductID.
SELECT productid, productname, unitsinstock, reorderlevel
FROM products
WHERE unitsinstock < reorderlevel
ORDER BY productid;

#23)Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued—into our calculation. We’ll define “products that need reordering” with the following:
#UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel
#The Discontinued flag is false (0).
SELECT productid, productname, unitsinstock, unitsonorder, reorderlevel, discontinued
FROM products
WHERE (unitsinstock + unitsonorder) <= reorderlevel
ORDER BY productid;

#24)A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of all customers, sorted by region, alphabetically.
#However, he wants the customers with no region (null in the Region field) to be at the end, instead of at the top, where you’d normally find the null values. Within the same region, companies should be sorted by CustomerID.
SELECT customerid, companyname, region
FROM customers
GROUP BY customerid
ORDER BY CASE WHEN region is NULL THEN 1 ELSE 0 END, region ,customerid;

#25)Some of the countries we ship to have very high freight charges. We'd like to investigate some more shipping options for our customers, to be able to offer them lower freight charges. Return the three ship countries with the highest average freight overall, in descending order by average freight.
SELECT shipcountry AS country, AVG(freight) AS avg_freight
FROM orders
GROUP BY country
ORDER BY avg_freight DESC
LIMIT 3;

#26)We're continuing on the question above on high freight charges. Now, instead of using all the orders we have, we only want to see orders from the year 2015
SELECT shipcountry AS country, AVG(freight) AS avg_freight
FROM orders
WHERE YEAR(CONVERT(orderdate, DATE)) = 2015
GROUP BY country
ORDER BY avg_freight DESC
LIMIT 3;

#27)
SELECT shipcountry AS country, AVG(freight) AS avg_freight
FROM orders
WHERE CONVERT(orderdate, DATE) BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY country
ORDER BY avg_freight DESC
LIMIT 3;

#28)We now want to get the three ship countries with the highest average freight charges. But instead of filtering for a particular year, we want to use the last 12 months of order data, using as the end date the last OrderDate in Orders.
SELECT MAX(CONVERT(orderdate, DATE)) FROM orders;

SELECT shipcountry AS country, AVG(freight) AS avg_freight
FROM orders
WHERE CONVERT(orderdate, DATE) BETWEEN '1997-05-01' AND '1998-05-31'
GROUP BY country
ORDER BY avg_freight DESC
LIMIT 3;

#29)We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and Product ID
SELECT o.employeeid, e.lastname, o.orderid, p.productname, od.quantity
FROM orders o
JOIN order_details od
ON o.orderid = od.orderid
JOIN products p
ON od.productid = p.productid
JOIN employees e
ON o.employeeid = e.employeeid
ORDER BY o.orderid, p.productid;

#30)There are some customers who have never actually placed an order. Show these customers
SELECT c.companyname, od.quantity
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON od.orderid = o.orderid
WHERE od.quantity IS NULL;

#31)One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her
SELECT c.companyname, c.customerid
FROM customers c
LEFT JOIN orders o
ON c.customerid = o.customerid AND o.employeeid = 4
WHERE o.customerid IS NULL
GROUP BY c.companyname, c.customerid
ORDER BY c.companyname;	

#32)We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016
SELECT c.customerid, c.companyname, o.orderid, SUM(od.unitprice*od.quantity) AS totalvalue
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
GROUP BY c.customerid, c.companyname, o.orderid
HAVING SUM(od.unitprice*od.quantity) > 10000
ORDER BY totalvalue DESC;

#33)SELECT c.customerid, c.companyname, o.orderid, SUM(od.unitprice*od.quantity) AS totalvalue
SELECT c.customerid, c.companyname, SUM(od.unitprice*od.quantity) AS totalvalue
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
GROUP BY c.customerid, c.companyname
HAVING SUM(od.unitprice*od.quantity) > 15000
ORDER BY totalvalue DESC;

#34)Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount 
SELECT c.customerid, c.companyname, SUM((od.unitprice*od.quantity)*(1-od.discount)) AS totalvalue
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
GROUP BY c.customerid, c.companyname
HAVING SUM(od.unitprice*od.quantity) > 15000
ORDER BY totalvalue DESC;

#35)At the end of the month, salespeople are likely to try much harder to get orders, to meet their month-end quotas. Show all orders made on the last day of the month. Order by EmployeeID and OrderID
SELECT employeeid, orderid, last_day(orderdate) AS orderdate
FROM orders
GROUP BY orderid
ORDER BY employeeid;

#36)The Northwind mobile app developers are testing an app that customers will use to show orders. In order to make sure that even the largest orders will show up correctly on the app, they'd like some samples of orders that have lots of individual line items. Show the 10 orders with the most line items, in order of total line items
SELECT orderid, COUNT(productid) AS total_order_details
FROM order_details
GROUP BY orderid
ORDER BY total_order_details DESC
LIMIT 10;

#37)The Northwind mobile app developers would now like to just get a random assortment of orders for beta testing on their app. Show a random set of 2% of all orders
SELECT orderid
FROM orders
WHERE RAND() < 0.02;

#38)Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered a line item on an order, with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more. Show all the OrderIDs with line items that match this, in order of OrderID
SELECT orderid
FROM order_details
WHERE quantity >= 60
GROUP BY orderid, quantity
HAVING COUNT(*) >1;

#39)Based on the previous question, we now want to show details of the order, for orders that match the above criteria
with t1 AS(
	SELECT orderid
	FROM order_details
	WHERE quantity >= 60
	GROUP BY orderid, quantity
	HAVING COUNT(*) >1)
SELECT *
FROM order_details
WHERE orderid in (SELECT orderid from t1)
ORDER BY orderid, quantity;

#40)

#41)Some customers are complaining about their orders arriving late. Which orders are late?
SELECT orderid, CONVERT(orderdate,DATE), CONVERT(requireddate, DATE), CONVERT(shippeddate, DATE)
FROM orders
WHERE shippeddate > requireddate;

#42)Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, and need more training. Which salespeople have the most orders arriving late?
SELECT employeeid, COUNT(shippeddate > requireddate) AS total_late_orders
FROM orders
GROUP BY employeeid
ORDER BY total_late_orders DESC;

#43)Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders. He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea. It needs to be compared against the total number of orders per salesperson
WITH t1 AS (
	SELECT employeeid, COUNT(shippeddate > requireddate) AS total_late_orders
	FROM orders
	GROUP BY employeeid
	ORDER BY total_late_orders DESC),
	t2 AS (
	SELECT employeeid, COUNT(*) AS total_orders
    FROM orders
    GROUP BY employeeid
    ORDER BY total_orders DESC)
SELECT orders.employeeid, total_orders, total_late_orders
FROM orders
JOIN t1 
ON orders.employeeid = t1.employeeid
JOIN t2
ON t1.employeeid = t2.employeeid
GROUP BY employeeid;

#44)There's an employee missing in the answer from the problem above. Fix the SQL to show all employees who have taken orders
WITH t1 AS (
	SELECT employeeid, COUNT(shippeddate > requireddate) AS total_late_orders
	FROM orders
	GROUP BY employeeid
	ORDER BY total_late_orders DESC),
	t2 AS (
	SELECT employeeid, COUNT(*) AS total_orders
    FROM orders
    GROUP BY employeeid
    ORDER BY total_orders DESC)
SELECT orders.employeeid, total_orders, total_late_orders
FROM orders
JOIN t1 
ON orders.employeeid = t1.employeeid
LEFT JOIN t2
ON t1.employeeid = t2.employeeid
GROUP BY employeeid;

#45)

#46)Now we want to get the percentage of late orders over total orders
WITH t1 AS (
	SELECT employeeid, COUNT(shippeddate > requireddate) AS total_late_orders
	FROM orders
	GROUP BY employeeid
	ORDER BY total_late_orders DESC),
	t2 AS (
	SELECT employeeid, COUNT(*) AS total_orders
    FROM orders
    GROUP BY employeeid
    ORDER BY total_orders DESC)
SELECT orders.employeeid, total_orders, total_late_orders, (total_late_orders/total_orders) AS percentage_late
FROM orders
JOIN t1 
ON orders.employeeid = t1.employeeid
LEFT JOIN t2
ON t1.employeeid = t2.employeeid
GROUP BY employeeid;

#47)To make the output easier to read, let's cut the PercentLateOrders off at 2 digits to the right of the decimal point
WITH t1 AS (
	SELECT employeeid, COUNT(shippeddate > requireddate) AS total_late_orders
	FROM orders
	GROUP BY employeeid
	ORDER BY total_late_orders DESC),
	t2 AS (
	SELECT employeeid, COUNT(*) AS total_orders
    FROM orders
    GROUP BY employeeid
    ORDER BY total_orders DESC)
SELECT orders.employeeid, total_orders, total_late_orders, ROUND(total_late_orders/total_orders, 2) AS percentage_late
FROM orders
JOIN t1 
ON orders.employeeid = t1.employeeid
LEFT JOIN t2
ON t1.employeeid = t2.employeeid
GROUP BY employeeid;

#48)Andrew Fuller, the VP of sales at Northwind, would like to do a sales campaign for existing customers. He'd like to categorize customers into groups, based on how much they ordered in 2016. Then, depending on which group the customer is in, he will target the customer with different sales materials.
#The customer grouping categories are 0 to 1,000, 1,000 to 5,000, 5,000
#to 10,000, and over 10,000.
#We don’t want to show customers who don’t have any orders in 2016.
#Order the results by CustomerID.
SELECT c.customerid, c.companyname, SUM(od.unitprice*od.quantity) AS totalvalue,
CASE WHEN SUM(od.unitprice*od.quantity) BETWEEN 0 AND 1000 THEN 'LOW'
	 WHEN SUM(od.unitprice*od.quantity) BETWEEN 1001 AND  5000 THEN 'MEDIUM'
     WHEN SUM(od.unitprice*od.quantity) BETWEEN 5001 AND 10000 THEN 'HIGH'
     ELSE 'PREMIUM' END AS customergroup
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
GROUP BY c.customerid, c.companyname;
#HAVING SUM(od.unitprice*od.quantity) > 15000

#49)There's a bug with the answer for the previous question. The CustomerGroup value for one of the rows is null.
#Fix the SQL so that there are no nulls in the CustomerGroup field
SELECT c.customerid, c.companyname, SUM(od.unitprice*od.quantity) AS totalvalue,
CASE WHEN SUM(od.unitprice*od.quantity) > 0 AND SUM(od.unitprice*od.quantity) <= 1000 THEN 'LOW'
	 WHEN SUM(od.unitprice*od.quantity) > 1000 AND SUM(od.unitprice*od.quantity) <= 5000 THEN 'MEDIUM'
     WHEN SUM(od.unitprice*od.quantity) > 5000 AND SUM(od.unitprice*od.quantity) <= 10000 THEN 'HIGH'
     ELSE 'PREMIUM' END AS customergroup
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
AND customergroup IS NOT NULL
GROUP BY c.customerid, c.companyname;

#50)Based on the above query, show all the defined CustomerGroups, and the percentage in each. Sort by the total in each group, in descending order
with t1 AS (
	SELECT c.customerid, c.companyname, SUM(od.unitprice*od.quantity) AS totalvalue,
CASE WHEN SUM(od.unitprice*od.quantity) > 0 AND SUM(od.unitprice*od.quantity) <= 1000 THEN 'LOW'
	 WHEN SUM(od.unitprice*od.quantity) > 1000 AND SUM(od.unitprice*od.quantity) <= 5000 THEN 'MEDIUM'
     WHEN SUM(od.unitprice*od.quantity) > 5000 AND SUM(od.unitprice*od.quantity) <= 10000 THEN 'HIGH'
     ELSE 'PREMIUM' END AS customergroup
FROM customers c
JOIN orders o
ON c.customerid = o.customerid
JOIN order_details od
ON o.orderid = od.orderid
WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
AND customergroup IS NOT NULL
GROUP BY c.customerid, c.companyname)
SELECT t1.customergroup, COUNT(*) AS total_in_group, COUNT(*) * 1.0 /(SELECT COUNT(*) FROM t1) AS percentage_in_group
FROM t1
GROUP BY t1.customergroup
ORDER BY total_in_group DESC;

#51)Andrew, the VP of Sales is still thinking about how best to group customers, and define low, medium, high, and very high value customers. He now wants complete flexibility in grouping the customers, based on the dollar amount they've ordered. He doesn’t want to have to edit SQL in order to change the boundaries of the customer groups.
with t1 AS (
	SELECT c.customerid, c.companyname, SUM(od.unitprice*od.quantity) AS totalvalue
	FROM customers c
	JOIN orders o
	ON c.customerid = o.customerid
	JOIN order_details od
	ON o.orderid = od.orderid
	WHERE CONVERT(o.orderdate, DATE) BETWEEN '2015-12-31' AND '2017-01-01'
	GROUP BY c.customerid, c.companyname)
SELECT customerid, companyname, totalvalue, customergroupname
FROM t1
JOIN customergroupthresholds
ON t1.totalvalue BETWEEN customergroupthresholds.rangebottom AND
customergroupthresholds.rangetop
ORDER BY customerid;

#52)Some Northwind employees are planning a business trip, and would like to visit as many suppliers and customers as possible. For their planning, they’d like to see a list of all countries where suppliers and/or customers are based
SELECT country
FROM customers
UNION 
SELECT country
FROM suppliers
ORDER BY country;

#53)The employees going on the business trip don’t want just a raw list of countries, they want more details
with t1 AS (
	SELECT DISTINCT country FROM customers),
t2 AS (
	SELECT DISTINCT country FROM suppliers)
SELECT t1.country AS customer_country, t2.country AS supplier_country
FROM t1
FULL OUTER JOIN t2
ON t1.country = t2.country;

#54)The output of the above is improved, but it’s still not ideal
#What we’d really like to see is the country name, the total suppliers, and the total customers.
with t1 AS (
	SELECT country, COUNT(*) AS total_customers FROM customers),
t2 AS (
	SELECT DISTINCT country, COUNT(*) AS total_suppliers FROM suppliers)
SELECT t1.country AS customer_country, t2.country AS supplier_country, total_customers, total_suppliers
FROM t1
FULL OUTER JOIN t2
ON t1.country = t2.country;

#55)Looking at the Orders table—we’d like to show details for each order that was the first in that particular country, ordered by OrderID.
#So, we need one row per ShipCountry, and CustomerID, OrderID, and OrderDate should be of the first order from that country.
WITH t1 as (
	SELECT shipcountry, customerid, orderid, CONVERT(orderdate, DATE) AS orderdate,
    ROW_NUMBER() OVER (PARTITION BY shipcountry ORDER BY shipcountry, orderid) AS row_number_per_country
	FROM orders)
SELECT shipcountry, customerid, orderid, CONVERT(orderdate, DATE) AS orderdate
FROM t1
WHERE row_number_per_country = 1
ORDER BY shipcountry;

#56)There are some customers for whom freight is a major expense when ordering from Northwind.
#However, by batching up their orders, and making one larger order instead of multiple smaller orders in a short period of time, they could reduce their freight costs significantly.
#Show those customers who have made more than 1 order in a 5 day period. The sales people will use this to help customers reduce their costs.
SELECT
initialorder.customerid
,initialorderid = initialorder.orderid
,initialorderdate = CONVERT(initialorder.orderdate, DATE)
,nextorderid = nextorder.orderid
,nextorderdate = CONVERT(nextorder.orderdate, DATE)
,daysbetween = DATEDIFF(DD, initialorder.orderdate, nextorder.orderdate) 
FROM orrders initialorder
JOIN orders nextorder
ON initialorder.customerid = nextorder.customerid 
WHERE initialorder.orderid < nextorder.orderid
AND DATEDIFF(DD, initialorder.orderdate, nextorder.orderdate) <= 5 
ORDER BY initialorder.customerid,initialorder.orderid

#57)There’s another way of solving the problem above, using Window functions
WITH nextorderdate AS ( 
SELECT customerid, CONVERT(orderdate, DATE) AS orderdate,
CONVERT(Lead(orderdate,1),DATE) AS nextorderdate
OVER (PARTITION BY customerid ORDER BY customerid, orderdate)
)
FROM orders
)
SELECT customerid, orderdate, nextorderdate, 
DATEDIFF(dd,orderdate, nextorderdate)
FROM nextorderdate
WHERE DATEDIFF(dd, orderdate, nextorderdate) <= 5;
