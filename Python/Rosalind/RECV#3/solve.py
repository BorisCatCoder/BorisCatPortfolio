def Reverse(s):

	# res=[res for i in range(len(s),1,-1)]
	# return res
	res=s[::-1]
	return res



print('Given= ')
s=list(input().lower())
for i in range(len(s)):
	if s[i]=='a' : s[i]='t'; continue
	if s[i]=='t' : s[i]='a'; continue
	if s[i]=='c' : s[i]='g'; continue
	if s[i]=='g' : s[i]='c'; continue
print(s)
print(''.join(Reverse(s)).upper())
