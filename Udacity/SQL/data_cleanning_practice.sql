# LEFT & RIGHT Quizzes

''' Q1
In the accounts table, there is a column holding the website for each company. 
The last three digits specify what type of web address they are using.Pull these 
extensions and provide how many of each website type exist in the 
accounts table.'''

# pull the extension
# group them with company

SELECT RIGHT(website, 3) AS webtype, COUNT(*) n_company
FROM accounts
GROUP BY 1


''' Q2
There is much debate about how much the name matters. Use the accounts table 
to pull the first letter of each company name to see the distribution of 
company names that begin with each letter (or number). '''


SELECT LEFT(name, 1) AS initial_comp_name, COUNT(*) initial
FROM accounts
GROUP BY 1
ORDER BY 1


''' Q3
Use the accounts table and a CASE statement to create two groups: one group of 
company names that start with a number and a second group of those company names 
that start with a letter. What proportion of company names start with a letter?'''

# group company by their initial
# count

WITH t1 AS(
	SELECT name,
		CASE WHEN LEFT(name, 1) IN ('0','1','2','3','4','5','6','7','8','9') 
			THEN 1
			ELSE 0 END AS initial_is_num
	FROM accounts
)


SELECT COUNT(name) AS total_n, SUM(initial_is_num),
	COUNT(name) - SUM(initial_is_num) AS initial_is_letter
FROM t1


''' Q4
Consider vowels as a, e, i, o, and u. What proportion of company names start 
with a vowel, and what percent start with anything else?'''

WITH t1 AS(
	SELECT name,
		CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
			THEN 1
			ELSE 0 END AS initial_is_vowel
	FROM accounts
)


SELECT COUNT(name) AS total_n, SUM(initial_is_vowel),
	COUNT(name) - SUM(initial_is_vowel) AS initial_not_vowel
FROM t1

## ============================================================================
# Quizzes POSITION & STRPOS

''' Q1
Use the accounts table to create first and last name columns that hold 
the first and last names for the primary_poc.''' 

SELECT primary_poc,
    LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
                             
FROM accounts


''' Now see if you can do the same thing for every rep name in the sales_reps table. 
Again provide first and last name columns.'''

SELECT name,
    LEFT(name, STRPOS(name, ' ') -1) AS first_name,
    RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name
                             
FROM sales_reps


## ============================================================================
# Quizzes CONCAT

''' Q1
Each company in the accounts table wants to create an email address for each 
primary_poc. The email address should be the first name of the 
primary_poc . last name primary_poc @ company name .com.'''

WITH name_table AS (
	SELECT name, primary_poc,
    	LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) AS first_name,
    	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
                             
	FROM accounts
)

SELECT CONCAT(first_name, '.', last_name,'@', name, '.com')
FROM name_table


''' Q2
See if you can create an email address that will work by removing 
all of the spaces in the account name'''

# use 'REPLACE' to replace ' ' (blank) to '' (no blank)

WITH name_table AS (
	SELECT 
		REPLACE(name,' ','') AS name,
    	LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) AS first_name,
    	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
                             
	FROM accounts
)

SELECT first_name, last_name,
	CONCAT(first_name, '.', last_name,'@', name, '.com') AS email
FROM name_table


''' Q3
We would also like to create an initial password, which they will change after 
their first log in. The first password will be the first letter of the 
primary_poc''s first name (lowercase), then the last letter of their 
first name (lowercase), the first letter of their last name (lowercase), 
the last letter of their last name (lowercase), the number of letters in their 
first name, the number of letters in their last name, and then the name of the 
company they are working with, all capitalized with no spaces. '''

WITH name_table AS (
	SELECT 
		REPLACE(name,' ','') AS name,
    	LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) AS first_name,
    	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
                             
	FROM accounts
)

SELECT first_name, last_name,
	CONCAT(first_name, '.', last_name,'@', name, '.com') AS email,
	CONCAT(
		LOWER( 
		LEFT(first_name,1) || RIGHT(first_name,1) || 
		LEFT(last_name,1) || RIGHT(last_name,1) ||
		LENGTH(first_name) ||LENGTH(last_name)) ,
		UPPER (name)
		) AS password
FROM name_table


## =============================================================================
# CAST Quizzes

# working with another data set (sf_crime_data)
# https://classroom.udacity.com/courses/ud198/lessons/03f64082-fa4d-4aff-80be-d48597867e07/concepts/a9de2023-ae43-4781-a5c5-050bf5c33dd9

''' Q1
look at the top 10 row to understand the dataset '''

SELECT *
FROM sf_crime_data
LIMIT 10


''' Q2
change the date into the correct SQL date format '''

# original format: 01/31/2014 08:00:00 AM +0000

SELECT date orig_date
	CONCAT(
      SUBSTR(date,7,4), '-',
      SUBSTR(date,1,2), '-',
      SUBSTR(date,4,2)
    ) :: date AS new_date
FROM sf_crime_data
LIMIT 10


## =============================================================================
# COALESCE Quizzes

'use LEFT JOIN to combine accounts and order table base on accounts table'

SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


'fill in the accounts.id with the account.id'

SELECT COALESCE(a.id, a.id) filled_id, 
	a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
	o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


'fill in the orders.account_id with account.id'
SELECT COALESCE(a.id, a.id) filled_id, 
		a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
	COALESCE(o.account_id, a.id) account_id, 
		o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, 
		o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, 
		o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


'fill qty and usd to 0'
SELECT COALESCE(a.id, a.id) filled_id, 
		a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, 
	COALESCE(o.account_id, a.id) account_id, 
		o.occurred_at, 
		COALESCE(o.standard_qty, 0) standard_qty, 
		COALESCE(o.gloss_qty,0) gloss_qty, 
		COALESCE(o.poster_qty,0) poster_qty, 
		COALESCE(o.total,0) total, 
		COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
		COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
		COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
		COALESCE(o.total_amt_usd,0) total_amt_usd

FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;