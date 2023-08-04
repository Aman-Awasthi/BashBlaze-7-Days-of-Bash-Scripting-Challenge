#!/bin/bash

# Extract error messages from the logfile and count their occurrences
error_messages=$(grep -oE '\[ERROR\] [^-0-9]\+' "$1" | sort | uniq -c | sort -nr)

# Display the top 5 most common error messages and their occurrence count
echo "Top 5 most common error messages:"
echo "$error_messages" | head -n 5
