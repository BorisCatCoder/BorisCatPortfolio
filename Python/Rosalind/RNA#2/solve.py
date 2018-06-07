print('Give= ')
s= list(input().lower())
for i in range(len(s)):
        if s[i]=='t' :
                s[i]='u'
print(''.join(s).upper())
