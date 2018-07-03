# Write a procedure, remove_tags, that takes as input a string and returns
# a list of words, in order, with the tags removed. Tags are defined to be
# strings surrounded by < >. Words are separated by whitespace or tags. 
# You may assume the input does not include any unclosed tags, that is,  
# there will be no '<' without a following '>'.


def remove_tags(text):
    start = text.find('<')
    
    while start != -1:
        end = text.find('>', start+1)
        
        text = text[:start] + " " + text[end+1:]
        
        start = text.find('<')
    
    return text.split()