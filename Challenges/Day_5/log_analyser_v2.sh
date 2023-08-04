#!/bin/bash

# Function to count total errors
function count_errors() {
    echo "Total errors: "
    grep -c ERROR "$1"
}

# Function to count total critical alerts
function count_critical_alerts() {
    echo "Total Critical alerts: "
    grep -c CRITICAL "$1"
}

# Function to count total warnings
function count_warnings() {
    echo "Total Warnings: "
    grep -c WARNING "$1"
}

# Function to display total critical events with line numbers
function total_critical_events() {
    echo "---------Total Critical Events---------"
    grep -n CRITICAL "$1"
}

# Function to display top 5 error messages with occurrence count
function top_5_error_messages() {
    echo
    echo "-----Total 5 error messages-----"
    grep '\[ERROR\]' "$1" | awk '{print  $4, $5, $6}' | awk '{sub("-", ""); print}' | sort | uniq -c | sort -nr | head -n 5
}

# Function to generate summary report
function generate_summary_report() {
    date_of_analysis=$(date "+%Y-%m-%d-%H-%M-%S")
    summary_report="summary_reports_$date_of_analysis.txt"

    total_line_processed=$(wc -l < "$1")
    total_error_count=$(grep -c '\[ERROR\]' "$1")
    top_errors=$(grep '\[ERROR\]' "$1" | awk '{print  $4, $5, $6}' | awk '{sub("-", ""); print}' | sort | uniq -c | sort -nr | head -n 5)
    critical_event=$(grep -n '\[CRITICAL\]' "$1")

    echo -e "Summary Report\n" > "$summary_report"
    echo -e "Date of analysis: $date_of_analysis\n" >> "$summary_report"
    echo -e "Log file name: $1\n" >> "$summary_report"
    echo -e "Total lines processed: $total_line_processed\n" >> "$summary_report"
    echo -e "Total error count: $total_error_count\n" >> "$summary_report"
    echo -e "Top 5 error messages with their occurrence count:\n$top_errors\n" >> "$summary_report"
    echo -e "List of critical events with line numbers:\n$critical_event" >> "$summary_report"

    echo "Summary report generated successfully in $summary_report"
}

# Main script
function main() {
    echo "-------------Log Analyzer Script-------------"
    
    # Check if the log file path is provided as an argument
    if [ -z "$1" ]; then
        echo "Please provide the path to the log file as an argument."
        exit 1
    fi

    count_errors "$1"
    count_critical_alerts "$1"
    count_warnings "$1"
    total_critical_events "$1"
    top_5_error_messages "$1"
    generate_summary_report "$1"
}

# Call the main function with the provided log file path as an argument
main "$1"

