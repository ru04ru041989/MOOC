"""Write a HashTable class that stores strings
in a hash table, where keys are calculated
using the first two letters of the string."""

class HashTable(object):
    def __init__(self):
        self.table = {}

    def store(self, string):
        """Input a string that's stored in 
        the table."""
        hv = self.calculate_hash_value(string)
        if hv not in self.table:
        	self.table[hv] = []
        self.table[hv].append(string)
       
    def lookup(self, string):
        """Return the hash value if the
        string is already in the table.
        Return -1 otherwise."""
        hv = self.calculate_hash_value(string)
        if hv in self.table:
        	return hv
        else:
        	return -1

    def calculate_hash_value(self, string):
        """Helper function to calulate a
        hash value from a string."""
        return ord(string[0])*100 + ord(string[1])


if __name__ == '__main__':
	
	# Setup
	hash_table = HashTable()
	print('Q1: ........ans: 8568')
	print (hash_table.calculate_hash_value('UDACITY'))
	print('')

	# Test lookup edge case
	# Should be -1
	print('Q2...........ans: -1')
	print (hash_table.lookup('UDACITY'))
	print('')

	# Test store
	hash_table.store('UDACITY')
	print('Q3...........ans: 8568')
	print (hash_table.lookup('UDACITY'))
	print('')

	# Test store edge case
	hash_table.store('UDACIOUS')
	print('Q4...........ans: 8568')
	print (hash_table.lookup('UDACIOUS'))