# Amicable numbers

'''
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
'''


import math

def sum_proper_divisor(n):
    limit = int(math.sqrt(n))
    divisors_list = []
    for i in range(1, limit+1, 1):
        if n % i == 0:
            divisors_list.append(i)
            if i != n/i:
                divisors_list.append(int(n/i))
    return sum(divisors_list) -n


amicable_list = set()
for i in range(1,10001):
	if i not in amicable_list:
		d_i = sum_proper_divisor(i)
		if i == sum_proper_divisor(d_i) and d_i <= 10000 and i != d_i:
			amicable_list.add(i)
			amicable_list.add(d_i)

print(amicable_list)
print(sum(amicable_list))



