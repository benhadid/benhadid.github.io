---
type: lab
date: 2021-01-23T10:00:00+1:00
title: 'Travaux Pratiques #2 - Manipulations des données'
attachment: /static_files/labs/lab_02.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event:
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #2 - à remettre'
---

# Objectifs

  - Apprendre à effectuer des manipulations de bits spécifiques grâce à des compositions d'opérations sur les bits.

  - Apprendre à identifier les problèmes potentiels en relation avec la gestion dynamique de la mémoire.

# Exercice 1

Commencez d'abord par télécharger le fichier de démarrage (voir plus haut dans ce document) et décompressez son contenu dans le répertoire de votre choix. Implémentez ensuite dans le fichier `bit_ops.c` les fonctions de manipulation de bits` get_bit()`, `set_bit()` et` flip_bit()` (illustrées ci-dessous). Vous pouvez utiliser **UNIQUEMENT** des [opérations de manipulation de bits]({{site.baseurl}}/static_files/docs/bitwise_operations_in_c.html) comme le **ET** (`&`), le **OU** (`|`), le **XOR** (`^`), le **NOT** (`~`), le **décalage à gauche** (`<<`) et le **décalage à droite** (`>>`). Vous ne pouvez pas utiliser de boucles `for` / `while` / `do` ou les instructions de condition `if / else` et `switch / case`. Vous ne pouvez pas non plus utiliser les opérations arithmétiques ( modulo (%), division, soustraction, addition ou multiplication ) pour cet exercice.


``` C
// Retourne le n-ième bit de x.
// Vous pouvez considérer que 0 <= n <= 31
bool get_bit(uint32_t x, uint8_t n);

// Fixe le n-ième bit de la valeur de x à v.
// Vous pouvez considérer que 0 <= n <= 31, et v est soit 0 ou 1
void set_bit(uint32_t *x, uint8_t n, bool v);

// Inverse le n-ième bit de la valeur de x.
// Vous pouvez considérer que 0 <= n <= 31
void flip_bit(uint32_t *x, uint8_t n);

```

## Tâches à réaliser :

Après avoir achevé l'implémentation des fonctions `get_bit()`, `set_bit()` et `flip_bit()`, vous pouvez compiler et exécuter votre code à l'aide des commandes suivantes :

``` shell
$ make bit_ops
$ ./bit_ops
```

Cela affichera sur votre écran le résultat de quelques tests limités.

# Exercice 2

Dans cet exercice, vous implémenterez une fonction `lfsr_calculate()` pour calculer la prochaine itération d'un registre à décalage à rétroaction linéaire [LFSR](https://fr.wikipedia.org/wiki/Registre_%C3%A0_d%C3%A9calage_%C3%A0_r%C3%A9troaction_lin%C3%A9aire). Les applications qui utilisent les LFSR sont: la télévision numérique, les téléphones portables CDMA, Ethernet, USB 3.0 et bien plus encore ! Dans `lfsr.c`, implémentez la fonctio3n `lfsr_calculate()` pour qu'elle réalise l'opération illustrée ci-dessous :

![LFSR]({{site.baseurl}}/static_files/images/lfsr.gif){: height="50%" width="50%" .aligncenter}

## Explications :
  - Si vous vous demandez, cette fonction sert à générer des nombres pseudo-aléatoires.

  - A chaque appel à `lfsr_calculate()`, vous déplacerez le contenu du registre d'un bit vers la droite.

  - Ce décalage n'est ni un décalage logique ni un décalage arithmétique. Sur le côté gauche, vous injecterez un bit qui est égal au OU exclusif (XOR) des bits originaires des positions 0, 2, 3 et 5.

  - Le symbole rouge illustrant un signe `plus dans un cercle` représente un `OU exclusif`, qui prend deux entrées `{a , b}` et produit `a ^ b`.

  - Si vous avez implémenté correctement `lfsr_calculate()`, la fonction devrait afficher tous les 65535 entiers positifs sur 16 bits avant de revenir au nombre initial de départ.

  - Notez que le bit le plus à gauche est le MSB  (bit de poids fort) et le bit le plus à droite est le LSB (bit de poids faible).

## Tâches à réaliser :

Implémentez la fonction `lfsr_calculate()` dans le fichier `lfsr.c` puis compilez et exécutez ce dernier à l'aide de la commande `make` (voir ci-dessous). Vérifiez que le résultat affiché sur votre écran ressemble à ce qui suit :

``` shell
$ make lfsr
$ ./lfsr
My number is: 1
My number is: 5185
My number is: 38801
My number is: 52819
My number is: 21116
My number is: 54726
My number is: 26552
My number is: 46916
My number is: 41728
My number is: 26004
My number is: 62850
My number is: 40625
My number is: 647
My number is: 12837
My number is: 7043
My number is: 26003
My number is: 35845
My number is: 61398
My number is: 42863
My number is: 57133
My number is: 59156
My number is: 13312
My number is: 16285
 ... etc etc ...
Got 65535 numbers before cycling!
Congratulations! It works!
```

# Exercice 3

La compilation manuelle de programmes C dans le terminal (voir les exemples du TP précédent) est une opération fastidieuse et longue qui nécessite l'exécution de plusieurs commandes avec de longues séries d'arguments. Bien que cela soit faisable pour les programmes C simples, pour les programmes avec des dizaines de fichiers et de dépendances, cela devient rapidement assez compliqué.

Ainsi, la plupart des programmeurs C écrivent ce que l’on appelle un << Makefile >> pour faciliter la compilation. Un << Makefile >> est un fichier texte (littéralement appelé << Makefile >>) qui se trouve dans le répertoire de code source et qui contient un ensemble de règles. Chacune de ces règles spécifie des commandes à exécuter pour manipuler un programme (ex : compiler un fichier source, effacer l'exécutable, etc). Une fois le fichier Makefile préparé, le programmeur a juste besoin de taper "make" dans son terminal de commande pour effectuer les tâches indiquées dans le makefile.

Consultez le << Makefile >> inclus dans ce TP et essayez de répondre aux questions suivantes (Les réponses sont disponibles en cliquant sur &nbsp; &#9656; &nbsp; pour chaque question. Pour apprendre davantage sur les Makefiles Google est votre ami :smile: ).

  <details close="">
  <summary>  
  Quelle cible (<i>anglais</i> : target) fait partie d'une règle qui supprime tous les programmes compilés ?  
  </summary>
  <p style="color: firebrick" markdown="span">
  C'est la cible << `clean:` >> dans **notre** Makefile.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Quelle cible fait partie d'une règle qui permet de compiler tous les programmes ?
  </summary>
  <p style="color: firebrick" markdown="span">
  C'est la cible << `all:` >> dans **notre** Makefile.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Quel compilateur est actuellement utilisé dans notre Makefile ?
  </summary>
  <p style="color: firebrick" markdown="span">
  La variable CC dans **notre** Makefile définie le compilateur utilisé. Ici, c'est le compilateur C de `gcc`.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Quelle norme C utilisons-nous actuellement ?
  </summary>
  <p style="color: firebrick" markdown="span">
  La norme de langage utilisée dans un code source peut être définie avec le paramètre `-std=<norme>` dans un compilateur. Ici nous indiquons que les fichiers sources obéissent à la norme [C99](https://en.wikipedia.org/wiki/C99) du langage C.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Comment est référencé une variable « FOO » dans un makefile ?
  </summary>
  <p style="color: firebrick" markdown="span">
  La syntaxe `$(FOO)` fait référence à la variable FOO dans un Makefile.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Quel système d'exploitation le terme « Darwin » représente-t-il ?
  </summary>
  <p style="color: firebrick" markdown="span">
  Le terme << Darwin >> retourné par la commande de shell `uname -s` indique que le système est un MacOSX.
  </p>
  </details>
  <p></p>

  <details close="">
  <summary>  
  Quelle ligne crée le programme <b>lfsr</b> à partir de ses fichiers objets ?
  </summary>
  <p style="color: firebrick" markdown="span">
  La cible << `$(LFSR_PROG):` >> dans le Makefile.
  </p>
  </details>
  <p></p>

<!-- Un << Makefile >> a l'air intimidant, mais est en fait un outil formidable qui permet de gagner beaucoup de temps ! -->

# Exercise 4

Cet exercice utilise les fichiers `vector.h`, `vector-test.c` et `vector.c` pour implémenter des fonctionnalités pour la gestion des tableaux C de longueur variable. Cet exercice est conçu pour vous aider à vous familiariser avec les structures C et la gestion de la mémoire en langage C.

## Tâches à réaliser :

Expliquez pourquoi `bad_vector_new()` et `also_bad_vector_new()` sont de mauvaises implémentations et complétez les fonctions `vector_new()`, `vector_get()`, `vector_delete()` et `vector_set()` dans `vector.c`. Insérez également les prototypes de ces fonctions dans le fichier entête `vector.h` afin que le code de test `vector-test.c` puisse s'exécuter sans aucune erreur.

Additionnellement, implémentez une règle pour la cible `vector-test` dans le fichier Makefile.

Les commentaires dans le code décrivent comment les fonctions doivent fonctionner. Consultez les fonctions déjà implémentées pour voir comment les structures de données doivent être utilisées. Par souci de cohérence, il est supposé que toutes les entrées du vecteur sont égales à `0` à moins qu'elles ne soient explicitement définies ou modifiées par l'utilisateur. Rappelez-vous de cela parce que la fonction `malloc()` ne met pas à zéro la mémoire qu'elle alloue.

Pour expliquer pourquoi les deux mauvaises fonctions sont incorrectes, gardez à l'esprit que l'une de ces fonctions s'exécutera correctement mais il peut y avoir d'autres problèmes (invisibles). Indication : Examinez l'utilisation de la mémoire.

Vérifiez votre implémentation de `vector_new()`, `vector_get()`, `vector_delete()` et `vector_set()` par rapport à l'exactitude des résultats et aussi par rapport à la gestion corrècte de la mémoire (détails ci-dessous).

```shell
# 1) pour vérifier l'exactitude des résultats
$ make vector-test
$ ./vector-test

# 2) pour vérifier la gestion de la mémoire avec Valgrind
$ make vector-memcheck
```

Tout ce que la [règle](https://www.gnu.org/software/make/manual/make.html#Rule-Introduction) `vector-memcheck` fait est d'exécuter la commande `valgrind` suivante sur notre exécutable. Que signifie chacun des drapeaux/paramètres dans la commande suivante ?

```shell
$ valgrind --tool=memcheck --leak-check=full --track-origins=yes [OS SPECIFIC ARGS] ./<executable>
```

La dernière ligne de la sortie Valgrind vous indiquera en un coup d'œil s'il y a eu des erreurs. Voici un exemple de sortie d'un programme bogué :

```shell
==47132== ERROR SUMMARY: 1200039 errors from 24 contexts (suppressed: 18 from 18)
```

Si votre programme comporte des erreurs, vous pouvez faire défiler la sortie de la ligne de commande pour afficher les détails de chacune des erreurs. Pour cet exercice, vous pouvez ignorer toutes les sorties faisant référence à des erreurs supprimées (*anglais* : suppressed). Dans un programme sans problèmes de mémoire, votre sortie ressemblera à ceci :

```shell
==44144== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 18 from 18)
```

Au final, n'hésitez pas à utiliser également CGDB ou à ajouter des instructions `printf` à `vector.c` et `vector-test.c` pour déboguer votre code.
