# Non-abundant sums
'''
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. 
For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 
is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant
 if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written 
as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
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


limit = 28124

# find abundant number list, < 28123
abund_number_ls = []
for i in range(1, limit):
	if i < sum_proper_divisor(i):
		abund_number_ls.append(i)

#print(abund_number_ls)

#print(comb_num_ls)

total_list = list(range(1,limit))

for i in range(0,len(abund_number_ls)):
    for j in range(i,len(abund_number_ls)):
        sumOf2AbundantNums = abund_number_ls[i]+abund_number_ls[j]
        try:
            total_list[sumOf2AbundantNums-1] = 0
        except:
            pass



print('-----')
print(sum(total_list))


#sum_non_abund = 0
#for i in range(1,limit):
#	if i not in comb_num_ls:
#		sum_non_abund += i

