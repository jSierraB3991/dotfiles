#! /bin/bash


for ascii in $(ls *.txt)
do
    echo "Show $ascii"
    /usr/bin/neofetch --source $ascii 
done
