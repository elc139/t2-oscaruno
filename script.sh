#!/bin/bash
SIZES=(1000000 2000000 3000000 4000000)
REPS=(4000 3000 2000 1000)
THREADS=(1 2 4)
echo "tool,nthreads,size,repetitions,usec" > parciais.csv

for j in {0..3}; do
    for i in "${THREADS[@]}"; do
        for k in {1..3}; do
            size=$((${SIZES[$j]}/$i))
            rep=${REPS[$j]}
            usec=($(./pthreads_dotprod/pthreads_dotprod $i $size $rep))
            echo "Pthreads,${i},${size},${rep},${usec[3]}" >> parciais.csv
        done
    done
done
