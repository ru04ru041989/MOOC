# Largest product in a grid

grid=[
[8,2,22,97,38,15,0,40,0,75,4,5,7,78,52,12,50,77,91,8],
[49,49,99,40,17,81,18,57,60,87,17,40,98,43,69,48,4,56,62,0],
[81,49,31,73,55,79,14,29,93,71,40,67,53,88,30,3,49,13,36,65],
[52,70,95,23,4,60,11,42,69,24,68,56,1,32,56,71,37,2,36,91],
[22,31,16,71,51,67,63,89,41,92,36,54,22,40,40,28,66,33,13,80],
[24,47,32,60,99,3,45,2,44,75,33,53,78,36,84,20,35,17,12,50],
[32,98,81,28,64,23,67,10,26,38,40,67,59,54,70,66,18,38,64,70],
[67,26,20,68,2,62,12,20,95,63,94,39,63,8,40,91,66,49,94,21],
[24,55,58,5,66,73,99,26,97,17,78,78,96,83,14,88,34,89,63,72],
[21,36,23,9,75,0,76,44,20,45,35,14,0,61,33,97,34,31,33,95],
[78,17,53,28,22,75,31,67,15,94,3,80,4,62,16,14,9,53,56,92],
[16,39,5,42,96,35,31,47,55,58,88,24,0,17,54,24,36,29,85,57],
[86,56,0,48,35,71,89,7,5,44,44,37,44,60,21,58,51,54,17,58],
[19,80,81,68,5,94,47,69,28,73,92,13,86,52,17,77,4,89,55,40],
[4,52,8,83,97,35,99,16,7,97,57,32,16,26,26,79,33,27,98,66],
[88,36,68,87,57,62,20,72,3,46,33,67,46,55,12,32,63,93,53,69],
[4,42,16,73,38,25,39,11,24,94,72,18,8,46,29,32,40,62,76,36],
[20,69,36,41,72,30,23,88,34,62,99,69,82,67,59,85,74,4,36,16],
[20,73,35,29,78,31,90,1,74,31,49,71,48,86,81,16,23,57,5,54],
[1,70,54,71,83,51,54,69,16,92,33,48,61,43,52,1,89,19,67,48]]


def get_adj_gird(x,y, x_add, y_add, length):
	'''
	start from (x,y), return a list
	contain coordinate of points (start from (x,y)) 
	base on direction and length
	'''
	ls = [(x,y)]
	
	#'horizontal': 	x_add = 1, 	y_add = 0
	#'verticle':   	x_add = 0, 	y_add = 1
	#'diagonal_Ld':	x_add = 1,	y_add = -1
	#'diagonal_Rd':	x_add = 1, 	y_add = 1

	for i in range(1,length):
		ls.append((x + x_add*i, y + y_add*i))

	return ls

def get_product(grid, ls):
	'''
	return False if coordinate in list exceed limit
	return true otherwise
	'''
	# check_limit
	product = 1
	for cor in ls:
		#if 0 <= cor[0] <= len(grid[0]) and 0 <= cor[1] <= len(grid):
		try:
			# compute produce
			product = product * grid[cor[0]][cor[1]]

		except IndexError: # not exist in the grid
			return 0
	return product
	


def get_largest_product_in_grid(grid, length):

	largest = 0
	for x in range(len(grid)):
		for y in range(len(grid)):
			ls_horiz = get_adj_gird(x,y, 1, 0, length)
			ls_vert = get_adj_gird(x,y, 0, 1, length)
			ls_diagLd = get_adj_gird(x,y, 1, -1, length)
			ls_diagRd = get_adj_gird(x,y, 1, 1, length)

		largest = max([largest,
			get_product(grid, ls_horiz),
			get_product(grid, ls_vert),
			get_product(grid, ls_diagLd),
			get_product(grid, ls_diagRd)])

	return largest
		
####################################################################

def product_in_direction(grid, start, direction, steps):
    x0, y0 = start
    dx, dy = direction

#    if  not(0 <= y0                  < len(grid) and
#            0 <= y0 + (steps - 1)*dy < len(grid) and
#            0 <= x0                  < len(grid[y0]) and
#            0 <= x0 + (steps - 1)*dx < len(grid[y0])):
#        return 0

    product = 1
    try:
    	for n in range(steps):
        	product *= grid[y0 + n*dy][x0 + n*dx]
    	return (product, x0, y0, dx, dy)
    except:
    	return (0, x0,y0)

#horizontal and vertical
#largest = 0
result = []
for y in range(len(grid)):
    for x in range(len(grid[y])):
    	result.append(product_in_direction(grid, (x, y),   (1,  0), 4))
    	result.append(product_in_direction(grid, (x, y),   (0,  1), 4))
    	result.append(product_in_direction(grid, (x, y),   (1,  1), 4))
    	result.append(product_in_direction(grid, (x, y+3),   (1,  -1), 4))

#        largest = max(
#            product_in_direction(grid, (x, y),   (1,  0), 4), # horizontal
#            product_in_direction(grid, (x, y),   (0,  1), 4), # vertical
#            product_in_direction(grid, (x, y  ), (1,  1), 4), # right diagonal
#            product_in_direction(grid, (x, y+3), (1, -1), 4), # left diagonal
#            largest,
#        )

final_result = sorted(result)


print(final_result[-3:])


if __name__ == '__main__':
	print(get_largest_product_in_grid(grid, 4))

	# test get_adj_grid & check_limit
#	print('\ninput: (0,0, horizontal, 4)')
	print(get_adj_gird(3,15, 1, 0, 4))
	print(get_product(grid, get_adj_gird(3,15, 0,1, 4)))

#	print('\ninput: (10,10, verticle, 6)')
	print(get_adj_gird(3,15, 0, 1, 4))
	print(get_product(grid, get_adj_gird(3,15, 1,0, 4)))

#	print('\ninput: (4,7, diagonal_ld, 3)')
	print(get_adj_gird(3,15, 1, 1, 4))
	print(get_product(grid, get_adj_gird(3,15, 1,1, 4)))

#	print('\ninput: (4,7, diagonal_rd, 6)')
	print(get_adj_gird(3,15, 1, -1, 4))
	print(get_product(grid, get_adj_gird(3,15, 1,-1, 4)))

	print(grid[3][15])
	print(grid[2][16])
	print(grid[1][17])
	print(grid[0][18])
	print(grid[3][15] * grid[2][16] * grid[1][17] * grid[0][18])

	
	





