#!/bin/bash

<<readme
This script performs backup and rotation
Usage: $0 /path/to/source_dir
readme

echo "Part-2"

#usage funtion
function display_usage {
        echo "Usage: $0 /path/to/source_dir"
}


#checks for valid input arg
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
        echo "Enter a valid directory!"
        display_usage
        exit 1
fi


#arg
source_dir="$1"


#function to create a backup
function create_backup {
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    local backup_dir="${source_dir}/backup_${timestamp}"

    # Create a zip archive of the directory
    zip -r "${backup_dir}.zip" "$source_dir" >/dev/null
    if [ $? -eq 0 ]; then
        echo "Backup created successfully: ${backup_dir}.zip"
    else
        echo "Error: Failed to create backup."
    fi
}


#function to perform backup rotation
function perform_rotation {
    local backups=($(ls -t "${source_dir}/backup_"*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 3 ]; then
        local backups_to_remove=("${backups[@]:3}")
        for backup in "${backups_to_remove[@]}"; do
            rm -f "$backup"
        done
    fi
}


create_backup
perform_rotation

