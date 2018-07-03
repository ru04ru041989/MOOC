# quick sort

# If the list has zero or one elements, it is already sorted.

# Otherwise, pick a pivot element, and split the list into two partitions: one
# contains all the elements equal to or lower than the value of the pivot
# element, and the other contains all the elements that are greater than the
# pivot element. Recursively sort each of the sub-lists, and then return the
# result of concatenating the sorted left sub-list, the pivot element, and the
# sorted right sub-list.

def quick_sort(p):
    if len(p) <= 1:
        return p
    pivot = p.pop()
    low_eq = []
    larg = []
    for i in p:
        if i <= pivot:
            low_eq = low_eq +[i]
        else:
            larg = larg +[i]
            
    return quick_sort(low_eq) + [pivot] + quick_sort(larg)



a = [100,25,66,89,24,61,28,77,46]
print(quick_sort(a))