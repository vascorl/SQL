#1)Prepare a list of offices sorted by country, state, city.
SELECT *
FROM offices
ORDER BY country, state, city;

#2)How many employees are there in the company?
SELECT COUNT(employeeNumber) AS total_employees
FROM employees;

#3)What is the total of payments received?
SELECT SUM(amount) AS total_payments_received
FROM payments;

#4)List the product lines that contain 'Cars'.
SELECT productLine, COUNT(productLine) AS number_units
FROM productlines
WHERE productLine LIKE '%Cars%'
GROUP BY productLine;

#5)Report total payments for October 28, 2004.
SELECT SUM(amount) AS total_payments, paymentDate
FROM payments
WHERE paymentDate = '2004-10-28';

#6)Report those payments greater than $100,000.
SELECT amount, paymentDate
FROM payments
WHERE amount > 100000;

SELECT SUM(amount), paymentDate
FROM payments
GROUP BY amount, paymentDate
HAVING SUM(amount) > 100000;

#7)List the products in each product line.
SELECT productlines.productLine, products.productName
FROM productlines
JOIN products
ON productlines.productLine = products.productLineON productlines.productLine = products.productLine
GROUP BY productlines.productLine, products.productName;

#8)How many products in each product line?
SELECT productlines.productLine, COUNT(products.productName)
FROM productlines
JOIN products
ON productlines.productLine = products.productLine
GROUP BY productlines.productLine
HAVING COUNT(products.productName);

#9)What is the minimum payment received?
SELECT MIN(amount)
FROM payments
LIMIT 1;

#10)List all payments greater than twice the average payment.
SELECT * 
FROM payments 
WHERE amount > (SELECT AVG(amount)*2 FROM payments);

#11)What is the average percentage markup of the MSRP on buyPrice?
SELECT AVG(MSRP-buyPrice)/100
from products;

#12)How many distinct products does ClassicModels sell?
SELECT productName, COUNT(DISTINCT productName)
FROM products
GROUP BY productName
HAVING COUNT(DISTINCT productName);

#13)Report the name and city of customers who don't have sales representatives?
SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

#14)What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
SELECT employeeNumber, CONCAT(lastName, firstName),jobTitle
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%Manager%'
GROUP BY employeeNumber;

#15)Which orders have a value greater than $5,000?
SELECT orderNumber
FROM orderdetails
WHERE priceEach*quantityOrdered > 5000
GROUP BY orderNumber;

#16)Report the account representative for each customer.
SELECT customerName, employees.lastName, employees.firstName
FROM customers
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY customerName, employees.lastName, employees.firstName;

#17)Report total payments for Atelier graphique.
SELECT SUM(amount) AS total_payments, customerName
FROM payments
JOIN customers
ON payments.customerNumber = customers.customerNumber
WHERE customerName = "Atelier graphique";

#18)Report the total payments by date
SELECT SUM(amount) AS total_payments, paymentDate
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate;

#19)Report the products that have not been sold.
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock != 0;

#20)List the amount paid by each customer.
SELECT customerName, SUM(amount) as total_paid
FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
GROUP BY customerName;

#21)How many orders have been placed by Herkku Gifts?
SELECT customerName, COUNT(orderNumber)
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE customerName = "Herkku Gifts";

#22)Who are the employees in Boston?
SELECT lastName, firstName, offices.city
FROM employees
JOIN offices
ON employees.officeCode = offices.officeCode
WHERE city = "Boston";

#23)Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.
SELECT customerName, SUM(amount) AS total_payments
FROM payments
JOIN customers
ON payments.customerNumber = customers.customerNumber
GROUP BY customerName
HAVING SUM(amount) > 100000
ORDER BY customerName ASC;

#24)List the value of 'On Hold' orders.
SELECT orders.orderNumber, status, (quantityOrdered * priceEach) AS value
FROM orders
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
WHERE status = "On Hold";

#25)Report the number of orders 'On Hold' for each customer.
SELECT customerName, orders.orderNumber, status, (quantityOrdered * priceEach) AS value
FROM orders
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN customers
ON orders.customerNumber = customers.customerNumber
WHERE status = "On Hold";

#26)List products sold by order date.
SELECT productName, orderDate
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
ORDER BY orderDate;

#27)List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
SELECT productName, orderDate
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
WHERE productName = "1940 Ford Pickup Truck"
ORDER BY orderDate;

#28)List the names of customers and their corresponding order number where a particular order from that customer has a value greater than $25,000?
SELECT customerName, orders.orderNumber, amount
FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE amount > 25000
ORDER BY customerName;

#29)Are there any products that appear on all orders?


#30)List the names of products sold at less than 80% of the MSRP.
SELECT productName, MSRP
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE priceEach<(.8*MSRP)
ORDER BY MSRP;

#31)Reports those products that have been sold with a markup of 100% or more (i.e.,  the priceEach is at least twice the buyPrice)
SELECT productName, priceEach, buyPrice
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE priceEach > (2*buyPrice)
GROUP BY productName, priceEach, buyPrice
ORDER BY priceEach;

#32)List the products ordered on a Monday.
SELECT productName, orderDate
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
WHERE DAYNAME(Orders.orderDate) = 'Monday'
GROUP BY productName, orderDate;

#33)What is the quantity on hand for products listed on 'On Hold' orders?
SELECT productName, quantityInStock
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
WHERE status = 'On Hold'
GROUP BY productName, quantityInStock
ORDER BY quantityInStock;

#https://www.richardtwatson.com/dm6e/Reader/ClassicModels.html

