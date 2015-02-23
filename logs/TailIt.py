#!/usr/env python
def tail(file, n=1000, bs=1024):
    f = open(file)
    f.seek(-1,2)
    l = 1-f.read(1).count('\n') # If file doesn't end in \n, count it anyway.
    B = f.tell()
    while n >= l and B > 0:
            block = min(bs, B)
            B -= block
            f.seek(B, 0)
            l += f.read(block).count('\n')
    f.seek(B, 0)
    l = min(l,n) # discard first (incomplete) line if l > n
    lines = f.readlines()[-l:]
    f.close()
    return lines

J=tail("stdOut.log")
for i in J:
    print i.strip()
