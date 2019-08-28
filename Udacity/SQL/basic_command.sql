'SELECT' 
#	what columns you want back (SELECT * : get all columns)
#	col1 +/-/*/ col2 to create new column, add AS new_col_name for this new column
#	the new column name after AS does not need single quotation mark

'FROM'
#	what table querying from

# eg.
SELECT columns1_name, columns2_name
FROM table_name

SELECT columns1_name, columns2_name,
	columns1_name + columns2_name AS col1_add_col2
FROM table_name


'LIMIT'
#	return n rows from the query
#	place: usually, limit comman should be at the last one

# eg.
SELECT columns1_name, columns2_name
FROM table_name
LIMIT 15            # return first 15 rows


'ORDER BY'
#	column_name you want to order
#	place: after SELECT and FROM
#	can add DESC after the column to sort descending order

# eg.
SELECT columns1_name, columns2_name
FROM table_name
ORDER BY columns1_name DESC
LIMIT 15 


'WHERE'
#	column_name + condition
#	place: after FROM, JOIN and ON, before GROUP BY, ORDER BY

#	!=: not equal
#	can compare string (in ' ') or number

#	* important
#	do not work with aggregated column, need to use HAVING

# eg.
SELECT columns1_name, columns2_name
FROM table_name
WHERE columns1_name = 1333


SELECT columns1_name, columns2_name
FROM table_name
WHERE columns1_name = '2015-Jan-23'


## ===============================================
## Logical Operators
## ===============================================

'LIKE / NOT LIKE'
#	This allows you to perform operations similar to using WHERE and =, 
#	but for cases when you might not know exactly what you are looking for.

#	use LIKE within a WHERE clause
#	frequently used with %
#	need to use single quotes for the text

# eg.
SELECT columns1_name, columns2_name
FROM table_name
WHERE columns1_name LIKE '%google%'  # return any string contain google


'IN / NOT IN'
#	This allows you to perform operations similar to using WHERE and =, 
#	but for more than one condition.

#	working with both numeric and text (text with single quotes)
#	pull data from particular column for <=1 items
#	usiage formate IN (item1, item2)

# eg.
SELECT columns1_name
FROM table_name
WHERE columns1_name IN ('id1_name', 'id2_name')


'AND / BETWEEN / OR'
# 	combine logical operations, including LIKE, IN, NOT
#	need to specify the column_name and the condition

#	BETWEEN : used in the case like 
#			( column BETWEEN 6 AND 10)
#			( equal to column >= 6 AND column <= 10)