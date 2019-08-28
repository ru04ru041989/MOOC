#Largest palindrome product

def check_palindorm(num):
	if len(num) <= 1:
		return True
	# check the first and last one
	if num[0] == num[-1]:
		if check_palindorm(num[1:len(num)-1]):
			return True
		else:
			return False
	return False


def list_palindorm_product(n_dig):
	'''
	return the largest palindrome made from the product of two n-digit numbers
	'''
	num = (10 ** n_dig) -1

	palindorm_list = []

	for i in range(num, num//2, -1):
		for j in range(num, num//2, -1):
			if check_palindorm(str(i*j)):
				palindorm_list.append(i*j)
	return palindorm_list


n_dig = int(input("Enter n_dig numbers: "))

#print(list_palindorm_product(n_dig))
print(max(list_palindorm_product(n_dig)))


