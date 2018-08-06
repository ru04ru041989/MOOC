def n_carry(num,n):
    return int(num / n) , num % n

def ck_add_s(x,str_add):
    ''' 
    add x infront of the str_add and 
    add 's' to the str_add if x ~! 1
    '''
    if x != 1:
        return str(x) + ' ' + str_add + 's'
    else:
        return str(x) + ' ' + str_add

def convert_seconds(x):
    minute, sec = n_carry(x,60)
    hr, minute = n_carry(minute,60)
    
    if x % 1 == 0:
        sec = int(sec)
    
    result = ck_add_s(int(hr),'hour') + ', '+ck_add_s(int(minute),'minute') +', ' +ck_add_s(sec,'second')
    return result
    

def get_bit(unit):
    if unit[0] == 'k':
        a = 10
    elif unit[0] == 'M':
        a = 20
    elif unit[0] == 'G':
        a = 30
    else:
        a = 40
        
    if unit[1] == 'b':
        return 2 ** a
    else:
        return 2 ** a * 8

def download_time(filesize,f_uint,bdwith,bd_unit):
    time_need = float(filesize * get_bit(f_uint)) / (bdwith * get_bit(bd_unit))
    return convert_seconds(time_need)

print(download_time(1024,'kB', 1, 'Mb'))
#>>> 0 hours, 0 minutes, 1 second