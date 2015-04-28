#!/bin/csh -f
foreach file ( cleanup.csh cleanup.sh setup.csh setup.sh )
  cat ${file} | sed 's/\.cern/cern/' > ${file}.new
  \mv ${file}.new ${file}
end
