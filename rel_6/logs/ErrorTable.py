#!/bin/env python
def files():
    n = 0
    while True:
        n += 1
        yield open('./more_logs/%d.txt' % n, 'w')

pat = 'Now trying'
fs = files()
outfile = next(fs) 
colour = ["red", "red", "green", "yellow"]
Package_name=[]

with open("StdOut.log") as infile:
	for line in infile:
		if pat not in line:
			outfile.write(line)
		else:
			items = line.split(pat)
			for item in items[1:]:
				outfile = next(fs)
				outfile.write(pat + item)
				Package_name.append(item)

with open('./more_logs/mypage.html', 'w') as myFile:
    myFile.write('<html>')
    myFile.write('<body>')
    myFile.write('<table>')

    for i in range(0, len(Package_name)):
        myFile.write('<tr><td><font style="background-color:%s;"><a href="./more_logs/%s.txt">%s</a><font></td>' % (colour[3], i+2 , Package_name[i]));

    myFile.write('</tr>')
    myFile.write('</table>')
    myFile.write('</body>')
    myFile.write('</html>')
