#!/bin/bash

usage_tests()
{
	clear
	echo "$COLOR\0TN_TEST // FILLIT$END"
	sleep 1
	echo "$COLOR\0Usage tests$END"
	rm -rf toto tata
	echo "$COLOR\0No parameter test (should display usage): $END" && ./fillit | cat -e
	echo "$COLOR\0More than 1 parameter test (should display usage): $END" && ./fillit toto tata | cat -e
	echo "$COLOR\0[DONE]$END"
}

invalid_file_tests()
{
	#clear
	#echo "$COLOR\0TN_TEST // FILLIT$END"
	#sleep 1
	echo "$COLOR\0Invalid file tests$END"

	echo "$COLOR\0Non existing file test (should display 'error'): $END" 
	run_tests toto

	echo "$COLOR\nEmpty file test (should display 'error'): $END"
	touch resources/toto
	run_tests toto
	rm resources/toto

	echo "$COLOR\0Invalid grid tests(should display 'error'): $END"
	run_tests sample_test01
	run_tests sample_test02
	run_tests sample_test05

	echo "$COLOR\n[DONE]$END"
}

invalid_tetris_tests()
{
	local test_quantity=50
	local number_of_tetris=10
	local c=1

	clear
	echo "$COLOR\0TN_TEST // FILLIT$END"
	sleep 1
	echo "$COLOR\0Invalid tetris Tests$END"
	generate_grids -i $test_quantity $number_of_tetris

	while [ $c -le  $test_quantity ]
	do
		run_tests invalid_test_$c
		let "c++"
	done


	echo "$COLOR\n[DONE]$END"
}

minimum_map_size_tests()
{
	#clear
	#echo "$COLOR\0TN_TEST // FILLIT$END"
	#sleep 1
	echo "$COLOR\0Minimum Map Size Tests$END"

	run_tests sample_test03
	run_tests sample_test04

	echo "$COLOR\n[DONE]$END"
}

valid_tests()
{
	local test_quantity=50
	local number_of_tetris=3
	local c=1

	clear
	echo "$COLOR\0TN_TEST // FILLIT$END"
	sleep 1
	echo "$COLOR\0General Tests$END"

	local number_of_tetris=3
	generate_grids -v $test_quantity $number_of_tetris

	while [ $c -le $test_quantity ]
	do
		run_tests valid_test_$c
		let "c++"
	done

	echo "$COLOR\n[DONE]$END"
}

run_tests()
{
	resources/TN_fillit $1 > tests_outputs/TN_fillit_$1
	./fillit $1 > tests_outputs/user_fillit_$1
	diff -u tests_outputs/user_fillit_$1 tests_outputs/TN_fillit_$1 > tests_outputs/diff_output_$1
	if [ -s tests_outputs/diff_output_$1 ]
		then
			printf "\ntest_gnl$1, ex$b: BOOM"
			say boom
		else
			printf "$COLOR.$END"
			rm tests_outputs/user_fillit_$1
			rm tests_outputs/diff_output_$1
			rm tests_outputs/TN_fillit_$1
		fi
}

generate_grids()
{
	local validity=$1
	local test_quantity=$2
	local number_of_tetris=$3
	local counter=1

while [ $counter -le $test_quantity ]
do
	let "r =  $(( ( RANDOM % $number_of_tetris )  + 1 ))"
	resources/tetri-gen $validity -f $r
	if [ $validity = "invalid" ]
		then
		mv sample.fillit resources/invalid_test$c
	else
		mv sample.fillit resources/valid_test$c
	fi
	let "counter++"
done
}