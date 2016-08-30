#!/bin/bash

if [ $1 -gt 5 ]; then
    exit
fi

param=$1
initialPos=49

let headerRow=2**$[6-$param]-1
for (( i=0; i<$headerRow; i++))
do
    for (( k=0; k<100; k++))
    do
        echo "_\c"
    done
    echo
done

for (( i=0; i<$param; i++))
do
    firstPos=${initialPos}
    for (( j=$[$param-$i-1]; j>0; j--))
    do
        let firstPos=${firstPos}-2**$[5-$j]
    done
    #echo "firstPos: "${firstPos}

    deltaIndex=$[7-$param+$i]
    let delta=2**${deltaIndex}
    let countY=2**$[$param-$i-1]

    let row=2**$[5-$param+$i]
    for (( j=0; j<$row; j++))
    do
        temp=""
        matchedNO=0
        firstMatch=0
        
        let yPos=${firstPos}
        let xPos=${yPos}-${row}+${j}
        for (( k=0; k<100; k++))
        do
            if [ $matchedNO -lt $countY ]; then
                if [ $firstMatch -eq 1 ]; then
                    if [ $k -eq ${xPos} ]
                    then
                        temp=${temp}"1"
                        matchedNO=$[$matchedNO+1]
                        let yPos=${firstPos}+${matchedNO}*${delta}
                        let xPos=${yPos}-${row}+${j}
                        firstMatch=0
                    else
                        temp=${temp}"_"
                    fi
                else
                    if [ $k -eq ${xPos} ]
                    then
                        temp=${temp}"1"
                        #matchedNO=$[$matchedNO+1]
                        let xPos=${yPos}+${row}-${j}
                        firstMatch=1
                    else
                        temp=${temp}"_"
                    fi
                fi
            else
                temp=${temp}"_"
            fi
        done
        echo $temp
    done

    for (( j=0; j<$row; j++))
    do
        temp=""
        matchedNO=0

        let yPos=${firstPos}
        for (( k=0; k<100; k++))
        do
            #echo "yPos: "$yPos
            if [ $matchedNO -lt $countY ]; then
                if [ $k -eq $yPos ]; then
                    temp=${temp}"1"
                    matchedNO=$[$matchedNO+1]
                    let yPos=${firstPos}+${matchedNO}*${delta}
                else
                    temp=${temp}"_"
                fi
            else
                temp=${temp}"_"
            fi
        done
        echo $temp
    done

done
