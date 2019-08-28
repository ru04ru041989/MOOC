# Minimal network

def get_data():
    with open('p107_network.txt') as f:
        data = f.readlines()
        data = [x.strip() for x in data]
        data = [x.split(',') for x in data]
    return data


def get_edge(data):
    # return [ weight, (nodes linked)]
    rtn = set()
    for i in range(len(data)):
        for j in range(len(data)):
            if data[i][j] != '-':
                rtn.add( (tuple(sorted([i,j])) , int(data[i][j]))  )
    return sorted(list(rtn), key= lambda x: x[1])

def update_pattern(pattern, node1, node2):
    # update a and b in the pattern to which ever is smaller
    p = pattern.copy()
    a = min([p[node1], p[node2]])
    for i in range(len(p)):
        if pattern[i] == p[node1] or pattern[i] == p[node2]:
            pattern[i] = a
        

def find_MST(pattern, edges):
    rtn = 0
    while sum(pattern) != 0: 
    
        nodes, edge = edges.pop(0)
        # check if create loop if the node has same pattern number
        if pattern[nodes[0]] != pattern[nodes[1]]:
            rtn += edge
            update_pattern(pattern, nodes[0], nodes[1])
    return rtn
    
    
    
    
    
###########################
data = get_data()
edges = get_edge(data)
pattern = list(range(40))

###########################
ans = find_MST(pattern, edges)

sum([i[1] for i in edges]) - ans