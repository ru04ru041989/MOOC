# Largest prime factor

from sympy.ntheory import factorint

num = int(input('Enter the number for looking its largest prime factor: '))

factors = factorint(num)
factors_list = list(factors.keys())

print(factors_list)
print(max(factors_list))
