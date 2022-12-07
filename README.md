# Docker et Docker compose

Docker est un outil que les développeurs utilisent pour simplifier le développement et la livraison d'applications.

Selon l'enquête auprès des développeurs 2021 de Stack Overflow, c'est l'un des outils de développement les plus populaires.

Cette partie vous expliquera les bases de Docker, en vous concentrant spécifiquement sur :

    1. Les concepts et composants de base de Docker
    2. À quoi ressemble un Dockerfile et à quoi servent ses instructions les plus courantes
    3. Que sont les images et les conteneurs, comment sont-ils créés et comment les gérer

# Objectifs

À la fin de cette partie, vous devriez être en mesure de :

    1. Expliquer ce qu'est Docker et son fonctionnement
    2. Décrire et différencier les concepts et composants suivants : Docker Engine, Docker Desktop, Dockerfile, Image Docker et conteneur Docker 
    3. Suivrer des tutoriels plus compliqués qui utilisent Docker

Conteneurs et machines virtuelles

Avant de vous lancer dans Docker, il est important de comprendre la différence entre les conteneurs et les machines virtuelles.

Les conteneurs et les machines virtuelles sont similaires en ce sens qu'ils permettent à plusieurs applications de s'exécuter sur le même serveur avec diverses exigences logicielles - par exemple, différentes versions de Python, différentes bibliothèques, etc. Leur principale différence réside dans le système d'exploitation. Alors que les conteneurs utilisent le système d'exploitation de l'hôte, chaque machine virtuelle a son propre système d'exploitation invité au-dessus du système d'exploitation de l'hôte.

Dans une image désormais presque célèbre, vous pouvez voir comment Docker se compare aux machines virtuelles :



![image](https://user-images.githubusercontent.com/81464575/206052538-84f6de29-c3f8-428a-b7f9-c16f5175b032.png)



Donc, si vous avez une application qui doit s'exécuter sur différents systèmes d'exploitation, une machine virtuelle est la solution. Mais si ce n'est pas une exigence, Docker présente de multiples avantages par rapport à une machine virtuelle :

    1. Poids plus léger
    2. Plus rapide à construire
    3. Peut être facilement porté sur différentes plates-formes
    4. Moins gourmand en ressources
    5. La mise à l'échelle et la duplication sont plus faciles

Tous ces avantages sont dus au fait que les conteneurs Docker n'ont pas besoin de leur propre système d'exploitation.


# Docker


## Moteur Docker

Lorsque les gens font référence à Docker, ils font généralement référence à Docker Engine(Moteur Docker).

Docker Engine est la technologie de conteneurisation open source sous-jacente pour créer, gérer et exécuter des applications conteneurisées. C'est une application client-serveur avec les composants suivants :

    1. Le démon Docker (appelé dockerd) est un service qui s'exécute en arrière-plan qui écoute les requêtes de l'API Docker Engine et gère les objets Docker tels que les images et les conteneurs.
		 
	Dans les systèmes d'exploitation informatiques multitâches, un démon(daemon) est un 	programme informatique qui s'exécute en arrière-plan

	Pourquoi le processus d'arrière-plan est-il appelé démon ?

	Dans la mythologie grecque, un démon était considéré comme un être ou un pouvoir surnaturel. 	Les programmeurs du MIT pensaient que démon serait un nom approprié pour un processus 	d'arrière-plan qui travaillait sans relâche pour effectuer des tâches système. Mais au lieu 	d'utiliser le terme démon(demon), ils ont utilisé démon(daemon), qui est une forme plus 	ancienne du mot.
       
    2. L'API Docker Engine est une API RESTful utilisée pour interagir avec le démon Docker.
       
    3. Le client Docker (appelé docker) est l'interface de ligne de commande utilisée pour interagir avec le démon Docker. Ainsi, lorsque vous utilisez une commande comme <<docker build>>, vous utilisez le client Docker, qui à son tour exploite l'API Docker Engine pour communiquer avec le démon Docker.


## Desktop Docker

Ces jours-ci, lorsque vous essayez d'installer Docker, vous rencontrerez Docker Desktop. Bien que Docker Engine soit inclus avec Docker Desktop, il est important de comprendre que Docker Desktop n'est pas identique à Docker Engine. Docker Desktop est un environnement de développement intégré pour les conteneurs Docker. Il est beaucoup plus facile de configurer votre système d'exploitation pour travailler avec Docker.

Si vous ne l'avez pas déjà fait, installez Docker Desktop :

    • Linux 
    • MacOS 
    • Windows 

## Concepts Docker

Au cœur de Docker, il y a trois concepts de base :

    1. Dockerfile - un fichier texte qui sert de plan pour votre conteneur. Dans celui-ci, vous définissez une liste d'instructions que Docker utilise pour créer une image.
       
    2.  Image - une incarnation en lecture seule du Dockerfile. Il est construit à partir de couches - chaque couche correspond à une seule ligne d'instructions d'un Dockerfile.
       
    3.  Conteneur - l'exécution d'une image Docker produit un conteneur, qui est un environnement contrôlé pour votre application. Si nous établissons des parallèles avec la programmation orientée objet, un conteneur est une instance d'une image Docker.

![image](https://user-images.githubusercontent.com/81464575/206056179-946f5272-40b7-4e87-bf80-c45258ff9962.png)



Un Dockerfile est utilisé pour créer une image Docker, qui est ensuite utilisée pour créer (plusieurs) conteneurs Docker.


# Dockerfile

Encore une fois, un Dockerfile est un fichier texte qui contient des instructions pour Docker sur la façon de créer une image. Par défaut, un Dockerfile n'a pas d'extension, mais vous pouvez en ajouter une si vous en avez besoin de plusieurs - par exemple, Dockerfile.prod.

Voici un exemple de Dockerfile très simple :




Un Dockerfile est essentiellement une liste de commandes sous la forme suivante : arguments INSTRUCTION. La majorité des commandes les plus utilisées peuvent être vues dans le Dockerfile ci-dessus. Voyons chacun d'eux en détail.


### FROM

Tous les Dockerfiles incluent une image parent/base sur laquelle la nouvelle image sera construite. Vous utilisez l'instruction FROM pour définir l'image parent :

FROM python : 3.10-slim-buster

Un Dockerfile valide inclut toujours une instruction FROM.

Bien que les termes d'image parent et de base soient parfois utilisés de manière interchangeable, il existe une différence entre eux. Une image parent a sa propre image parent. Pendant ce temps, une image de base n'a pas de parent ; ça commence à partir de zéro.

    L'image alpine est une image de base et Python:alpine est une image parente (dont l'image parente (de base) est en fait l'image alpine).

    Il est possible de créer une image de base par vous-même, mais la probabilité que vous ayez besoin de votre propre image est faible.


Vous pouvez trouver des images parentes sur Docker Hub, qui est la bibliothèque/registre de Docker pour les images Docker. Vous pouvez le considérer comme GitHub pour les images Docker. Vous souhaiterez probablement utiliser des images officielles ou des images vérifiées provenant de sources fiables, car elles sont plus susceptibles de respecter les meilleures pratiques de Docker et de contenir les derniers correctifs de sécurité.

Dans l'exemple ci-dessus, nous avons utilisé l'image parent Python officielle, en particulier python:3.10-slim-buster.


Remarques sur python:3.10-slim-buster :

    Le nombre vous indique quelle version de la technologie l'image utilise (par exemple, l'image python:3.11.0a5 utilise Python version 3.11.0a5 tandis que node:18.9.0 utilise Node version 18.9.0).

    Vous voudrez probablement éviter toutes les versions contenant rc (par exemple, python:3.11.0rc2) puisque rc signifie release candidate(candidat à la libération).

    Des noms comme buster, bullseye ou alpine vous indiquent quelles images de système d'exploitation ont été utilisées pour cette image (buster et bullseye font référence aux versions de Debian tandis qu'alpine est une distribution Linux légère). De plus, il existe des balises telles que slim et slim-buster qui utilisent des versions plus légères de l'image complète.


### RUN

L'instruction RUN exécute toutes les commandes dans un nouveau calque au-dessus de l'image actuelle et valide le résultat.

Exemples:

RUN mkdir /home/app/web

RUN python manage.py collectstatic –noinput


##ENV

Vous utilisez l'instruction ENV pour définir une variable d'environnement. Cette variable sera disponible dans toutes les instructions ultérieures.

Exemples:

ENV TZ=UTC

ENV HOME=/home/application


##CMD et ENTRYPOINT

Certaines instructions Docker sont si similaires qu'il peut être difficile de comprendre pourquoi les deux commandes sont nécessaires. L'un de ces "couples" est CMD et ENTRYPOINT.

Tout d'abord, pour les similitudes :

    CMD et ENTRYPOINT spécifient tous deux une commande / un exécutable qui sera exécuté lors de l'exécution d'un conteneur. Contrairement à RUN, qui exécute la commande immédiatement (le résultat est utilisé dans la couche image), la commande CMD/ENTRYPOINT dans le build-up spécifie la commande qui sera utilisée uniquement au démarrage du conteneur.
    Vous ne pouvez avoir qu'une seule instruction CMD/ENTRYPOINT dans un Dockerfile, mais elle peut pointer vers un fichier exécutable plus compliqué.

Il n'y a en fait qu'une seule différence entre ces instructions :

    CMD peut facilement être remplacé à partir de Docker CLI.

Vous devez utiliser CMD si vous souhaitez avoir la possibilité d'exécuter différents exécutables en fonction de vos besoins lors du démarrage du conteneur. Si vous souhaitez communiquer clairement que la commande n'est pas destinée à être remplacée et éviter de la modifier accidentellement, utilisez ENTRYPOINT.

Vous utiliserez probablement l'un ou l'autre. Si vous n'en utilisez pas, le conteneur sera arrêté immédiatement car il n'y a aucune raison pour qu'il existe (l'exception étant si vous utilisez également Docker Compose).

Vous pouvez également utiliser à la fois CMD et ENTRYPOINT dans le même Dockerfile, auquel cas CMD sert d'argument par défaut pour ENTRYPOINT.

Vous ne pouvez avoir qu'une seule instruction CMD dans un Dockerfile, mais elle peut pointer vers un fichier exécutable plus compliqué. Si vous avez plusieurs CMD, seul le dernier CMD prendra effet. Il en va de même pour l'instruction ENTRYPOINT.

Exemple d'utilisation de l'instruction CMD :

CMD gunicorn core.wsgi:application --bind 0.0.0.0:$PORT

Il y a de grandes chances que vous voyiez l'argument ENTRYPOINT comme un fichier exécutable puisque les commandes qui doivent être exécutées sont souvent plus qu'une ligne.

Exemple d'ENTRYPOINT en tant qu'utilisation de fichier exécutable :

ENTRYPOINT ["./entrypoint.sh"]

Et voici à quoi pourrait ressembler le fichier entrypoint.sh :

#!/bin/ch

python manage.py migrate
python manage.py collectstatic –noinput


## ADD et COPY

Une autre paire similaire est ADD et COPY.

Les deux instructions copient les nouveaux fichiers ou répertoires du chemin vers le système de fichiers de l'image au chemin :

ADD <src> <dest>
COPY <src> <dest>

De plus, ADD peut copier à partir d'URL de fichiers distants (par exemple, il permet d'ajouter directement un référentiel git à une image) et directement à partir d'une archive compressée (ADD décompressera automatiquement le contenu à l'emplacement donné).

Vous devriez préférer COPY à ADD, sauf si vous avez spécifiquement besoin de l'une des deux fonctionnalités supplémentaires d'ADD, c'est-à-dire télécharger des exemples de fichiers ou décompresser un fichier compressé.

Exemples d'utilisation des instructions ADD et COPY :

# copier les fichiers locaux sur l'hôte vers la destination
COPY /source/chemin /destination/chemin
COPY ./exigences.txt .

# télécharger le fichier externe et le copier vers la destination
ADD http://external.file/url/destination/path
ADD --keep-git-dir=true https://github.com/moby/buildkit.git#v0.10.1 /buildkit

# copier et extraire les fichiers compressés locaux
ADD source.fichier.tar.gz /destination/chemin


## IMAGE

Une image pourrait être le concept le plus déroutant des trois. Vous créez un Dockerfile, puis utilisez un conteneur, mais une image se situe entre ces deux.

Ainsi, une image est un mode de réalisation en lecture seule d'un Dockerfile utilisé pour créer un conteneur Docker. Il se compose de couches - chaque ligne d'un Dockerfile constitue une couche. Vous ne pouvez pas modifier une image directement ; vous le modifiez en modifiant le Dockerfile. Vous n'utilisez pas non plus directement une image ; vous utilisez un conteneur créé à partir d'une image.

Les tâches liées à l'image les plus importantes sont :

    1. construire des images à partir de Dockerfiles
    2. listant toutes les images construites
    3. suppression d'images


## Contruction

Pour créer une image à partir d'un Dockerfile, vous utilisez la commande docker image build. Cette commande nécessite un argument : soit un chemin, soit une URL du contexte.

Cette image utilisera le répertoire courant comme contexte :

```$ docker image build .```


Il existe un certain nombre d'options que vous pouvez proposer. Par exemple, -f est utilisé pour spécifier un Dockerfile spécifique lorsque vous avez plusieurs Dockerfiles (par exemple, Dockerfile.prod) ou lorsque le Dockerfile n'est pas dans le répertoire actuel (par exemple, docker image build . -f docker/Dockerfile.prod) .

La plus importante est probablement la balise -t qui est utilisée pour nommer/taguer une image.

Lorsque vous créez une image, un identifiant lui est attribué. Contrairement à ce à quoi vous pourriez vous attendre, les identifiants ne sont pas uniques. Si vous souhaitez pouvoir référencer facilement votre image, vous devez la nommer/la taguer. Avec -t, vous pouvez lui attribuer un nom et un tag.

Voici un exemple de création de trois images : une sans l'utilisation de -t, une avec un nom attribué et une avec un nom et un tag attribués.


$ docker image build .
$ docker image build . -t hello_world
$ docker image build . -t hello_world:67d19c27b60bd782c9d3600ae914604a94bddfd4

$ docker image ls
REPOSITORY           TAG       IMAGE ID       CREATED          SIZE
REPOSITORY    TAG                                        IMAGE ID       CREATED          SIZE
hello_world   67d19c27b60bd782c9d3600ae914604a94bddfd4   e03784993f22   25 minutes ago   181MB
hello_world   latest                                     e03784993f22   26 minutes ago   181MB
<none>        <none>                                     7a615d108866   29 minutes ago   181MB
Remarques:

 Pour l'image qui a été construite sans nom ni tag, vous ne pouvez la référencer que via son ID          d'image. Non seulement il est difficile de s'en souvenir, mais, encore une fois, il se peut qu'il ne soit pas unique (ce qui est le cas ci-dessus). Vous devriez éviter cela.
    Pour l'image qui n'a qu'un nom (-t hello_world), la balise est automatiquement définie sur latest.

##Référencement

La commande `docker image ls `répertorie toutes les images construites.

Exemple:

```$ docker image ls```

REPOSITORY      TAG       IMAGE ID       CREATED         SIZE
hello_world     latest    c50405e84d39   9 minutes ago   245MB
<none>          <none>    2700a62cd8f1   42 hours ago    245MB
alpine/git      latest    692618a0d74d   2 weeks ago     43.4MB
todo_app        test      999740882932   3 weeks ago     1.03GB

##Suppression

Il existe deux cas d'utilisation pour supprimer des images :
       
    1. Vous souhaitez supprimer une ou plusieurs images sélectionnées
    2. Vous souhaitez supprimer toutes les images inutilisées (vous ne vous souciez pas des images en particulier)

Pour le premier cas, vous utilisez `docker image rmi` pour le second, vous utilisez `docker image prune`.

## Retirer

docker image rm supprime et décode la ou les images sélectionnées. Il nécessite un argument : la référence à l'image ou aux images que vous souhaitez supprimer. Vous pouvez le référencer par son nom ou son ID court/long.

Si vous repensez à l'explication du marquage des images... il peut y avoir plusieurs images avec un nom différent mais le même identifiant. Si vous essayez de supprimer l'image par ID d'image et que plusieurs images avec cet ID existent, vous obtiendrez une erreur d'image référencée dans plusieurs référentiels. Dans ce cas, vous devrez le supprimer en le référençant par son nom. Si vous souhaitez supprimer toutes les images avec le même ID, vous pouvez utiliser le flag -f.

Exemple de suppression d'image infructueuse et réussie :

``$ docker image ls``

REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
test1        latest    4659ba97837b   41 seconds ago   245MB
test2        latest    4659ba97837b   41 seconds ago   245MB
test         latest    4659ba97837b   41 seconds ago   245MB


```$ docker rmi 4659ba97837b```

Error response from daemon: conflict: unable to delete 4659ba97837b (must be forced) - image is referenced in multiple repositories


```$ docker rmi test2```
Untagged: test2:latest


```$ docker image ls```

REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
test1        latest    4659ba97837b   4 minutes ago   245MB
test         latest    4659ba97837b   4 minutes ago   245MB


## Prune

docker image prune supprime les images pendantes. Étant donné que prune est une commande qui peut être utilisée pour nettoyer les conteneurs, les images, les volumes et les réseaux, cette commande n'a pas de version plus courte. Si vous utilisez l'indicateur -a, toutes les images inutilisées sont supprimées (c'est-à-dire, docker image prune -a).

    Une image pendante est une image qui n'est pas taguée et qui n'est référencée par aucun conteneur.

    Une image inutilisée est une image qui n'est pas associée à au moins un conteneur.

Exemple:

```$ docker image prune```

WARNING! This will remove all dangling images.
Are you sure you want to continue? [y/N]

Deleted Images:
deleted: sha256:c9a6625eb29593463ea43aab4053090427bf29cc59bc97917b3298fda6a94e8a
deleted: sha256:284f940f39c3ef5be09440e23fdefdb00df0791344db5c340a9d11979a98039e
deleted: sha256:1934187bf17ccf4e754842a4ceeacf5c14aaa63ba7a04c0c520f53946426c902


## Conteneur

Le troisième concept que vous devez comprendre est un conteneur, qui est un environnement contrôlé pour votre application. Une image devient un conteneur lorsqu'elle est exécutée sur Docker Engine. C'est l'objectif final : vous utilisez Docker pour disposer d'un conteneur pour votre application.

Les principales opérations que vous pouvez effectuer avec un conteneur sont:

    1. faire fonctionner un conteneur
    2. répertoriant tous les conteneurs
    3. arrêter un conteneur
    4. enlever un conteneur


## Fonctionnement

Vous pouvez soit créer un nouveau conteneur d'une image et l'exécuter, soit démarrer un conteneur existant qui a été précédemment arrêté.

Run

La commande `docker container run` combine en fait deux autres commandes, `docker container create` et `docker container start`.

Ainsi, ce qui suit vous donne essentiellement le même résultat :

```$ docker container run mom_image```

# meme que:

``$ docker container create mom_image
88ce9c60aeabbb970012b5f8dbae6f34581fa61ec20bd6d87c6831fbb5999263
```$ docker container start 88ce9c60aeabbb970012b5f8dbae6f34581fa61ec20bd6d87c6831fbb5999263


Vous devez fournir un argument : l'image que vous souhaitez utiliser pour le conteneur.

Lorsque vous exécutez la commande d'exécution, Docker crée une couche de conteneur inscriptible sur l'image spécifiée, puis la démarre à l'aide de la commande spécifiée (CMD/ENTRYPOINT dans le Dockerfile).


Étant donné que vous pouvez remplacer un certain nombre de valeurs par défaut, il existe de nombreuses options. Vous pouvez tous les voir dans les documents officiels. L'option la plus importante est --publish/-p, qui est utilisée pour publier les ports vers le monde extérieur. Bien qu'il soit techniquement possible d'exécuter un conteneur sans port, ce n'est pas très utile car le ou les services exécutés à l'intérieur du conteneur ne seraient pas accessibles à l'extérieur du conteneur. Vous pouvez utiliser --publish/-p pour les commandes de création et d'exécution :

Voici un exemple de ce à quoi cela ressemble :

```$ docker container run -p 8000:8000 mon_image```



Vous pouvez exécuter votre conteneur en mode détaché en utilisant --detach/-d, ce qui vous permet de continuer à utiliser le terminal.

Si vous exécutez un conteneur en mode détaché, Docker renverra simplement l'ID du conteneur :


```$ docker container run -p 8000:8000 -d mon_image```

0eb20b715f42bc5a053dc7878b3312c761058a25fc1efaffb7920b3b4e48df03
Votre conteneur reçoit un nom unique et original par défaut, mais vous pouvez lui attribuer votre propre nom :


```docker container run -p 8000:8000 --name mon_container mon_image```


### Start

Pour démarrer un conteneur arrêté ou juste créé, vous utilisez la commande `docker container start`. Étant donné qu'avec cette commande, vous démarrez un conteneur existant, vous devez spécifier le conteneur au lieu d'une image (comme avec docker container run).

Une autre différence par rapport à l'exécution du conteneur docker est que le démarrage du conteneur docker exécute par défaut le conteneur en mode détaché. Vous pouvez l'attacher en utilisant --attach/-a (inverse de l'exécution du conteneur docker -d).

Exemple:

```$ docker container start -a hello_world```

Référencement

Vous pouvez répertorier tous les conteneurs en cours d'exécution avec `docker container ls`.

Exemple:


```$ docker container ls
CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS      NAMES
5111c770a7aa   fnndsc/pman:latest   "gunicorn --bind 0.0…"   59 minutes ago   Up 58 minutes   5010/tcp   pfcon_stack_pman.1.eaie82rfojaezqt294o8l3c62```


Si vous souhaitez également voir les conteneurs arrêtés, vous pouvez ajouter le flag -a :

``` docker container ls -a
CONTAINER ID   IMAGE                COMMAND                  CREATED             STATUS             PORTS      NAMES
5111c770a7aa   mon_image   "gunicorn --bind 0.0…"   About an hour ago   Up About an hour   5010/tcp   mon_container```


Jetons un coup d'œil à la sortie pour :

    1. CONTAINER ID(5111c770a7aa) et ses NAMES (container) sont tous deux uniques, vous pouvez donc les utiliser pour accéder au conteneur.
       
    2. IMAGE ( mon_image ) vous indique quelle image a été utilisée pour exécuter le conteneur.
       
    3. CREATED est assez explicite : quand le conteneur a été créé .
       
    4. Nous avons déjà évoqué la nécessité de spécifier une commande pour démarrer un conteneur.COMMANDE vous indique quelle commande a été utilisée ("/gunicorn --bind 0.0…").

    5.  STATUS est utile lorsque vous ne savez pas pourquoi votre conteneur ne fonctionne pas (Up About an hour  signifie que votre conteneur est en cours d'exécution, Exited ou Created signifie que ce 	n'est pas le cas)

Certaines informations sont tronquées. Si vous voulez la version non tronquée, ajoutez –no-trunc.

### Stop

Pour arrêter un conteneur, utilisez `docker container stop`. Le nom ou l'ID du conteneur arrêté est ensuite renvoyé.

Exemple:

``` $ docker container stop a50de088fdfd
a50de088fdfd```

```$ docker container ls -a
CONTAINER ID   IMAGE                COMMAND                  CREATED              STATUS                          PORTS     NAMES
a50de088fdfd   fnndsc/pman:latest   "gunicorn --bind 0.0…"   About a minute ago Exited (0) 11 seconds ago  mon_container
```
``` $ docker container stop mon_container
mon_container```


### Suppression

Comme pour les images, pour supprimer un conteneur, vous pouvez :

    1. supprimer un ou plusieurs conteneurs sélectionnés via `docker container rm`.
    2. supprimer tous les conteneurs arrêtés via `docker container prune`

Exemple de conteneur docker rm:

```$ docker container rm a50de088fdfd
a50de088fdfd```

Exemple docker container prune:

```$ docker container prune

WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
0f21395ec96c28b443bad8aac40197fe0468d24e0eed49e5f56011de1c81b589
80c693693f3d99999925eae5f4bbfc03236cde670db509797d83f50e732fcf31
0eb20b715f42bc5a053dc7878b3312c761058a25fc1efaffb7920b3b4e48df03
```





# Conclusion

Pour résumer, les concepts les plus essentiels dans Docker sont Dockerfile, image et conteneur.

En utilisant un Dockerfile comme plan, vous créez une image. Les images peuvent ensuite être utilisées pour créer d'autres images et peuvent être trouvées sur Docker Hub. L'exécution d'une image produit un environnement contrôlé pour votre application, appelé conteneur.

Le but de cette partie était de vous expliquer les bases de Docker.


















# PARTIE II Essayez Docker Compose

Cette partie est conçu pour présenter les concepts clés de Docker Compose tout en créant une application Web Python simple. L'application utilise le framework django et maintient un compteur d'accès dans Redis.

Les concepts présentés ici devraient être compréhensibles même si vous n'êtes pas familier avec Python.



## Conditions préalables

Vous devez avoir Docker Engine et Docker Compose sur votre machine. Vous pouvez soit:

    1. Installer Docker Engine et Docker Compose en tant que librarie autonomes
    2. Installez Docker Desktop qui inclut à la fois Docker Engine et Docker Compose

Vous n'avez pas besoin d'installer Python ou Redis, car les deux sont fournis par les images Docker.


## Étape 1 : Définir les dépendances de l'application

    1. Créez un répertoire pour le projet :
           mkdir composetest
           cd composetest
           installer django 
           pip install django 
           creer un project django
           django-admin startproject compose 
           cd compose
           creer une application django
           django-admin startapp app 
           
    2. Dans le fichier appele views.py dans votre répertoire de l’application app et collez le code suivant dans :

		from django.http import JsonResponse

```import time

import redis



cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

def hello(request):
    count = get_hit_count()
    return JsonResponse("Bonjour le monde! J'ai été vu {} fois.\n".format(count), safe=False)
```

	Enregistrer l’application dans le INSTALLED_APP 
```
INSTALLED_APPS = [
'django.contrib.admin',
'django.contrib.auth',
'django.contrib.contenttypes',
'django.contrib.sessions',
'django.contrib.messages',
'django.contrib.staticfiles',
'app'
]
```
	Enregistrer la fonction hello dans le urls.py 
```
from app import views
urlpatterns = [
path('admin/', admin.site.urls),
path('', views.hello, name="hello"),
]
```



Dans cet exemple, redis est le nom d'hôte du conteneur redis sur le réseau de l'application. Nous utilisons le port par défaut pour Redis, 6379.


Gestion des erreurs transitoires

    Notez la façon dont la fonction get_hit_count est écrite. Cette boucle de relance de base nous permet de tenter notre requête plusieurs fois si le service redis n'est pas disponible. Ceci est utile au démarrage lorsque l'application est en ligne, mais rend également l'application plus résistante si le service Redis doit être redémarré à tout moment pendant la durée de vie de l'application. Dans un cluster, cela aide également à gérer les pertes de connexion momentanées entre les nœuds.

3. Créez un autre fichier appelé requirements.txt dans votre répertoire de projet et collez-y le code suivant :



```
asgiref==3.5.2
Django==4.1.2
sqlparse==0.4.3
redis
```

##Étape 2 : Créer un Dockerfile

Le Dockerfile est utilisé pour créer une image Docker. L'image contient toutes les dépendances requises par l'application Python, y compris Python lui-même.

Dans votre répertoire de projet, créez un fichier nommé Dockerfile et collez le code suivant dans :
``` # syntax=docker/dockerfile:1
FROM python:3.10-slim-buster
# setup environment variable 
ENV DockerHOME=/home/ing/wprojects/composetest/compose
RUN mkdir -p $DockerHOME 
WORKDIR $DockerHOME 
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1 
COPY . $DockerHOME 
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN pip install --upgrade pip

COPY . .
# start server 
CMD python manage.py runserver 0.0.0.0:8000
```



Explorons le Dockerfile et ce que fait chacune des commandes.

    1. FROM python:3.8 : Créez une image en commençant par l'image Python 3.10. C'est aussi la version de Python qui exécutera l'application dans le conteneur

    2. ENV DockerHOME=/home/ing/wprojects/composetest/compose/home/ing/wprojects/composetest/compose : Ici, nous déclarons le répertoire de travail et l'attribuons au nom de variable DockerHOME. Ce sera le répertoire racine de l'application Django dans le conteneur.
       
    3. RUN mkdir -p $DockerHOME : cela crée le répertoire avec le chemin spécifié attribué à la variable DockerHOME dans l'image.
       
    4. WORKDIR $DockerHOME : cela indique explicitement à Docker de définir le répertoire fourni comme emplacement où l'application résidera dans le conteneur.


    5. COPY . $DockerHOME : Cela copie tous les autres fichiers nécessaires et leur contenu respectif dans le dossier de l'application qui est le répertoire racine de l'application dans le conteneur.
       
    6.  RUN pip install -r requirements.txt : cette commande installe toutes les dépendances définies dans le fichier requirements.txt dans votre application dans le conteneur.
       
    7. RUN pip install --upgrade pip : Ceci met à jour la version de pip qui sera utilisée pour installer les dépendances de l'application.
       
    8. EXPOSE 8000 : cette commande libère le port 8000 dans le conteneur, où l'application Django s'exécutera.
       
    9. CMD python manage.py runserver : cette commande démarre le serveur et exécute l'application


Vérifiez que le Dockerfile n'a pas d'extension de fichier comme .txt. Certains éditeurs peuvent ajouter automatiquement cette extension de fichier, ce qui entraîne une erreur lorsque vous exécutez l'application.


## Étape 3 : Définir les services dans un fichier Compose🔗

Exécuter plusieurs conteneurs avec Docker Compose

Dans certains cas, vous souhaiterez peut-être exécuter plusieurs conteneurs dans Docker et les exécuter dans un ordre spécifique.

C'est là que Docker Compose est utile.

Docker Compose est un outil permettant de définir et d'exécuter des applications multi-conteneurs de toutes sortes. Si vous avez une application comprenant plusieurs conteneurs, vous utiliserez la CLI(Commande Line Interface) Docker Compose pour les exécuter tous dans l'ordre requis que vous spécifiez.

Prenons, par exemple, une application Web avec les composants suivants :

    1. Conteneur de serveur Web tel que Nginx
    2. Conteneur d'application qui héberge l'application Django
    3. Conteneur de base de données qui héberge la base de données de production, telle que PostgreSQL
    4. Un conteneur de messages qui héberge le courtier de messages, tel que RabbitMQ

Pour exécuter un tel système, vous déclarerez les directives dans un fichier Docker Compose YAML. Ici, vous définissez comment les images seront construites, sur quel port chacune des images sera accessible, et surtout, l'ordre dans lequel les conteneurs doivent s'exécuter (c'est-à-dire, quel conteneur dépend d'un autre conteneur pour que le projet s'exécute avec succès ).

Créez un fichier appelé docker-compose.yml dans votre répertoire de projet et collez ce qui suit :



```
version: "3.9"
services:
	web: # service name
	#build the image for the web service from the dockerfile in parent directory. 
		build: .
		ports:
		- "8000:8000"
	redis: # service name
		image: "redis:alpine"
```



Ce fichier Compose définit deux services : web et redis.

Le service Web utilise une image créée à partir du Dockerfile dans le répertoire actuel. Il lie ensuite le conteneur et la machine hôte au port exposé, 8000. Cet exemple de service utilise le port par défaut pour le serveur Web django, 8000.

Le service Redis utilise une image Redis publique extraite du registre Docker Hub.


##Étape 4 : Créez et exécutez votre application avec Compose

    Depuis votre répertoire de projet, démarrez votre application en exécutant 

```docker compose up```.


```(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose up
[+] Running 2/2
 ⠿ Container compose-redis-1  Recreated                                                                                                                                     5.4s
 ⠿ Container compose-web-1    Created                                                                                                                                       0.0s
Attaching to compose-redis-1, compose-web-1
compose-redis-1  | 1:C 06 Dec 2022 22:23:07.658 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
compose-redis-1  | 1:C 06 Dec 2022 22:23:07.658 # Redis version=7.0.5, bits=64, commit=00000000, modified=0, pid=1, just started
compose-redis-1  | 1:C 06 Dec 2022 22:23:07.658 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.659 * monotonic clock: POSIX clock_gettime
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.660 * Running mode=standalone, port=6379.
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 # Server initialized
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * Loading RDB produced by version 7.0.5
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * RDB age 43 seconds
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * RDB memory usage when created 0.85 Mb
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * Done loading RDB, keys loaded: 1, keys expired: 0.
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * DB loaded from disk: 0.000 seconds
compose-redis-1  | 1:M 06 Dec 2022 22:23:07.661 * Ready to accept connections
compose-web-1    | Watching for file changes with StatReloader
compose-web-1    | Performing system checks...
compose-web-1    | 
compose-web-1    | System check identified no issues (0 silenced).
compose-web-1    | 
compose-web-1    | You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
compose-web-1    | Run 'python manage.py migrate' to apply them.
compose-web-1    | December 06, 2022 - 22:23:10
compose-web-1    | Django version 4.1.2, using settings 'compose.settings'
compose-web-1    | Starting development server at http://0.0.0.0:8000/
```


Compose extrait une image Redis, crée une image pour votre code et démarre les services que vous avez définis. Dans ce cas, le code est copié statiquement dans l'image au moment de la construction.

2-Entrez http://localhost:8000/ dans un navigateur pour voir l'application en cours d'exécution.

Si cela ne résout pas, vous pouvez également essayer http://127.0.0.1:8000.

Vous devriez voir un message dans votre navigateur indiquant :



![image](https://user-images.githubusercontent.com/81464575/206056389-88f280be-3f53-4ba2-9e15-6669a3c60adf.png)





## 3-Actualiser la page.

Le nombre s’incrementera automatique.



##4-Basculez vers une autre fenêtre de terminal et tapez `docker image ls` pour répertorier les images locales.

La liste des images à ce stade devrait renvoyer redis et web.

REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
compose-web   latest    832f7af18152   20 minutes ago   170MB

redis         alpine    ffd287e43d20   4 days ago       29.9MB


Vous pouvez inspecter les images avec docker inspect <tag or id>.




## 5-Arrêtez l'application, soit en exécutant `docker compose down` dans le répertoire de votre projet dans le deuxième terminal, soit en appuyant sur CTRL + C dans le terminal d'origine où vous avez démarré l'application.



##Étape 5 : Modifier le fichier Compose pour ajouter un montage de liaison

Modifiez docker-compose.yml dans le répertoire de votre projet pour ajouter un montage de liaison pour le service Web :
```
version: "3.9"
services:
	web: # service name
		#build the image for the web service from the dockerfile in parent directory. 
		build: .
		ports:
			- "8000:8000"
		volumes:
			- .:/code
	redis: # service name
		image: "redis:alpine"
```

La nouvelle clé de volumes monte le répertoire du projet (répertoire actuel) sur l'hôte vers /code à l'intérieur du conteneur, vous permettant de modifier le code à la volée, sans avoir à reconstruire l'image.


## Étape 6 : Recréez et exécutez l'application avec Compose

Dans votre répertoire de projet, tapez `docker compose up` pour créer l'application avec le fichier Compose mis à jour et exécutez-le.

```
(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose up 
[+] Running 7/7
 ⠿ redis Pulled                                                                                                                                                            32.2s
   ⠿ c158987b0551 Pull complete                                                                                                                                             6.2s
   ⠿ 1a990ecc86f0 Pull complete                                                                                                                                             8.3s
   ⠿ f2520a938316 Pull complete                                                                                                                                            10.7s
   ⠿ ae8c5b65b255 Pull complete                                                                                                                                            13.2s
   ⠿ 1f2628236ae0 Pull complete                                                                                                                                            17.1s
   ⠿ 329dd56817a5 Pull complete                                                                                                                                            19.7s
[+] Building 99.4s (17/17) FINISHED                                                                                                                                              
 => [internal] load build definition from Dockerfile                                                                                                                        1.4s
 => => transferring dockerfile: 32B                                                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                                                           2.0s
 => => transferring context: 2B                                                                                                                                             0.1s
 => resolve image config for docker.io/docker/dockerfile:1                                                                                                                  3.4s
 => CACHED docker-image://docker.io/docker/dockerfile:1@sha256:9ba7531bd80fb0a858632727cf7a112fbfd19b17e94c4e84ced81e24ef1a0dbc                                             0.0s
 => [internal] load .dockerignore                                                                                                                                           0.0s
 => [internal] load build definition from Dockerfile                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/python:3.10-slim-buster                                                                                                  2.9s
 => [internal] load build context                                                                                                                                           1.1s
 => => transferring context: 920B                                                                                                                                           0.0s
 => [1/8] FROM docker.io/library/python:3.10-slim-buster@sha256:6f0a9332035a0268cdca0bfecb509ec17db855e3d079d134373b3bf5bfb9e98f                                            0.0s
 => CACHED [2/8] RUN mkdir -p /home/ing/wprojects/composetest/compose                                                                                                       0.0s
 => CACHED [3/8] WORKDIR /home/ing/wprojects/composetest/compose                                                                                                            0.0s
 => [4/8] COPY . /home/ing/wprojects/composetest/compose                                                                                                                    2.4s
 => [5/8] COPY requirements.txt requirements.txt                                                                                                                            3.2s
 => [6/8] RUN pip install -r requirements.txt                                                                                                                              36.6s
 => [7/8] RUN pip install --upgrade pip                                                                                                                                    23.2s
 => [8/8] COPY . .                                                                                                                                                          4.9s
 => exporting to image                                                                                                                                                     14.1s
 => => exporting layers                                                                                                                                                    11.1s
 => => writing image sha256:b062e902aff2956ff0c9b54ff88e55a57b1d3d9fa65feb781e251f58c3b52cd0                                                                                0.2s
 => => naming to docker.io/library/compose-web                                                                                                                              0.3s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
[+] Running 3/3
 ⠿ Network compose_default    Created                                                                                                                                       1.0s
 ⠿ Container compose-web-1    Created                                                                                                                                      11.4s
 ⠿ Container compose-redis-1  Created                                                                                                                                      11.5s
Attaching to compose-redis-1, compose-web-1
compose-redis-1  | 1:C 06 Dec 2022 23:25:56.687 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
compose-redis-1  | 1:C 06 Dec 2022 23:25:56.687 # Redis version=7.0.5, bits=64, commit=00000000, modified=0, pid=1, just started
compose-redis-1  | 1:C 06 Dec 2022 23:25:56.687 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
compose-redis-1  | 1:M 06 Dec 2022 23:25:56.688 * monotonic clock: POSIX clock_gettime
compose-redis-1  | 1:M 06 Dec 2022 23:25:56.754 * Running mode=standalone, port=6379.
compose-redis-1  | 1:M 06 Dec 2022 23:25:56.754 # Server initialized
compose-redis-1  | 1:M 06 Dec 2022 23:25:56.755 * Ready to accept connections
compose-web-1    | Watching for file changes with StatReloader
compose-web-1    | Performing system checks...
compose-web-1    | 
compose-web-1    | System check identified no issues (0 silenced).
compose-web-1    | 
compose-web-1    | You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
compose-web-1    | Run 'python manage.py migrate' to apply them.
compose-web-1    | December 06, 2022 - 23:26:00
compose-web-1    | Django version 4.1.2, using settings 'compose.settings'
compose-web-1    | Starting development server at http://0.0.0.0:8000/
compose-web-1    | Quit the server with CONTROL-C.
compose-web-1    | [06/Dec/2022 23:26:38] "GET / HTTP/1.1" 200 38
compose-web-1    | [06/Dec/2022 23:26:44] "GET / HTTP/1.1" 200 38
```


## Étape 7 : Mettre à jour l'application

Étant donné que le code de l'application est maintenant monté dans le conteneur à l'aide d'un volume, vous pouvez apporter des modifications à son code et voir les modifications instantanément, sans avoir à reconstruire l'image.

Modifiez le message d'accueil dans views.py et enregistrez-le. Par exemple, modifiez le bonjour le monde! message à bonjour de Docker ! :


##Étape 8 : Expérimentez avec d'autres commandes

Si vous souhaitez exécuter vos services en arrière-plan, vous pouvez passer l'indicateur -d (pour le mode "détaché") à docker compose up et utiliser docker compose ps pour voir ce qui est en cours d'exécution :


```(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose up -d
[+] Running 2/2
 ⠿ Container compose-redis-1  Started                                                                                                                                      
 ⠿ Container compose-web-1    Started                                                                                                                                      
(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
compose-redis-1     "docker-entrypoint.s…"   redis               running             6379/tcp
compose-web-1       "/bin/sh -c 'python …"   web                 running             0.0.0.0:8000->8000/tcp
(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ 
```

La commande docker compose run vous permet d'exécuter des commandes uniques pour vos services. Par exemple, pour voir quelles variables d'environnement sont disponibles pour le service Web :


```docker compose run web env```


Voir docker compose --help pour voir les autres commandes disponibles.

Si vous avez démarré Compose avec ```docker compose up -d```, arrêtez vos services une fois que vous en avez terminé :

```docker compose stop```


```(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose stop
[+] Running 2/2
 ⠿ Container compose-redis-1  Stopped                                                                                                                                       
 ⠿ Container compose-web-1    Stopped                                                                                                                                      
(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$
```

Vous pouvez tout supprimer, en supprimant entièrement les conteneurs, avec la commande down. Passez --volumes pour supprimer également le volume de données utilisé par le conteneur Redis :



```(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ docker compose down --volumes
[+] Running 3/3
 ⠿ Container compose-redis-1  Removed                                                                                                                                       
 ⠿ Container compose-web-1    Removed                                                                                                                                       
 ⠿ Network compose_default    Removed                                                                                                                                       
(base) ing@ing-Precision-M4600:~/wprojects/composetest/compose$ 
```

#DonaldProgrammeur
