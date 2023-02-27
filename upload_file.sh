#!/bin/bash

# Spécifiez les détails de connexion au serveur SFTPGo
HOST="35.209.70.131/"
USERNAME="user1" ## modify with your username (if you have one - otherwise ask us for a username and password )
PASSWORD="yourpassword" ## modify with your password (same)
PORT=2022

# Spécifiez le chemin absolu du fichier que vous souhaitez envoyer
FILE="/path/to/local/file" # modify with your local file

# Spécifiez le chemin absolu du dossier de destination sur le serveur SFTP
DESTINATION_FOLDER="/path/to/destination/folder" # modify with your destination folder

# Envoyez le fichier à l'aide de la commande SFTP
sftp -P=$PORT $USERNAME@$HOST:$DESTINATION_FOLDER <<< $'put $FILE'