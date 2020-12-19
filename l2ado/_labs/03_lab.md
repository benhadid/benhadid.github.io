---
type: lab
date: 2019-09-19T4:00:00+4:30
title: 'Travaux Pratiques #3 - Programmation « non structurée »'
attachment: /static_files/labs/lab_03.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event: 
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #3 - à remettre'
---

# Objectifs

  - Rappel sur les structures de contrôle dans le langage C
  - Connaître la programmation « [non structurée](http://pise.info/algo/complements.htm) »

# Introduction

Toute personne qui s’initie à la plongé sous-marine commence d'abord par apprendre les bases de cette technique dans une piscine ! Similairement, avant de s'attaquer à la programmation en assembleur (quelque chose qui effraie beaucoup d'étudiants), les exercices suivants vous apprennent à écrire des programmes simples dans le langage C mais qui se rapproche un pas de l'assembleur.     

Ainsi, pour les exercices ci-dessous, vous allez proposer des solutions aux problèmes posés dans le langage C avec la contrainte suivante : Aucun mot clé `for`, `while`, `do`, `switch` ou `else` ne peut être utilisé dans vos programmes.

*Indication* : Écrivez d'abord vos algorithmes d'une manière standard (c.-à-d. avec les mots-clés interdits), ensuite vous pouvez les convertir en des codes sans ces mots clés en vous aidant des exemples et indications donnés dans le document "[Programmation structurée et non structurée]({{site.baseurl}}/static_files/docs/non_structured_programming.html)".

# Exercice 1

La somme des carrés de *N* nombres entiers est décrit comme suit :

{% raw %}
$$sum = \sum_{i=0}^{N-1} n_i^2$$

où $$n_0, n_1, ..., n_{N-1}$$ sont des nombres entiers (de type ``int``).
{% endraw %}

Commencez par télécharger le fichier de démarrage (voir plus haut dans ce document) et décompressez son contenu dans le répertoire de votre choix. Implémentez ensuite dans le fichier `SumOfSquares.c` le corp de la fonction `SumOfSquares(int count, const int *tab)` qui retourne la somme des carrés des éléments d'un tableau d'entiers.
Le paramètre `count` est le nombre des éléments du tableau, et `tab` est un pointeur sur un tableau de type `int`.

**Contraintes à respecter :**
- *mot-clés interdits* : for, while, do, switch, else

```c
unsigned int SumOfSquares(int size, const int *tab)
{
  // à compléter
}
```

# Exercice 2

Dans la bibliothèque standard du langage C, la fonction `strcmp` (cf. `man 3 strcmp`) compare, caractère par caractère,
deux chaînes en mémoire pour établir quelle chaine de caractère vient en premier dans l'ordre
lexicographique standard, c.-à-d. en fonction des valeurs ASCII des caractères. Voici quelques exemples :

  - "a" < "b"
  - "abc" < "abcd"
  - "A" < "a"

Les chaînes de caractères à comparer sont représentées par des octets contigus en mémoire (chaque octet est un
caractère ASCII) suivi du caractère NUL (0x00).

Ecrivez dans le fichier `StrCmp.c` le corp de la fonction `StrCmp(const char *s1, const char *s2)` qui compare deux chaines de caractères. 
Les arguments `s1` et `s2` de la fonction `StrCmp` sont les adresses des deux chaînes à comparer. L'adresse de
mémoire du caractère de début de la première chaîne est dans `s1`, et l'adresse de mémoire du caractère de début
de la deuxième chaîne est dans `s2`. Si la première chaîne est supérieure à la seconde, renvoyez un nombre positif.
Si la deuxième chaîne est plus grande, renvoyez un nombre négatif. Si les chaînes sont égales, renvoyez 0.

**Contraintes à respecter :**
   - *mot-clés interdits* : for, while, do, switch, else

```c
int StrCmp(const char *s1, const char *s2)
{
  // à compléter
}
```

# Exercice 3

Dans le fichier `Calculatrice.c`, écrivez le corp de la fonction `calculatrice(float num1, float num2, char op)` qui retourne le résultat de l'opération `num1 op num2`, où `num1` et `num2` sont deux nombres de type `float`, et `op` est un caractère indicant le type de l'opération :

  '+' : opération d'addition
  '-' : opération de soustraction
  '*' : opération de multiplication
  '/' : opération de division

si `op` est différent des quatre opérations indiquées ci-dessus alors la fonction doit retourné la valeur `NAN` (cf. `man 3 NAN`).

**Contraintes à respecter :**
   - *mot-clés interdits* : for, while, do, switch, else

```c
float calculatrice(float num1, float num2, char op)
{
  // à compléter
}
```
