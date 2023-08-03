Monitoring Metrics Script with Sleep Mechanism
This Bash script is designed to provide monitoring metrics for CPU usage, memory usage, and disk usage. It also offers the ability to monitor a specific service and restart it if necessary.

Usage
The script is intended to be run in a Bash environment and requires the following components:

Linux Operating System (Tested on Ubuntu and CentOS)
Bash Shell

To run the script, make sure it has executable permissions. You can set the permissions using the following command:

chmod +x script_name.sh

Once the script has the necessary permissions, you can execute it with the following command:

./script_name.sh

Options

Upon executing the script, you will be presented with a menu displaying various monitoring options:

Show the current CPU usage
Show the current memory usage
Show the current root disk usage
Monitor a specific service
Exit

Select the appropriate number corresponding to the desired option. If you select the "Monitor a specific service" option (option 4), you will be prompted to enter the name of the service you wish to monitor.

ShowCpuUsage()

This function retrieves the current CPU usage using the top command and displays it on the screen. It then waits for the user to press Enter to continue.

ShowMemUsage()

This function retrieves the current memory usage using the free command and displays the used memory in MB out of the total available memory. It then waits for the user to press Enter to continue.

ShowDiskUsage()

This function retrieves the current disk usage using the df command and displays the used disk space in GB out of the total available disk space. It then waits for the user to press Enter to continue.

MonSpecSrvc(service_name)

This function allows the user to monitor a specific service. It checks whether the provided service (service_name) is running using systemctl is-active. If the service is running, it informs the user; otherwise, it gives the option to restart the service by prompting the user for consent.

HandleError()

This function is called when the user enters an invalid option in the menu. It displays a meaningful error message instructing the user to select a valid option.
