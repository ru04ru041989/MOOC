# Smallest multiple

'''
find the smallest number that can be divided by each of the numbers 
from start to end
'''

def gcd(a,b):
    """Compute the greatest common divisor of a and b"""
    while b > 0:
        a, b = b, a % b
    return a
    
def lcm(a, b):
    """Compute the lowest common multiple of a and b"""
    return a * b / gcd(a, b)


def smallest_multiple(start, end):
	num = lcm(start, start+1)

	i = start+2
	while i <= end:
		num = lcm(num, i)
		i += 1
	return num


start = int(input("Enter start number: "))
end = int(input("Enter end number: "))


print(smallest_multiple(start, end))

		
