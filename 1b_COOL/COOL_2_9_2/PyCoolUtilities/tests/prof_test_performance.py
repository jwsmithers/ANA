import profile, os, sys

proffile = 'test_performance.prof'

if len(sys.argv) == 2 and sys.argv[1] == '-f':
    sys.argv.pop(1)
    overwrite = True
else:
    overwrite = False

if overwrite or not os.path.exists( proffile ):
    print 'creating profile information'
    profile.run( 'import test_performance; test_performance.main()', proffile )
else:
    print ( 'analyzing existing file "%s" '
            '-- remove it to create a new profile' ) % proffile

import pstats
p = pstats.Stats('test_performance.prof')
p.strip_dirs()

p.sort_stats('cumulative').print_stats(10)

p.sort_stats('time').print_stats(10)