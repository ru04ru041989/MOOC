# Lexicographic permutations

def swap_append(s, new):
    result = [s + new]
    for i in s:
        temp_s = s
        new_s = temp_s.replace(i,new) + i
        result.append(new_s)
    return result

def get_combination(n):
    if n == 1:
        return ['0']
    
    result = []
    for item in get_combination(n-1):
        result.extend(swap_append(item, str(n-1)))
    return result
    
perm_10 = sorted(get_combination(10))
perm_10[1000000-1]        
    
    
    
        