#!/bin/bash

echo "-------------Log Analyzer Script-------------"
echo "Total errors: "
grep -c ERROR "$1"
echo "Total Critical alerts: "
grep -c CRITICAL "$1"
echo "Total Warnings: "
grep -c WARNING "$1"

echo "---------Total Critical Events---------"
grep -n CRITICAL $1

echo
echo "-----Total 5 error messages-----"
grep '\[ERROR\]' $1 | awk '{print  $4, $5, $6}' | awk '{sub("-", ""); print}' | sort | uniq -c | sort -nr | head -n 5

date_of_analysis=$(date "+%Y-%m-%d-%H-%M-%S")
summary_report="summary_reports_$date_of_analysis.txt"

total_line_processed=$(wc -l < "$1")
total_error_count=$(grep -c '\[ERROR\]' "$1")
top_errors=$(grep '\[ERROR\]' "$1" | awk '{print  $4, $5, $6}' | awk '{sub("-", ""); print}' | sort | uniq -c | sort -nr | head -n 5)
critical_event=$(grep -n '\[CRITICAL\]' "$1")

echo -e "Summary Report\n" > "$summary_report"
echo -e "Date of analysis: $date_of_analysis\n" >> "$summary_report"
echo -e "Log file name: " $1>> "$summary_report"
echo -e "\nTotal lines processed: $total_line_processed\n" >> "$summary_report"
echo -e "Total error count: $total_error_count\n" >> "$summary_report"
echo -e "Top 5 error messages with their occurrence count:\n$top_errors\n" >> "$summary_report"
echo -e "List of critical events with line numbers:\n$critical_event" >> "$summary_report"

echo "Summary report generated successfully in $summary_report"
