#!/bin/bash

inputText="$1"
if [[ -z $inputText ]]; then
	inputText="START!!!"
fi
extraLength="$2"
if [[ -z $extraLength ]]; then
	extraLength=0
fi
borderLength="$3"
if [[ -z $borderLength ]]; then
	borderLength=128
fi
borderString="#"

blankSpaceLength=$(($borderLength-2-${#inputText}-${extraLength}))
if [[ $(($blankSpaceLength%2)) -eq 1 ]]; then
	blankSpaceLength=$(($blankSpaceLength-2))
fi
dotText="."
titleText=$borderString

horizEdge=""
for (( i = 0; i < $borderLength; i++ )); do
	horizEdge=$horizEdge$borderString
done
horizEdge="$horizEdge"


titleTextPrinting() {
	titleText="$1"
	for (( i = 0; i < $(($blankSpaceLength/2)); i++ )); do
		titleText=$titleText$dotText
	done
}

titleTextPrinting "$titleText"
titleText+=$inputText
titleTextPrinting "$titleText"
titleText="$titleText$borderString"

middleRow="${titleText//./ }"
topRow=${horizEdge:0:$((${#middleRow}+${extraLength}))}
bottomRow=${horizEdge:0:$((${#middleRow}+${extraLength}))}


echo "${topRow}"
echo ""
echo "${middleRow}"
echo ""
echo "${bottomRow}"
echo ""
