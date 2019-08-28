# Longest Collatz sequence
'''
The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
'''

def get_next_collatz(n):
	if n % 2 == 0:
		return n/2
	else:
		return n*3 +1

def get_collatz_term(n):
	count = 1
	while n != 1:
		n = get_next_collatz(n)
		count += 1
	return count


def get_collatz_map(n, c_map):
	count = 1
	original_n = n
	while n != 1:
		if n not in c_map:
			n = get_next_collatz(n)
			count += 1
		else:
			count += c_map[n]
			break
	c_map[original_n] = count
	return c_map

def sort_value(value):
	return value[1]



if __name__ == '__main__':

	
	result = []
	for i in range(1,1000001):
		result.append((get_collatz_term(i), i))

	print(sorted(result)[-5:])
	
	c_map = {}
	for i in range(1,1000001):
		c_map = get_collatz_map(i, c_map)

	print(sorted(c_map.items(), key = sort_value)[-5:])
