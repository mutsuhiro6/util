
account = input('account: ')
password = input('password: ')
matrix = {}
for al in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']:
    for num in [1, 2, 3, 4, 5, 6, 7]:
        el = input('[' + al + ',' + str(num) + ']: ')
        matrix['[' + al + ',' + str(num) + ']'] = el
f = open('config.py', 'w')
f.write('account = ' + '\'' + account + '\'' + '\npassword = ' + '\'' + password  + '\'' + '\n' + 'matrix = ' + str(matrix))
f.close()
