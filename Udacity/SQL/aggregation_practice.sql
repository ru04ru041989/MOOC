## Aggregation-- SUM

''' Q1
Find the total amount of poster_qty paper ordered in the orders table.'''

SELECT SUM(poster_qty) AS poster_amount
FROM orders


''' Q2
Find the total amount of standard_qty paper ordered in the orders table.'''

SELECT SUM(standard_qty) AS standard_amount
FROM orders


''' Q3
Find the total dollar amount of sales using the total_amt_usd 
in the orders table.'''


SELECT SUM(total_amt_usd) AS total_dollar_amount
FROM orders


''' Q4
Find the total amount spent on standard_amt_usd and gloss_amt_usd paper 
for each order in the orders table. This should give a dollar amount for 
each order in the table.'''

SELECT standard_amt_usd + gloss_amt_usd AS standard_gloss_USD
FROM orders


''' Q5
Find the standard_amt_usd per unit of standard_qty paper. 
Your solution should use both an aggregation and a mathematical operator.'''

SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS standard_price_per_unit
FROM orders

## ===========================================================================
## Aggregation-- MIN, MAX, AVG

''' Q1
When was the earliest order ever placed? You only need to return the date.'''

SELECT MIN(occurred_at)
FROM orders


''' Q2
Try performing the same query as in question 1 without 
using an aggregation function.'''

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1


''' Q3
When did the most recent (latest) web_event occur?'''

SELECT MAX(occurred_at)
FROM web_events


''' Q4
Try to perform the result of the previous query without 
using an aggregation function.'''

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1


''' Q5
Find the mean (AVERAGE) amount spent per order on each paper type, 
as well as the mean amount of each paper type purchased per order. 
Your final answer should have 6 values - one for each paper type for 
the average number of sales, as well as the average amount.'''

SELECT AVG(standard_qty) AS mean_standard_sale,
	AVG(gloss_qty) AS mean_gloss_sale,
	AVG(poster_qty) AS mean_poster_sale,
	AVG(standard_amt_usd) AS mean_standard_amt,
	AVG(gloss_amt_usd) AS mean_gloss_amt,
	AVG(poster_amt_usd) AS mean_poster_amt

FROM orders


''' Q6
Via the video, you might be interested in how to calculate the MEDIAN. 
Though this is more advanced than what we have covered so far try 
finding - what is the MEDIAN total_usd spent on all orders?'''

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

# explain
# Since there are 6912 orders - we want the average of the 3457 and 3456 
# order amounts when ordered. This is the average of 2483.16 and 2482.55.


## ===========================================================================
## GROUP BY part1

''' Q1
Which account (by name) placed the earliest order? 
Your solution should have the account name and the date of the order.'''

SELECT a.name, o.occurred_at
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1


''' Q2
Find the total sales in usd for each account. You should include two columns
 - the total sales for each company''s orders in usd and the company name.'''

SELECT a.name, 
	SUM(o.total_amt_usd)
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name


''' Q3
Via what channel did the most recent (latest) web_event occur, which account
was associated with this web_event? Your query should return only three values
- the date, channel, and account name.'''

SELECT a.name, w.occurred_at, w.channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1


''' Q4
Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times 
the channel was used.'''

SELECT channel, COUNT(channel) AS time_used
FROM web_events
GROUP BY channel


''' Q5
Who was the primary contact associated with the earliest web_event? '''

SELECT a.primary_poc
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1


''' Q6
What was the smallest order placed by each account in terms of total usd. 
Provide only two columns - the account name and the total usd. Order from 
smallest dollar amounts to largest.'''

SELECT a.name, MIN(o.total_amt_usd) AS smallest_order
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order 


''' Q7
Find the number of sales reps in each region. Your final table should have two 
columns - the region and the number of sales_reps. Order from fewest reps to 
most reps.'''

SELECT r.name, COUNT(s.name) AS number_reps
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY number_reps


## ===========================================================================
## GROUP BY part2

''' Q1
For each account, determine the average amount of each type of paper they 
purchased across their orders. Your result should have four columns - one for 
the account name and one for the average quantity purchased for each of the 
paper types for each account. '''

SELECT a.name,
	AVG(o.standard_qty) AS mean_standard,
	AVG(o.poster_qty) AS mean_poster,
	AVG(o.gloss_qty) AS mean_glossy

FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name


''' Q2
For each account, determine the average amount spent per order on each paper 
type. Your result should have four columns - one for the account name and one 
for the average amount spent on each paper type.'''

SELECT a.name,
	AVG(o.standard_amt_usd) AS mean_standard,
	AVG(o.poster_amt_usd) AS mean_poster,
	AVG(o.gloss_amt_usd) AS mean_glossy

FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name


''' Q3
Determine the number of times a particular channel was used in the web_events 
table for each sales rep. Your final table should have three columns - the name 
of the sales rep, the channel, and the number of occurrences. Order your table 
with the highest number of occurrences first.'''

SELECT s.name, w.channel,
	COUNT(*) AS num_events
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY num_events DESC


''' Q4
Determine the number of times a particular channel was used in the web_events 
table for each region. Your final table should have three columns - the region 
name, the channel, and the number of occurrences. Order your table with the 
highest number of occurrences first.'''

SELECT r.name, w.channel,
	COUNT(*) AS num_events
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY num_events DESC


## ===========================================================================
## DISTINCT

''' Q1
Use DISTINCT to test if there are any accounts associated with more than 
one region.'''

SELECT DISTINCT r.name AS region_name, r.id AS region_id,
	a.id AS account_id, a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id

# and
SELECT DISTINCT id, name
FROM accounts;

# explain
#	two queries have the same number of resulting rows (351), so we know that 
#	every account is associated with only one region. If each account was 
#	associated with more than one region, the first query should have returned 
#	more rows than the second query.



''' Q2
Have any sales reps worked on more than one account?'''

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts

# and
SELECT DISTINCT id, name
FROM sales_reps;

# explain
#	Actually all of the sales reps have worked on more than one account. 
#	The fewest number of accounts any sales rep works on is 3. There are 
#	50 sales reps, and they all have more than one account. 
#	Using DISTINCT in the second query assures that all of the sales reps 
#	are accounted for in the first query. 


## ========================================================================
# HAVING

''' Q1
How many of the sales reps have more than 5 accounts that they manage?'''

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts


''' Q2
How many accounts have more than 20 orders?'''

SELECT a.id, COUNT(*) num_order
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.id
HAVING COUNT(*) > 20
ORDER BY num_accounts


''' Q3
Which account has the most orders?'''

SELECT a.name, a.id, COUNT(*) num_order
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name, a.id
ORDER BY num_order DESC


''' Q4
How many accounts spent more than 30,000 usd total across all orders?'''

SELECT a.id, a.name, SUM(total_amt_usd) total_usd
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) > 30000


''' Q5
How many accounts spent less than 1,000 usd total across all orders?'''

SELECT a.id, a.name, SUM(total_amt_usd) total_usd
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.id, a.name
HAVING SUM(total_amt_usd) < 1000


''' Q6
Which account has spent the most with us?'''

SELECT a.id, a.name, SUM(total_amt_usd) total_usd
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_usd DESC


''' Q7
Which account has spent the least with us?'''

SELECT a.id, a.name, SUM(total_amt_usd) total_usd
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_usd


''' Q8
Which accounts used facebook as a channel to contact customers 
more than 6 times?'''

# filter web_events so that only contain FB channel during JOIN

SELECT a.id, a.name, COUNT(channel) with_FB
FROM accounts  AS a
JOIN  web_events AS w
ON a.id = w.account_id
	AND channel = 'facebook'
GROUP BY a.id, a.name
HAVING COUNT(channel) > 6

# another way: groupby channel, and using having to select channel = FB

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel



''' Q9
Which account used facebook most as a channel? '''

SELECT a.id, a.name, COUNT(channel) with_FB
FROM accounts  AS a
JOIN  web_events AS w
ON a.id = w.account_id
	AND channel = 'facebook'
GROUP BY a.id, a.name
ORDER BY with_FB DESC


''' Q10
Which channel was most frequently used by most accounts?'''

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10


## ==========================================================================
# Working With DATEs

''' Q1
Find the sales in terms of total dollars for all orders in each year, ordered 
from greatest to least. Do you notice any trends in the yearly sales totals?'''

SELECT DATE_TRUNC('year', o.occurred_at) AS year,
	SUM(total_amt_usd) AS total_usd
FROM orders AS o
GROUP BY DATE_TRUNC('year', o.occurred_at)
ORDER BY total_usd DESC

# can also use this
GROUP BY 1			# 1: the first item in SELECT
ORDER BY 2 DESC		# 2: the second item ...


''' Q2
Which month did Parch & Posey have the greatest sales in terms of total dollars? 
Are all months evenly represented by the dataset?'''

SELECT DATE_PART('month', o.occurred_at) AS month,
	SUM(total_amt_usd) AS total_usd
FROM orders AS o
GROUP BY DATE_PART('month', o.occurred_at)
ORDER BY month 


''' Q3
Which year did Parch & Posey have the greatest sales in terms of total number 
of orders? Are all years evenly represented by the dataset?'''

SELECT DATE_TRUNC('year', o.occurred_at) AS year,
	SUM(total) AS total_num
FROM orders AS o
GROUP BY DATE_TRUNC('year', o.occurred_at)
ORDER BY total_num DESC


''' Q4
Which month did Parch & Posey have the greatest sales in terms of total number 
of orders? Are all months evenly represented by the dataset?'''

SELECT DATE_PART('month', o.occurred_at) AS month,
	SUM(total) AS total_num
FROM orders AS o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY DATE_PART('month', o.occurred_at)
ORDER BY total_num DESC 

# explain:
#	To make a fair comparison, 2017 and 2013 data were removed.


''' Q5
In which month of which year did Walmart spend the most on gloss paper in 
terms of dollars?'''

SELECT DATE_TRUNC('month', o.occurred_at) AS month,
	a.name, SUM(o.gloss_amt_usd)
FROM orders o
JOIN accounts a
ON o.account_id = a.id
	AND a.name = 'Walmart'
GROUP BY DATE_TRUNC('month', o.occurred_at), a.name
ORDER BY SUM(o.gloss_amt_usd) DESC


## =======================================================================
# CASE

''' Q1
We would like to understand 3 different levels of customers based on the amount 
associated with their purchases. The top branch includes anyone with a Lifetime 
Value (total sales of all orders) greater than 200,000 usd. The second branch 
is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 
usd. Provide a table that includes the level associated with each account. You 
should provide the account name, the total sales of all orders for the customer, 
and the level. Order with the top spending customers listed first.'''

SELECT a.name, SUM(o.total_amt_usd) AS total_sales,
	CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'top'
		 WHEN SUM(o.total_amt_usd) > 100000 THEN 'middle'
		 ELSE 'lowest' END AS level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC


''' Q2
We would now like to perform a similar calculation to the first, but we want to 
obtain the total amount spent by customers only in 2016 and 2017. Keep the same 
levels as in the previous question. Order with the top spending customers listed 
first.'''


SELECT a.name, SUM(o.total_amt_usd) AS total_sales,
	CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'top'
		 WHEN SUM(o.total_amt_usd) > 100000 THEN 'middle'
		 ELSE 'lowest' END AS level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at >= '2016-01-01' AND o.occurred_at <= '2017-12-31'
GROUP BY 1
ORDER BY 2 DESC


''' Q3
We would like to identify top performing sales reps, which are sales reps 
associated with more than 200 orders. Create a table with the sales rep name, 
the total number of orders, and a column with top or not depending on if they 
have more than 200 orders. Place the top sales people first in 
your final table.'''

SELECT s.name, COUNT(o.total) AS orders_num,
	CASE WHEN COUNT(o.total) > 200 THEN 'top'
		ELSE 'not' END AS top_performance

FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC


''' Q4
The previous didn''t account for the middle, nor the dollar amount associated 
with the sales. Management decides they want to see these characteristics 
represented as well. We would like to identify top performing sales reps, 
which are sales reps associated with more than 200 orders or more than 750000 
in total sales. The middle group has any rep with more than 150 orders or 
500000 in sales. Create a table with the sales rep name, the total number of 
orders, total sales across all orders, and a column with top, middle, or low 
depending on this criteria. Place the top sales people based on dollar amount 
of sales first in your final table. You might see a few upset sales people by 
this criteria!'''

SELECT s.name, COUNT(o.total) AS orders_num, SUM(o.total_amt_usd) AS tot_usd,
	CASE WHEN COUNT(o.total) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
		 WHEN COUNT(o.total) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
		ELSE 'low' END AS performance

FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 3 DESC