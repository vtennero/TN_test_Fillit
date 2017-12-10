#!/bin/bash

COLOR='\x1b[38;5;220m'
END='\x1b[0m'
source resources/main_tests.sh

sh resources/animation.sh

echo "$COLOR\0TN_TEST // FILLIT$END"
sleep 1
echo "$COLOR\0Norminette...$END"
#norminette | grep Error > norminette_log.txt
#norminette | grep Warning >> norminette_log.txt

#norminette > norminette_log.txt
#cat norminette_log.txt | grep "may not compile"
#cat norminette_log.txt | grep "Error"

#if [ -s norminette_log.txt ]
#	then
#	cat norminette_log.txt
#	say norminette
#fi
echo "$COLOR\0[DONE]$END"
#read -p "Press enter to continue..."

echo "$COLOR\0Makefile...$END"
make -s
#time (make -s fclean && make -s && make -s clean && make -s re)
echo "$COLOR\0[DONE]$END"
#read -p "Press enter to continue..."

mkdir -p tests_outputs

usage_tests
read -p "Press enter to continue..."
invalid_file_tests
read -p "Press enter to continue..."
invalid_tetris_tests
read -p "Press enter to continue..."
minimum_map_size_tests
read -p "Press enter to continue..."
valid_tests
read -p "Press enter to continue..."

echo "$COLOR\0[ALL DONE]$END"
