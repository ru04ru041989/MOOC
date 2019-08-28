# Circular primes
"""
The number, 197, is called a circular prime because all rotations of the digits: 197, 971, 
and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?
"""

from math import sqrt

def sieve(n):
    primes = [True] * (n+1)
    primes[0] = primes[1] = False

    for x in range(4,n+1,2):
        primes[x] = False

    for x in range(3,int(sqrt(n))+1,2):
        if(primes[x]):
            for y in range(x*x,n+1,x):
                primes[y] = False
    return primes

def primes(n):
    s = [0,0,2]
    s.extend([x for x in range(3, n+1)])
    for i in range(2, n//2):
        if s[i]!=0:
            for j in range(2, n // i+1):
                s[j*i]=0
    return [x for x in s if x!=0]


def get_all_rotation(n):
    answer = []
    rotation = n
    while not rotation in answer:
        answer.append(rotation)
        rotation = int(str(rotation)[1:] + str(rotation)[0])
    return answer


limit = 1000000
#limit = 1000000
def get_answer(limit):
    prime_list = primes(limit)
    ans = []
    for i in prime_list:
        check = True
        check_list = get_all_rotation(i)
        for item in check_list:
            if item not in prime_list:
                check = False
                break
        
        if check: #and 0 not in str(i):
            ans.append(i)
    return ans
            
        
    