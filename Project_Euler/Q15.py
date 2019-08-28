# Lattice paths
'''
Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
	

How many such routes are there through a 20×20 grid?
'''

from math import factorial

width = int(input("Enter width : "))
high = int(input("Enter high : "))

print(int(factorial(width + high) / (factorial(width) * factorial(high))))