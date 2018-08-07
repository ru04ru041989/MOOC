# 0,1,1,2,3,5,8,13,21,34,....


def get_fib(position):
	if position == 0:
		return 0
	elif position == 1:
		return 1
	else:
		return get_fib(position -1) + get_fib(position -2)


if __name__ == '__main__':
	print(get_fib(9))
	print(get_fib(11))
	print(get_fib(0))