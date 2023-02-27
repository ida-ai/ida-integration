
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
    <li><a href="#Obtenir des logs">#Obtenir des logs</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Description du process

Dans ce tutoriel, nous allons créer un script Bash qui enverra un fichier à un serveur SFTPGo hébergé dans le Cloud Storage de Google tous les jours à une heure précise. 
Nous utiliserons le service de planification de tâches cron pour exécuter le script chaque jour.

L'interface web est la suivante et vous pouvez toujours y accéder pour vérifier que tout s'est bien passé : 
**http://35.209.70.131:8080/web/client/login**

### Documentation générale

* [!sftp-go][https://github.com/drakkan/sftpgo/blob/main/docs/howto/getting-started.md#creating-users]

<!-- GETTING STARTED -->
## Etapes
installer except : 

**sur macOS : **
```sh
brew install expect
```

*** sur linux: ***
```sh
sudo apt-get install expect
```

### Créer le script bash Except: 
**chmod +x upload_except_gcs.sh**

  ```sh
  #!/usr/bin/expect -f

    # Spécifiez les détails de connexion au serveur SFTPGo
    set HOST "35.209.70.131"
    set USERNAME "username" # modifier avec votre username
    set PASSWORD "123456789" #modifier avec votre password
    set PORT 2022

    # Spécifiez le chemin absolu du fichier que vous souhaitez envoyer
    set FILE "/Path/to/file.txt" #modifier avec le chemin vers votre fichier

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
  ```

Modifiez les valeurs des variables HOST, USERNAME, PASSWORD, PORT, FILE et DESTINATION_FOLDER en fonction de votre configuration.

Enregistrez le fichier et assurez-vous qu'il est exécutable en utilisant la commande suivante :
```sh
chmod +x upload_except_gcs.sh
```




<!-- USAGE EXAMPLES -->
## Test

Avant de planifier l'exécution du script, testez-le manuellement pour vous assurer qu'il fonctionne correctement. Exécutez le script en utilisant la commande suivante :

```sh
./upload_except_gcs.sh
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
0 3 * * * /path/to/file/upload_file.sh # à modifier avec le chemin vers ou vous avez mis le fichier

```

autre exemple ce fichier va run la commande à 15H20:

```sh
20 15 * * * /path/to/file/upload_file.sh
```

encore un autre exemple mais à 17H45

```sh
45 17 * * * /path/to/file/upload_file.sh
```

## Obtenir des logs (sur mac)

### utiliser le terminal-notifier: 
Tout d'abord il faut installer terminal-notifier
```sh
brew install terminal-notifier$
``` 
si vous êtes sur macOs. 


ensuite vous pouvez créer le fichier suivant :
```sh
#!/usr/bin/env bash
# run cron job
# git add, comit and push

#!/bin/bash
dir= /Users/mathieugrosso/Desktop/projet-chataigne/ida-integration/
notifier=/usr/local/bin/terminal-notifier

cd $dir
./upload_file.sh

$notifier -title FileUpload -subtitle "Daily Updated" -message "Completed" 
now=$(date)
echo "Cron job update completed at $now"
````

et ensuite il faudra donc modifier le cron: 
```sh 
crontab -e
```
on ajoute le nouveau cron vers le nouveau fichier: 
```sh
0 3 * * * /path/to/file/ida-cron.sh
```

### Utiliser le système de mail du terminal 
**finalement vous pouvez aussi rentrer : **
```
mail
```
dans le terminal

Votre terminal envoie ses messages de sortie et d'erreur par mail après avoir exécuté une tâche cron. 
Vérifions si la tâche cron a fonctionné
Vous devez appuyer sur enter pour lire les messages, puis sur q et enter pour quitter. Utilisez j pour voir les lignes suivantes. 
Vous devez vérifier que le courrier ne contient pas d'erreurs. 
En cas d'erreurs, reportez-vous à la documentation ci-dessous.



## Résolution de problème :

--> Le cron ne marche pas ? 
Si vous êtes sur mac, il vous manque surement une autorisation: 
voilà un tutoriel assez clair -->
https://itprohelper.com/how-to-fix-cron-operation-not-permitted-error-in-macos/
En clair il faut ajouter le droit au cron d'accèder au fichier, ce qui se fait via l'onglet securité dans préferences systèmes. Mais je vous laisse lire le tutoriel. 


--> Comment savoir si le cron a marché ? 
Vous pouvez le modifier et le mettre à l'heure que vous voulez, une fois cette heure passée, faire mail dans le terminal pour voir le log. 

--> Autres questions ? Contactez-moi: mathieu.grosso@ai-ida.com

