# Poker hands
"""
In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, 
in the following way:

High Card: Highest value card.
One Pair: Two cards of the same value.
Two Pairs: Two different pairs.
Three of a Kind: Three cards of the same value.
Straight: All cards are consecutive values.
Flush: All cards of the same suit.
Full House: Three of a kind and a pair.
Four of a Kind: Four cards of the same value.
Straight Flush: All cards are consecutive values of same suit.
Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; 
for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, 
for example, both players have a pair of queens, then highest cards in each hand are compared 
(see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:

Hand	 	Player 1	 	    Player 2	 	           Winner
1	 	5H 5C 6S 7S KD    2C 3S 8S 8D TD         Player 2
       Pair of Fives    Pair of Eights

2	 	5D 8C 9S JS AC    2C 5C 7D 8S QH         Player 1
     Highest card Ace   Highest card Queen
 	
3	 	2D 9C AS AH AC    3D 6D 7D TD QD         Player 2
        Three Aces     Flush with Diamonds
 	
4	 	4D 6S 9H QH QC     3D 6D 7H QD QS        Player 1
        Pair of Queens  Pair of Queens
     Highest card Nine  Highest card Seven
 	
5	 	2H 2D 4C 4D 4S     3C 3D 3S 9S 9D        Player 1
       Full House        Full House
     With Three Fours    with Three Threes
 	
The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?
"""
def get_data():
    with open('p054_poker.txt') as f:
        data = []
        for line in f:
            play1 = line[:15].split()
            play2 = line[15:].split()
            data.append([play1, play2])
    return data

#hand_rank = {'high card' :1, 'one pair' :2, 
#             'tow pairs' :3, '3 a kind':4, 'straight':5,
#             'flush' :6, 'full house':7, '4 a kind': 8,
#             'straight flush':9, 'royal flush':10}

def conv_special_card(n):
    special_card = {'T':10, 'J':11, 'Q':12, 'K':13, 'A':14}
    if n in special_card:
        return special_card[n]
    return int(n)

def judge_ncard(card_value):
    # return format: pair, (is_3, card), (is_4, card), rest
    # card_dic, key = card, value = n of the card
    card_dic = {}
    for i in card_value:
        if i not in card_dic:
            card_dic[i] = 0
        card_dic[i] += 1
        
    pair = []
    is_3 = (False, '0')
    is_4 = (False, '0')
    rest = []
    for card, n_card in card_dic.items():
        if n_card == 1:
            rest.append(card)
        if n_card == 2:
            pair.append(card)
        if n_card == 3:
            is_3 = (True, card)
        if n_card == 4:
            is_4 = (True, card)
    return pair, is_3, is_4, rest
            
def is_straight(card_value):
    # return (True, starting point), (False, 0)
    value_int = [conv_special_card(card) for card in card_value]
    value_int = sorted(value_int)

    if value_int[-1] - value_int[-2] ==1:
        if value_int[-2] - value_int[-3] ==1:
            if value_int[-3] - value_int[-4] ==1:
                if value_int[-4] - value_int[-5] ==1:
                    return True, value_int[-5]
    return False, 0
    
def is_flush(card_suit):
    if card_suit[0] == card_suit[1] == card_suit[2] == card_suit[3] == card_suit[4]:
        return True
    return False
    
        
    

def card_judge(hands):
    # format: (rank(match to the {hand_rank}), of which card, remain cards)
    # return all the judges
    card_value = [i[0] for i in hands]
    card_suit = [i[1] for i in hands]
    
    pair, is_3, is_4, rest = judge_ncard(card_value)
    straight = is_straight(card_value)
    flush = is_flush(card_suit)
    
    judges = []
    
    # check pair, 3 a kind, full house
    if len(pair) == 1 and is_3[0]:
        judges.append((7, is_3[1]))
        
    elif len(pair) == 1:
        judges.append((2, pair))
        
    elif len(pair) == 2:
        judges.append((3, pair))
        
    elif is_3[0]:
        judges.append((4, is_3[1]))
        
    if straight[0] and flush:
        if straight[1] == 10:
            judges.append((10, straight[1]))
        else:
            judges.append((9, straight[1]))
    
    elif straight[0]:
        judges.append((5, straight[1]))
    elif flush:
        judges.append((6, 0))
    
    if is_4[0]:
        judges.append((8, is_4[1]))
    
    if rest:
        for i in rest:
            judges.append((1, i))
        
    return judges
    
    
def rank_card(hands):
    judges = card_judge(hands)
    rank = []
    for item in judges:
        if item[0] == 2:
            rank.append((2, conv_special_card(item[1][0])))
        elif item[0] == 3:
            rank.append((3, conv_special_card(item[1][0])))
            rank.append((3, conv_special_card(item[1][1])))
        else:
            rank.append((item[0], conv_special_card(item[1])))
    rank = sorted(rank)
    return rank

def help_if_p1_win(p1_rank, p2_rank, time):
    
    if p1_rank[-time][0] > p2_rank[-time][0]:
        return 1
    elif p1_rank[-time][0] < p2_rank[-time][0]:
        return 0
    else:
        
        if p1_rank[-time][1] > p2_rank[-time][1]:
            return 1
        elif p1_rank[-time][1] < p2_rank[-time][1]:
            return 0
        else: # compair 2nd
            return help_if_p1_win(p1_rank, p2_rank, time+1)
    

def if_p1_win(p1,p2):
    p1_rank = rank_card(p1)
    p2_rank = rank_card(p2)
    print('p1 hand: {}, rank result: {}'.format(p1,p1_rank))
    print('p2 hand: {}, rank result: {}'.format(p2,p2_rank))
    return help_if_p1_win(p1_rank, p2_rank, 1)
    

            
########################################################3
# test
data = get_data()            

result_table = []
ans = 0
for i in range(len(data)):
    result = if_p1_win(data[i][0], data[i][1])
    result_table.append([ [data[i]], [rank_card(data[i][0]), rank_card(data[i][1])], result])
    ans += result

