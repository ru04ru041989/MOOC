# hash function

def hash_string(keyword,buckets):
    '''
    takes as inputs a keyword (string) and a number of buckets,
    returns a number representing the bucket for that keyword.
    '''
    result = 0
    for word in keyword:
        result = result + (ord(word) % buckets)
        
    return result % buckets


def make_hashtable(nbuckets):
    '''
    Creating an Empty Hash Table
    returns an empty hash table with nbuckets empty buckets.
    '''
    Htable = []
    for i in range(0,nbuckets):
        Htable.append([])
    
    return Htable