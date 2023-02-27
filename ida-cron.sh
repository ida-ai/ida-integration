#!/bin/bash


#!/bin/bash
dir=/Users/mathieugrosso/Desktop/projet-chataigne/ida-integration/
notifier=/usr/local/bin/terminal-notifier

cd $dir
./upload_file.sh


$notifier -title FileUpload -subtitle "Daily Updated" -message "Completed" 
now=$(date)
echo "Cron job update completed at $now"
