#!/bin/bash

# Function to perform directory backup
perform_backup() {
  source_directory="$1"
  backup_directory="$2"

  # Create a timestamp for the backup filename
  timestamp=$(date +"%Y%m%d%H%M%S")

  # Generate the backup filename
  backup_filename="backup_$timestamp.tar.gz"

  # Create the backup by compressing the source directory
  tar -czvf "$backup_directory/$backup_filename" "$source_directory"

  echo "Backup created: $backup_directory/$backup_filename"
}

# Prompt the user for the source directory and backup directory
echo "Enter the source directory path:"
read source_directory

echo "Enter the backup directory path:"
read backup_directory

# Check if the source directory exists
if [ ! -d "$source_directory" ]; then
  echo "Source directory '$source_directory' does not exist."
  exit 1
fi

# Check if the backup directory exists, if not, create it
if [ ! -d "$backup_directory" ]; then
  mkdir -p "$backup_directory"
fi

# Call the function to perform the backup
perform_backup "$source_directory" "$backup_directory"

echo "Do you want to delete the original file? (y/n)"
read choice

# Delete the original file
if [ $choice == "y" ]; then
  echo "Deleting the original file"
    if [ -d "$source_directory" ]; then
      rm -rf $source_directory
    else
      rm "$source_directory"
    fi
  echo "Original file has been deleted"
else
  echo "Task Completed - Gracefully exiting now!"
fi
