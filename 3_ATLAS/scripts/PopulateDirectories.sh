#!/bin/bash
#Preserve Order
while read line
do
python $TopDir/../scripts/CreateCMT_CheckoutList.py ./SVN/${line}-${VERSION}-Dependents.txt > ./TEMP${line}.txt

done < $TopDir/../Projects.txt
