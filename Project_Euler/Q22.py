# Names scores

'''
Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?
'''
import string

with open('p022_names.txt', 'r') as ins:
	names = []
	for line in ins:
		names.append(line)

name_list = names[0].split(',')

# get name_list
name_list = sorted([i[1:-1] for i in name_list])

def name_point(name):
    abc_list = string.ascii_uppercase
    count = 0
    for letter in name:
        count += abc_list.find(letter) +1
    return count

def name_score(name):
    return name_point(name) * (name_list.index(name)+1)


total_score = 0
for name in name_list:
	total_score += name_score(name)

print(total_score)