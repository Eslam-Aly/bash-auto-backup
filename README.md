# bash-auto-backup

A simple Bash script that creates a compressed backup (`.tar.gz`) of any files modified in the last 24 hours from a target directory and moves it to a destination directory.

## 📦 How it works

- Takes **two arguments**:  
  `target_directory` → directory to scan for changed files  
  `destination_directory` → where the compressed backup file will be stored  
- Checks for files that have been modified in the **last 24 hours**  
- Creates a `.tar.gz` file named like: `backup-<timestamp>.tar.gz`  
- Moves the backup archive to the provided destination directory  

## 🚀 Usage

bash backup.sh <target_directory> <destination_directory>

Example:

bash backup.sh /home/user/data /home/user/backups

## 🔁 Automating with Cron

To run the backup automatically every day at **2 AM**, add the following cron job:

0 2 * * * /bin/bash /path/to/backup.sh /home/user/data /home/user/backups

**Breakdown:**
| Time pattern        | Runs at  |  
|---------------------|---------|  
| `0 2 * * *`         | daily at 02:00 AM |  

| Parameter                 | Description |
|--------------------------|-------------|
| `/path/to/backup.sh`     | Full path to this script  |
| `/home/user/data`        | Folder you want to back up |
| `/home/user/backups`     | Folder where the backup file should be placed |

To edit your crontab:

crontab -e

## ✅ Requirements

- Bash shell (Linux/macOS)
- `tar` command available on system

## 🙌 Author

Eslam Aly
