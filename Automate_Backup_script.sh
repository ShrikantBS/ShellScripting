directory_to_backup="/home/ubuntu/DirectorytoBackup" #This is the directory we want to zip & create a backup

backup_location="/home/ubuntu" #This is the path where we want to store the backup

current_date=$(date +%Y-%m-%d) #Value of the current date which will be appended in the backup file name

tar -czf "$backup_loaction-$current_date.tar.gz" "$directory_to_backup" #Creating the backup

echo "backup of $directory_to_backup is completed successfully on $current_date inside $backup_location"