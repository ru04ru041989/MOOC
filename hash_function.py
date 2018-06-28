# hash function

# that takes as inputs a keyword
# (string) and a number of buckets,
# and returns a number representing
# the bucket for that keyword.

def hash_string(keyword,buckets):
    result = 0
    for word in keyword:
        result = result + (ord(word) % buckets)
        
    return result % buckets