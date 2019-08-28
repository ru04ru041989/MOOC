# -*- coding: utf-8 -*-
"""
Created on Thu Aug  9 17:13:15 2018

@author: ru04r
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

def rotate(n):
    n=str(n)
    return n[1:]+n[:1]

def isRotatable(n, primes):
    for x in range(2,n):
        n = rotate(n)
        if not primes[int(n)]:
            return False
    return True

def main(n):
    ans = []
    primes = sieve(n)
    for x in range(2, len(primes)):
        if(isRotatable(x,primes)):
            ans.append(x)
            #print(x)
    return ans