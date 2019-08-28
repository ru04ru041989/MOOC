# Window Functions

'''
create a running total of standard_amt_usd (in the orders table) over order 
time with no date truncation. Your final table should have two columns: 
one with the amount being added for each new row, and a second with the 
running total.'''

SELECT 
	standard_amt_usd,
	SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total

FROM orders


'''
Now, modify your query from the previous quiz to include partitions.
date truncate occurred_at by year and partition by that same year-truncated 
occurred_at variable. Your final table should have three columns: 
One with the amount being added for each row, one for the truncated date, 
and a final columns with the running total within each year. '''

SELECT 
	standard_amt_usd,
	DATE_TRUNC('year', occurred_at) AS year,
	SUM(standard_amt_usd) OVER w AS running_total

FROM orders
WINDOW w AS (PARTITION BY DATE_TRUNC('year', occurred_at) 
			ORDER BY occurred_at


## =============================================================================
# Quiz: ROW_NUMBER & RANK

''' Ranking Total Paper Ordered by Account
Select the id, account_id, and total variable from the orders table, then create 
a column called total_rank that ranks this total amount of paper ordered 
(from highest to lowest) for each account using a partition. 
Your final table should have these four columns.'''

SELECT id, account_id, total,
	RANK() OVER(PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders


## =============================================================================
# Quiz: Comparing a Row to Previous Row

''' how the current order''s total revenue (i.e. from sales of all types of 
paper) revenue compares to the next order''s total revenue. '''


SELECT
	occurred_at, total_amt_usd,
	LEAD(total_amt_usd) OVER(ORDER BY occurred_at) AS lead,
	LEAD(total_amt_usd) OVER(ORDER BY occurred_at) - total_amt_usd 
		AS lead_difference

FROM (
	SELECT occurred_at, SUM(total_amt_usd) AS total_amt_usd
	FROM orders
	GROUP BY 1
	) sub


## =============================================================================
# Quiz: Percentiles with Partitions

''' Q1
Use the NTILE functionality to divide the accounts into 4 levels in terms of 
the amount of standard_qty for their orders. Your resulting table should have 
the account_id, the occurred_at time for each order, the total amount of 
standard_qty paper purchased, and one of four levels in a 
standard_quartile column. '''

SELECT account_id, occurred_at, standard_qty,
	NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty)
		AS standard_quartile

FROM orders
ORDER BY account_id DESC


''' Q2
Use the NTILE functionality to divide the accounts into two levels in terms 
of the amount of gloss_qty for their orders. Your resulting table should have 
the account_id, the occurred_at time for each order, the total amount of 
gloss_qty paper purchased, and one of two levels in a gloss_half column. '''

SELECT account_id, occurred_at, gloss_qty,
	NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty)
		AS gloss_half

FROM orders
ORDER BY account_id DESC


''' Q3
Use the NTILE functionality to divide the orders for each account into 100 
levels in terms of the amount of total_amt_usd for their orders. Your 
resulting table should have the account_id, the occurred_at time for each 
order, the total amount of total_amt_usd paper purchased, and one of 100 
levels in a total_percentile column.'''

SELECT account_id, occurred_at, total_amt_usd,
	NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd)
		AS total_percentile

FROM orders
ORDER BY account_id DESC

