## subquery

''' Q1
Provide the name of the sales_rep in each region with the largest 
amount of total_amt_usd sales.'''

# think: final table:
'   rep_name | region_name | max(total_amt_usd)		'

# intermidate table: 

# t1:
'  rep_name | region_name | max(total_amt_usd)	'
SELECT s.name AS rep_name, r.name AS region_name, MAX(total_amt_usd)
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1,2

# t2: max(total_amt_usd) for each region
'	region_name | max(total_amt_usd)	'
SELECT r.name AS region_name, MAX(total_amt_usd)
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1

# join t2 to t1
SELECT t1.rep_name, t1.region_name, t1.max

FROM (SELECT s.name AS rep_name, r.name AS region_name, MAX(total_amt_usd)
	FROM region r 
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1,2) t1

JOIN (SELECT r.name AS region_name, MAX(total_amt_usd)
	FROM region r 
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1) t2

ON t1.region_name = t2.region_name
	AND t1.max = t2.max


''' Q2
For the region with the largest (sum) of sales total_amt_usd, how many 
total (count) orders were placed? '''


# t1: sum of sales for each region
SELECT r.name, SUM(o.total_amt_usd)
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
GROUP BY r.name

# value: the region with max sales:
SELECT MAX(sum)
FROM (SELECT r.name, SUM(o.total_amt_usd)
	FROM region r 
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY r.name) t1


# pull together
SELECT r.name, COUNT(o.total_amt_usd)
FROM region r 
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
	SELECT MAX(sum)
	FROM (SELECT r.name, SUM(o.total_amt_usd)
		FROM region r 
		JOIN sales_reps s
		ON r.id = s.region_id
		JOIN accounts a 
		ON s.id = a.sales_rep_id
		JOIN orders o 
		ON a.id = o.account_id
		GROUP BY r.name) t1
	)


''' Q3
For the name of the account that purchased the most (in total over their 
lifetime as a customer) standard_qty paper, how many accounts have more 
total purchases than this account? '''


# the account which has the most standard_qty paper
SELECT a.name, SUM(o.standard_qty) as num_std_order, SUM(o.total) as total
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

# the account who has more total than that account
SELECT a.name, SUM(o.total)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (
	SELECT total
	FROM(SELECT a.name, SUM(o.standard_qty) as num_std_order, SUM(o.total) as total
		FROM accounts a 
		JOIN orders o 
		ON a.id = o.account_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1) t1 )

# count the number of the row
SELECT COUNT(*)
FROM (SELECT a.name, SUM(o.total)
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (
		SELECT total
		FROM(SELECT a.name, SUM(o.standard_qty) as num_std_order, SUM(o.total) as total
			FROM accounts a 
			JOIN orders o 
			ON a.id = o.account_id
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 1) t1 )
	) t2


''' Q4
For the customer that spent the most (in total over their lifetime as a
customer) total_amt_usd, how many web_events did they have for each channel?'''


# the name that spent the most usd
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a 
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

# get the channel and event count of that name
SELECT a.name, w.channel, COUNT(w.*)
FROM web_events w 
JOIN accounts a
ON w.account_id = a.id
GROUP BY 1,2
HAVING a.name = (
	SELECT name
	FROM (SELECT a.name, SUM(o.total_amt_usd) AS total_spent
		FROM accounts a 
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1 ) most_usd )


''' Q5
What is the lifetime average amount spent in terms of total_amt_usd 
for the top 10 total spending accounts?
( ie: the avg total_amt_usd of the top 10 '''


# top 10 total spend
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a 
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

# avg the total spent
SELECT AVG(total_spent)
FROM (SELECT a.name, SUM(o.total_amt_usd) AS total_spent
	FROM accounts a 
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10) top_10


''' Q6
What is the lifetime average amount spent in terms of total_amt_usd for only 
the companies that spent more than the average of all orders.'''


# avg of all orders
SELECT AVG(total_amt_usd) AS avg_all
FROM orders 

# companies that spent more than the average of all orders
SELECT a.name, AVG(o.total_amt_usd)
FROM accounts a 
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT avg_all
								FROM (SELECT AVG(total_amt_usd) AS avg_all
									FROM orders ) temp)

# avg these companies
SELECT AVG(avg)
FROM(SELECT a.name, AVG(o.total_amt_usd)
	FROM accounts a 
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1
	HAVING AVG(o.total_amt_usd) > (SELECT avg_all
								FROM (SELECT AVG(total_amt_usd) AS avg_all
									FROM orders ) temp)
	) avg_table


## =========================================================================
# WITH Quizzes

''' Q1
Provide the name of the sales_rep in each region with the largest 
amount of total_amt_usd sales.'''

# t1 = rep_name | region | max of usd
# t2 = region | max of usd
# final = join t1 and t2

WITH 
t1 AS (
	SELECT s.name AS rep_name, r.name AS region_name, 
		MAX(o.total_amt_usd)
	FROM region r  
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1,2),

t2 AS (
	SELECT r.name AS region_name, 
		MAX(o.total_amt_usd)
	FROM region r  
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1)

SELECT *
FROM t1 
JOIN t2
ON t1.region_name = t2.region_name
	AND t1.max = t2.max


''' Q2
For the region with the largest (sum) of sales total_amt_usd, how many 
total (count) orders were placed? '''

# t1: find the region
# final: count the order of that region

WITH 
t1 AS (
	SELECT r.name AS region_name, 
		SUM(o.total_amt_usd)
	FROM region r  
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a 
	ON s.id = a.sales_rep_id
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1)


SELECT r.name AS region_name, 
		COUNT(o.total_amt_usd)
FROM region r  
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
GROUP BY 1
HAVING r.name = (SELECT region_name
				 FROM t1)


''' Q3
For the name of the account that purchased the most (in total over their 
lifetime as a customer) standard_qty paper, how many accounts have more 
total purchases than this account? '''

# find the total purchases of the account that has the most std_qty
# use that number as condition

WITH 
t1 AS (
	SELECT a.name, SUM(o.standard_qty), SUM(o.total) AS total
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1
),

t2 AS (
	SELECT a.name, SUM(o.total) 
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT total
						   FROM t1)
)

SELECT COUNT(*)
FROM t2


''' Q4
For the customer that spent the most (in total over their lifetime as a
customer) total_amt_usd, how many web_events did they have for each channel?'''

# find the name of the customer who spent the most usd
# find the web_event for each channel of that customer

WITH
t1 AS (
	SELECT a.name, SUM(total_amt_usd) 
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1
)

SELECT a.name, w.channel, COUNT(*)
FROM web_events w 
JOIN accounts a 
ON w.account_id = a.id
GROUP BY 1,2
HAVING a.name = (SELECT name FROM t1)
ORDER BY 3 DESC


''' Q5
What is the lifetime average amount spent in terms of total_amt_usd 
for the top 10 total spending accounts?
( ie: the avg total_amt_usd of the top 10 '''

# find the top 10 total spending account
# avg them

WITH 
t1 AS (
	SELECT a.name, SUM(total_amt_usd) 
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
)

SELECT AVG(sum)
FROM t1


''' Q6
What is the lifetime average amount spent in terms of total_amt_usd for only 
the companies that spent more than the average of all orders.'''

# find the avg of all orders
# find the company that spend more
# avg them

WITH
t1 AS (
	SELECT AVG(total_amt_usd)
	FROM orders
),

t2 AS (
	SELECT a.name, AVG(o.total_amt_usd) AS total_spent
	FROM accounts a 
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1
	HAVING AVG(o.total_amt_usd) > (SELECT avg FROM t1)
)

SELECT AVG(total_spent)
FROM t2