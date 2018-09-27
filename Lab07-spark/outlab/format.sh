#!/bin/bash
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7A Spark Assignment (In Class)-60613" )"
regex="([0-9|D]*).([a-z|.]*)"
workingDir="$PWD"

echo $submissionDir
submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"

for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	echo $dir
	dir=$(printf %q "$dir")
	echo $dir
	dirPresent=0
	rollNumber=""
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')

	if [[ $fileName =~ $regex ]]; then
		mv $fileName $workingDir/dump
		rm -rf ./*
		mv $workingDir/dump/$fileName ./
		rollNumber="${BASH_REMATCH[1]}"
		extension="${BASH_REMATCH[2]}"		
		echo $extension
		echo $rollNumber

		if [[ ${#rollNumber} -ne 9 ]]; then
			echo "$rollNumber does not match the rollNumber format"					
		fi

		if [[ "$extension" == "zip" ]]; then
			echo "Extension is zip"
			unzip -qq $fileName
		elif [[ "$extension" == "tar.gz" ]]; then
			echo "Extension is tar gz"
			tar -xzf $fileName
		else
			echo "Unknown extension"
		fi

		count=$(ls -1 *.java 2>/dev/null | wc -l)
		if [[ $count -ne 0 ]]; then
			echo "Java file directly exists"
		elif [[ -d $rollNumber ]]; then
			echo "RollNumber directory exists"
			dirPresent=1
			cd $rollNumber
		else
			echo "Unknown submission format"
		fi
		javaFileName=$(ls -1 *.java 2>/dev/null)
		echo $javaFileName
		if [[ $(echo $javaFileName | wc -w) -ne 1 ]]; then
			echo "Multiple java files found"
		fi
		substitute=$( echo "\"${PWD}/output\"")
		echo $substitute
		inputPath=$( echo "\"$workingDir/newsdata\"")
		sed -i 's,String outputPath=.*;,String outputPath='"$substitute"';,g' $javaFileName		
		sed -i 's,String inputPath=.*;,String inputPath='"$inputPath"';,g' $javaFileName
		sed -i -e 's,public class [_a-zA-Z0-9]* {,public class phraseCounter {,g' $javaFileName

		head -n 1 $javaFileName | grep -q '^package'
		if [[ $? -eq 0 ]]; then
			sed -i '1d' $javaFileName
		fi
		cat $javaFileName | grep '^package'
	else
		echo "$fileName does not match the regex"		
	fi

	if [[ $dirPresent -eq 1 ]]; then
		cd ..
	fi
	cd ..
	echo ""
done
cd ..
