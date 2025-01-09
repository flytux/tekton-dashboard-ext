#!/bin/bash
i=0
while read -r a b c d; do
    id+=("$a")
    hostname+=("$b")
    ip+=("$c")
    role+=("$d")
    ((i++))
done < node-list

c=0
while  (( $c < $i ))
do 
  echo "ID : " ${id[$c]}
  echo "HOSTNAME : " ${hostname[$c]}
  echo "IP : " ${ip[$c]}
  echo "ROLE : " ${role[$c]}
  ((c++))
done
