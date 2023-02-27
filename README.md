
<a name="readme-top"></a>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>IDA Intégration à cloud straoge</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#créer le script bash ">créer le script bash </a></li>
      </ul>
    </li>
    <li><a href="#test">Test</a></li>
    <li><a href="#Planifier l'exécution du script">Planifier l'exécution du script</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Dans ce tutoriel, nous allons créer un script Bash qui enverra un fichier à un serveur SFTPGo hébergé dans le Cloud Storage de Google tous les jours à une heure précise. Nous utiliserons le service de planification de tâches cron pour exécuter le script chaque jour.

L'interface web est la suivante et vous pouvez toujours y accéder pour vérifier que tout c'est bien passé : 
**http://35.209.70.131:8080/web/client/login**

### Built With

* [!sftp-go][https://github.com/drakkan/sftpgo/blob/main/docs/howto/getting-started.md#creating-users]

<!-- GETTING STARTED -->
## Getting Started


### Créer le script bash 


  ```sh
  #!/bin/bash

    # Spécifiez les détails de connexion au serveur SFTPGo
    HOST="example.com"
    USERNAME="user1"
    PASSWORD="yourpassword"
    PORT=22

    # Spécifiez le chemin absolu du fichier que vous souhaitez envoyer
    FILE="/path/to/local/file"

    # Spécifiez le chemin absolu du dossier de destination sur le serveur SFTP
    DESTINATION_FOLDER="/path/to/destination/folder"

    # Envoyez le fichier à l'aide de la commande SFTP
    sftp -oPort=$PORT $USERNAME@$HOST:$DESTINATION_FOLDER <<< $'put $FILE'
  ```

Modifiez les valeurs des variables HOST, USERNAME, PASSWORD, PORT, FILE et DESTINATION_FOLDER en fonction de votre configuration.

Enregistrez le fichier et assurez-vous qu'il est exécutable en utilisant la commande suivante :
 chmod +x upload_file.sh


<!-- USAGE EXAMPLES -->
## Test

Avant de planifier l'exécution du script, testez-le manuellement pour vous assurer qu'il fonctionne correctement. Exécutez le script en utilisant la commande suivante :

```sh
$ ./upload_file.sh
```


Si le script s'exécute correctement, il devrait envoyer le fichier à notre serveur SFTP.



<!-- ROADMAP -->
## Planifier l'exécution du script

Nous allons maintenant planifier l'exécution du script à l'aide du service de planification de tâches cron. Pour ce faire, ouvrez le fichier crontab en utilisant la commande suivante :


```sh
$ crontab -e
```
Ajoutez la ligne suivante à la fin du fichier pour planifier l'exécution du script tous les jours à 3 heures du matin :

```sh
0 3 * * * /path/to/upload_file.sh
```