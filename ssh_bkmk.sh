#!/bin/bash
# This script reads a file for information on an SSH session
# and presents a list of options to choose from

# Check if a file name is provided as an argument
if [ $# -eq 0 ]; then
  echo "Please provide a file name as an argument"
  exit 1
fi

# Check if the file exists and is readable
if [ ! -f $1 ] || [ ! -r $1 ]; then
  echo "The file $1 does not exist or is not readable"
  exit 2
fi

# Declare an array to store the SSH options
declare -a options

# Read each line of the file and add it to the array
while read line; do
  options+=("$line")
done < $1

# Check if the array is not empty
if [ ${#options[@]} -eq 0 ]; then
  echo "The file $1 does not contain any valid SSH information"
  exit 3
fi

# Present a list of options using select statement
echo "Please select one of the following SSH sessions:"
select opt in "${options[@]}"; do
  # Check if a valid option is chosen
  if [ -n "$opt" ]; then 
    # Open an interactive session with ssh command and -t option 
    ssh -t "$opt" 
    break # Exit the loop after opening the session 
  else 
    echo "Invalid option. Please try again." 
  fi 
done 
