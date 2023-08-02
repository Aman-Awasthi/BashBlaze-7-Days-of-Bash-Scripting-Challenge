#! /bin/bash

echo "Part 1: File and Directory Exploration :"

echo
echo "Welcome to the Interactive File and Directory Explorer!"

while true; do
    echo "Files & directories in current path are : "
    ls -lh | awk 'NR > 1 {print $9, "("$5")"}'
    read -p "Do you want to continue exploring? (y/n):" input
    [[ "$input" != "y" ]] && break
done

echo
echo "Part 2: Character Counting: "
echo


while true; do
read -rp "Enter a line of text (Press Enter without text to exit): " string 
	if [ -z "$string" ]; then
		break
	fi
character_count=$(echo -n $string | wc -c)
echo "Character count: $character_count"
done

