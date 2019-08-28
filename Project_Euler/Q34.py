# Digit factorials
"""
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
"""
from math import factorial

def check_digit_factorial(n):
    n_str = str(n)
    f_sum = 0
    for i in n_str:
        f_sum += factorial(int(i))
    
    if f_sum == n:
        return True, n
    return False, None

digit_fact = [ factorial(i) for i in range(1,10)]

ans = []
for i in range(3, 2*sum(digit_fact)):
    is_good, n = check_digit_factorial(i)
    if is_good:
        ans.append(n)

