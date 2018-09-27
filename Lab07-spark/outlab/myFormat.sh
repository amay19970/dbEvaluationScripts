#!/bin/bash
shopt -s expand_aliases
alias errcho=">&2 echo -e"

dump="/dev/null"
submissionDir="$( printf %q "CS 387-2018-1-Assignment 7B Spark Assignment (Take Home)-64791" )"
regex="^([0-9|D]*)\.([a-z|\.]*)$"
fullRegex="^((.*)([0-9]{2}[0-9|D][0-9]{6})(.*))\.(tar\.gz|zip)$"
workingDir="$PWD"
dirFile="${workingDir}/dirNames.txt"

echo $submissionDir
submissions=$(eval ls -1 "${submissionDir:q}" | sed 's/\ /\\/g')
eval cd "${submissionDir:q}"

function extractArchive {
	retval=0
	echo "extension=$1 fileName=$2"
	if [[ "$1" == "zip" ]]; then
		echo "Extension is zip"
		unzip -oqq $2
	elif [[ "$1" == "tar.gz" ]]; then
		echo "Extension is tar gz"
		tar -xzf $2
	else
		errcho "Unknown extension"
		retval=1
	fi
	return $retval
}

function checkFormat {
	dirPresent=0
	fileName=$1
	dir=$2
	if [[ $fileName =~ $fullRegex ]]; then
		rollNumber="${BASH_REMATCH[3]}"
		extension="${BASH_REMATCH[5]}"
		echo "extension $extension"
		ls
		echo "rollNumber: $rollNumber"

		if [[ ${#rollNumber} -ne 9 ]]; then			
			errcho "$dir :: $rollNumber does not match the rollNumber format"
			return $dirPresent
		fi

		extractArchive $extension $fileName
		if [[ $? -ne 0 ]]; then
			errcho "$dir :: Archive extraction failed"
			return $dirPresent
		fi

		count=$(ls -1 *.java 2>/dev/null | wc -l)
		echo "File Name: ${BASH_REMATCH[1]}"
		if [[ $count -ne 0 ]]; then
			echo "Java file directly exists"
		elif [[ -d ${BASH_REMATCH[1]} ]]; then
			echo "RollNumber directory exists"
			dirPresent=1
			cd ${BASH_REMATCH[1]}
		else
			errcho "$dir :: Unknown submission format"
			return $dirPresent
		fi

		javaFileName=$(ls -1 *.java 2>/dev/null)
		echo $javaFileName
		if [[ $(echo $javaFileName | wc -w) -ne 1 ]]; then
			errcho "Multiple java files found"
		fi

		head -n 1 $javaFileName | grep -q '^package'
		if [[ $? -eq 0 ]]; then
			sed -i '1d' $javaFileName
		fi
		cat $javaFileName | grep '^package' >&2

		cat $javaFileName | grep '^[[:space:]]*String[[:space:]]*inputPath[[:space:]]*=[[:space:]]*".*"[[:space:]]*;.*$' > $dump
		outputPath=$?
		cat $javaFileName | grep '^[[:space:]]*String[[:space:]]*outputPath[[:space:]]*=[[:space:]]*".*"[[:space:]]*;.*$' > $dump
		inputPath=$?
		if [[ $inputPath -ne 0 ]]; then
			errcho "$rollNumber $dir"
		fi

		cat $javaFileName | grep '".*/positive\.txt"' > $dump
		if [[ $? -eq 0 ]]; then
			sed -i 's/positive.txt/positive-words.txt/g' $javaFileName
			sed -i 's/negative.txt/negative-words.txt/g' $javaFileName
			echo "${dir:q}" | sed 's/\ /\\/g' >> $dirFile
		fi
		
		cat $javaFileName | grep '".*/positive-words\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber positive-words" 		
		fi

		cat $javaFileName | grep '".*/negative-words\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber negative-words"
		fi

		cat $javaFileName | grep '".*/entities\.txt"' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "$dir $rollNumber entities"
		fi

		cat $javaFileName | grep -e 'public[[:space:]]*class[[:space:]]*[_a-zA-Z0-9]*' > $dump
		if [[ $? -ne 0 ]]; then
			errcho "class name $dir $rollNumber entities"
		fi

	else
		errcho "$dir :: $fileName does not match the full regex"
	fi
	return $dirPresent
}

if [[ -f $dirFile ]]; then
	rm $dirFile
fi

for dir in $submissions; do
	dir=$(echo "$dir" | sed 's/\\/\ /g')
	echo $dir
	dir=$(printf %q "$dir")
	echo $dir
	eval cd "${dir:q}"
	fileName=$(ls | grep -E '[0-9]*.(tar.gz|.zip)')
	echo $fileName

	checkFormat $fileName "$dir"

	if [[ $? -eq 1 ]]; then
		cd ..
	fi
	cd ..
	echo ""
done
cd ..
