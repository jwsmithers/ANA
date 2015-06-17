#!/bin/env python
def files():
    n = 0
    while True:
        n += 1
        yield open('./more_logs/%d.txt' % n, 'w')

pat = 'Now trying'
fs = files()
outfile = next(fs) 
colour = ["LightCoral", "Chartreuse", "green", "yellow","white"]
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

with open('./more_logs/AllPackages.html', 'w') as myFile:
    myFile.write('<html>')
    myFile.write('<body>')
    myFile.write('<h1>All packages compiled</h1>')
    myFile.write('<table>')

    for i in range(0, len(Package_name)):
        myFile.write('<tr><td><font style="background-color:%s;"><a href="./more_logs/%s.txt">%s</a><font></td>' % (colour[4], i+2 , Package_name[i]));

    myFile.write('</tr>')
    myFile.write('</table>')
    myFile.write('</body>')
    myFile.write('</html>')

with open('./more_logs/FailedPackages_temp.html', 'w') as failed:
    failed.write('<html>')
    failed.write('<body>')
    failed.write('<h1>Packages that failed to compile</h1>')
    failed.write('<table>')
    
    for j in range (0, len(Package_name)):
   	 with open("./more_logs/%s.txt" % (j+1)) as log_files:
		for error in log_files:
                    if "No such file or directory" in error:
			failed.write('<tr><td><font style="background-color:%s;"><a href="./more_logs/%s.txt">%s</a><font></td>' % (colour[0], j+1 , Package_name[j-1]));

    failed.write('</tr>')
    failed.write('</table>')
    failed.write('</body>')
    failed.write('</html>')

import subprocess
command="awk '!a[$0]++' ./more_logs/FailedPackages_temp.html > ./more_logs/FailedPackages.html"
subprocess.Popen(command, shell=True)

