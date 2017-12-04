#!/bin/bash

COLOR='\x1b[38;5;220m'
END='\x1b[0m'

echo "$COLOR\0Norminette...$END"
norminette | grep Error
echo "$COLOR\0[DONE]$END"

echo "$COLOR\0Makefile...$END"
time (make fclean && make && make clean && make re)
echo "$COLOR\0[DONE]$END"

echo "$COLOR\0No parameter test (should display usage): $END" && ./fillit | cat -e
echo "$COLOR\0More than 1 parameter test (should display usage): $END" && ./fillit toto tata | cat -e

echo "$COLOR\0Non existing file test (should display 'error'): $END" && ./fillit toto | cat -e
touch toto
echo "$COLOR\0Empty file test (should display 'error'): $END" && ./fillit toto | cat -e
rm toto
echo "$COLOR\0Invalid grid test #1 (should display 'error'): $END" && ./fillit sample_test01 | cat -e
echo "$COLOR\0Invalid grid test #2 (should display 'error'): $END" && ./fillit sample_test02 | cat -e
read -p "Press enter to continue..."

mkdir tests

echo "$COLOR\0Invalid tetris tests$END"
sh generator.sh -i 15 10

echo "$COLOR\0[DONE]$END"
read -p "Press enter to continue..."

echo "$COLOR\0Minimum grid size test #1 (size should be 2x2)$END" && ./fillit sample_test03 | cat -e
echo "$COLOR\0Minimum grid size test #2 (size should be 3x3)$END" && ./fillit sample_test04 | cat -e
read -p "Press enter to continue..."

echo "$COLOR\0Valid tetris tests #1$END"
sh generator.sh -v 5 3
read -p "Press enter to continue..."

echo "$COLOR\0Valid tetris tests #2$END"
sh generator.sh -v 5 5
read -p "Press enter to continue..."

echo "$COLOR\0Valid tetris tests #3$END"
sh generator.sh -v 5 8
echo "$COLOR\0[DONE]$END"
echo "$COLOR\0[ALL DONE]$END"
