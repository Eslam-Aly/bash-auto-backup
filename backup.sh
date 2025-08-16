#!/bin/bash

# -------------------------------
# bash-auto-backup.sh
# Backs up files from a target directory that have been modified
# in the last 24 hours into a .tar.gz file and moves it to a destination directory.
# -------------------------------

# 1) Check that exactly 2 command-line arguments were passed
if [[ $# != 2 ]]
then
  echo "Usage: backup.sh <target_directory> <destination_directory>"
  exit 1
fi

# 2) Validate that both arguments are existing directories
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Error: One (or both) provided paths are not valid directories."
  exit 1
fi

# 3) Read CLI arguments
targetDirectory=$1
destinationDirectory=$2

echo "Target directory      : $targetDirectory"
echo "Destination directory : $destinationDirectory"

# 4) Get current timestamp in seconds from epoch (not just seconds 0-59!)
currentTS=$(date +%s)

# 5) Build backup file name based on timestamp
backupFileName="backup-$currentTS.tar.gz"

# 6) Take absolute path of destination directory
destDirAbsPath=$(realpath "$destinationDirectory")

# 7) Move to the target directory so we can loop over its contents
cd "$targetDirectory" || exit 1

# Calculate timestamp for 24 hours ago
yesterdayTS=$(( currentTS - 24*60*60 ))

declare -a toBackup

# 8) Collect files modified within the last 24 hours
for file in *
do
  # Check if it is a regular file (not a directory) _and_
  # if its modification timestamp is greater than $yesterdayTS
  if [[ -f "$file" ]] && [[ $(date -r "$file" +%s) -gt $yesterdayTS ]]
  then
    toBackup+=("$file")
  fi
done

# 9) If no files to backup, exit quietly
if [[ ${#toBackup[@]} -eq 0 ]]
then
  echo "No recent files to backup."
  exit 0
fi

# 10) Create a compressed archive
tar -czvf "$backupFileName" "${toBackup[@]}"

# 11) Move the backup archive to the destination directory
mv "$backupFileName" "$destDirAbsPath"/

echo "Backup complete. Archive moved to: $destDirAbsPath/$backupFileName"
