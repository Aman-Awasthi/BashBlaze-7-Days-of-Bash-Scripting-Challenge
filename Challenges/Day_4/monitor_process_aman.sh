#! /bin/bash

#Checking if we have entercorrect number of argument

checkargument() {
    if [ "$#" -ne 1 ]; then
    echo "Entered argument is incorrect"
    exit 1
    fi
} 

#Chekcing if the process is already running using systemcthl is-active

processrunning() {
    if systemctl is-active --quiet "$1"; then
        echo "$1 is already running"
        return 0
    else
	echo "$1 is in stopped state"
        return 1
    fi
}

#Function to restart process if the process is not running

restartprocess() {
    local processname="$1"
    local maxattempts=3
    local attempt=1

    while [ $attempt -le $maxattempts ]; do
        echo "Restarting process $processname (Attempt $attempt)" #Script will attempt to restart the process 3 times
       sudo systemctl restart "$processname"
        if systemctl is-active --quiet "$processname"; then
            echo "$processname restarted successfully"
            return 0
        fi
        ((attempt++))
    done
    echo "Failed to restart $processname"
    return 1

# Calling notify function to send email to admin after 3 failed restart attempts
	notify "processname"
	echo "Failed to restart $processname after $maxattempts"
	return 1

}

#Function to send email to admin

notify() {
    local processname="$1"
    local emailaddr="amana6420@gmail.com"
    Subject="Alert | $processname is in hung state"
    message="Unable to restart $processname after $maxattempts, need manual intervention."

    echo "$message" | mail -s "$Subject" "$emailaddr"
}

#Main function...

main() {
    checkargument "$@"
    processname="$1"
    if ! processrunning "$processname"; then
        restartprocess "$processname"
    fi
}

# Call the main function with command-line arguments...

main "$@"
