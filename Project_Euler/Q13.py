# large sum

# Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.


import numpy as np


with open('euler13.txt', 'r') as ins:
	array = []
	for line in ins:
		array.append(line)

# Convert the array into an array of integers
newArray = []
for i in array:
    newArray.append(int(i))

arraySum = sum(newArray)
print(str(arraySum)[:10])