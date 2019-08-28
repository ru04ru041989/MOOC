# Even Fibonacci numbers

'''
By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
find the sum of the even-valued terms.
'''

limit = int(input('Enter upper limit: '))

fib_cur, fib_next = 0, 1

ans = 0
while fib_cur + fib_next <= limit: # check if the next fib exceed given limit
	if (fib_cur + fib_next) % 2 == 0: # if the fib is even
		ans += fib_cur + fib_next # add the fib num in answer

	fib_cur, fib_next = fib_next, (fib_cur + fib_next)

print('sum of even fibonacci numbers below {}'.format(limit))
print(ans)

