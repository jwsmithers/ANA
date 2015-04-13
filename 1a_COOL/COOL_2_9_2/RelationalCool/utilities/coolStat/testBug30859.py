#!/usr/bin/env python
import os
from coolStat import coolStat
if __name__ == '__main__':
    key='OSTYPE'
    if key in os.environ and os.environ[key] == "linux" :
        file="/afs/cern.ch/sw/lcg/app/releases/SEAL/SEAL_1_9_3/win32_vc71_dbg/lib/modules/lcg_SealServices.reg"
        ###file="/afs/cern.ch/sw/lcg/app/releases/COOL/internal/avalassi/COOL_HEAD/win32_vc71_dbg/lib/modules/lcg_RelationalCool.reg"
    else :
        file="\\\\afs\\all\\cern.ch\\sw\\lcg\\app\\releases\\SEAL\\SEAL_1_9_3\\win32_vc71_dbg\\lib\\modules\\lcg_SealServices.reg"
        ###file="\\\\afs\\all\\cern.ch\\sw\\lcg\\app\\releases\\COOL\\internal\\avalassi\\COOL_HEAD\\win32_vc71_dbg\\lib\\modules\\lcg_RelationalCool.reg"
    print "File =", file
    coolStat(file,"none")
    coolStat(file,"CEST")
    coolStat(file,"CET")
    coolStat(file,"UTC")


    
