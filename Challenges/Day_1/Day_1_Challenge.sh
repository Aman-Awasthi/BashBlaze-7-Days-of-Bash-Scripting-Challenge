#!/bin/bash

# Day 1 of the Bash Scripting Challenge! Today, we will cover the basics of bash scripting to get you started.
#Task 1 - To create proper comments

#Task 2 - Create a bash script that uses echo to print a message
echo "This is Day 1 of Challenge"
echo

#task 3 - Create a bash script that declares variables and assigns values to them.

V1="Value1"
V2="Value2"

echo "Declared variables are $V1 $V2" 
#Task 4 - Create a bash script that takes two variables (numbers) as input and prints their sum using those variables.

echo 
echo "Enter two values to add" 

read -p "Enter first vaulue: " num1
read -p "Enter second value: " num2

sum=$((num1+num2))

echo "Sum is $sum"

# Task 5 - Create a bash script that utilizes at least three different built-in variables to display relevant information.
echo
echo "User name of curresnt user is $USER"
echo "Home directory of current user is $HOME"
echo "Present working directory is $PWD"

#Task 6 - Create a bash script that utilizes wildcards to list all the files with a specific extension in a directory.
echo
echo "Files with .txt extension in the current directory:"
ls *.txt


