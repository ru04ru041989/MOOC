# What is subquery?
#	write a query that creates a table or a single value, 
#	and then write a query that interacts with this newly created table/value.

#	When there is no direct answer working with existing tables in database

## Subquery Formatting
#	for easy read: 
#		easily determine which parts of the query will be executed together
#	

#	case1: the 1st query return a table, 2nd can use this table with FROM
#	case2: ...................... value, 2nd can use this value as a condition
#								   with WHERE, HAVING ....

#	in case1, need to alias the column name for the 2nd query
# 	in case2, no need to alias the value, since only has one value

## ==========================================================================

# eg. case1: [1st query return a table]
#	task: find the average number of events for each day for each channel.
#		
#		first query: provide the number of events for each day and channel
#		next query: average these values together

SELECT channel,
	DATE_TRUNC('day', occurred_at) AS day,
	COUNT(*) AS event_num
FROM web_events
GROUP BY 1,2

# this is the first query which return a table
# then use this table for the second query

SELECT channel, day, AVG(event_num)
FROM(
	SELECT channel,
		DATE_TRUNC('day', occurred_at) AS day,
		COUNT(*) AS event_num
	FROM web_events
	GROUP BY 1,2
	) sub
GROUP BY 1,2

#		the column in 2nd query depends on the column name in 1st query

## =========================================================================

# eg. case2: [1st query return a single value]
#	task: return the orders that occurred in the same month as first order
#
#		first query: get the month of the first order
#		next query: use this value as condition to filter

SELECT DATE_TRUNC('month',MIN(occurred_at))
FROM orders

# this is the first query which return the month of the first order
# then use this value to filter

SELECT *
FROM orders
WHERE DATE_TRUNK('month',occurred_at) = 
	(SELECT DATE_TRUNC('month',MIN(occurred_at))
	FROM orders)

## ========================================================================

# more complex

# eg. nest subquery 

#	task: top channel used by each account and how often that channel was used

#		think: the ending query:
#			account id | channel | Max(count(event))
#		
#		> the intermediate table:
#			account id | channel | count(event)

#		then return the pair where (channel, event_count) is MAX with each ID

# query for intermediate table: (t1)
SELECT a.id, a.name, w.channel, COUNT(*) event_num
FROM accounts a 
JOIN web_events w 
ON a.id = w.account_id
GROUP BY 1,2,3
ORDER BY 2

# this will return table like this:
'	 id   |  name  | channel | event_num
	1921	  3M		FB	        2
	1923	  3M	  dirrct	   19
	2371	Ab lab    direct	   20
	2371	Ab lab    organic       1   	' 

# then nested the intermediate table to get the max

# query for getting max event_count: (t2)
SELECT t1.id, t1.name, MAX(event_num)
FROM (SELECT a.id, a.name, w.channel, COUNT(*) event_num
	FROM accounts a 
	JOIN web_events w 
	ON a.id = w.account_id
	GROUP BY 1,2,3
	) AS t1
GROUP BY 1,2
ORDER BY 2

# this will return table like this:
'	 id   |  name  | max
	1921	  3M	  19
	2371	Ab lab    20
	2221	AbbVie	  2	   ' 

# ps:
#	if we including channel and groupby it in this query
#	it will return the same table as intermediate one
#	since the channel is unique if we groubby with it

# now, we need to mach t1 and t2
#	JOIN the id and name match, and where (the count in t1) = (max in t2)

SELECT t3.id, t3.name, t3.channel, t3.event_num

FROM (SELECT a.id, a.name, w.channel, COUNT(*) event_num
	FROM accounts a 
	JOIN web_events w 
	ON a.id = w.account_id
	GROUP BY 1,2,3
	) AS t3

JOIN (SELECT t1.id, t1.name, MAX(event_num)
	FROM (SELECT a.id, a.name, w.channel, COUNT(*) event_num
		FROM accounts a 
		JOIN web_events w 
		ON a.id = w.account_id
		GROUP BY 1,2,3
		) AS t1
	GROUP BY 1,2) AS t2

ON t3.id = t2.id
	AND t2.max = t3.event_num

ORDER BY 2

# this will return table like this:
'	 id   |  name  | channel | event_num
	1923	  3M	  dirrct	   19
	2371	Ab lab    direct	   20
	2221	AbbVIe    direct        2   	' 

# ps:
#	t2 is a subquery with t1, and we nested it in JOIN for JOIN t1 and t2.
#	since t1 has been use in t2's subquery, we need to alais t3 when refering it

## =========================================================================

'WITH'
#	Common Table Expression or CTE

#	above, we put subqueries in the query
#	with 'WITH' we can run this subquery out side and name the table,
#		then run the final query with the table return from query using 'WITH'

#	formate: WITH name_of_table AS (query)

#	place: before the final query, need to run the WITH part then final query

#	can creat more than one subquery table with one 'WITH'
#	seperate each table with ','
#		eg.
			WITH table1 AS (
          			SELECT *
          			FROM web_events),

     			 table2 AS (
         		 	SELECT *
          			FROM accounts)


# eg.

# using subqueries:
SELECT channel, day, AVG(event_num)
FROM(
	SELECT channel,
		DATE_TRUNC('day', occurred_at) AS day,
		COUNT(*) AS event_num
	FROM web_events
	GROUP BY 1,2
	) sub
GROUP BY 1,2


# using 'WITH'
WITH events AS (SELECT channel,
		DATE_TRUNC('day', occurred_at) AS day,
		COUNT(*) AS event_num
	FROM web_events
	GROUP BY 1,2)

SELECT channel, day, AVG(event_num)
FROM events
GROUP BY 1,2