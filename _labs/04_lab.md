---
type: lab
date: 2019-09-19T4:00:00+4:30
title: 'Travaux Pratiques #4 - Introduction à MARS'
attachment: /static_files/labs/Fibonacci.asm
#solutions: /static_files/labs/lab_solutions.pdf
due_event: 
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #4 - à remettre'
---

# Objectifs

  - Se familiariser avec le simulateur MARS. 
  - Apprendre à assembler, exécuter et déboguer un programme MIPS.


# Le simulateur MARS 

MARS, the Mips Assembly and Runtime Simulator, will assemble and simulate the execution of MIPS assembly language programs. It can be used either from a command line or through its integrated development environment (IDE). MARS is written in Java and requires at least Release 1.5 of the J2SE Java Runtime Environment (JRE) to work. It is distributed as an executable JAR file. The MARS home page is http://www.cs.missouristate.edu/MARS/.

MARS (**Mi**ps **A**ssembly and **R**untime **S**imulator), assemble et simule l'exécution de programmes en langage assembleur MIPS. Il peut être utilisé à partir de la ligne de commande ou via son environnement de développement intégré (IDE). MARS est écrit en Java et nécessite au moins la version 1.5 de J2SE Java Runtime Environment (JRE) pour fonctionner. Il est distribué sous forme de fichier JAR exécutable depuis cette [page d'accueil](http://www.cs.missouristate.edu/MARS/). 

MARS est déjà installé sur les machines du laboratoire et dans la VM fournie. Pour lancer Mars dans la VM ou depuis une machine du laboratoire, entrez la commande suivante dans un terminal

```bash
$ mars
```

Il y a deux fenêtres principales dans MARS (voir figure ci-dessous)

 - La fenêtre d'édition **Edit** : utilisée pour créer et modifier un programme MIPS
 - La fenêtre d'exécution **Execute** : utilisée pour exécuter et déboguer un programme MIPS

 ![MARS]({{site.baseurl}}/static_files/images/mars.png){: height="100%" width="100%" .aligncenter}

Pour basculer entre les fenêtres **Edit** et **Execute**, utilisez les onglets en haut.

Il y a deux zones de message à onglets au bas de la figure ci-dessus:

 1. The Mars Messages tab : Used for messages such as assembly or runtime errors and informational messages. You can click on assembly error messages to select the corresponding line of code in the editor. 

 1. L'onglet << Mars Messages >> : utilisé pour afficher des messages tels que les erreurs d'assemblage ou d'exécution et les messages d'information. Vous pouvez cliquer sur les messages d'erreur d'assemblage pour sélectionner la ligne de code correspondante dans l'éditeur.

 2. L'onglet << Run I/O >> : Utilisé au moment de l'exécution pour afficher la sortie du programme sur la console et saisir éventuellement des entrées pour celui-ci.

La fenêtre **Execute** contient trois volets principaux :

 1. **Text Segment** : affiche le code machine et les adresses associées. 

 2. **Data Segment** : affiche les emplacements de mémoire qui contiennent des variables dans le segment de données. 
 
 3. **Labels** : affiche les adresses des éléments étiquetés comme les variables et les points de saut. Si l'anglet n'est pas visible sur votre simulateur, vous pouvez l'activer à partir du menu << Settings \| Show Labels Window (symbol table) >>

La figure ci-dessous montre les volets de la fenêtre **Execute** et souligne les fonctionnalités suivantes :

  1. L'onglet de la fenêtre **Execute**. 

  2. Code assembleur affiché avec adresses et code machine associés. 
 
  3. Valeurs stockées dans le segment de données. Vous pouvez les modifier directement dans cette zone. 
 
  4. Commandes de navigation dans la zone de segment de données. Permet aussi de basculer pour afficher le segment de pile. 
 
  5. Basculer entre l'affichage décimal et hexadécimal des adresses et les valeurs dans la mémoire et dans les registres.
 
  6. Les étiquettes et leurs adresses mémoire correspondantes.
 
  7. Valeurs stockées dans les registres. Vous pouvez modifier directement ces valeurs dans cette zone.
 
  8. Cases à cocher utilisées pour configurer les << points d'arrêt >> pour chaque instruction MIPS. Utile pour le débogage.  
 
  9. Sélection de la vitesse d'exécution. Utile pour le débogage.

 ![MARS]({{site.baseurl}}/static_files/images/mars_execute_annotated.png){: height="100%" width="100%" .aligncenter}

À tout moment, la fenêtre de registre MIPS apparaît sur le côté droit de l'écran, même lorsque vous êtes en mode édition et n'exécutez pas de programme. Cela sert de référence utile pour les noms de registre et leur utilisation. Déplacez la souris sur le nom du registre pour voir les info-bulles.

Il existe trois onglets de registres :

 - **Registers** : Les registres entiers $0 à $31, HI, LO, et le PC. 
 - **Coproc 0** : registres pour les codes d'excéptions, d'interruptions, et de status. 
 - **Coproc 1** : registres pour le calcul en virgule flottante. 

# Assembler, Exécuter, et Déboguer un programme MIPS

Pour assembler le code actuellement dans l'onglet **Edit**, sélectionnez << Assemble >> dans le menu << Run >> ou utilisez l'icône ![MARS]({{site.baseurl}}/static_files/images/mars_assemble_icon.png) de la barre d'outils.

S'il y'a des erreurs de syntaxe dans le programme, elles apparaîtront dans l'onglet << Mars Messages >> en bas de la fenêtre MARS. Chaque message d'erreur contient la ligne et la colonne où l'erreur s'est produite.

Si le programme MIPS s'assemble avec succès, les registres sont initialisés et les segment de texte et de données sont remplis, comme illustré à la figure ci-dessous.

 ![MARS]({{site.baseurl}}/static_files/images/mars_execute.png){: height="100%" width="100%" .aligncenter}


Après avoir exécuté la commande << Assemble >>, vous pouvez maintenant exécuter le programme. Le menu << Run >> et la barre d'outils contiennent les options d'exécution suivantes :



<table class="styled-table">
<colgroup>
<col width="13%" />
<col width="10%" />
<col width="77%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Menu</th>
<th style="text-align:center">Icône</th>
<th style="text-align:center" >Action</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:left" markdown="span">Run \| Assemble</td>
<td style="text-align:center" markdown="span">![MARS]({{site.baseurl}}/static_files/images/mars_assemble_icon.png)</td>
<td markdown="span">Assemble le programme</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">Run \| Go</td>
<td style="text-align:center" markdown="span">![GO]({{site.baseurl}}/static_files/images/mars_execute_go.png)</td>
<td markdown="span">Exécute le programme jusqu'à la fin ou jusqu'au prochain << point d'arrêt >></td>
</tr>

<tr>
<td style="text-align:left" markdown="span">Run \| Reset</td>
<td style="text-align:center" markdown="span">![RESET]({{site.baseurl}}/static_files/images/mars_execute_reset.png)</td>
<td markdown="span">Réinitialise le programme et le simulateur aux valeurs initiales. Permet de redémarrer l'exécution du programme.</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">Run \| Step</td>
<td style="text-align:center" markdown="span">![STEP]({{site.baseurl}}/static_files/images/mars_execute_step.png)</td>
<td markdown="span">Exécution pas-à-pas : Exécute une instruction à la fois. Permet de déboguer le programme en inspectant les registres et la mémoire après avoir exécuté chaque instruction.</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">Run \| BackStep</td>
<td style="text-align:center" markdown="span">![BACKSTEP]({{site.baseurl}}/static_files/images/mars_execute_backstep.png)</td>
<td markdown="span">Un pas en arrière : Annule l'exécution de la dernière instruction.</td>
</tr>

<tr>
<td style="text-align:center" colspan=2 markdown="span">![SPEED]({{site.baseurl}}/static_files/images/mars_execute_speed.png)</td>
<td markdown="span">Ce curseur permet d'exécuter le programme à pleine vitesse ou de le ralentir pour qu'on puisse voir l'évolution de l'exécution.</td>
</tr>
</tbody>
</table>
 

Pendant l'exécution du programme, l'instruction en cours est surlignée en jaune et le registre qui a été modifié en dernier est surligné en vert. De plus, la variable qui vient d'être mise à jour dans le segment de données est surlignée en bleu. Ces effets de couleurs ne sont perceptibles que si vous exécutez le programme en mode << pas-à-pas >> ou à une vitesse assez réduite.

Pour plus de détails sur le simulateur MARS, reportez-vous à la [documentation MARS](http://courses.missouristate.edu/KenVollmar/MARS).

# Tâches à réaliser 


1. Tester un programme MIPS simple. Considérez le programme suivant illustré ci-dessous :

   1. Tapez dans MARS le programme illustré dans la figure ci-dessus.  

   2. Découvrez comment afficher et masquer les numéros de ligne. 

   3. Assemblez et exécutez le programme. 

   4. Quelle est la sortie du programme ? et où apparaît-elle ? 

  ![MARS]({{site.baseurl}}/static_files/images/mars_hello.png){: height="93%" width="93%" .wp-caption .aligncenter}

{:start="2"}
2. Explorer le simulateur MARS : 

   1. Téléchargez et assemblez dans MARS le fichier de démarrage au début de ce document (ou depuis le [site de MARS](http://courses.missouristate.edu/KenVollmar/MARS)). 

   2. Identifiez les emplacements et les valeurs des données initialisées. 

   3. Basculer le format d'affichage entre décimal et hexadécimal. 

   4. Exécutez le programme à une vitesse de 3 instructions par seconde ou moins. 

   5. Exécutez le programme pas-à-pas et remarquez comment les valeurs dans les registres et dans la mémoire changent. 

   6. Observez la sortie du programme dans la fenêtre d'affichage << Run I/O >>. 

   7. Définissez un << point d'arrêt >> à la première instruction qui affiche les résultats. Quelle est l'adresse de cette instruction ?

   8. Exécutez le programme à vitesse normale et remarquez comment il s'arrête au << point d'arrêt >>.

   9. Changez la ligne :
         ```mips
         space: .asciiz " "    # space to insert between numbers 
         ```
         à cette ligne

         ```mips
         space: .asciiz "\n"   # space to insert between numbers
         ```
         
         Exécutez le programme encore une fois. Que remarquez-vous ? 




<!--

La somme des carrés de *N* nombres entiers est décrit comme suit :

{% raw %}
$$sum = \sum_{i=0}^{N-1} n_i^2$$

où $$n_0, n_1, ..., n_{N-1}$$ sont des nombres entiers (de type ``int``).
{% endraw %}

Télécharger le fichier de démarrage (voir plus haut dans ce document) et décompressez son contenu dans le répertoire de votre choix. Implémentez ensuite dans le fichier `SumOfSquares.s` le corps de la fonction `SumOfSquares` en assembleur MIPS et qui retourne dans le registre `$v0` la somme des carrés des éléments d'un tableau de **words**. Le nombre des éléments du tableau est donné dans le registre `$a0`, et l'adresse de début du tableau est donnée dans le registre `$a1`.

**INDICATION** : Faites l'exercice n°1 du "[TP Programmation « non structurée »]({{site.baseurl}}/labs/03_lab.html)", puis convertissez votre code C en assembleur MIPS à l'aide de la [fiche]({{site.baseurl}}/static_files/docs/iche_mips.pdf) de référence MIPS et du document [contrôle de flux d'exécution dans MIPS]({{site.baseurl}}/static_files/docs/flow_control.pdf).


# Exercice 2

Dans la bibliothèque standard du langage C, la fonction `strcmp` (cf. `man 3 strcmp`) compare, caractère par caractère, deux chaînes en mémoire pour établir quelle chaîne de caractère vient en premier dans l'ordre lexicographique standard, c.-à-d. en fonction des valeurs ASCII des caractères. Voici quelques exemples :

  - "a" < "b"
  - "abc" < "abcd"
  - "A" < "a"

Les chaînes de caractères à comparer sont représentées par des octets contigus en mémoire (chaque octet est un
caractère ASCII) suivi du caractère NUL (0x00).

Dans le fichier `StrCmp.s`, écrivez le corps de la fonction `StrCmp` en Assembleur MIPS. 

Cette fonction doit retourner dans le registre `$v0` le résultat de la comparaison de deux chaînes de caractères. Si la première chaîne de caractères est inférieure à la second, alors `$v0` sera négatif. Si les deux chaînes de caractères sont semblables alors `$v0` sera nul. Enfin, si la première chaîne de caractères est supérieure à la seconde alors `$v0` sera positif.

L'adresse de la première (resp. deuxième) chaîne de caractères est donnée dans le registre `$a0` (resp. `$a1`).  

**INDICATION** : Faites l'exercice n°2 du "[TP Programmation « non structurée »]({{site.baseurl}}/static_files/labs/03_lab.html)", puis convertissez votre code C en assembleur MIPS à l'aide de la [fiche]({{site.baseurl}}/static_files/docs/fiche_mips.pdf) de référence MIPS et du document [contrôle de flux d'exécution dans MIPS]({{site.baseurl}}/static_files/docs/flow_control.pdf).


## Exercice 3

Dans le fichier `InRange.s`, écrivez en assembleur MIPS le corp de la fonction `in_range(min, max, value)` qui retourne 1 dans `$v0` si `min <= value <= max` et 0 sinon. Vous pouvez supposer que :

  - `min` est donnée dans le registre `$a0`
  - `max` est donnée dans le registre `$a1`
  - `value` est donnée dans le registre `$a2`


# Exercice 4

Dans le fichier `Reverse.s`, écrivez en assembleur MIPS le corp de la fonction `reverse(int* array, int size)` qui inverse l'ordre des éléments du tableau `array`. Par exemple, si :

```c
  array[6] = {1, 2, 3, 4, 5, 6};  
```
alors après application de la fonction `reverse` sur le tableau `array` le résultat devra être :

```c
  array[6] = {6, 5, 4, 3, 2, 1};  
```

Pour notre fonction en assembleur MIPS, l'adresse du tableau `array` est donnée dans le registre `$a0` et le paramètre `size` est donné dans le registre `$a1`.

-->
