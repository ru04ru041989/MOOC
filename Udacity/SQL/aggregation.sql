'NULLs'
#	a datatype: specifies where no data exists in SQL
#	often ignored in aggregation function
#	could occur when performing OUTER JOIN

#	WHERE col_name IS NULL / IS NOT NULL
#		> to get the rows which contain NULL / NOT NULL data in that column


'COUNT'
#	count the number of rows in a table
#	add COUNT after SELECT, and call it as a function
#	can also use alias to it

#	formate: SELECT COUNT(*)
#	tip: quickly identifying which rows have missing data

# eg.
SELECT COUNT(*)    			# count all the row which has data
SELECT COUNT(accounts.id)   # count all the row in col id which has data

SELECT COUNT(*) AS account_count  # alias a new name to this count result


'SUM'
#	sum up numeric columns
#	add SUM after SELECT, and call it as a function
#	can use alias

#	formate: SELECT SUM(col_name)

# eg.
SELECT SUM(standard_qty) AS standard


'MIN / MAX'
#	return min or Max value of the column
#	same as COUNT


'AVG'
#	return mean of the given column
#	same as SUM


'GROUP BY'
#	aggregate data within subsets of the data
#		ie: grouping for different accounts, different regions...

#	* important!!
#	Any column in the SELECT statement that is not within an aggregator 
#		must be in the GROUP BY clause
#	can group by more than one column

#	place: always goes between WHERE and ORDER BY.

# eg.

SELECT account_id, 
	SUM(standard_qty) AS standard_sum,
	SUM(gloss_qty) AS gloss_sum,
	SUM(poster_qty) AS poster_sum

FROM orders
GROUP BY account_id 
	# noticed that only account_id is not in aggration function


'DISTINCT'
#	provides the unique rows for all columns written in the SELECT statement
#	always used in SELECT statements

#	formate: SELECT DISTINCT column1, column2, column3

# eg.
SELECT DISTINCT column1, column2, column3
FROM table1;


'HVAING'
#	the “clean” way to filter a query that has been aggregated

#	* tip:
#	any time you want to perform a WHERE on an element of your query that 
#	was created by an aggregate, you need to use HAVING instead

#	place: after GROUP BY, before ORDER BY

#	formate: same as WHERE


' time in SQL' 
# storage formate: yyyy-mm-dd hh:mm:ss

#	using SQL time function to help as to groupby in larger period than second

	'DATE_TRUNC'
	#	truncate your date to a particular part of your date-time column
	#	set to the very first of the given part of the time period
	#	Common trunctions are day, month, and year

	#	formate: DATE_TRUNC('trunctions ', time col)

	# eg.
	DATE_TRUNC('second', 2017-0401 12:15:01) -> 2017-0401 12:15:01
	DATE_TRUNC('day', 2017-0401 12:15:01) -> 2017-0401 00:00:00
	DATE_TRUNC('year', 2017-0401 12:15:01) -> 2017-0101 00:00:00


	'DATE_PART'
	#	pulling a specific portion of a date

	#	* importane:
	#		if pull out month for 2018-0401 and 2017-0401, both will return 4
	#		ie: discard other date infor, only keep the part 
	#		have been pull out

	# 	formate: DATE_PART('part of the day ', time col)
	#		part of the day:
	#			dow = day of week {0:w7, 1:w1, 2:w2, ... 6:w6}

	# eg.
	DATE_PART('second', 2017-0401 12:15:01) -> 1
	DATE_PART('day', 2017-0401 12:15:01) -> 1
	DATE_PART('month', 2017-0401 12:15:01) -> 4
	DATE_PART('year', 2017-0401 12:15:01) -> 2017


'CASE'
#	must include the following components: 
#		WHEN, THEN, (ELSE) and END
#		(like the if statement in python)
#		WHEN = if/ elif, THEN = (code when if = True), 
#		ELSE = else, END = finish of the if statement

#	can combine conditioal operator

#	place: always goes in the SELECT clause

#	formate: WHEN .... THEN ... END

# eg.
# 	solving when denominator might contain 0

SELECT account_id, 
	CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
    	ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;