# Define a procedure, split_string, that takes two
# inputs: the string to split and a string containing
# all of the characters considered separators. The
# procedure should return a list of strings that break
# the source string up by the characters in the
# splitlist.


def split_string(source,splitlist):
    splintpos = []
    for i in range(len(source)):
        if source[i] in splitlist:
            splintpos.append(i)

    st_pos = 0
    end_pos = 0
    new_str = []
    while splintpos:
        end_pos = splintpos.pop(0)
        if st_pos != end_pos:
            new_str.append(source[st_pos:end_pos])
        st_pos = end_pos +1
    if source[-1] not in splitlist:
        new_str.append(source[st_pos:])
    
    return new_str
        
        
a = "First Name,Last Name,Street Address,City,State,Zip Code"   

print(split_string(a,","))
print(a)