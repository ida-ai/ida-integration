#!/usr/bin/expect -f

# Spécifiez les détails de connexion au serveur SFTPGo
set HOST "35.209.70.131"
set USERNAME "user1"
set PASSWORD "123456789"
set PORT 2022

# Spécifiez le chemin absolu du fichier que vous souhaitez envoyer
set FILE "/Users/mathieugrosso/Desktop/file.txt"

# Spécifiez le chemin absolu du dossier de destination sur le serveur SFTP
set DESTINATION_FOLDER ""

# Connexion au serveur SFTP avec le nom d'utilisateur et le mot de passe
spawn sftp -P $PORT $USERNAME@$HOST:$DESTINATION_FOLDER
expect "password:"
send "$PASSWORD\n"

# Envoyez le fichier à l'aide de la commande SFTP
expect "sftp>"
send "put $FILE\n"
expect "sftp>"
send "exit\n"

