## window function

'https://www.postgresql.org/docs/9.1/static/tutorial-window.html'


'LAG' / 'LEAD' function

#	It returns the value from a previous / following row to the current row 
#	in the table

#	format: LAG(column_name) OVER (ORDER BY column_name) AS lag

# eg. LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
# eg. LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead

'	id	   |   standard_sum		|		lag 	| 	   lead
   1901			    0 				   NULL				79
   3371			   79				    0			   102
   1961			  102				   79			   NULL       '



SELECT 
	account_id, 
	standard_sum, 

	LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
	standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) 
		AS lag_difference,

	LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
	LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum 
		AS lead_difference

FROM   (
        SELECT   account_id, SUM(standard_qty) AS standard_sum
        FROM     orders
        GROUP BY 1
       ) sub




'NTILE'

#	integer ranging from 1 to the argument value, 
#	dividing the partition as equally as possible

#	format: NTILE(*# of buckets*)
#		ORDER BY determines which column to use to determine the quartiles