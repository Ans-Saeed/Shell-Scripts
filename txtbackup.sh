#!/bin/bash

# Get the source directory and destination directory from the command line arguments
source_dir=$1
destination_dir=$2

# Check if the required parameters are provided
if [ "$#" -ne 2 ]
then
  echo "Please provide the required parameters: <source dir> and <destination dir>"
  exit 1
fi

# Check if the source directory exists and is readable
if [ -d "$source_dir" ] && [ -r "$source_dir" ]
then
  # Check if the destination directory exists and is writable
  if [ -d "$destination_dir" ] && [ -w "$destination_dir" ]
  then
    # Loop through each .txt file in the source directory
    for f in $(ls $source_dir | grep .txt)
    do
      # Check if the file already exists in the destination directory
      if [ -f "$destination_dir/$f" ]
      then
        echo "$f already exists in $destination_dir, skipping..."
        echo "$(date) $f already exists in "$destination_dir", skipped." >> txtbackup.log
      else
        # Copy the file to the destination directory
        cp "$source_dir/$f" "$destination_dir"
        echo "$(date) Successfully copied "$f" to "$destination_dir"." >> txtbackup.log
      fi
    done
  else
    # Create the destination directory if it does not exist
    mkdir "$destination_dir"
    echo "The "$destination_dir" does not exist, creating one..."
    echo "$(date) Created "$destination_dir" because it did not exist." >> txtbackup.log
    exit 1
  fi
else
  echo "The "$source_dir" does not exist or is not readable."
  echo "$(date) Error: "$source_dir" does not exist or is not readable." >> txtbackup.log
  exit 1
fi
