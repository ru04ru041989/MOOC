## Multiples of 3 and 5

'''
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
The sum of these multiples is 23.   
Find the sum of all the multiples of 3 or 5 below 1000.
'''


def sum_multiples(upperlim, multiples):
 	'''
 	upperlim: the upper limit (type: int)
 	multiples: list of the multiples
 	'''

 	result = set()
 	for i in range(upperlim):
 		for multiple in multiples:
 			if i % multiple == 0:
 				result.add(i)

 	return sum(result)

if __name__ == '__main__':

	# test
	print('upperlim = 10, multiples = [3,5]')
	print(sum_multiples(10,[3,5]))

	# input
	upperlim = int(input('Enter upper limit (numbers): '))
	multiples = input('Enter multiples (numbers, seperate with comma): ').split(',')
	multiples = [int(multiple) for multiple in multiples]

	print('\nresult of the sum of the multiples:')
	print(sum_multiples(upperlim, multiples))
