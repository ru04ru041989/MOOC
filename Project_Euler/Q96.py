# Su Doku
"""
003 | 020 | 600            483 | 921 | 657
900 | 305 | 001            967 | 345 | 821
001 | 806 | 400            251 | 876 | 493
---------------            ---------------
008 | 102 | 900            548 | 132 | 976
700 | 000 | 008            729 | 564 | 138
006 | 708 | 200            136 | 798 | 245
---------------            ---------------
002 | 609 | 500            372 | 689 | 514
800 | 203 | 009            814 | 253 | 769
005 | 010 | 300            695 | 417 | 382 



The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'), 
contains fifty different Su Doku puzzles ranging in difficulty, but all with 
unique solutions (the first puzzle in the file is the example above).

By solving all fifty puzzles find the sum of the 3-digit numbers found in the 
top left corner of each solution grid; for example, 483 is the 3-digit number 
found in the top left corner of the solution grid above.
"""
import numpy as np

def get_data():
    with open('p096_sudoku.txt') as f:
        raw_data = []
        for line in f:
            raw_data.append(line.split())
        data = []
        for i in range(1,len(raw_data)+1, 10):
            sudo = []
            while len(sudo) < 9:
                sudo.append([ int(s) for s in raw_data[i][0] ])
                i += 1
            data.append(sudo)
    return data

def display(sudo):
    rtn = ""
    line = '+'.join(['-' * 9]*3)
    for i in range(9):
        ln = ''
        for j in range(9):
            if sudo[i][j] != 0:
                ln = ln + ' {} '.format(sudo[i][j])
            else:
                ln = ln + ' . '
            if j % 3 == 2:
                ln = ln + '|'
        rtn = rtn + ln + '\n'
        if i % 3 == 2:
            rtn = rtn + line + '\n'
    print(rtn)

def cross(A,B):
    "Cross product of elements in A and elements in B."
    return [(int(a),int(b)) for a in A for b in B]

def background_set():
    point = cross(range(9),range(9))
    unit_list = ([cross(range(9), str(c)) for c in list(range(9))] +
            [cross(str(r), range(9)) for r in list(range(9))] +
            [cross(rs, cs) for rs in ('012','345','678') for cs in ('012','345','678')])
    units = dict((s, [u for u in unit_list if s in u]) for s in point)
    peers = dict((s, set(sum(units[s],[]))-set([s])) for s in point)

    return point, unit_list, units, peers      
            
def set_up(data):
    # return a dic with sudo set up
    sudo = np.zeros((9,9), dtype = 'i')
    for i in range(9):
        for j in range(9):
            sudo[i][j] = data[i][j]
    return sudo  

class point:
	def __init__(self,x,y):
		self.x=x
		self.y=y
		self.available=[]
		self.value=0
    


#####################
data = get_data()
point, unit_list, units, peers = background_set()
sudo = set_up(data[0])
display(sudo)


    
    
    