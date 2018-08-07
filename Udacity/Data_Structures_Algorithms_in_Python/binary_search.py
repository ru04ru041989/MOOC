# binary search practice

def binary_search(input_array, value):
    low = 0
    high = len(input_array)-1
    input_array = sorted(input_array)
    while low <= high:
        mid = (low+high) // 2
        if value == input_array[mid]:
            return mid
        elif value > input_array[mid]:
            low = mid+1
        else:
            high = mid -1
    return -1


if __name__ == '__main__':
    test_list = [1,3,9,11,15,19,29]
    test_val1 = 25
    test_val2 = 15
    
    print(binary_search(test_list, test_val1))
    print(binary_search(test_list, test_val2))
