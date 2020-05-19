
for line in open('test.lst','r'):
	upperCase = True
	variable = ""
	for i in line:
		if i != "'" and i != ",":
			if upperCase:
				variable += i.upper()
				upperCase = False
			else:
				variable += i
			if i == " ":
				upperCase = True
		else:
			upperCase = False

	variable = variable.replace(" ", "")
#	print "[Embed(source=\"Sounds/" + line[:-1] + "\")]"
#	print "public static const " + variable[:-5] + ":Class;"
	print variable[:-5]
