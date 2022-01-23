#1)Try pulling all the data from the accounts table, and all the data from the orders table
SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

#2)Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table
SELECT website, primary_poc, standard_qty, gloss_qty, poster_qty
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

#3)Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen
SELECT accounts.name, accounts.primary_poc, web_events.occurred_at, web_events.channel
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
WHERE accounts.name = 'Walmart';

#4)Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;

#5)Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero
SELECT r.name, a.name, (total_amt_usd/(total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders
ON a.id = orders.account_id
ORDER BY a.name;

#6)Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
WHERE r.name = 'Midwest';

#7)Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
WHERE r.name = 'Midwest'
AND s.name LIKE 'S%'
ORDER BY a.name;

#8)Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
WHERE r.name = 'Midwest'
AND s.name LIKE '% K%'
ORDER BY a.name;

#9)Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01)
SELECT r.name, a.name, (total_amt_usd/(total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders
ON a.id = orders.account_id
WHERE standard_qty > 100
ORDER BY a.name;

#10)Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01)
SELECT r.name, a.name, (total_amt_usd/(total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders
ON a.id = orders.account_id
WHERE standard_qty > 100
AND poster_qty > 50
ORDER BY a.name;

#11)Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01)
SELECT r.name, a.name, (total_amt_usd/(total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders
ON a.id = orders.account_id
WHERE standard_qty > 100
AND poster_qty > 50
ORDER BY unit_price DESC;

#12)What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = 1001;

#13)Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN'01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

#14)Find the total amount of poster_qty paper ordered in the orders table
SELECT SUM(poster_qty)
FROM orders;

#15)Find the total amount of standard_qty paper ordered in the orders table
SELECT SUM(standard_qty)
FROM orders;

#16)Find the total dollar amount of sales using the total_amt_usd in the orders table
SELECT SUM(total_amt_usd)
FROM orders;

#17)Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table
SELECT id, SUM(standard_amt_usd), SUM(gloss_amt_usd)
FROM orders
GROUP BY id;

#18)Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

#19)When was the earliest order ever placed? You only need to return the date
SELECT MIN(occurred_at)
FROM orders;

#20)Try performing the same query as in question 1 without using an aggregation function
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

#21)When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at)
FROM web_events;

#22)Try to perform the result of the previous query without using an aggregation function
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

#23)Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount
SELECT AVG(standard_qty) AS mean_standard_qty, AVG(poster_qty) AS mean_poster_qty,
AVG(gloss_qty) AS mean_glossy_qty, AVG(standard_amt_usd) AS mean_standard_amt_usd,
AVG(gloss_amt_usd) AS mean_gloss_amt_usd, AVG(poster_amt_usd) AS mean_poster_amt_usd
FROM orders;

#24)What is the MEDIAN total_usd spent on all orders?
SELECT *
FROM(SELECT total_amt_usd
	 FROM orders
     ORDER BY total_amt_usd
     LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

#25)Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order
SELECT a.name, MIN(o.occurred_at)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
LIMIT 1;

#26)Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name
SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

#27)Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name
SELECT a.name, w.occurred_at, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

#28)Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

#29)Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

#30)What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest
SELECT a.name, MIN(o.total_amt_usd) AS total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_usd;

#31)Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps
SELECT r.name, COUNT(s.name) AS number_of_sales_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY number_of_sales_reps;

#32)For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account
SELECT a.name, AVG(o.standard_qty) AS mean_standard, 
AVG(o.poster_qty) AS mean_poster, AVG (o.gloss_qty) AS mean_gloss
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY mean_standard, mean_poster, mean_gloss;

#33)For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type
SELECT a.name, AVG(o.standard_amt_usd) AS mean_standard, 
AVG(o.poster_amt_usd) AS mean_poster, AVG (o.gloss_amt_usd) AS mean_gloss
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY mean_standard, mean_poster, mean_gloss;

#34)Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first
SELECT s.name, w.channel, COUNT(*) AS number_occurrences
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY number_occurrences DESC;

#35)Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first
SELECT r.name, w.channel, COUNT(*) AS number_occurrences
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON a.sales_rep_id = s.region_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY r.name, w.channel
ORDER BY number_occurrences DESC;

#36)Use DISTINCT to test if there are any accounts associated with more than one region
SELECT DISTINCT a.name, r.name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY a.name;

#37)Have any sales reps worked on more than one account?
SELECT DISTINCT s.name, COUNT(*) AS num_accounts
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY num_accounts;

#38)How many of the sales reps have more than 5 accounts that they manage?
SELECT DISTINCT s.name, COUNT(*) AS num_accounts
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

#39)How many accounts have more than 20 orders?
SELECT a.name, COUNT(*) AS num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

#40)Which account has the most orders?
SELECT a.name, COUNT(*) AS num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1;

#41)Which accounts spent more than 30,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING total_spent > 30000
ORDER BY total_spent DESC;

#42)Which accounts spent less than 1,000 usd total across all orders?
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING total_spent < 1000
ORDER BY total_spent DESC;

#43)Which account has spent the most with us?
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;

#44)Which account has spent the least with us?
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;

#45)Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.name, w.channel, COUNT(*) AS number_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY number_times;

#46)Which account used facebook most as a channel?
SELECT a.name, w.channel, COUNT(*) as number_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook'
ORDER BY number_times DESC
LIMIT 1;

#47)Which channel was most frequently used by most accounts?
SELECT a.name, w.channel, COUNT(*) as number_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY number_times DESC;

#48)Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT SUM(total_amt_usd) AS total_dollars, YEAR(occurred_at) AS ord_year
FROM orders
GROUP BY ord_year
ORDER BY total_dollars DESC;

#49)Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT SUM(total_amt_usd) AS total_dollars, MONTH(occurred_at) AS ord_month
FROM orders
GROUP BY ord_month
ORDER BY total_dollars DESC
LIMIT 1;

#50)Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
SELECT SUM(total_amt_usd) AS total_dollars, YEAR(occurred_at) AS ord_year
FROM orders
GROUP BY ord_year
ORDER BY total_dollars DESC
LIMIT 1;

#51)Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
SELECT COUNT(*) AS total_sales, MONTH(occurred_at) AS ord_month
FROM orders
GROUP BY ord_month
ORDER BY total_sales DESC
LIMIT 1;

#52)In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT SUM(gloss_amt_usd) AS total_dollars, MONTH(occurred_at) AS order_month, YEAR(occurred_at) AS order_year
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY order_month, order_year
ORDER BY total_dollars DESC
LIMIT 1;

#53)Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
SELECT id, total_amt_usd, 
CASE WHEN total_amt_usd > 3000 THEN 'Large' ELSE 'Small' 
END AS order_level
FROM orders
GROUP BY id, total_amt_usd
ORDER BY total_amt_usd;

#54)Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'
SELECT CASE WHEN total >= 2000  THEN 'At Least 2000' 
	 WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
     ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

#55)We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name, SUM(total_amt_usd) AS total_sales,
CASE WHEN SUM(total_amt_usd) >= 200000 THEN 'High'
     WHEN SUM(total_amt_usd) >= 100000 AND SUM(total_amt_usd) < 200000 THEN 'Medium'
     ELSE 'Low' END AS level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_sales DESC;

#56)We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name, SUM(total_amt_usd) AS total_sales,
CASE WHEN SUM(total_amt_usd) >= 200000 THEN 'High'
     WHEN SUM(total_amt_usd) >= 100000 AND SUM(total_amt_usd) < 200000 THEN 'Medium'
     ELSE 'Low' END AS level,
YEAR(occurred_at) AS year
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, year
HAVING year IN (2016, 2017)
ORDER BY total_sales DESC;

#57)We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table
SELECT s.name, SUM(o.total) AS total_orders, 
CASE WHEN SUM(total) >= 200 THEN 'Top'
ELSE 'Not' END AS level
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY total_orders DESC;

#58)The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) AS total_sales,
CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 75000 THEN 'Top'
	 WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 50000 THEN 'Middle'
ELSE 'Low' END AS level
FROM orders o 
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY total_sales DESC;

#59)Find the number of events that occur for each day for each channel. Create a subquery that simply provides all of the data from your first query. Now find the average number of events for each channel. 
SELECT channel, AVG(events) AS average_events
FROM (SELECT TRUNCATE('day', occurred_at) AS day, channel, COUNT(*) AS events
FROM web_events
GROUP BY day, channel
ORDER BY events) sub
GROUP BY channel
ORDER BY average_events DESC;

#60)Pull month level information about the first order ever placed in the orders table. Use the result of the previous query to find only the orders that took place in the same month and year as the first order, and then pull the average for each type of paper qty in this month.
SELECT AVG(standard_qty) AS avg_std, AVG(poster_qty) AS avg_poster, AVG(gloss_qty) AS avg_gloss,
SUM(total_amt_usd)
FROM orders
WHERE TRUNCATE('month', occurred_at) = (SELECT TRUNCATE('month', MIN(occurred_at)) FROM orders);

#61)Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales
SELECT MAX(total_sales), region
FROM(
	SELECT SUM(total_amt_usd) AS total_sales, s.name AS rep_name, r.name AS region
	FROM orders o
	JOIN accounts a
	ON o.account_id = a.id
	JOIN sales_reps s
	ON a.sales_rep_id = s.id
	JOIN region r
	ON s.region_id = r.id
	GROUP BY s.name, r.name)table1
GROUP BY region;

#62)For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT r.name, COUNT(o.total) AS total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
	SELECT MAX(total_sales)
    FROM(
		SELECT SUM(total_amt_usd) AS total_sales, r.name AS region
		FROM orders o
		JOIN accounts a
		ON o.account_id = a.id
		JOIN sales_reps s
		ON a.sales_rep_id = s.id
		JOIN region r
		ON s.region_id = r.id
		GROUP BY region)table1);
        
#63)How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?        
SELECT COUNT(*)
FROM(
	SELECT a.name
	FROM orders o
	JOIN accounts a
	ON o.account_id = a.id
	GROUP BY a.name
	HAVING SUM(o.total) > (SELECT total
		FROM (SELECT a.name, SUM(o.standard_qty) AS total_std, SUM(o.total) AS total
		FROM orders o
		JOIN accounts a
		ON o.account_id = a.id
		GROUP BY a.name
        ORDER BY total_std DESC
        LIMIT 1)table1)
        )table2;
        
#64)For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.id = (SELECT a.id
	FROM (SELECT a.name, SUM(o.total_amt_usd) AS total_sales
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY a.name
	ORDER BY total_sales DESC
	LIMIT 1) table1)
GROUP BY a.name, channel
ORDER BY COUNT(*) DESC;

#65)What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(total_sales)
FROM (SELECT a.name, SUM(total_amt_usd) AS total_sales
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY a.name
	ORDER BY total_sales DESC
	LIMIT 10)table1;

#66)What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) AS avg_amt
	FROM orders o
	GROUP BY o.account_id
	HAVING AVG(o.total_amt_usd) >
		(SELECT AVG(o.total_amt_usd) AS avg_all
		FROM orders o))table1;

#67)Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH table1 AS (
	SELECT SUM(o.total_amt_usd) AS total_sales, s.name AS rep_name, r.name AS region_name
	FROM orders o 
	JOIN accounts a
	ON o.account_id = a.id
	JOIN sales_reps s
	ON a.sales_rep_id = s.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY s.name, r.name
	ORDER BY total_sales DESC),
table2 AS (
	SELECT region_name, MAX(total_sales) AS total_sales
	FROM table1
	GROUP BY region_name)
SELECT table1.rep_name, table1.region_name, table1.total_sales
FROM table1
JOIN table2
ON table1.region_name = table2.region_name AND table1.total_sales = table2.total_sales;

#68)For the region with the largest sales total_amt_usd, how many total orders were placed?
WITH t1 AS (
	SELECT r.name AS region_name, SUM(o.total_amt_usd) AS total_sales, SUM(o.total) AS total_orders
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    GROUP BY region_name
    ORDER BY total_sales DESC),
t2 AS (
	SELECT MAX(total_sales)
    FROM t1)
SELECT r.name, COUNT(o.total) AS total_orders
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

#69)How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
WITH t1 AS (
	SELECT a.name AS account_name, SUM(o.standard_qty) AS std_qty, SUM(o.total) AS total_orders
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY account_name
    ORDER BY std_qty DESC
    LIMIT 1),
t2 AS (
	SELECT a.name
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY a.name
	HAVING SUM(o.total) > (SELECT total_orders FROM t1))
SELECT COUNT(*)
FROM t2;
    
#70)For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
WITH t1 AS (
		SELECT a.name, SUM(o.total_amt_usd) AS total_sales
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY a.name
        ORDER BY total_sales DESC
        LIMIT 1),
t2 AS (
		SELECT a.name, w.channel
        FROM accounts a
        JOIN web_events w
        ON a.id = w.account_id AND a.name = (SELECT a.name FROM t1))
SELECT COUNT(*)
FROM t2;

#71)What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
WITH t1 AS (
	SELECT a.name, SUM(o.total_amt_usd) AS total_sales
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY a.name
    ORDER BY total_sales DESC
    LIMIT 10)
SELECT AVG(t1.total_sales) AS avg_spent
FROM t1;

#72)What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders
WITH t1 AS (
	SELECT AVG(total_amt_usd) AS avg_all
    FROM orders),
	 t2 AS (
	SELECT a.name, AVG(o.total_amt_usd) AS avg_orders
	FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY a.name
    HAVING avg_orders > (SELECT * FROM t1))
SELECT AVG(avg_orders)
FROM t2;

#73)In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table
SELECT RIGHT(website, 3) AS domain, COUNT(*) AS num_companies
FROM accounts
GROUP BY domain
ORDER BY num_companies DESC;

#74)There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number)
SELECT LEFT(name, 1) AS first_letter, COUNT(*) AS num_companies
FROM accounts
GROUP BY first_letter
ORDER BY num_companies DESC;

#75)Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?
SELECT SUM(num) AS nums, SUM(letter) AS letters 
FROM (SELECT name, CASE WHEN LEFT(name, 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS num,
	  CASE WHEN LEFT(name, 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0 ELSE 1 END AS letter
      FROM accounts)t1;

#76)Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?
SELECT SUM(vowel) AS vowels, SUM(other) AS others 
FROM (SELECT name, CASE WHEN LEFT(name, 1) IN ('a','e','i','o','u') THEN 1 ELSE 0 END AS vowel,
	  CASE WHEN LEFT(name, 1) IN ('a','e','i','o','u') THEN 0 ELSE 1 END AS other
      FROM accounts)t1;

#77)Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
FROM accounts;

#78)Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns
SELECT LEFT(name, STRPOS(name, ' ')-1) AS first_name,
RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name
FROM sales_reps;

#79)Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com
WITH t1 AS (
	SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
	FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

#80)You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here
WITH t1 AS (
	SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
	FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ',''), '.com')
FROM t1;

#81)We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces
WITH t1 AS (
	SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first_name, 
    RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
    FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'),
LEFT(LOWER(first_name), 1) ||
RIGHT(LOWER(first_name), 1) ||
LEFT(LOWER(last_name), 1) ||
RIGHT(LOWER(last_name), 1) ||
LENGTH(first_name) || LENGTH(last_name) ||
REPLACE(UPPER(name), ' ', '')
FROM t1;

#82)Is there any missing total order data?
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

#83)Use COALESCE to fill in the account id column with the account id for the NULL value 
SELECT COALESCE(o.id, a.id) AS filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

#84)Use COALESCE to fill in the orders account id column with the account id for the NULL value 
SELECT COALESCE(o.id, a.id) AS filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) AS account_id,
o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

#85)USE COALESCE to fill in each of the qty and usd columns with 0
SELECT COALESCE(o.id, a.id) AS filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) AS account_id,
o.occurred_at, COALESCE(o.standard_qty,0), COALESCE(o.gloss_qty,0), COALESCE(o.poster_qty,0), COALESCE(o.total,0), COALESCE(o.standard_amt_usd,0), COALESCE(o.gloss_amt_usd,0), COALESCE(o.poster_amt_usd,0), COALESCE(o.total_amt_usd,0)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

#86)
SELECT COUNT(*)
FROM accounts a
JOIN orders o
ON a.id = o.account_id;

SELECT COUNT(*), COALESCE(o.id, a.id) AS filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) AS account_id,
o.occurred_at, COALESCE(o.standard_qty,0), COALESCE(o.gloss_qty,0), COALESCE(o.poster_qty,0), COALESCE(o.total,0), COALESCE(o.standard_amt_usd,0), COALESCE(o.gloss_amt_usd,0), COALESCE(o.poster_amt_usd,0), COALESCE(o.total_amt_usd,0)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.occurred_at;

#87)Create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total
WITH t1 AS (
	SELECT SUM(standard_amt_usd) as amount, occurred_at AS time
    FROM orders
    GROUP BY time)
SELECT amount, SUM(amount) OVER (order by time) AS cumulative_amount
FROM t1;

#88)Create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year
SELECT standard_amt_usd AS amount, TRUNCATE('year', occurred_at) AS year,
SUM(standard_amt_usd) OVER (PARTITION BY TRUNCATE('year', occurred_at) ORDER BY occurred_at) AS cumulative_amount
FROM orders;

#89)Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns
SELECT id, account_id, total, RANK() OVER(PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders;

#90)Find matched and unmatched rows. Find each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full). But also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)
SELECT * 
FROM accounts a
FULL JOIN sales_reps s
ON a.sales_rep_id = s.id;

#91)write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID number and joins it using the < comparison operator on accounts.primary_poc and sales_reps.name, like so: accounts.primary_poc < sales_reps.nameThe query results should be a table with three columns: the account name (e.g. Johnson Controls), the primary contact name (e.g. Cammy Sosnowski), and the sales representative's name (e.g. Samuel Racine). Then answer the subsequent multiple choice question.
SELECT a.name, a.primary_poc, s.name
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id = s.id
AND a.primary_poc < s.name;

#92)Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table. 
SELECT *
FROM accounts 
UNION ALL
SELECT *
FROM accounts


