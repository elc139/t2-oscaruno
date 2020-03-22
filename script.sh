#!/bin/bash
SIZES=(1000000 2000000 3000000 4000000)
REPS=(4000 3000 2000 1000)
THREADS=(1 2 4)
EXECS=4

echo "tool,nthreads,size,repetitions,usec" > parciais.csv
echo "|size|repetitions|threads|usec(média)|speedup|" > tabela.md
echo "|:---:|:---:|:---:|:---:|:---:|" >> tabela.md

for j in {0..3}; do
    declare -a results
    for i in "${THREADS[@]}"; do
        size=$((${SIZES[$j]}/$i))
        rep=${REPS[$j]}
        media=0
        for ((k = 0 ; k < $EXECS ; k++)); do
            usec=($(./pthreads_dotprod/pthreads_dotprod $i $size $rep))
            echo "Pthreads,${i},${size},${rep},${usec[3]}" >> parciais.csv
            media=$(($media + ${usec[3]}))
        done
        media=$(($media / $EXECS))
        results+=($media)
        speedup=$(echo "scale=4; ${results[0]} / $media" | bc -l) 
        echo "|${size}|${rep}|${i}|${media}|${speedup}|" >> tabela.md
    done
    unset results
done