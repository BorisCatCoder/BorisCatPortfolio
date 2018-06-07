print('Give= ')
s=input()

print('\n Return= ')
l=[0,0,0,0]
s.islower()
for i in range(len(s)):
	if s[i]=='a' : l[0]=l[0]+1
	if s[i]=='c' : l[1]=l[1]+1
	if s[i]=='g' : l[2]=l[2]+1
	if s[i]=='t' : l[3]=l[3]+1
print(l)
