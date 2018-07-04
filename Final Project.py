# --------------------------- #
# Intro to CS Final Project   #
# Gaming Social Network       #
# --------------------------- #

# <user> is connected to <user1>, ..., <userM>.<user> likes to play <game1>, ..., <gameN>.
#
# For example:
# 
# John is connected to Bryant, Debra, Walter.John likes to play The Movie: The Game, The Legend of Corgi, Dinosaur Diner.
# 

example_input="John is connected to Bryant, Debra, Walter.\
John likes to play The Movie: The Game, The Legend of Corgi, Dinosaur Diner.\
Bryant is connected to Olive, Ollie, Freda, Mercedes.\
Bryant likes to play City Comptroller: The Fiscal Dilemma, Super Mushroom Man.\
Mercedes is connected to Walter, Robin, Bryant.\
Mercedes likes to play The Legend of Corgi, Pirates in Java Island, Seahorse Adventures.\
Olive is connected to John, Ollie.\
Olive likes to play The Legend of Corgi, Starfleet Commander.\
Debra is connected to Walter, Levi, Jennie, Robin.\
Debra likes to play Seven Schemers, Pirates in Java Island, Dwarves and Swords.\
Walter is connected to John, Levi, Bryant.\
Walter likes to play Seahorse Adventures, Ninja Hamsters, Super Mushroom Man.\
Levi is connected to Ollie, John, Walter.\
Levi likes to play The Legend of Corgi, Seven Schemers, City Comptroller: The Fiscal Dilemma.\
Ollie is connected to Mercedes, Freda, Bryant.\
Ollie likes to play Call of Arms, Dwarves and Swords, The Movie: The Game.\
Jennie is connected to Levi, John, Freda, Robin.\
Jennie likes to play Super Mushroom Man, Dinosaur Diner, Call of Arms.\
Robin is connected to Ollie.\
Robin likes to play Call of Arms, Dwarves and Swords.\
Freda is connected to Olive, John, Debra.\
Freda likes to play Starfleet Commander, Ninja Hamsters, Seahorse Adventures."

# create_data_structure(string_input): 
#   Parses a block of text (such as the one above) and stores relevant 
#   information into a data structure. You are free to choose and design any 
#   data structure you would like to use to manage the information.
# 
# Arguments: 
#   string_input: block of text containing the network information
# Return:
#   The newly created network data structure
def no_common(ls):
    ans = []
    for string in ls:
        if ',' in string:
            out = string.split(',')
            for i in out:
                if i != '':
                    ans.append(i)
        else:
            ans.append(string)
    return ans

def no_blank_start(ls):
    ans = []
    for string in ls:
        if string[0] == ' ':
            ans.append(string[1:])
            print(string[1:])
        else:
            ans.append(string)
    return ans
            

def create_data_structure(string_input):
    '''Parses a block of text (such as the one above) and stores relevant 
       information into a data structure. 
       {user:[[connection], [games]], ...}

       Arguments: 
           string_input: block of text containing the network information'''
           
    network = {}
    if string_input == '':
        None
    else:
        sentences = string_input.split('.')
        for sentence in sentences:
            if sentence != '':
                words = sentence.split()
#            return words
            #connection
                if words[2] == 'connected':
                    network[words[0]] = [no_common(words[4:])]
#            return network
#            # game
                if words[1] == 'likes':
                    index = sentence.find('likes to play')
                    games = sentence[index+13+1 :].split(',')
                    network[words[0]].append(no_blank_start(games))
    return network


def get_connections(network, user):
    '''Returns a list of all the connections that user has
       Arguments: 
           network: the gamer network data structure
           user:    a string containing the name of the user
       
       Return: 
           A list of all connections the user has.
           - If the user has no connections, return an empty list.
           - If the user is not in network, return None.'''
    
    if user not in network:
        return None
    return network[user][0]

    
def get_games_liked(network,user):
    '''Returns a list of all the games a user likes

       Arguments: 
           network: the gamer network data structure
           user:    a string containing the name of the user
 
       Return: 
           A list of all games the user likes.
           - If the user likes no games, return an empty list.
           - If the user is not in network, return None.'''
    
    if user not in network:
        return None
    return network[user][1]


def add_connection(network, user_A, user_B):
    
    '''Adds a connection from user_A to user_B.
    
       Arguments: 
           network: the gamer network data structure 
           user_A:  a string with the name of the user the connection is from
           user_B:  a string with the name of the user the connection is to

       Return: 
           The updated network with the new connection added.
           - If a connection already exists from user_A to user_B, return network unchanged.
           - If user_A or user_B is not in network, return False.'''
    if user_A not in network or user_B not in network:
        return False
    else:
        if user_B not in get_connections(network,user_A):
            network[user_A][0].append(user_B)
        return network


def add_new_user(network, user, games):
    '''Creates a new user profile and adds that user to the network, along with
        any game preferences specified in games. Assume that the user has no 
        connections to begin with.

        Arguments:
            network: the gamer network data structure
            user:    a string containing the name of the user to be added to the network
            games:   a list of strings containing the user's favorite games, e.g.:
                ['Ninja Hamsters', 'Super Mushroom Man', 'Dinosaur Diner']

        Return: 
            The updated network with the new user and game preferences added. The new user 
            should have no connections.
            - If the user already exists in network, return network *UNCHANGED*'''
            
    if user in network:
        return network
    else:
        network[user] = [[]]
        network[user].append(games)
    return network


def union(p,q): # merge 2 list except the same item
    for e in q:
        if e not in p:
            p.append(e)

def get_secondary_connections(network, user):
    '''Finds all the secondary connections (i.e. connections of connections) of a 
        given user.
 
    Arguments: 
        network: the gamer network data structure
        user:    a string containing the name of the user

     Return: 
         A list containing the secondary connections (connections of connections).
         - If the user is not in the network, return None.
         - If a user has no primary connections to begin with, return an empty list.
 
    NOTE: 
        It is OK if a user's list of secondary connections includes the user 
        himself/herself. It is also OK if the list contains a user's primary 
        connection that is a secondary connection as well.'''
   
    if user not in network:
        return None
    first_co = network[user][0]
    sec_co = []
    for ppl in first_co:
        union(sec_co, network[ppl][0])
    return sec_co

def count_common_connections(network, user_A, user_B):
    '''Finds the number of people that user_A and user_B have in common.
     Arguments: 
         network: the gamer network data structure
         user_A:  a string containing the name of user_A
         user_B:  a string containing the name of user_B

     Return: 
         The number of connections in common (as an integer).
         - If user_A or user_B is not in network, return False.'''
         
    if user_A not in network or user_B not in network:
        return False
    else:
        ls = []
        for ppl in network[user_A][0]:
            if ppl in network[user_B][0]:
                ls.append(ppl)
        return len(ls)



def find_path_to_friend(network, user_A, user_B):
    ''' Finds a connections path from user_A to user_B.
    
        Arguments:
            network: The network you created with create_data_structure. 
            user_A:  String holding the starting username ("Abe")
            user_B:  String holding the ending username ("Zed")
        Return:
            A list showing the path from user_A to user_B.
            - If such a path does not exist, return None.
            - If user_A or user_B is not in network, return None.
            
        Sample output:
            >>> print find_path_to_friend(network, "Abe", "Zed")
            >>> ['Abe', 'Gel', 'Sam', 'Zed']    '''
	
    if user_A not in network or user_B not in network:
        return None
    
    new_path = [user_A]
    if user_B in network[user_A][0]:
        new_path = new_path + [user_B]
        return new_path
    
    for ppl in network[user_A][0]:
        path = find_path_to_friend(network, ppl, user_B)
        if path != None:
            new_path = new_path + path
            return new_path
    return None


###############======================
# test
###############
    
net = create_data_structure(example_input)
print(net)
print(get_connections(net, "Debra"))
print(get_connections(net, "Mercedes"))
print(get_games_liked(net, "John"))
print(add_connection(net, "John", "Freda"))
print(add_new_user(net, "Debra", [])) 
print(add_new_user(net, "Nick", ["Seven Schemers", "The Movie: The Game"])) # True
print(get_secondary_connections(net, "Mercedes"))
print(count_common_connections(net, "Mercedes", "John"))
print(find_path_to_friend(net, "John", "Ollie"))
