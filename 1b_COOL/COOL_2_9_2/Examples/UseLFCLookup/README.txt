/------------------------------------\
| How to use CORAL LFCReplicaService |
\------------------------------------/

Prepare the enviroment
----------------------
To use LFCReplicaSvc you need to be able to access LFC, which means that you
need the a GRID certificate and the appropriate environment.

To prepare the environment source the LGC provided script:

   source /afs/cern.ch/project/gd/LCG-share/sl3/etc/profile.d/grid_env.csh

and initialize your proxy certificate:

   voms-proxy-init

For tests, you should set the environment variable CORAL_LFC_BASEDIR to point
to a LFC directory that you can write (by default CORAL uses "/databases").
   
Add a replica to LFC
--------------------
To create a new entry or add a replica to an existing one we need the small
CORAL utility "coral_replica_manager". (use option -h to get help or go to
http://pool.cern.ch/coral/currentReleaseDoc/LFCReplicaService)

   coral_replica_manager -add -l logical_connection_string \
                              -h host_name \
                              -c physical_connection_string \
                              -r coral_role \
                              -u username \
                              -p password \
                              -rw

(use -ro instead of -rw for read-only replicas).

Example:

# coral_replica_manager -add -l LHCbConditionsDatabase \
                             -h LCG.CERN.ch \
                             -c int4r_lb \
                             -r reader \
                             -u conddb_reader \
                             -p *put_a_password* \
                             -ro

# coral_replica_manager -add -l LHCbConditionsDatabase \
                             -h LCG.CERN.ch \
                             -c int4r_lb \
                             -r manager \
                             -u schema_owner \
                             -p *put_a_password* \
                             -rw

# coral_replica_manager -add -l LHCbConditionsDatabase \
                             -h LCG.RAL.de \
                             -c LUGH.gridpp.rl.ac.uk \
                             -r reader \
                             -u conddb_reader \
                             -p *put_a_password* \
                             -ro


Access the COOL Database
------------------------
To use the LFCReplicaSvc from an application (see src/useLFCLookup.cpp), you
need to load the service "CORAL/Services/LFCReplicaService" in COOL's context
before trying to connect.

The connection string to use has to be something like: alias/DBNAME.
Example:
   
   example_Cool_UseLFCLookup LHCbConditionsDatabase/DDDB


For more informations contact Marco__dot__Clemencic__at__cern__dot__ch
