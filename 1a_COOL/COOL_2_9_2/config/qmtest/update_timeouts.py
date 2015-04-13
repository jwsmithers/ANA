#!/usr/bin/env python

from re import match, sub, search
from sys import argv, exit
from time import strptime, mktime

# functions
convert_time = lambda t: mktime(strptime(t,"%Y-%m-%dT%H:%M:%SZ%Z"))
timeout = lambda t: max(120,(int(t*1.2/60)+1)*60)

# initialize
tests = {}
timeouts = {}
current_test = None

if len(argv) < 2 or argv[1] in [ '-h', '--help' ]:
    print "You must specify at least one file"
    exit(1)

# loop over the files passed on the command line
for f in argv[1:]:
    tests[f] = {}
    # loop over the lines of the file
    iterator = open(f).xreadlines().__iter__()
    for l in iterator:

        if l.find('TESTS THAT DID NOT PASS') >= 0: break # skip summary

        # search for the test name
        m = match("  ([a-z._]*) *: (PASS|FAIL)",l)
        if m :
            current_test = m.group(1)
            tests[f][current_test] = { 'result' : m.group(2) }
            continue
        # search for the time strings
        m = match(" *qmtest.(end_time|start_time):",l)
        if m :
            tests[f][current_test][m.group(1)] = iterator.next().strip()
            # the start_time is the last of the 2 times, so we can compute the difference
            if m.group(1) == 'start_time':
                t = tests[f][current_test]
                
                if current_test not in timeouts: timeouts[current_test] = 0
                
                timeouts[current_test] =  max(timeouts[current_test],
                                              timeout(convert_time(t['end_time'])
                                                      -convert_time(t['start_time'])))
                    
# modify the test descriptions
keys = timeouts.keys()
keys.sort()
total_time = 0
for k in keys:
    to = timeouts[k]
    try:
        print k,to
        
        f = k.replace('.','.qms/')+'.qmt'
        s = open(f).read()
        reg_exp = '(<argument name="timeout"><integer>)(-?[0-9]*)(</integer></argument>)'
        m = search(reg_exp,s)
        if m :
            if int(m.group(2)) < to:
                open(f,"w").write(sub(reg_exp,'\\1%d\\3'%to, s))
                total_time += to
            else:
                total_time += int(m.group(2))
    except KeyError, e:
        print k, "does not have",e.args[0]

print "Maximum time allowed =",total_time/60.
