#!/bin/bash

#Fuction to show CPU usage
ShowCpuUsage() {
	top -bn1 | grep Cpu | awk '{print "Current CPU Usage: " $2 "%"}'
	echo
	read -p "Press Enter to continue..."
}

#Function to show Memory usage
ShowMemUsage() {

    	free -m  | awk 'NR==2{printf "Used memory is %s MB out of %s MB\n", $3, $2}'
	echo
	read -p "Press Enter to continue..."
}

#Function to show Disk uage
ShowDiskUsage() {
  	df -h | awk 'NR==2{printf "Used disk is %s out of %s\n", $3, $2}'
	echo
	read -p "Press Enter to continue..."
}

#Function to monitor any service or to restart any service
MonSpecSrvc() {
    
    echo "----- Monitoring service: $1 -----"
    service_name="$1"
    if systemctl is-active --quiet "$service_name"; then
        echo "$service_name is running."
	echo
    else
        echo "$service_name is not running"
	echo
	read -p "Do you want to restart $service_name (y/n)" consent
        if [ "$consent" = "y" ] || [ "$consent" = "Y" ]; then
            sudo systemctl start "$service_name"
            echo "$service_name has been started."
	    echo
        fi
    fi
    read -p "Press Enter to continue..."
}

#Fuction to handle error
HandleError() {
	echo "Invalid choice, please select any of the below option:"
	echo
}
    

#main function
main() {
	echo
	echo "------Monitoring Metrics Script with Sleep Mechanism------"
	while true; do
	echo "1. Show the current CPU usage"
	echo "2. Show the urrent memory usage"
	echo "3. Show the current root disk usage"
	echo "4. Monitor a specific service"
	echo "5. Exit"
	echo
	read -p "Enter the option: " option

case $option in
        1)
            ShowCpuUsage
            ;;
        2)
            ShowMemUsage
            ;;
        3)
            ShowDiskUsage
            ;;
        4) 
            read -p "Enter the name of service to monitor:" service
            MonSpecSrvc "$service"
            ;;
        5)
            echo "Exiting the script"
            exit 0
            ;;
        *)
            HandleError
            ;;  
    esac
done
}

main

