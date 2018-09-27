#!/bin/bash
shopt -s expand_aliases
alias errcho=">&2 echo -e"

dump="/dev/null"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7B Spark Assignment (Take Home)-64791" )"
fullRegex="^((.*)([0-9]{2}[0-9|D][0-9]{6})(.*))\.(tar\.gz|zip)$"
rollNumberFile="sortedRollNumber.txt"

echo $submissionDir
submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"


for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	echo $dir
	dir=$(printf %q "$dir")
	echo $dir
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')
	echo $fileName
	if [[ $fileName =~ $fullRegex ]]; then
		rollNumber="${BASH_REMATCH[3]}"
		cat ../../$rollNumberFile | grep "$rollNumber" > $dump
		if [[ $? -eq 0 ]]; then
			cd ..
			eval rm -R "${dir:q}"
		else
			cd ..
		fi
	fi
	echo ""
done
cd ..
