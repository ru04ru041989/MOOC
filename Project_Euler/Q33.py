# Digit cancelling fractions
"""
The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify 
it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, 
and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of 
the denominator.
"""

def check_non_trivial_exp(n,d):
    for c in range(1,10):
        # possible compination
        n_sets = [10*n +c, 10*c +n]
        d_sets = [10*d +c, 10*c +d]
                       
        for n_set in n_sets:
            for d_set in d_sets:
                if n_set / d_set == n/d:
                    return True, (n_set, d_set)

    return False, None

ans = []

for n in range(1,10):
    for d in range(1,10):
        is_target, pair = check_non_trivial_exp(n,d)
        if n < d and is_target:
            ans.append(pair)

