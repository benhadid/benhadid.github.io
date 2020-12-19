---
type: lab
date: 2019-09-19T4:00:00+4:30
title: 'Travaux Pratiques #1 - Ligne de commande et débogage de programmes'
attachment: /static_files/labs/lab_01.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event: 
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #1 - à remettre'
---

# Objectifs
  - L'étudiant sera initié aux commandes de base du shell Un*x.
  - L'étudiant sera capable de compiler et d'exécuter un programme C sur les ordinateurs des laboratoires MI et d'examiner différents types de flux de contrôle en C.
  - L'étudiant sera initié au débogueur C et acquerra une expérience pratique de l'utilisation de gdb pour déboguer des programmes C.

# Installation et configuration

Pour ce devoir et les devoirs futurs de ce cours, il est suggéré d'effectuer l'installation/configuration suivante sur votre ordinateur personnel :

  1. Commencez par télécharger VirtualBox à partir de ce [lien](https://www.virtualbox.org/wiki/Downloads). Installez la version 6.1.x
  2. Toujours depuis la même page de VirtualBox, téléchargez et installez le pack d'extension (Extension Pack) correspondant à la version de VirtualBox que vous venez d'installer sur votre machine.
  3. Maintenant, téléchargez et installez la machine virtuelle (VM) "cvlab.ova" (1.7 Go) à partir de ce [lien](https://1drv.ms/u/s!Agf0g-qZKM8_2nVUvgzxWj7vtC-n?e=KuEYoL). Pour ajouter la VM à VirtualBox, suivez les instructions données [ici](https://docs.oracle.com/cd/E26217_01/E26796/html/qs-import-vm.html).
  4. C'est fini ! Vous disposez maintenant d'une machine virtuelle avec une configuration semblable aux machines MI (Labo 4).
  5. Si votre ordinateur possède 4 Go ou plus de de Mémoire RAM, il est préférable dans ce cas de reconfigurer la VM pour lui attribuer [plus de mémoire](https://docs.bitnami.com/virtual-machine/faq/administration/increase-memory/).
  6. Une fois la VM lancée, le système est configuré pour utiliser par défaut un clavier américain (comme dans les salles machines). Vous pouvez permuter vers un clavier français en cliquant avec la souris sur le drapeau américain en haut à droite de l'écran. 

**Remarque** : Vous êtes libres d'installer/configurer vos propres PCs de la manière qui vous convient. Cependant, pour réaliser les devoirs de ce cours sans trop de difficultés et afin d'éviter les problèmes/excuses/frustrations du genre « pourquoi ça fonctionne sur mon PC mais pas sur le PC du labo ? », vous êtes vivement encouragés à installer la VM fournie en suivant les instructions données ci-dessus. Cela devrait rendre votre vie beaucoup plus facile.


# Exercice 1 : (Un*x shell)

Afin d'acquérir un minimum d'expérience avec la ligne de commande (Command Line Interface - CLI) sous UN\*X, nous introduisons ici quelques commandes courantes qui peuvent vous être utiles pendant ce cours. Pour une introduction aux commandes UN\*X de base, consultez ce [didacticiel](https://tutorials.ubuntu.com/tutorial/command-line-for-beginners).

Les exemples de commandes seront affichés comme suit :

``` bash
$ echo "Hello world"
```

Taper l'instruction ci-dessus (sans le $) dans un terminal exécutera la commande. Ici, l'instruction affiche simplement le message "Hello world" (sans les guillemets).

Les drapeaux (*anglais*: flags) sont utilisés pour spécifier éventuellement des options pour la commande à exécuter ou modifier son comportement. Ils commencent généralement par un ou deux tirets et peuvent éventuellement prendre un argument.

```bash
$ gcc --help
$ echo -e "Hello\nworld"
```

## Raccourcis CLI

Lors de la saisie de commandes ou de chemins de fichiers :

 - la touche `<tab>` complétera automatiquement le terme actuel
 - les touches `<flèche haut>` et `<flèche bas>` vous permettront de réutiliser les commandes que vous avez tapées précédemment sans les saisir à nouveau.
 - la combinaison `<ctrl> + a` déplacera le curseur au début de la ligne courante (utile pour corriger les erreurs) 
 - la combinaison `<ctrl> + e` déplacera le curseur à la fin de la ligne courante (également utile pour corriger les erreurs)
 - la combinaison `<ctrl> + r` vous permettra d'effectuer une recherche dans la commande récemment utilisée
 
## Manipulation de Fichiers 

La commande `touch` permet de créer un fichier vide avec le nom de fichier fourni en argument.

```bash
$ touch example.txt
```

Cela créera un fichier nommé « exemple.txt » sans rien à l'intérieur. Si vous souhaitez créer un fichier non vide (i.e. avec du contenu), vous pouvez utiliser la commande

```bash
$ echo "Votre contenu entre les guillements" > example.txt
```

Cela créera un fichier avec le nom « exemple.txt » dans le répertoire actuel. Si le fichier existe déjà alors il sera écrasé. Le (nouveau) fichier contiendra "Votre contenu entre les guillemets" mais sans les guillemets.

Le symbole `>` est suivi d'un argument pour rediriger vers un fichier (i.e. example.txt) les données qui sont normalement envoyées vers `stdout` (i.e. l'écran). Ici, nous redirigeons la sortie de `echo` vers un fichier nommé` example.txt`.

Vous pouvez également utiliser la commande `echo` sans redirection, auquel cas elle affichera la chaîne de caractères sur le terminal (sans créer de fichier dans le processus).

```bash
$ echo "Hello world"
```

Pour visualiser le contenu d'un fichier, vous pouvez utliser les commandes `cat` ou` less`.

```bash
$ cat example.txt
$ less example.txt
```

La commande `cat` affiche le contenu de `example.txt` sur votre terminal. `less` lance un éditeur basique. Vous pouvez donner comme argument à `cat` ou `less` un chemin relatif ou absolu pour afficher le contenu des fichiers non locaux.


## `man` - Pages de manuel

Les pages de manuel (*anglais* : « man pages ») sont d'excellentes ressources UN\*X qui sont souvent sous-utilisées; bien qu'elles ne soient pas aussi polyvalents que Google, elles contiennent de la documentation sur les composants UN\*X comme les manuels d'utilisation des programmes, des normes et conventions linguistiques, etc. Elles fonctionnent également hors ligne et peuvent donc être utiles si vous êtes coincé sans internet parce que le cable sousmarin a été rupturé une n-ième fois (ou pendant la période du bac !). 

Bien que votre moteur de recherche préféré ait probablement les réponses que vous recherchez, nous aimerions dans ce cours que vous vous familiarisiez avec l'utilisation de la commande « `man` », en particulier pour les questions relatives au langage C et au systèmes d'exploitation UN\*X.

Pour afficher la page de manuel pour une commande spécifique (ici la commande `echo` est donnée en exemple), vous pouvez exécuter l'instruction :

```bash
$ man echo | less
```

La page de manuel d'une commande contient généralement des informations sur celle-ci, ce que font certains drapeaux lorsque vous invoquez la commande avec eux et où aller pour avoir plus d'informations. 

Dans l'exemple ci-dessus, nous avons redirigé, grâce au symbole « `|` », le contenu du manuel d'utilisation de la commande `echo` vers le programme `less`. Cela nous permet de dérouler la page de manuel avec les touches fléchées ou la barre d'espace. Appuyez sur la touche `q` pour quitter la page de manuel et revenir à l'invite de votre terminal.

Si vous souhaitez rechercher dans les pages de manuel une commande relative à un mot-clé spécifique :

```bash
$ man -k mot_clé_specifique | less
```

Cette commande recherchera dans les pages de manuel toutes les commandes avec le mot-clé `mot_clé_specifique`.

## Vim Basics

`vim` est un editeur de texte inclus dans de nombreuses distributions UN*X.

**Remarque** : Nous utiliserons Vim dans la plupart des exemples et documentations fournis, mais nous n'avons aucune exigence stricte sur l'éditeur de texte que vous utiliserez; vous pouvez choisir l'éditeur de texte qui vous convient ! Toutefois, nous aimerions rappeler que, en tant que futur informaticien, vous devez savoir utiliser au moins un éditeur de texte en ligne de commande. Si vous n'aimez pas Vim, vous pouvez essayer `nano` ou `emacs`!

Pour ouvrir un fichier à partir de votre répertoire actuel, donnez le nom du fichier à Vim :

```bash
$ vim filename
```

Pour ouvrir un fichier à partir d'un autre répertoire, utilisez un chemin relatif ou absolu :

```shell
$ vim ../other_folder/filename
```

### Quelques commandes utiles pour Vim :

|   Commande  | Signification |
|:------------|:------------|
|`<esc>:q`    | Ferme (quitte) Vim sans enregistrer |
|`<esc>:wq`   | quitte Vim après enregistrement des modifications |
|`<esc>:w`    | Enregistre le fichier |
|`<esc>:q!`   | Forcer à quitter Vim (lorsque vous avez effectué des modifications mais vous ne souhaitez pas les garder) |
|`<esc>i`     | mode Insertion, vous permet d'insérer des caractères dans le fichier |
|`<esc>/cats` | Recherche dans le fichier la première occurrence de la chaîne de caractères « cats ». Appuyez sur `n` pour aller à l'occurrence suivante ou `N` pour retourner à la précédente |
|`<esc>:setnu`| Affiche les numéros de ligne dans votre fichier |

<br>

**Remarque** : Ces commandes sont précédées de `<esc>` pour indiquer que vous devez appuyer sur la touche d'échappement de votre clavier pour quitter le mode actuel. Par exemple, si vous voulez enregistrer votre fichier après modification, vous devez appuyer sur la touche d'échappement pour sortir du mode « insertion », puis taper « `:w` » pour sauvegarder le fichier. 

# Exercise 2 : (gdb)

Un **débogueur**, comme son nom l'indique, est un programme spécialement conçu pour vous aider à trouver des bogues, ou des erreurs logiques et des fautes dans votre code (remarque : si vous voulez savoir pourquoi les erreurs sont appelées bogues, regardez [ici](https://www.quora.com/Why-are-errors-in-software-codes-called-bugs). Différents débogueurs ont des fonctionnalités différentes, mais ils permettent tous d'effectuer les opérations suivantes :

  1. Définir un point d'arrêt dans le programme. Un point d'arrêt est une ligne spécifique dans votre code où vous souhaitez arrêter l'exécution du programme afin que vous puissiez examiner ce qui se passe dans cette région du code.

  2. Executer le programme ligne par ligne. Un code s'exécute toujours ligne par ligne, mais cela arrive trop rapidement pour que nous puissions déterminer quelles lignes ou parties du code causent des erreurs. Être capable d'examiner l'execution de votre code ligne par ligne vous permet de déterminer exactement ce qui cause un bogue dans votre programme.

Pour cet exercice, le [document de référence GDB]({{site.baseurl}}/static_files/docs/gdb5-refcard.pdf) vous sera très utile. GDB signifie « **G**NU **D**e-**B**ugger ». D'abord, téléchargez le fichier de démarrage (voir plus haut dans ce document) et décompressez son contenu (avec la commande `unzip`) dans le répertoire de votre choix. Compilez ensuite le fichier `hello.c` avec le drapeau `-g` (indiquez le chemin complet du fichier `hello.c` si différent du répertoire actuel ) :

```bash
$ gcc -g -o hello hello.c
```

Cela instruit le compilateur `gcc` à stocker des informations supplémentaires dans le programme exécutable pour que l'outil `gdb`/`cgdb` puisse interprêter correctement votre programme compilé. Maintenant, lancez le débogueur `cgdb` :


```bash
$ cgdb hello
```

L'instruction ci-dessus permet de lancer le programme `cgdb` sur le fichier exécutable` hello` généré par `gcc`. N'essayez pas d'exécuter `cgdb` sur le code source `hello.c`, il ne saura pas quoi en faire ! Si `cgdb` ne fonctionne pas pour vous, essayez avec `gdb` (démarrez `gdb` avec` gdb hello`). Le débogueur `cgdb` est installé uniquement sur les machines des laboratoires et la machine virtuelle fournie dans la rubrique [Ressources]({{site.baseurl}}/materials) de ce site.

**Remarque** : Si vous n'utilisez pas la VM fournie, vous pouvez installer et exécuter `gdb`/`cgdb` sur votre ordinateur local, mais sachez qu'il ne peut pas être installé sur des machines macOS (mises à jour). Si cela s'applique à vous, vous pouvez utiliser `lldb` qui est un autre excellent débogueur. Les commandes diffèrent légèrement de `gdb`, mais il existe d'excellents guides ([comme celui-ci !](Https://lldb.llvm.org/lldb-gdb.html)) pour vous aider à démarrer. Pour ce TP, cependant, utilisez les machines des laboratoires (ou la VM) et `cgdb`.

## Tâches à réaliser :

Parcourez le programme en procédant comme suit :

  1. définissez un point d'arrêt sur la fonction `main`
  2. utilisez la commande `run` de `gdb`
  3. utilisez la commande exécution pas-à-pas de `gdb`

Tapez help depuis `gdb` pour connaître les commandes permettant d'effectuer ces opérations ou utilisez le document de référence fourni.

**Si vous voyez un message d'erreur comme « printf.c: No such file or directory »**, vous êtes probablement entré dans une fonction `printf` ! Si vous continuez l'exécution pas-à-pas, vous aurez l’impression d’aller nulle part ! CGDB se plaint parce que vous n’avez pas le fichier source où `printf` est défini. Pour sortir de cette impasse, utilisez la commande `finish` pour exécuter le programme jusqu'au retour de la fonction non définie (dans ce cas, jusqu'à ce que `printf` soit terminée). Pour éviter ce genre de mésaventure la PROCHAINE fois, utilisez la commande `next` pour sauter la ligne où `printf` est affichée.

## Note : cgdb vs. gdb

Dans cet exercice, nous utilisons `cgdb` pour déboguer nos programmes. `cgdb` est identique à `gdb`, sauf qu'il fournit des fonctionnalités supplémentaires qui le rendent plus agréable à utiliser en pratique. Toutes les commandes du « document de référence GDB » fonctionnent avec `gdb`.

Dans `cgdb`, vous pouvez appuyer sur la touche d'échappement pour aller à la fenêtre de code (en haut) et `i` pour revenir à la fenêtre de commande (en bas) - similaire à vim. La fenêtre de commande est l'endroit où vous entrerez vos commandes `gdb`.

## Tâches à réaliser :

Connaître les réponses aux questions ci-dessous vous sera très utile pour le reste de ce TP et pour votre carrière en informatique en général :

  1. Lorsque vous êtes dans une session `cgdb`/`gdb`, comment **définissez-vous les arguments** qui seront transmis au programme lors de son exécution ?
  2. Comment faire pour créer un point d'arrêt dans un programme ?
  3. Comment exécuter **la ligne suivante de code C** après s'être arrêté à un point d'arrêt ?
  4. Si la ligne de code suivante est un appel de fonction alors vous exécuterez la fonction complète en un seul coup si vous utilisez votre réponse à la question n° 3 (Sinon, envisagez une commande différente pour la question n° 3!). Comment indiquer à GDB que vous **voulez déboguer le code à l'intérieur de la fonction** (c'est-à-dire entrer dans la fonction) ? (Si vous avez changé votre réponse à la question n° 3 alors la réponse précédente est probablement applicable ici.)
  5. Comment **continuer l'exécution du programme après sa suspension** à un point d'arrêt ?
  6. Comment **imprimer la valeur d'une variable** (ou même une expression comme 1 + 2) dans `gdb` ?
  7. Comment configurer `gdb` pour qu'il **affiche la valeur d'une variable après chaque pas d'exécution** ?
  8. Comment afficher **une liste de toutes les variables et leurs valeurs** dans la fonction en cours d'exécution ?
  9. Comment **quitter** gdb ?

# Exercise 3 : (Valgrind)

Même avec un débogueur, nous ne pourrons peut-être pas détecter tous les bogues. Certains bogues sont ce que nous appelons des « bohrbugs », ce qui signifie qu'ils se manifestent de manière fiable dans un ensemble de conditions bien définies, mais peut-être inconnues. D'autres bogues sont ce que nous appelons des « heisenbugs », et au lieu d'être déterminants, ils sont connus pour disparaître ou modifier leur comportement lorsque l'on tente de les étudier. Nous pouvons détecter le premier type avec des débogueurs, mais le second type peut passer sous notre radar car ils sont (au moins en langage C) souvent dus à une mémoire mal gérée.

Rappelons que contrairement à d'autres langages de programmation, le C s'attend à ce que vous (le programmeur) gériez correctement la mémoire. Pour détecter et attraper ces « heisenbugs », nous utiliserons un outil appelé Valgrind. Cet outil est un programme qui émule votre processeur et répertorie tous vos accès mémoire. Cela ralentit considérablement le processus que vous exécutez (c'est pourquoi, par exemple, nous n'exécutons pas toujours tous les exécutables à l'intérieur de Valgrind), mais permet d'exposer des bogues qui peuvent autrement passer inaperçus. 

**Remarque** : Valgrind est déjà installé sur les machines des laboratoires et la VM. Cet outil est également disponible sur la plupart des distributions UN*X ainsi que sur macOS. Nous vous recommandons, toutefois, d'utiliser les machines des laboratoires ou la VM fournie pour ce cours pour éviter d'éventuelles problèmes de compatibilité. Les outils `gdb` et `Valgrind` deviendront incroyablement utiles pour vous au fur et à mesure que vous avancerez dans votre carrière d'informaticien.

Dans cet exercice, nous allons démontrer deux exemples d'utilisation de Valgrind et expliquer comment ils peuvents être utile.

À l'aide du compilateur `gcc`, construisez deux exécutables : `segfault_ex` à partir de `segfault_ex.c` et `no_segfault_ex` à partir de `no_segfault_ex.c` (utilisez le drapeau `-o` pour les noms d'exécutable !). Ensuite, essayez d'exécuter les programmes compilés... qu'observez-vous ?

Commençons par `segfault_ex`. Vous devriez avoir observé une erreur de segmentation (segfault), qui se produit lorsqu'un programme se bloque après avoir tenté d'accéder à de la mémoire qui ne lui est pas disponible (nous en parlerons plus tard dans le cours). Le code source `segfault_ex.c` est assez simple, vous devriez pouvoir « comprendre » facilement ce qui cause l'erreur de segmentation. Ne modifiez pas le fichier, il n'est pas nécessaire de corriger l'erreur ici. 

Trouver une erreur de segmentation dans un fichier très volumineux ne sera pas une tâche facile, et c'est là où Valgrind peut intervenir. Pour exécuter le programme `segfault_ex` dans Valgrind, utilisez la commande :

```bash
$ valgrind ./segfault_ex
```

Cela devrait amener Valgrind à afficher l'endroit où l'accès illégal s'est produit. Comparez ces résultats à ce que vous avez déterminé en examinons manuellement le fichier `segfault_ex.c`. Comment Valgrind pourrait-il vous aider à faire face à un segfault à l'avenir ? 

Maintenant, essayez d'exécuter Valgrind sur `no_segfault_ex`. Le programme ne devrait pas planter mais il y a toujours un problème avec le fichier. Valgrind peut nous aider à trouver le problème (apparemment invisible).

Malheureusement, vous verrez ici que Valgrind semble ne pas être en mesure de vous dire exactement où le problème se produit. Utilisez le message fourni par Valgrind **pour déterminer quelle variable a un comportement non défini, puis essayez de déduire ce qui a dû se passer** (Indication : qu'est-ce qu'une valeur non initialisée ?).

À ce stade, nous ne nous attendons pas à ce que vous soyez familier avec l'utilisation du mot-clé `sizeof` dans un programme en langage C. Mais, vous pouvez, néanmoins, construire une certaine intuition autour de l'endroit où le problème s'est probablement produit.

## Tâches à réaliser :

Après avoir parcouru cet exercice, vous devriez être en mesure de comprendre et de répondre à ce qui suit :
  - Pourquoi Valgrind est un outil important et très utile ?
  - Comment exécuter un programme dans Valgrind ?
  - Comment interpréter les messages d'erreur ? 
  - Pourquoi des variables non initialisées peuvent-elles entraîner des « heisenbugs » ?

<!--  
Nous vous présentons Valgrind maintenant car c'est un outil extrêmement important dont vous aurez besoin quand vous écrivez des programmes en langage C. **Cependant, pour vraiment l'apprécier, nous devons apprendre davantage sur le modèle de mémoire dans le langage C, ce que nous ferons très prochainement**. Après avoir couvert la mémoire en cours, revenez à ce TP et essayez de répondre aux questions suivantes :

  - Pourquoi le programme `no_segfault_ex` n'a pas fait d'erreur de segmentation ?
  - Pourquoi le programme « `no_segfault_ex` » produit des résultats incohérents ?
  - Pourquoi l'utilisation actuelle de « `sizeof` » est incorrecte ? Comment pouvez-vous corriger cela ?
-->


