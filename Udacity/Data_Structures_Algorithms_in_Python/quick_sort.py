"""Implement quick sort in Python.
Input a list.
Output a sorted list."""
def quicksort(array):
	if len(array) <= 1:
		return array
	povit = array.pop()
	lower=[]
	higher=[]
	for num in array:
		if num < povit:
			lower.append(num)
		else:
			higher.append(num)
	return quicksort(lower) + [povit] + quicksort(higher)


if __name__ == '__main__':
	test = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
	print(test)
	print(quicksort(test))