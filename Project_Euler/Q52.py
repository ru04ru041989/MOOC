# Permuted multiples
"""
It can be seen that the number, 125874, and its double, 251748, 
contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.


"""

def is_same_digit(a,b):
    A = {}
    B = {}
    for s in str(a):
        if s not in A:
            A[s] = 0
        A[s] += 1
    for s in str(b):
        if s not in B:
            B[s] = 0
        B[s] += 1
    
    return A == B


i = 1
check = False
while check == False:
    if is_same_digit(i*2, i*3):
        if is_same_digit(i*3, i*4):
            if is_same_digit(i*4, i*5):
                if is_same_digit(i*5, i*6):
                    check = True
                    print(i)
    i += 1

