# Reciprocal cycles
'''
A unit fraction contains 1 in the numerator. 
The decimal representation of the unit fractions with denominators 2 to 10 are given:


1/5	= 	0.2
1/6	= 	0.1(6)
1/7	= 	0.(142857)

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. 
It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring 
cycle in its decimal fraction part.
'''

'''
1 / 7 = 0          1 % 7 = 1
10 / 7 = 1    (1*10) % 7 = 3
30 / 7 = 4    (3*10) % 7 = 4
20 / 7 = 2
60 / 7 = 8
40 / 7 = 5
50 / 7 = 7
10 / 7 = 1
'''

def get_next(n, bottom):
    if n < bottom:
        n *= 10
        
    return n % bottom

def reciprocal_pattern(bottom):
    # return recurring cycle count till get reciprocal
    count = 0
    reminder = set()
    n = 1
    
    while count < bottom or n!= 0:        
        n = get_next(n, bottom)
        if n in reminder:
            break
        
        reminder.add(n)
        count += 1
        
    return count

ans = []
for i in range(2, 1000+1):
    ans.append((reciprocal_pattern(i), i))

ans_sort =sorted(ans)
print(ans_sort[-5:])    

