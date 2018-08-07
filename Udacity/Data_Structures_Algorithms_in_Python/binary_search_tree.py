"""binary search tree (BST)"""

class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BST(object):
    def __init__(self, root):
        self.root = Node(root)

    def insert(self,new_val):
    	self.insert_helper(self.root, new_val)

    def insert_helper(self, current ,new_val):
    	if new_val > current.value:
    		# add at right
    		if current.right:
    			self.insert_helper(current.right, new_val)
    		else:
    			current.right = Node(new_val)
    	else:
    		# add at left
    		if current.left:
    			self.insert_helper(current.left, new_val)
    		else:
    			current.left = Node(new_val)


    def search(self, find_val):
        """Return True if the value
        is in the tree, return
        False otherwise."""
        return self.search_bst(self.root, find_val)


    def search_bst(self, current, find_val):
    	if current:
    		if find_val == current.value:
    			return True
    		elif find_val > current.value:
    			return self.search_bst(current.right, find_val)
    		else:
    			return self.search_bst(current.left, find_val)
    	return False
        

    def print_tree(self, method = 'preorder'):
        """Print out all tree nodes
        as they are visited in
        a pre-order traversal."""
        if method == 'postorder':
        	return self.postorder_print(self.root, '')[:-1]
        elif method == 'inorder':
        	return  self.inorder_print(self.root, '')[:-1]
        else:
        	return self.preorder_print(self.root, '')[:-1]

    def preorder_search(self, start, find_val):
        """Helper method - use this to create a 
        recursive search solution."""

        if start: # cuz when reach leafs, will return None, and None didn't have value
        	if find_val == start.value:
        		return True
        	if self.preorder_search(start.left, find_val) or self.preorder_search(start.right, find_val):
        		return True
        return False

    def preorder_print(self, start, traversal):
        """Helper method - use this to create a 
        recursive print solution."""
        if start:
        	traversal += str(start.value) + '-'
        	traversal = self.preorder_print(start.left, traversal)
        	traversal = self.preorder_print(start.right, traversal)
        return traversal

    def postorder_print(self, start, traversal):
        """Helper method - use this to create a 
        recursive print solution."""
        if start:
        	traversal = self.postorder_print(start.left, traversal)
        	traversal = self.postorder_print(start.right, traversal)
        	traversal += str(start.value) + '-'
        return traversal

    def inorder_print(self, start, traversal):
        """Helper method - use this to create a 
        recursive print solution."""
        if start:
        	traversal = self.inorder_print(start.left, traversal)
        	traversal += str(start.value) + '-'
        	traversal = self.inorder_print(start.right, traversal)
        return traversal



if __name__ == '__main__':
	
	tree = BST(4)

	tree.insert(2)
	tree.insert(1)
	tree.insert(3)
	tree.insert(5)

# Test search
# Should be True
	print('Q1...........ans: True')
	print (tree.search(4))
	print('')
# Should be False
	print('Q2...........ans: False')
	print (tree.search(3))
	print('')

# Test print_tree
# Should be 1-2-4-5-3
	print('Q3.test preorder_print..........ans: 1-2-4-5-3')
	print (tree.print_tree())
	print('')

# Test print_tree
# Should be 1-2-4-5-3
	print('Q4.test postorder_print.........ans: 4-5-2-3-1')
	print (tree.print_tree(method = 'postorder'))
	print('')

	# Test print_tree
# Should be 1-2-
	print('Q5.test inorder_print.........ans: 4-2-5-1-3')
	print (tree.print_tree(method = 'inorder'))
	print('')