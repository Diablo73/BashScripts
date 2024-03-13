#!/bin/bash

# regex for integer
re='^[0-9]+$'

# If the first parameter is not present (no parameter is provided) or is non-integer (user inputs only author as parameter)
countOfMonths="$1"
if [[ -z $countOfMonths || ! $countOfMonths =~ $re ]]; then
	countOfMonths=2
fi

# If the second parameter is not present (only 1 parameter provided) or is non-integer (user inputs only author as parameter)
author="$2"
if [[ -z $author && -z "$1" ]]; then
	author="Ashul Gupta"
elif [[ ! "$1" =~ $re ]]; then
	author="$1"
fi

# Path of folder containing all repos
CODE_DIR=~/Desktop/Code
cd $CODE_DIR

total_plus=0
total_minus=0

current_month=$(date +"%m")
current_year=$(date +"%Y")

# If current_month is December
if [ $current_month -eq 12 ]; then
	next_month=01
	next_year=$((current_year + 1))
else
	next_month=$(printf "%02d" $((10#$current_month + 1)))
	next_year=$current_year
fi

# counter to compare with number of months the user wants the data of
counter=0

while [ $counter -lt $countOfMonths ]; do
	echo "------------------------------"
	echo "$current_year-$current_month-01 --- $next_month-$next_year-01"
	echo "------------------------------"

	for repo in */ ; do
		# Navigate into the repo
		cd $repo

		output=$(git log --all --author="$author" --since="$current_year-$current_month-01" --before="$next_month-$next_year-01" --pretty=tformat: --numstat | grep -v '^-' | awk '{ plus+=$1; minus+=$2 } END { print plus, minus }')

		# Navigate out of the repo
		cd ..

		# Segregate the stats by git
		plus=$(echo $output | cut -d' ' -f1)
		minus=$(echo $output | cut -d' ' -f2)
		
		# If both numbers are null, then continue
		if [ -z "$plus" ] && [ -z "$minus" ]; then
			continue
		fi

		# If either number is null, consider it as 0
		if [ -z "$plus" ]; then
			plus=0
		fi
		if [ -z "$minus" ]; then
			minus=0
		fi

		# Add the numbers to the total
		total_plus=$((total_plus + plus))
		total_minus=$((total_minus + minus))
		
		# Print for a single repo in the iterating month
		printf "%-50s : %5s   %5s\n" "${repo}" "+${plus}" "-${minus}"
	done

	# Print for the entire month
	echo "------------------------------"
	printf "%-50s =  %10s" "TOTAL" "+${total_plus} + |-${total_minus}| = $((${total_plus} + ${total_minus}))\n"
	echo "------------------------------"
	echo

	# Stats of new month start from 0
	total_plus=0
	total_minus=0

	next_month=$current_month
	next_year=$next_year

	# If current_month is January
	if [ $current_month -eq 01 ]; then
		current_month=12
		current_year=$((current_year - 1))
	else
		current_month=$(printf "%02d" $((10#$current_month - 1)))
		current_year=$current_year
	fi

	counter=$((counter + 1))
done
