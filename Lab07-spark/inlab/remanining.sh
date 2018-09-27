#!/bin/bash
shopt -s expand_aliases
alias errcho=">&2 echo"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7A Spark Assignment (In Class)-60613" )"
regex="([0-9|D]*).([a-z|.]*)"
workingDir="$PWD"
outputFile="output.txt"
appName="sparkPhraseCounter"
outputDir="output"

submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"

for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	dir=$(printf %q "$dir")
	dirPresent=0
	diffZero=0
	rollNumber=""
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')

	if [[ $fileName =~ $regex ]]; then
		rollNumber="${BASH_REMATCH[1]}"
		extension="${BASH_REMATCH[2]}"		

		if [[ ${#rollNumber} -ne 9 ]]; then
			errcho "$rollNumber does not match the rollNumber format"					
		fi

		if [[ -d $rollNumber ]]; then
			dirPresent=1
			cd $rollNumber
		fi

		if [[ -d "$outputDir" ]]; then
			cd $outputDir
			sed -i 's/\:/,/g' $outputFile
			sed -i 's/, /,/g' $outputFile
			sed -i 's/ ,/,/g' $outputFile
			sed -i 's/,,/,/g' $outputFile
			sed -i 's/(/[/g' $outputFile
			sed -i 's/)/]/g' $outputFile
			# sed -i 's/[[/[/g' $outputFile
			sed -i 's/\[\[/\[/g' $outputFile
			sed -i 's|],|,|g' $outputFile			
			diff $outputFile $workingDir/$outputDir/$outputFile > diff.txt
			if [[ $? -ne 0 ]]; then
				errcho "Diff doesn't tally for $rollNumber"
			else
				echo "$rollNumber"
				diffZero=1
			fi
			cd ..
		else
			errcho "No output file for $rollNumber $dir"
		fi

	else
		errcho "$fileName does not match the regex"		
	fi

	if [[ $dirPresent -eq 1 ]]; then
		cd ..
	fi
	cd ..
	# if [[ diffZero -eq 1 ]]; then
	# 	# echo "Removing ${dir:q}"
	# 	eval rm -r "${dir:q}"
	# fi
done
cd ..
