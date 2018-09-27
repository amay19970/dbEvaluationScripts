#!/bin/bash

shopt -s expand_aliases
alias errcho=">&2 echo -e"

dirs=$(cat dirNames.txt)
dump="/dev/null"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7B Spark Assignment (Take Home)-64791" )"
regex="^([0-9|D]*)\.([a-z|\.]*)$"
fullRegex="^((.*)([0-9]{2}[0-9|D][0-9]{6})(.*))\.(tar\.gz|zip)$"
workingDir="$PWD"

echo $submissionDir
submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"

for dir in $dirs; do
	dir=$(echo "$dir" | sed 's/\\\\/\ /g')
	dir=$(printf %q "$dir")
	echo $dir
	eval cd "${dir:q}"
	ls
	fileName=$(ls *tar.gz *.zip)
	echo $fileName
	if [[ $fileName =~ $regex ]]; then
	
		extension=${BASH_REMATCH[5]}
		echo $extension
		rm $fileName
		if [[ $extension == "tar.gz" ]]; then
			tar -zcf $fileName ./*
		elif [[ $extension == "zip" ]]; then
			zip	-r $fileName ./*
		else
			errcho "Some error occured, extension not proper $extension $dir"
		fi

	else
		errcho "Some error occured, regex not matched $dir $fileName"
	fi

	cd ..
done