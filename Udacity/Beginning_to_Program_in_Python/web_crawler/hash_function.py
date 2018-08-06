# hash function

def hash_string(keyword,buckets):
    '''takes as inputs a keyword (string) and a number of buckets,
    returns a number representing the bucket for that keyword.'''
    
    result = 0
    for word in keyword:
        result = result + (ord(word) % buckets)
        
    return result % buckets


def make_hashtable(nbuckets):
    '''Creating an Empty Hash Table
    returns an empty hash table with nbuckets empty buckets.'''
    
    Htable = []
    for i in range(0,nbuckets):
        Htable.append([])
    
    return Htable


def hashtable_get_bucket(htable,keyword):
    '''two inputs - a hashtable, and a keyword
    returns the bucket where the keyword could occur'''
    
    h_index = hash_string(keyword,len(htable))
    
    return htable[h_index]


def hashtable_add(htable,key,value):
    '''adds the key to the hashtable in correct bucket with the value
    return the new hashtable'''
    
    index = hashtable_get_bucket(htable,key)
    index.append([key, value])
    
    return htable  


def hashtable_lookup(htable,key):
    '''return the ralue associated with that key '''
    
    bucket = hashtable_get_bucket(htable,key)
    entry = bucket_find(bucket,key)
    if entry:
        return entry[1]
    else:
        return None


def hashtable_update(htable,key,value):
    '''updates the value associated with key
    If key is already in the table, change the value to the new value. 
    Otherwise, add a new entry for the key and value.'''
    
    bucket = hashtable_get_bucket(htable,key)
    entry = bucket_find(bucket,key)
    if entry:
        entry[1] = value
    else:
        bucket.append([key, value])
    
    return htable

def bucket_find(bucket,key):
    '''refactoring, 
    simplify function 'hashtable_update' and  'hashtable_lookup' '''
    for entry in bucket:
        if entry[0] == key:
            return entry
    return None