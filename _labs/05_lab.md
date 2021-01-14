---
type: lab
date: 2021-02-18T10:00:00+1:00
title: 'Travaux Pratiques #5 - Exceptions et Interruptions dans MIPS'
attachment: /static_files/labs/exceptions_handler.s
#solutions: /static_files/labs/lab_solutions.pdf
hide_from_announcements: True
due_event:
    type: due
    date: 2021-02-24T10:00:00+1:00
    description: 'Travaux Pratiques #6 - à remettre'
---

# Objectifs

- Comprendre la gestion des exceptions et interruptions dans MIPS

- Apprendre à écrire des gestionnaires d'exception dans MIPS.

# Exercice 1

Lancez l'exemple de code suivant dans MARS, puis répondez aux questions ci-dessous.

```
   .text
   .globl main  
main:
  li $t0, 2147483647   #
  li $t1, 5000
  add $a0, $t0, $t1    #

  li $v0, 10           # exit
  syscall

```
  1. Quelle est la valeur (en hexadécimal) du registre **status** du coprocesseur 0 ?

  2. Quelle est la valeur (en hexadécimal) du registre **cause** du coprocesseur 0 ?

  3. Quel type d'exception s'est produite ?

  4. A quelle adresse (en hexadécimal) s'est produite l'exception ?

# Exercice 2

L'activation des interruptions sur un processeur MIPS se fait en deux étapes :

   - **Configurer le périphérique en question pour qu'il envoie des signaux d'interruption**
     Cela requiert en général l'activation d'un bit de validation d'interruption dans un registre de contrôle dans le périphérique.

   - **Configurer le coprocesseur 0 pour accépter les signaux d'interruption**
     Ceci est effectué en mettant à 1 le bit 0 du registre status ($12) pour activer les interruptions d'une manière globale, puis, en définissant des bits particuliers dans le registre status, on activera des interruptions spécifiques. En effet, les bits 8 à 15 du registre status permettent 8 niveaux d'interruption différents. Par exemple, les bits 3 et 4 du masque (11 et 12 du registre status) activent les interruptions clavier (keyboard) et affichage (display), respectivement.

Si nous voulions activer **toutes** les interruptions dans le MIPS, complétez le masque de bits pour l'instruction `ori` :

   ```
   mfc0    $s1, $12         # lire le contenu du registre status et l'affecter à $s1
   ori     $s1, _________   # à compléter
   mtc0    $s1, $12         # mise à jour du contenu du registre status à partir de $s1
   ```

Si nous voulions activer **que** les interruptions pour le clavier et l'affichage, complétez le masque de bits pour l'instruction `ori` :

   ```
   mfc0    $s1, $12         # lire le contenu du registre status et l'affecter à $s1
   ori     $s1, _________   # à compléter
   mtc0    $s1, $12         # mise à jour du contenu du registre status à partir de $s1
   ```

# Exercice 3

Un gestionnaire d'exceptions doit signaler l'adresse de l'instruction qui a provoqué l'exception, le code d'exception, et doit reprendre (ou terminer) l’exécution du programme après avoir traité l'exception.

0. Pour cet exercice, nous allons utiliser un gestionnaire d'exceptions personnalisé au lieu de celui qui est déjà intégré dans MARS. Pour installer notre gestionnaire d'exceptions, veuillez suivre les instructions suivantes :

   1. Commencez par télécharger le fichier de démarrage (voir plus haut dans ce document). Le fichier obtenu (`exceptions_handler.s`) est gestionnaire d'exceptions MIPS personnalisé.

   2. Dans MARS, accédez à "**Settings**" dans les menus déroulants.  
      ![Mars exception handler]({{site.baseurl}}/static_files/images/mars_exception_handler.png)

   3. Cochez la case "Initialize Program Counter to global 'main' if defined"

   4. Refaite l'étape **(ii)** et cliquez sur l'élément "**Exception Handler**". Une nouvelle boîte de dialogue apparaîtra.
      ![Mars exception handler 2]({{site.baseurl}}/static_files/images/mars_ehandler2.png)

   5. Cochez la case "**Include this exception handler file in all assemble operations**", puis entrez le chemin du fichier de gestionnaire d'exceptions que vous avez téléchargé. Choisissez OK pour terminer.

   6. MARS est désormais configuré pour utiliser notre nouveau gestionnaire d'exceptions au lieu du gestionnaire intégré.

1. Dans l'éditeur de MARS, écrivez un programme complet pour tester des instructions qui provoquent : un débordement, des accès à des adresses de mémoire non valides, des instructions de déroutement (trap) et des instructions de breakpoint. Votre programme **doit** commencer par ce bout de code :

   ```mips
   .globl
   main:
   ```
2. Modifiez le gestionnaire d'exceptions pour afficher le **vaddr** non valide quand l’exception est provoquée par un chargement (load), un stockage (store) ou une lecture d'instruction (code d'exception 4 ou 5). Testez votre gestionnaire d'exceptions en écrivant des instructions de chargement et de stockage générant des adresses mémoire non valides.

3. A l’aide de la MMIO (E/S mappée en mémoire) et le polling, écrire une fonction `print_string` qui imprime une chaîne sur l'écran, sans utiliser aucun appel système (c.-à-s. sans `syscall`). L'adresse de la chaîne est passée dans le registre `$a0` et la chaîne doit être terminée par le caractère NUL (zéro). Testez cette fonction en l'appelant à partir de la fonction principale. Assurez-vous d'activer le Simulateur de clavier et d'affichage MMIO (Keyboard and Display MMIO Simulator).

4. A l’aide de la MMIO (E/S mappée en mémoire) et le polling, écrire un programme qui lit les caractères directement à partir du clavier. Pour montrer la lenteur du clavier, imprimer le caractère saisi et le nombre d’itérations après la sortie de la boucle wait_keyboard. Répéter l'exécution du programme jusqu'à ce que vous appuyiez sur le caractère de nouvelle ligne (touche return). Assurez-vous d'activer le Simulateur de clavier et d'affichage MMIO (Keyboard and Display MMIO Simulator) et d’exécuter le simulateur MARS à la vitesse maximale.

5. Si le bit d'activation d'interruption du clavier est activé, le clavier interrompra le processeur à chaque pression sur une touche. Écrire un gestionnaire d'interruption simple qui renvoie le caractère saisi dans le registre `$v0`. Réécrire la fonction principale de la question n°4 en utilisant les interruptions du clavier.

6. A l’aide de la MMIO (E/S mappée en mémoire) et le polling, écrire une fonction `read_string` qui lit une chaîne de caractères directement à partir du clavier. La fonction récupère les caractères du clavier et les stocke dans un tableau pointé par le registre `$a0`. La fonction doit continuer jusqu'à ce que n-1 caractères soient lus ou que le caractère de nouvelle ligne soit enfoncé (touche return). Le paramètre n doit être passé dans le registre `$a1`. La fonction doit insérer un octet NUL à la fin de la chaîne et devrait renvoyer le nombre réel de caractères lus dans le registre `$v0`. Assurez-vous d'activer le Simulateur de clavier et d'affichage MMIO (Keyboard and Display MMIO Simulator). Ecrivez une fonction principale pour tester plusieurs fois `read_string` et pour afficher la chaîne de caractère après chaque appel.
