## Update basice command in joints cases

'SELECT'
# with using joint, it means we will call 2 or more tables in a same query
# 	therefore, we need to identify which table we want the column from
#	The table name is always before the period, 
#	The column you want from that table is always after

# 	formate: SELECT tab_name. col_name / tab_name.* (*: all the cols)

# eg.
SELECT orders.*  # pull all col from orders table
SELECT *         # pull all col from all table 
SELECT orders.id # pull id col from orders table


'FROM'
#	formate: FROM tab_name


'JOIN'
#	the table want to be join

#	formate: JOIN tab_name

'ON'
#	how to merge the tables (the link)
#	(which col in which table, to match which col in another)
#	always have the primary key(PK) equal to the foreign key(FK)

#	can add AND + condition to subset the table 
#	(kinda like WHERE, but before the merge table, pre filter the data)
#	(think of WHERE is executed after the JOIN table is done)

#	formate: ON tab1_name.col_name = tab2_name.col_name

# eg. join 2 tables (orders, accounts)
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
	AND accounts.sales_rep_id = 1234 # pre filter the account table
									 # so that only contain sales_rep_id = 1234
									 # then do the join   

# eg. join 3 tables (web_events, accounts, orders)
SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id


'AS'
# (can be reduce and use ' ' blank)
#	give alias for table or column
#	when use for table, the whole query can use the alias name for that table
#	when use for column, the alias name will replace the corresponding 
#		output table's column 

#	formate: FROM table_name AS t1
#	formate: FROM table_name t1

# eg.

SELECT col1 + col2 AS total # total will show up at the result

SELECT t1.column1 aliasname1, t2.column2 aliasname2 
	# as table1 and table2 have been call as t1 and t2, and used this in SELECT
	# aliasname1 and aliasname2 will show up at the result
FROM tablename AS t1  
JOIN tablename2 AS t2

##=============================================================================
########################################
###### INNER JOIN vs OUTER JOIN  #######
########################################
'http://joins.spathon.com/'

'                 TABLE A      TABLE B               
               [ ------- ]   [ -- X -- ] --\ -------\ 
               [         ]   [    X    ]    |        |
               [         ]   [    X    ]  right Outer|
               [         ]   [    X    ]    |        |
     /---- /---[ -- X -- ]   [ -- X -- ]    |     FULL OUTER
    |   Inner  [    X    ]   [    X    ]    |        |
    |      \---[ -- X -- ]   [ -- X -- ]---/         |
 Left Outer    [    X    ]   [         ]             |
    |          [    X    ]   [         ]             |
    |          [    X    ]   [         ]             |
     \---------[ -- X -- ]   [ ------- ]------------/
'

FROM Table_A
JOIN Table_B
ON Table_A.column_name = Table_B.column_name

# Table_A calls left table (with FROM)
# Table_B calls right table (with JOIN)

## INNER JOIN
  SELECT column_name(s)
  FROM Table_A
  INNER JOIN Table_B 
  ON Table_A.column_name = Table_B.column_name;


## OUTER JOIN
#	add LEFT (OUTER) or RIGHT (OUTER) in front of the JOIN 	

#	left join: keep the info of left table, add  info of right table accordingly
#	right join: keep the info of right table, add  info of right table accordingly 

# LEFG JOIN
  SELECT column_name(s)
  FROM Table_A
  LEFT JOIN Table_B 
  ON Table_A.column_name = Table_B.column_name;

# RIGHT JOIN
  SELECT column_name(s)
  FROM Table_A
  RIGHT JOIN Table_B 
  ON Table_A.column_name = Table_B.column_name;

# FULL OUTER JOIN
#   FULL JOIN is commonly used in conjunction with aggregations 
#   to understand the amount of overlap between two tables.
  SELECT column_name(s)
  FROM Table_A
  FULL OUTER JOIN Table_B 
  ON Table_A.column_name = Table_B.column_name;


# wanted to return unmatched rows only (!= inner join)
  SELECT column_name(s)
  FROM Table_A
  FULL OUTER JOIN Table_B 
  ON Table_A.column_name = Table_B.column_name
  WHERE Table_A.column_name IS NULL OR Table_B.column_name IS NULL



## Self JOINs

#   One of the most common use cases for self JOINs is in cases where 
#   two events occurred, one after another. 

# eg. interval analysis: the orders occurred within 28 days

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

ORDER BY o1.account_id, o1.occurred_at

# explain:
#   o1: original table, 
#   o2: show the order which within 28 days after the order in o1 



'UNION' / 'UNION ALL'
#   Appending Data
#   combine the result-set of two or more SELECT statements

#   The UNION operator selects only distinct values by default. 
#   To allow duplicate values, use UNION ALL

#   rule of appending data:
#     * both tables must have the same number of columns
#     * Those columns must have the same data types in the same 
#       order as the first table

#   > Column names don't need to be the same, but in most case, they are

# format:
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2; 