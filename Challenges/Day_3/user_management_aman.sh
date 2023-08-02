#!/bin/bash

options() {
	echo "Options: $0"
	echo "  -c, --create     Create a new user account"
  	echo "  -d, --delete     Delete an existing user account"
	echo "  -r, --reset      Reset the password of an existing user account"
  	echo "  -l, --list       List all user accounts on the system"
  	echo "  -h, --help       Display this help message"
}
create_account() {
	read -p "Enter the new username: " username
	if id $username &>/dev/null; then
		echo "'$username' already exists"
		exit 1
	fi

	sudo useradd -m -s /bin/bash "$username" &> /dev/null 
	read -s -p "Enter the password for '$username': " password
	echo "$username:$password" | sudo chpasswd
	echo "User account '$username' created successfully"
}
delete_account() {
	read -p "Enter the username to delete: " username
	if ! id $username &> /dev/null; then
		echo "'$username' doesn't exists"
		exit 1
	fi

	sudo userdel -r "$username" &> /dev/null
	echo "User account $username deleted successfully"
}
reset_password() {
	read -p "Enter the username to reset the password: " username
	if ! id $username &> /dev/null; then
		echo "'$username' doesn't exists"
		exit 1 
	fi

	read -s -p "Enter the password for '$username': " password
	echo "$username:$password" | sudo chpasswd
	echo " Password reset successfully for '$username'"
}
list_accounts() {
	echo "List of user accounts: "
  	awk -F: '{printf "Username: %-15s UID: %s\n", $1, $3}' /etc/passwd
}


while [[ $# -gt 0 ]]; do
	case "$1" in
-c)
	create_account
	exit 0
	;;
-d)
  	delete_account
      	exit 0
      	;;
-r)
	reset_password
	exit 0
	;;
-l)
	list_accounts
	exit 0
	;;
-h)
	options
	exit 0
	;;
*)
	echo "Invalid option"
	options
	exit 1
	;;


esac
shift
done

options
exit 1
