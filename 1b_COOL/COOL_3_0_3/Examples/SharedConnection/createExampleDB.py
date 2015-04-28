#!/usr/bin/env python

from PyCool import cool, coral

from sys import argv, exit

if len(argv) != 2:
    print "ERROR! Wrong number of arguments (" + str(len(argv)-1) + \
          ") to " + argv[0]
    print "Usage:   " + argv[0] + \
          " '<dbIdUrl>'"
    print "Example: " + argv[0] + \
          " 'oracle://devdb10;schema=lcg_cool;dbname=COOLTEST'"
    print "Example: " + argv[0] + \
          " 'mysql://pcitdb59;schema=COOLDB;dbname=COOLTEST'" 
    print "Example: " + argv[0] + \
          " 'sqlite://none;schema=sqliteTest.db;dbname=COOLTEST'" 
    exit(1)

# Drop the database to start from scratch
print "%s: drop database"%argv[0]
cool.DatabaseSvcFactory.databaseService().dropDatabase(argv[1])

# Create an empty DB
print "%s: create database"%argv[0]
db = cool.DatabaseSvcFactory.databaseService().createDatabase(argv[1])

# Create folders
folderPath = "/folder_1"
print "%s: create folder '%s'"%(argv[0],folderPath)
folderSpec = cool.ExtendedAttributeListSpecification()
folderSpec.push_back("I","int")
folderSpec.push_back("S","string")
folderSpec.push_back("X","float")

f = db.createFolder(folderPath,folderSpec,"A single version folder",
                    cool.FolderVersioning.SINGLE_VERSION)

# Fill the folder
print "%s: fill folder"%argv[0]
payload = coral.AttributeList()
payload.extend("I","int")
payload.extend("S","string")
payload.extend("X","float")

payload["I"] = 1
payload["S"] = "one"
payload["X"] = 1.1

f.storeObject(cool.ValidityKeyMin, cool.ValidityKeyMax, payload)

print "%s: All done"%argv[0]
