# Double-base palindromes
"""
The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
"""

def check_palindrome(n):
    if len(n) == 1 or n == '':
        return True
    while n:
        if n[0] == n[-1]:
            return check_palindrome(n[1:-1])
        return False

def main(limit):
    ans = []
    for i in range(limit):
        if check_palindrome(str(i)) and check_palindrome(str(bin(i))[2:]):
            ans.append(i)
    return ans

ans = main(1000000)