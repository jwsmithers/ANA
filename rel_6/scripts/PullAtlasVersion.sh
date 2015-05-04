#!/bin/bash
cd $TopDir/../
echo ""
echo "Retreiving version ${VERSION} and creating package lists..."
echo ""
wget http://atlas-computing.web.cern.ch/atlas-computing/links/buildDirectory/www/nicos_content${VERSION}.html
/home/jwsmith/html2text-1.3.2a/html2text -width 160 nicos_content${VERSION}.html > ATLAS${VERSION}TEMP.txt
rm nicos_content${VERSION}.html
sed '1,11d' ATLAS${VERSION}TEMP.txt > ATLAS${VERSION}TEMP2.txt
head --lines=-5 ATLAS${VERSION}TEMP2.txt > ATLAS${VERSION}.txt
rm ATLAS${VERSION}TEMP.txt
rm ATLAS${VERSION}TEMP2.txt

while read line
do 
	cat ATLAS${VERSION}.txt | grep "$line" > ${TopDir}/../SVN/${line}-${VERSION}-DependentsTEMP.txt
	sed "s/${line}\b//g" ${TopDir}/../SVN/${line}-${VERSION}-DependentsTEMP.txt > ${TopDir}/../SVN/${line}-${VERSION}-Dependents.txt
	rm ${TopDir}/../SVN/${line}-${VERSION}-DependentsTEMP.txt
done < Projects.txt



