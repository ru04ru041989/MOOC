## using SELECT, JOIN, ON

''' Q1
Try pulling all the data from the accounts table, 
and all the data from the orders table.'''

SELECT *
FROM accounts
JOIN orders
ON orders.account_id = accounts.id


''' Q2
Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, 
and the website and the primary_poc from the accounts table.'''

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty
	accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

## ===========================================================================

''' Q1
Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. Be sure to include the primary_poc, 
time of the event, and the channel for each event. Additionally, you might choose 
to add a fourth column to assure only Walmart events were chosen.'''

SELECT web.channel, web.occurred_at AS time_of_the_event, 
	a.primary_poc, a.name
FROM web_events AS web
JOIN accounts AS a
ON web.account_id = a.id
WHERE a.name = 'Walmart'


''' Q2
QProvide a table that provides the region for each sales_rep along with their 
associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.'''


SELECT r.name AS region_name,
	sales.name AS sales_name,
	a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS sales
ON a.sales_rep_id = sales.id
JOIN region as r
ON sales.region_id = r.id
ORDER BY a.name 


''' Q3
Provide the name for each region for every order, as well as the 
account name and the unit price they paid (total_amt_usd/total) for the order. 
Your final table should have 3 columns: region name, account name, and unit price. 
A few accounts have 0 for total, so I divided by (total + 0.01) to assure 
not dividing by zero.'''


SELECT r.name AS region_name,
	a.name AS account_name,
	o.total_amt_usd / (o.total + 0.01) AS unit_price

FROM region AS r
JOIN sales_reps AS sales
ON r.id = sales.region_id
JOIN accounts AS a
ON sales.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id


## ==========================================================================

''' Q1
Provide a table that provides the region for each sales_rep along with 
their associated accounts. This time only for the Midwest region. 
Your final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
according to account name.'''

SELECT r.name AS region_name,
	s.name AS sales_name,
	a.name AS account_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name


''' Q2
same as Q1, but adding one more condition:
	the sales rep has a first name starting with S
'''

SELECT r.name AS region_name,
	s.name AS sales_name,
	a.name AS account_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
	AND s.name LIKE 'S%'
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name


''' Q3
same as Q1, but adding one more condition:
	the sales rep has a last name starting with K
'''

SELECT r.name AS region_name,
	s.name AS sales_name,
	a.name AS account_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
	AND s.name LIKE '% K%'
JOIN accounts AS a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name


''' Q4
Provide the name for each region for every order, as well as the account name 
and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity 
exceeds 100. Your final table should have 3 columns: region name, account name, 
and unit price. In order to avoid a division by zero error, adding .01 to the 
denominator here is helpful total_amt_usd/(total+0.01).'''

SELECT r.name AS region_name,
	a.name AS account_name,
	o.total_amt_usd / (o.total + 0.01) AS unit_price

FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
	AND o.standard_qty > 100


''' Q5
same as Q4, but adding one more condition:
	the poster order quantity exceeds 50,
Sort for the smallest unit price first.
'''

SELECT r.name AS region_name,
	a.name AS account_name,
	o.total_amt_usd / (o.total + 0.01) AS unit_price

FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
	AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price 


''' Q6
same as Q4, but adding one more condition:
	the poster order quantity exceeds 50,
Sort for the largest unit price first.
'''

SELECT r.name AS region_name,
	a.name AS account_name,
	o.total_amt_usd / (o.total + 0.01) AS unit_price

FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id
	AND o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC



''' Q7
What are the different channels used by account id 1001? Your final table should 
have only 2 columns: account name and the different channels. You can try 
SELECT DISTINCT to narrow down the results to only the unique values.'''

SELECT DISTINCT a.name, w.channel
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
	AND a.id = 1001


''' Q8
Find all the orders that occurred in 2015. Your final table should have 
4 columns: occurred_at, account name, order total, and order total_amt_usd.'''

SELECT a.name,
	o.occurred_at AS order_time,
	o.total As order_total,
	o.total_amt_usd
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
	AND o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'



## ==========================================================================
# FULL OUTER JOIN

''' 
* each account who has a sales rep and each sales rep that has an account 
	(all of the columns in these returned rows will be full)
* but also each account that does not have a sales rep and each sales rep 
	that does not have an account (some of the columns in these returned rows 
	will be empty)

write a query with FULL OUTER JOIN to fit the above described Parch & Posey 
scenario (selecting all of the columns in both of the relevant tables, 
accounts and sales_reps). '''

SELECT a.id AS account_id, s.id AS rep_id 
FROM accounts a 
FULL OUTER JOIN sales_reps s 
ON a.sales_rep_id = s.id

SELECT a.id AS account_id, s.id AS rep_id 
FROM accounts a 
FULL OUTER JOIN sales_reps s 
ON a.sales_rep_id = s.id
WHERE a.sales_rep_id IS NULL OR s.id IS NULL


## ==========================================================================
# JOINs with Comparison Operators

''' 
In the following SQL Explorer, write a query that left joins the accounts
 table and the sales_reps tables on each sale rep''s ID number and joins it 
 using the < comparison operator on accounts.primary_poc and sales_reps.name, 
 like so: accounts.primary_poc < sales_reps.name 

 The query results should be a table with three columns: the account name 
 (e.g. Johnson Controls), the primary contact name (e.g. Cammy Sosnowski), 
 and the sales representative''s name (e.g. Samuel Racine).  '''

SELECT a.name as account_name, a.primary_poc, s.name as rep_name
FROM accounts a 
LEFT JOIN sales_reps s 
ON a.sales_rep_id = s.id
	AND a.primary_poc < s.name


## ==========================================================================
# Self JOINs

''' Modify the query below, to perform the same interval analysis except for 
the web_events table, Also:

	change the interval to 1 day to find web events that occur within one 
	after another within one day
	add a column for the channel variable in both instances of the table

SELECT o1.id AS o1_id,
       o1.account_id AS o1_account_id,
       o1.occurred_at AS o1_occurred_at,
       o2.id AS o2_id,
       o2.account_id AS o2_account_id,
       o2.occurred_at AS o2_occurred_at
  FROM orders o1
 LEFT JOIN orders o2
   ON o1.account_id = o2.account_id
  AND o2.occurred_at > o1.occurred_at
  AND o2.occurred_at <= o1.occurred_at + INTERVAL '28 days'
ORDER BY o1.account_id, o1.occurred_at 							'''


SELECT w1.id AS w1_id,
       w1.account_id AS w1_account_id,
       w1.occurred_at AS w1_occurred_at,
       w1.channel AS w1_channel,
       w2.id AS w2_id,
       w2.account_id AS w2_account_id,
       w2.occurred_at AS w2_occurred_at,
       w2.channel AS w2_channel

FROM web_events w1
LEFT JOIN web_events w2
ON w1.account_id = w2.account_id
  AND w2.occurred_at > w1.occurred_at
  AND w2.occurred_at <= w1.occurred_at + INTERVAL '1 days'

ORDER BY w1.account_id, w1.occurred_at


## ==========================================================================
# UNION

''' Write a query that uses UNION ALL on two instances 
(and selecting all columns) of the accounts table. '''

SELECT * FROM accounts
UNION
SELECT * FROM accounts
----------------------------------------------
SELECT * FROM accounts
UNION All
SELECT * FROM accounts


''' filtering the first table where name equals Walmart and 
filtering the second table where name equals Disney'''

SELECT * FROM accounts
WHERE name = 'Walmart'
UNION
SELECT * FROM accounts
WHERE name = 'Disney'
----------------------------------------------
SELECT * FROM accounts
WHERE name = 'Walmart'
UNION ALL
SELECT * FROM accounts
WHERE name = 'Disney'


''' Perform the union in your first query (under the Appending Data via 
UNION header) in a common table expression and name it double_accounts. 
Then do a COUNT the number of times a name appears in the double_accounts 
table. If you do this correctly, your query results should have a count of 
2 for each name.'''

With double_accounts AS (
SELECT * FROM accounts
UNION All
SELECT * FROM accounts)

SELECT name, COUNT(*)
FROM double_accounts
GROUP BY name
