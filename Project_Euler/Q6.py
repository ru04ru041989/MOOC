# Sum square difference

'''
diff of [sum of the squares] & [square of the sum]
'''
import numpy as np


start = int(input("Enter start number: "))
end = int(input("Enter end number: "))

num_list = np.arange(start,end+1)

squ_sum = sum(num_list) **2
print('square of sum: ' + str(squ_sum))

sum_squ = sum(num_list **2)
print('sum of square: ' + str(sum_squ))

print('difference: ' + str(sum_squ - squ_sum))


