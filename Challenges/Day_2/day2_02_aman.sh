#! /bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

if [ ! -d "$directory_path" ]; then
    echo "Error: Directory does not exist!"
    exit 1
fi

timestamp=$(date +%Y%m%d%H%M%S)
backup_folder="${directory_path}/backup_${timestamp}"
mkdir -p "$backup_folder"

cp -r "$directory_path"/* "$backup_folder"

backup_folders=("$directory_path"/backup_*)
backup_count=${#backup_folders[@]}
sorted_backups=($(printf '%s\n' "${backup_folders[@]}" | sort))

if [ $backup_count -gt 3 ]; then
    folders_to_remove=$((backup_count - 3))
    for ((i = 0; i < $folders_to_remove; i++)); do
        rm -r "${sorted_backups[i]}"
    done
fi

echo "Backup completed successfully. Backup folder: $backup_folder"
