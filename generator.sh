#!/bin/bash
c=1
n=$2
d=$3

COLOR='\x1b[38;5;87m'
END='\x1b[0m'
/bin/rm -f tests/*
while [ $c -le $n ]
do
	/bin/rm -f Tetriminos-generator/sample.fillit
	/bin/rm -f sample.fillit
	let "r =  $(( ( RANDOM % $d )  + 1 ))"
	Tetriminos-generator/./tetri-gen $1 -f $r
	cp sample.fillit tests/test$c-$r
	echo "$COLOR\0test$c : $r tetris$END" && ./fillit "tests/test$c-$r"
		let "c++"
done

/bin/rm -f Tetriminos-generator/sample.fillit
/bin/rm -f sample.fillit
