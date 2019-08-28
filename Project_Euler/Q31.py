#  Coin sums
"""
In England the currency is made up of pound, £, and pence, p, and there are eight 
coins in general circulation:

1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
It is possible to make £2 in the following way:

1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
How many different ways can £2 be made using any number of coins?
"""

# the 8 coins correspond to 8 columns
coins = [1, 2, 5, 10, 20, 50, 100, 200]

def coin_sum(target, coins_index = len(coins)-1):
    if coins[coins_index] == 1 or target == 0:
        return 1
    else:
        # if the target big enough to accomodate coins[index]
        # a...using ONLY coins less than coins[index]
        # b...USING the coin of coins[index]
        if target >= coins[coins_index]:
            # compute a
            ans = coin_sum(target, coins_index -1)
            # compute b
            ans += coin_sum(target - coins[coins_index], coins_index)
            return ans
        else:
        # the target not big enough to accomodate coins[index]
            return coin_sum(target, coins_index -1)


print(coin_sum(3, 7))
    
    