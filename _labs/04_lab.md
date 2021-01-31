---
type: lab
date: 2021-02-11T10:00:00+1:00
title: 'Assembleur MIPS'
attachment: /static_files/labs/lab_04.zip
#solutions: /static_files/labs/lab_solutions.pdf
hide_from_announcements: True
due_event:
    type: due
    date: 2021-02-17T10:00:00+1:00
    description: 'Travaux Pratiques #5 - à remettre'
---

# Objectifs

 - Maîtrise des conventions d'appel de fonction dans MIPS

 - Apprendre à écrire des fonctions en langage assembleur.

# Exercice 1

Télécharger le fichier de démarrage et décompressez son contenu dans le répertoire de votre choix. Dans cet exercice, vous allez compléter l'implémentation de la fonction `map()` dans `mips.s`. Cette fonction modifie les élément de la liste chaînée communiquée en paramètre. Les modifications se font sur place au lieu de créer et renvoyer une nouvelle liste avec les valeurs modifiées. Une implémentation de la liste en langage C serait comme suit :

```c
struct node {
  int value;
  struct node *next;
};
```

La fonction `map()` prend deux paramètres; un pointeur sur le premier nœud d'une liste-chaînée d'entiers (*i.e.* l'adresse du premier nœud dans la liste); et un pointeur de fonction qui prend un `int` en argument et renvoie un `int` en sortie. La fonction `map()` parcourt de manière récursive la liste et applique la fonction donnée en paramètre à chaque champ `value` des nœuds de la liste. Une implémentation en C de la fonction `map()` serait comme ceci :

```c
void map (struct node *head, int (*f) (int))
{
  if(head==NULL) { return; }
  head->value = f(head->value);
  map(head->next, f);
}
```

La déclaration `int (*f)(int)` signifie simplement que `f` est un pointeur sur une fonction qui, en langage C, est utilisée exactement comme toute autre fonction (si vous êtes curieux, consultez ce [lien](https://www.geeksforgeeks.org/function-pointer-in-c/) pour apprendre davantage sur leur utilisation).

Pour votre implémentation en assembleur MIPS de la fonction `map()`, vous aurez besoin d'utiliser une instruction que vous pourriez ne pas avoir rencontrer avant : `jalr`. L'instruction `jalr` est à `jr` ce que `jal` est à `j`. Cette instruction permet de se brancher à l'adresse contenue dans le registre donné et stocker l'adresse de l'instruction suivante (c.-à-d. PC + 4) dans `$ra`. Par exemple, si nous ne voulions pas utiliser l'instruction `jal`, on pourrait utiliser `jalr` pour appeler une fonction comme ceci :

```mips
# Nous aimerions appeler la fonction `garply`, sans utiliser l'instruction `jal`.
la $t0, garply 	# donc, nous utilisons l'instruction `la` pour charger l'adresse de `garply` dans un registre (ici $t0)
jalr $t0       	# puis, nous utilisons l'instruction `jalr` pour lier et brancher (comme `jr`).
```

Commencez par télécharger le fichier de démarrage (voir plus haut dans ce document) et décompressez son contenu dans le répertoire de votre choix. Il y a 12 emplacements dans le code `map.s` où il est indiqué `### VOTRE CODE ICI ###`. Remplacez-les par les instructions indiquées dans les commentaires pour terminer l'implémentation de la fonction `map()`.

Une fois le code complété, l’exécution du programme (dans MARS) devrait donner un résultat similaire à celui-ci :

```
Liste Avant: 9 8 7 6 5 4 3 2 1 0
Liste Après: 81 64 49 36 25 16 9 4 1 0
```

# Exercise 2

Dans l'exercice précédent, vous avez complété une procédure MIPS qui appliquait une fonction à chaque nœud dans une liste chaînée. Ici, vous travaillerez avec une version similaire (mais légèrement plus complexe).

En effet, au lieu d'avoir une liste chaînée de « `int` », notre structure de données est une liste chaînée de tableaux de « `int` ». Pour rappel, lorsque nous traitons un tableau dynamique en C, nous devons stocker explicitement sa taille dans une variable. Voici, en langage C, à quoi ressemble la structure de notre liste chaînée :

```C
struct node {
    int* arr;
    int size;
    struct node* next;
};
```

Voici également ce que fait la nouvelle fonction `map` : dans chaque nœud de la liste chaînée, elle parcourt chaque élément du tableau dynamique et lui applique une fonction donnée. Le résultat de la fonction est stocké dans le tableau en écrasant l'ancienne valeur.

```C
void map(struct node *head, int (*f)(int)) {
    if (!head) { return; }
    for (int i = 0; i < head->size; i++) {
      head->arr[i] = f(head->arr[i]);
    }
    map(head->next, f);
}
```

## Tâches à effectuer

Trouvez et corrigez les erreurs dans `megalistmanips.s`. En ce sens, aidez-vous des lignes commentées dans le fichier source et **assurez-vous que les instructions MIPS correspondent aux indications données dans les commentaires**. Voici quelques indications :

  * Pourquoi avons-nous besoin de sauvegarder des informations dans la pile avant d'exécuter l'instruction `jal` ?
  * Quelle est la différence entre « `add $t0, $s0, $0` » et « `lw $t0, 0($s0)` » ?
  * Faites attention aux types des attributs dans la structure `struct node`.


Pour référence, l'exécution du programme (dans MARS) devrait donner le résultat suivant :

```shell
Listes avant:
5 2 7 8 1
1 6 3 8 4
5 2 7 4 3
1 2 3 4 7
5 6 7 8 9

Listes après:
30 6 56 72 2
2 42 12 72 20
30 6 56 20 12
2 6 12 20 56
30 42 56 72 90
```

# Exercise 3

Considérons une fonction discrète `f` définie sur les entiers de l'ensemble {-3, -2, -1, 0, 1, 2, 3}. Voici la définition de la fonction :

   f(-3) = 6
   f(-2) = 61
   f(-1) = 17
   f(0) = -38
   f(1) = 19
   f(2) = 42
   f(3) = 5

Implémentez la version MIPS de la fonction discrète `f` dans `discrete_fn.s` **SANS** utiliser des instructions de branchement ou de saut !

Indication : Comment lire un mot à partir d'une adresse mémoire ?


# Exercice 4

Dans le fichier `reverse.s`, écrivez en assembleur MIPS le corp de la fonction `reverse(int* array, int size)` qui inverse l'ordre des éléments du tableau `array`. Par exemple, si :

```c
  array[6] = {1, 2, 3, 4, 5, 6};  
```
alors après application de la fonction `reverse` sur le tableau `array` le résultat devra être :

```c
  array[6] = {6, 5, 4, 3, 2, 1};  
```

Pour notre fonction en assembleur MIPS, l'adresse du tableau `array` est donnée dans le registre `$a0` et le paramètre `size` est donné dans le registre `$a1`.

<!--
# Exercice 5

La somme des carrés de *N* nombres entiers est décrit comme suit :

{% raw %}
$$sum = \sum_{i=0}^{N-1} n_i^2$$

où $$n_0, n_1, ..., n_{N-1}$$ sont des nombres entiers (de type ``int``).
{% endraw %}

Implémentez dans le fichier `SumOfSquares.s` le corps de la fonction `SumOfSquares` en assembleur MIPS et qui retourne dans le registre `$v0` la somme des carrés des éléments d'un tableau de **words**. Le nombre des éléments du tableau est donné dans le registre `$a0`, et l'adresse de début du tableau est donnée dans le registre `$a1`.

**INDICATION** : Faites l'exercice n°1 du "[TP Programmation << non structurée >>]({{site.baseurl}}/labs/03_lab.html)", puis convertissez votre code C en assembleur MIPS à l'aide de la [fiche]({{site.baseurl}}/static_files/docs/iche_mips.pdf) de référence MIPS et du document [contrôle de flux d'exécution dans MIPS]({{site.baseurl}}/static_files/docs/flow_control.pdf).


# Exercice 6

Dans la bibliothèque standard du langage C, la fonction `strcmp` (cf. `man 3 strcmp`) compare, caractère par caractère, deux chaînes en mémoire pour établir quelle chaîne de caractère vient en premier dans l'ordre lexicographique standard, c.-à-d. en fonction des valeurs ASCII des caractères. Voici quelques exemples :

  - "a" \< "b"
  - "abc" \< "abcd"
  - "A" \< "a"

Les chaînes de caractères à comparer sont représentées par des octets contigus en mémoire (chaque octet est un
caractère ASCII) suivi du caractère NUL (0x00).

Dans le fichier `StrCmp.s`, écrivez le corps de la fonction `StrCmp` en Assembleur MIPS.

Cette fonction doit retourner dans le registre `$v0` le résultat de la comparaison de deux chaînes de caractères. Si la première chaîne de caractères est inférieure à la second, alors `$v0` sera négatif. Si les deux chaînes de caractères sont semblables alors `$v0` sera nul. Enfin, si la première chaîne de caractères est supérieure à la seconde alors `$v0` sera positif.

L'adresse de la première (resp. deuxième) chaîne de caractères est donnée dans le registre `$a0` (resp. `$a1`).  

**INDICATION** : Faites l'exercice n°2 du "[TP Programmation << non structurée >>]({{site.baseurl}}/static_files/labs/03_lab.html)", puis convertissez votre code C en assembleur MIPS à l'aide de la [fiche]({{site.baseurl}}/static_files/docs/fiche_mips.pdf) de référence MIPS et du document [contrôle de flux d'exécution dans MIPS]({{site.baseurl}}/static_files/docs/flow_control.pdf).


## Exercice 7

Dans le fichier `InRange.s`, écrivez en assembleur MIPS le corp de la fonction `in_range(min, max, value)` qui retourne 1 dans `$v0` si `min <= value <= max` et 0 sinon. Vous pouvez supposer que :

  - `min` est donnée dans le registre `$a0`
  - `max` est donnée dans le registre `$a1`
  - `value` est donnée dans le registre `$a2`
-->
