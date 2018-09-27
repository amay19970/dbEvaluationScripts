import sys
import os

def printE( *args, **kwargs):
	print( *args, file=sys.stderr, **kwargs)

def reportError( message, exitCode=1, end="\n" ):
	printE( message, end=end )
	exit( exitCode )

if len( sys.argv ) != 2:
	reportError( "Incorrect argument count" )

fileName = sys.argv[1]
path, name = os.path.split( fileName )
with open( sys.argv[1], 'r' ) as inputFile:
	lines = [ x.strip()[1:-1].split(",") for x in inputFile.readlines() ]

lines = [ x[:-1] + [ abs( int( x[-1] ) ) ] for x in lines ]
numbers = [ x[-1] for x in lines ]

if not all( numbers[i + 1] <= numbers[i] for i in range( len( numbers ) - 1 ) ):
	reportError( "Output not sorted by overall sentiment", 2 )

lines.sort()
lines = [ x[:-1] + [ str( x[-1] ) ] for x in lines ]
outputFileName = os.path.join( path, "sortedOutput.txt" )
with open( outputFileName, 'w' ) as outputFile:
	for line in lines:
		print( ",".join( line ), file=outputFile )