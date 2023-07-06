#!/bin/bash
 
sh /Users/ashulgupta/Desktop/BashScript/BoxPrinting.sh "GIT FETCH START ⚠️ ⚠️ ⚠️" "-3"
 
codeFolder="$1"
repos=($(ls ${codeFolder}))
 
createTempFile4Count() {
	count=0
	removeTempFile
	echo $count > $tempFilePath
}
export -f createTempFile4Count
 
removeTempFile() {
	if [[ -f $tempFilePath ]]; then
		rm $tempFilePath
	fi
}
export -f removeTempFile
 
tempFilePath="/Users/ashulgupta/Desktop/BashScript/Aliases/gitf_temp.lock"
 
 
gitFetchAll() {
	createTempFile4Count
	for i in ${!repos[@]}; do
		repoPath=${codeFolder}${repos[$i]}
		{
			{
				git -C $repoPath fetch &
				processId=$!
				wait $processId
			} && {
				flock -w 5 $tempFilePath 
				count=$(($(<$tempFilePath)+1)) && echo $count > $tempFilePath && printf "\n\rFETCHED ✅	:	 %32s	:	%16s\n\n" ${repos[$i]^^} "[$(($count))/${#repos[@]}]"
			} 
		} || {
			flock -w 5 $tempFilePath 
			count=$(($(<$tempFilePath)+1)) && echo $count > $tempFilePath && printf "\n\rFAILED ❌	:	 %32s	:	%16s\n\n" ${repos[$i]^^} "[$(($count))/${#repos[@]}]"
		} &
		# echo "FETCHED ✅			${repos[$i]^^} [$(($i+1))/${#repos[@]}]"
		# echo ${repos[i]}
	done
	wait
	removeTempFile
}
export -f gitFetchAll
 
 
gitUpdateBranches() {
	createTempFile4Count
	IFS=$'\n'
	branchListFile=($(</Users/ashulgupta/Desktop/BashScript/Aliases/gitf.csv))
	unset IFS
	for i in ${!branchListFile[@]}; do
		IFS=','
		branchDetails=(${branchListFile[$i]})
		unset IFS
		# echo "${branchDetails[0]}"
		# echo "${branchDetails[1]}"
		repoPath=${codeFolder}${branchDetails[0]}
		branchName=${branchDetails[1]}
		{
			{
				gitcommand="git -C $repoPath fetch origin $branchName:$branchName"
				eval $gitcommand &
				processId=$!
				wait $processId
			} && {
				flock -w 5 $tempFilePath 
				count=$(($(<$tempFilePath)+1)) && echo $count > $tempFilePath && printf "\n\rFETCHED ✅	:	 %24s	:	%24s	:	%16s\n\n" "${branchDetails[0]}" "${branchDetails[1]}" "[$(($count))/${#branchListFile[@]}]"
			} 
		} || {
			flock -w 5 $tempFilePath 
			count=$(($(<$tempFilePath)+1)) && echo $count > $tempFilePath && printf "\n\rFAILED ❌	:	 %24s	:	%24s	:	%16s\n\n" "${branchDetails[0]}" "${branchDetails[1]}" "[$(($count))/${#branchListFile[@]}]"
		} &
		# echo "FETCHED ✅			${repos[$i]^^} [$(($i+1))/${#repos[@]}]"
		# echo ${repos[i]}
	done
	wait
	removeTempFile
}
export -f gitUpdateBranches
 
 
gitFetchAll
gitUpdateBranches
 
echo "\n\n"
 
sh /Users/ashulgupta/Desktop/BashScript/BoxPrinting.sh "GIT FETCH COMPLETED ✅ ✅ ✅" "3"