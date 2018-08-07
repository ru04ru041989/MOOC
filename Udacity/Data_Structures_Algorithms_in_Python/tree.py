"""tree structure"""

class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BinaryTree(object):
    def __init__(self, root):
        self.root = Node(root)

    def search(self, find_val):
        """Return True if the value
        is in the tree, return
        False otherwise."""
        return self.preorder_search(self.root, find_val)

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
	
	tree = BinaryTree(1)
	tree.root.left = Node(2)
	tree.root.right = Node(3)
	tree.root.left.left = Node(4)
	tree.root.left.right = Node(5)
	tree.root.right.left = Node(6)
	tree.root.right.right = Node(7)

	print(tree.root.left.value)

# Test search
# Should be True
	print('Q1...........ans: True')
	print (tree.search(4))
	print('')
# Should be False
	print('Q2...........ans: False')
	print (tree.search(6))
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