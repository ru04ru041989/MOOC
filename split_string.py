# Define a procedure, split_string, that takes two
# inputs: the string to split and a string containing
# all of the characters considered separators. The
# procedure should return a list of strings that break
# the source string up by the characters in the
# splitlist.


def split_string(source,splitlist):
    splintpos = []   
    
    # get all the split sign's pos in source
    for i in range(len(source)):
        if source[i] in splitlist:
            splintpos.append(i)        
    
    st_pos = 0
    end_pos = 0
    new_str = []
    
    # pop out each pos, and extract chr according, till no pos remain
    while splintpos: 
        end_pos = splintpos.pop(0)
        if st_pos != end_pos: # skeep if two splint sign are next to each other
            new_str.append(source[st_pos:end_pos])
        st_pos = end_pos +1
    
    if source[-1] not in splitlist: # add last str if splint sign not at the end
        new_str.append(source[st_pos:])
    
    return new_str
        