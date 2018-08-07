"""graph"""

class Node(object):
    def __init__(self, value):
        self.value = value
        self.edges = []

class Edge(object):
    def __init__(self, value, node_from, node_to):
        self.value = value
        self.node_from = node_from
        self.node_to = node_to

class Graph(object):
    def __init__(self, nodes=[], edges=[]):
        self.nodes = nodes
        self.edges = edges

    def insert_node(self, new_node_val):
        new_node = Node(new_node_val)
        self.nodes.append(new_node)
        
    def insert_edge(self, new_edge_val, node_from_val, node_to_val):
        # set the from and to for the new edge
        	# in the case of new edge between current nodes
        from_found = None
        to_found = None
        for node in self.nodes:
            if node_from_val == node.value:
                from_found = node
            if node_to_val == node.value:
                to_found = node

        # in the case of one of the node is new:
            # create new node, and add to self.nodes
        if from_found == None:
            from_found = Node(node_from_val)
            self.nodes.append(from_found)
        if to_found == None:
            to_found = Node(node_to_val)
            self.nodes.append(to_found)

        # with all setup for edge is done, create new edge
        	# add new edges to the list for the nodes who associated with this new edge
        	# finally, add new edges to self.edges list
        new_edge = Edge(new_edge_val, from_found, to_found)
        from_found.edges.append(new_edge)
        to_found.edges.append(new_edge)
        self.edges.append(new_edge)

    def get_edge_list(self):
        """Don't return a list of edge objects!
        Return a list of triples that looks like this:
        (Edge Value, From Node Value, To Node Value)"""
        result = []
        for edge in self.edges:
        	result.append((edge.value, edge.node_from.value, edge.node_to.value))
        return result

    def get_adjacency_list(self):
        """Don't return any Node or Edge objects!
        You'll return a list of lists.
        The indecies of the outer list represent
        "from" nodes.
        Each section in the list will store a list
        of tuples that looks like this:
        (To Node, Edge Value)"""
        connect_to = {}
        for value, from_val, to_val in self.get_edge_list():
        	if from_val not in connect_to:
        		connect_to[from_val] = []
        	connect_to[from_val].append((to_val,value))

        result = [None,]
        for node in self.nodes:
        	if node.value not in connect_to:
        		result.append(None)
        	else:
        		result.append(connect_to[node.value])
        return result
    
    def get_adjacency_matrix(self):
        """Return a matrix, or 2D list.
        Row numbers represent from nodes,
        column numbers represent to nodes.
        Store the edge values in each spot,
        and a 0 if no edge exists."""
        node_adj_list = self.get_adjacency_list()
        result = []
        for node in node_adj_list:
        	each_node = [0] * len(node_adj_list)

        	if node:
        		for edge_to, value in node:
        			each_node[edge_to] = value
        	result.append(each_node)
        

        return result


if __name__ == '__main__':
	
	graph = Graph()
	graph.insert_edge(100, 1, 2)
	graph.insert_edge(101, 1, 3)
	graph.insert_edge(102, 1, 4)
	graph.insert_edge(103, 3, 4)

# Test get edge list
# Should be [(100, 1, 2), (101, 1, 3), (102, 1, 4), (103, 3, 4)]
	print('Q1...........ans: [(100, 1, 2), (101, 1, 3), (102, 1, 4), (103, 3, 4)]')
	print (graph.get_edge_list())
	print('')

# Should be False
	print('Q2...........ans: [None, [(2, 100), (3, 101), (4, 102)], None, [(4, 103)], None]')
	print (graph.get_adjacency_list())
	print('')

# Should be 1-2-4-5-3
	print('Q3...........ans: [[0, 0, 0, 0, 0], [0, 0, 100, 101, 102], [0, 0, 0, 0, 0], [0, 0, 0, 0, 103], [0, 0, 0, 0, 0]]')
	print (graph.get_adjacency_matrix())
	print('')

