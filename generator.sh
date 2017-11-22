#!/bin/bash
c=1
n=10
/bin/rm -f tests/*
while [ $c -le $n ]
do
	/bin/rm -f Tetriminos-generator/sample.fillit
	/bin/rm -f sample.fillit
	let "r =  $(( ( RANDOM % 10 )  + 1 ))"
	Tetriminos-generator/./tetri-gen $1 -f $r
	#if [ $c -ge 2 ]; then
	#/bin/rm -f tests/*
#fi
	cp sample.fillit tests/test$c-$r
		echo "test$c : $r tetris" && ./fillit "tests/test$c-$r"
		let "c++"
done

/bin/rm -f Tetriminos-generator/sample.fillit
/bin/rm -f sample.fillit
