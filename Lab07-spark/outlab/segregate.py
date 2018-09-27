import csv
import sys

lines = []
rollNumbers = []
with open('allMarks.csv', 'r') as csvfile:
	lines = [ line for line in csv.reader( csvfile, delimiter=',', quotechar='"' ) ]

with open( 'sortedRollNumber.txt', 'r' ) as rollNumberFile:
	rollNumbers = rollNumberFile.readlines()
	rollNumbers = [ x.strip() for x in rollNumbers ]


matchLines = [ line for line in lines if line[0] in rollNumbers ]
nonMatchLines = [ line for line in lines if line[0] not in rollNumbers ]

with open( 'non-diff-cases.csv', 'w' ) as csvfile:
	csvWriter = csv.writer( csvfile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL )
	for row in nonMatchLines:
		if row[1].strip() != '0' or row[3].strip() != '0':
			csvWriter.writerow( row )

with open( 'fullMarks.txt', 'w' ) as rollNumberFile:
	for line in nonMatchLines:
		if line[1].strip() == '5' and line[3].strip() == '5':
			print( line[0], file=rollNumberFile )	

with open( 'incorrectUpdates.txt', 'w' ) as rollNumberFile:
	nonMatchLines.sort()
	for line in matchLines:
		if line[1].strip() != '5' or line[3].strip() != '5':
			print( line[0], file=rollNumberFile )