#!/bin/bash

# Check if the number of arguments passed to the script is equal to 2
if [ "$#" -ne  2 ]; then
 echo "Usage: $0 <source-direcotry> <destination-directory>"
 exit 1
fi

# Assign the first argument to the variable source_dir and the second argument to the variable destination_dir
source_dir=$1
destination_dir=$2

# Check if the destination directory exists, and create it if it doesn't
if [ ! -d "$destination_dir" ]
then
 echo" Dirctory doesn't exist creating one"
 mkdir -p $destination_dir
fi

# If the destination directory exists, prompt the user whether to overwrite existing files or skip them
if [ -e "$destination_dir" ]
then
 read -p "You are sure you want to overwite existing files (Y/N):" ans
 if [ $ans == "Y" ] || [ $ans == "y" ]
 then
  # If the user chooses to overwrite existing files, copy all files and subdirectories from the source directory to the destination directory, while preserving permissions and ownership
  cp -rf $source_dir $destination_dir
  echo "$(date) Backup Successful: $source_dir to $destination_dir " >> "$destination_dir/backup.log"
 elif [ $ans == "N" ] || [ $ans == "n" ]
 then
  # If the user chooses to skip existing files, log the skipped backup in backup.log
  echo "$(date) Skipped file backup of $source_dir to $destination_dir" >> "$destination_dir/backup.log"
 fi
else
 # If the destination directory does not exist, copy all files and subdirectories from the source directory to the destination directory, while preserving permissions and ownership
 cp -rf $source_dir $destination_dir
 echo "$(date) Backup Successful: $source_dir to $destination_dir " >> "$destination_dir/backup.log"
fi
