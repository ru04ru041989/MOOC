## dealing with string
#	https://www.postgresql.org/docs/9.1/static/functions-string.html


'LEFT' / 'RIGHT'

#	pulls a specified number of characters for each row in a specified column 
#	starting at the beginning (from the left) / or at the end (from the right).

#	format: LEFT(colunm, number to extract)
#	formateL RIGHT(colunm, number to extract)

# eg.
'	id |  phone_number
	aa | 1-514-806-9987
	bb | 1-412-734-1256	'

LEFT(phone_number, 5) AS first_5
	> '	id |  first_5
		aa |   1-514
		bb |   1-412		'

RIGHT(phone_number, 12) AS last_12
	> '	id |  last_12
		aa | 514-806-9987
		bb | 412-734-1256	'

# ============================================================================

'LENGTH'

#	provides the number of characters for each row of a specified column
#	case sensitive, (A != a)

#	formate: LENGTH(column)

# ============================================================================

'POSITION' / 'STRPOS'

#	input: a column and a character, 
#	return the index where that character is

#	format: POSITION('character' IN column_name)
#	format: STRPOS(column_name, 'character')

# eg. find the ',' in city_state
POSITION(',' IN city_state)
STRPOS(city_state, ',')

# ============================================================================

'LOWER' / 'UPPER'

#	make all the character lower or uppercase

#	format: LOWER(column_name)

# ============================================================================

'CONCAT' / piping ||

#	combine strings

#	format: CONCAT(column, 'string to combine', column2)
#	format: column || 'string to combine' || column2

# eg. combine first and last name
CONCAT(first_name, ' ', last_name)
first_name || ' ' || last_name

# ============================================================================

'REPLACE'

#	replace character

#	format: REPLACE(column, 'to_replace', 'replace_with')

# eg.
REPLACE('aabbcdae', 'a', 'x')   > 'xxbbcdxe'

# ============================================================================

'TO_DATE'

#	changed a month name into the number associated with that particular month

#	format : TO_DATE(month, 'month')

# ============================================================================

'CAST' / ::
# http://www.postgresqltutorial.com/postgresql-cast/

#	change column types

#	format: CAST(column AS types_to_convert)
#		types: INTEGER, DATE, DOUBLE PRECISION

#	format: expression :: types_to_convert

## ============================================================================
# dealing with NULL
#	https://www.w3schools.com/sql/sql_isnull.asp
#	https://community.modeanalytics.com/sql/tutorial/sql-string-functions-for-cleaning/


'COALESCE'

#	returns the non-NULL value passed for each row and assign value to it
#	useful when assign value to 0 with NULL in numerical column

#	format: COALESCE(column, 'value to replace')

# eg.
COALESCE(primary_poc, 'no POC')

	> to fill 'no POC' to the NULL vales in column primary_poc