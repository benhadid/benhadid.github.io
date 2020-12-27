---
layout: default
title: page.title
---

# Programmation structurée et non structurée

## Introduction

La programmation non structurée est historiquement le paradigme de programmation le plus ancien et capable de créer des algorithmes [Turing-complet](https://fr.wikipedia.org/wiki/Turing-complet) (voir aussi [machine de Turing](https://fr.wikipedia.org/wiki/Machine_de_Turing)).

Un programme écrit de façon non structurée utilise des instructions de saut (c’est-à-dire l’instruction goto) vers des étiquettes ou vers des adresses d’instructions. Les lignes de ce programme sont généralement numérotées ou peuvent avoir des étiquettes : cela permet au flux d'exécution de sauter (i.e. brancher) à n'importe quelle ligne du programme. Ceci est en contraste avec la programmation structurée qui utilise des constructions de bloc de sélection (if/then/else) et de répétition (while et for).

Il existe des langages de programmation de haut et de bas niveau qui utilisent une programmation non structurée. Parmi les langages communément classés comme non-structurés on peut citer le JOSS, le FOCAL, le TELCOMP, les langages assembleurs, les fichiers de commande MS-DOS, ainsi que les premières versions du Fortran, du BASIC, du COBOL et de MUMPS.

Bien que cela vous ait été caché, vous avez déjà fait de la programmation structurée en algorithmique ! En effet, une instruction `if` réalise un saut sans que vous vous en apercevez. Par exemple, examinons le code C suivant :

```c
if (/* Condition */)
{
   /* Bloc */
}

/* Suite du programme */
```

Dans le cas où la condition est fausse, l’exécution du programme passe le bloc (délimité par des accolades) de l’instruction `if` et exécute la suite du programme. Autrement dit, il y a **un saut** jusqu’à la suite du bloc. En programmation non-structurée le programmeur (vous) introduit explicitement des instructions de saut dans le programme. Ainsi, l'exemple précédent dans un format non-structuré devient :

```c
if ( /* NON Condition */) goto FI;

/* Bloc */

FI:

/* Suite du programme */
```

Ici, une instruction goto avec l'étiquette associée (i.e. FI) sont introduites dans le programme pour accomplir la même tache que précédemment. Notez, toutefois, que la condition de l'instruction `if` est inversée ici (le mot clé NON) pour réaliser le même comportement que dans le cas de la programmation structurée (et la suppression des accolades qui ne sont plus utiles dans ce cas).

Une instruction `goto` en programmation C permet de sauter inconditionnellement du `goto` à une instruction étiquetée dans la même fonction. La syntaxe pour une instruction `goto` en C est la suivante -

```c
goto label;
..
.
label: instruction;
```

Ici, `label` peut être n’importe quel chaîne alphanumérique (à l'exception des mots-clé C), et elle peut être définie n’importe où dans le programme C au-dessus ou au-dessous pour une instruction `goto`.

## Exemples de codes structurés et non-structurés


### if/then/else

<div class="col-md-3">
<table class="table table-hover" >
  <thead>
    <tr>
      <th class="text-center" scope="col">Code structuré</th>
      <th class="text-center" scope="col">Code non structuré</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="text-left">
      <pre lang="c">
      if( /* Condition */ )
      {
         /* Bloc 1 */
      }
      else
      {
         /* Bloc 2 */
      }

      /* Suite du Programme */
      </pre>
      </td>

      <td class="text-left">
        <pre lang="c">
        if( /* NON Condition */) goto ESLE;

        /* Bloc 1 */
        goto FI;

        ESLE:
        /* Bloc 2 */
        FI:

        /* Suite du Programme */
        </pre>
      </td>
    </tr>
  </tbody>
</table>
</div>

Ici, deux instructions goto sont introduites : le premier goto (i.e. `goto ESLE`) permet de brancher dans le bloc du `else` si la condition est fausse. dans le cas où la condition est vraie, le bloc `then` (i.e. le Bloc 1) est exécuté. A la fin de ce bloc un deuxième goto (i.e. `goto FI`) permet de sauter à la suite du programme et ne pas exécuter le bloc du else (i.e. le Bloc 2).

### switch/case

<div class="col-md-3">
<table class="table table-hover" >
  <thead>
    <tr>
      <th class="text-center" scope="col">Code structuré</th>
      <th class="text-center" scope="col">Code non structuré</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="text-left">
      <pre lang="c">

      switch( /* Expression */ )
      {
        case 0: /* Bloc 0 */
                break;
        case 1: /* Bloc 1 */
                break;
        ...
        case N: /* Bloc N */
               break;
        default: /* Default */         
      }

      /* Suite du Programme */
      </pre>
      </td>

      <td class="text-left">
        <pre lang="c">
        void *SwitchTab[] = { &&ESAC0, &&ESAC1, ..., &&ESACN, &&TLUAFED };
        goto *SwitchTab[ /* Expression */ ];

        ESAC0: /* Bloc 0 */
        goto KAERB;
        ESAC1: /* Bloc 1 */
        goto KAERB;
        ...
        ESACN: /* Bloc N */
        goto KAERB;
        TLUAFED: /* Default */         
        KAERB:

        /* Suite du Programme */
        </pre>
      </td>
    </tr>
  </tbody>
</table>
</div>

Une approche naïve pour convertir un bloc de `switch/case` en un programme non structuré serait de réécrire le bloc de code en une suite de `if/then/else` et procéder par la suite à la conversion de ces blocs comme décrit plus haut dans ce document. Une autre approche, plus efficace, utiliserait les étapes suivantes :

1. Convertir chaque `case i` en une étiquette unique (ex: `case 5` deviendra `ESAC5`).

2. Créer un tableau avant l'instruction `switch` pour contenir toutes les valeurs des étiquettes correspondant aux instructions de case/default dans le bloc du switch (i.e. les étiquettes ESAC0, ESAC1 ...).

3. Créer une étiquette à la fin du bloc du switch et convertir chaque instruction de `break` du switch en une instruction de `goto` vers cette nouvelle étiquette pour sauter à la fin du bloc (i.e. l'instruction `goto KAERB` dans le code en dessus).

4. Enfin, en fonction de la valeur de l'expression du switch, nous récupérerons l'adresse de l'étiquette à partir du tableau et effectuons le saut adéquat à l'aide d'une instruction `goto`.  

REMARQUE : le schéma décrit ci-dessus suppose l'utilisation du compilateur GCC qui offre une fonctionnalité appelée "[labels as values](http://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html)" (i.e. étiquettes en tant que valeurs) - D'autres compilateurs C pourraient utilisés d'autres méthodes pour la conversion.

### boucle while/for

<div class="col-md-3">
<table class="table table-hover" >
  <thead>
    <tr>
      <th class="text-center" scope="col">Code structuré</th>
      <th class="text-center" scope="col">Code non structuré</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="text-left">
      <pre lang="c">

      while( /* Condition */ )
      {
         /* Bloc */
      }

      /* Suite du Programme */
      </pre>
      </td>

      <td class="text-left">
        <pre lang="c">
        ELIHW:
        if( /* NON Condition */ ) goto SUITE;

           /* Bloc */
        goto ELIHW;
        SUITE:
        /* Suite du Programme */
        </pre>
      </td>
    </tr>
  </tbody>
</table>
</div>

La conversion d'une boucle `while` en un code non structuré est très similaire à la conversion d'un bloc `if/then`. En effet, une petite comparaison entre le code ci-dessus et celui du bloc `if/then` introduit plus haut dans ce document montre qu'on plus de l'inversion de la condition de la boucle dans les codes non structuré (i.e. NON Condition), on procède ici à la transformation du mot clé `while` au mot clé `if` et on insert un deuxième `goto` à la fin du bloc de la boucle, juste avant l'étiquette de sortie pour revenir à nouveau à la condition de la boucle pour évaluation.

Pour convertir une boucle `for` en un code non structuré, on notera que cette boucle est conceptuellement équivalente à une boucle `while`. En effet, il est possible/facile de réécrire toute boucle `for` dans le langage C en une boucle `while` (voir l'exemple en dessous). On procédera par la suite comme décrit plus haut.

<div class="col-md-3">
<table class="table table-hover" >
  <thead>
    <tr>
      <th class="text-center" scope="col">Boucle for</th>
      <th class="text-center" scope="col">Boucle while</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="text-left">
      <pre lang="c">

      for( i = 0; i < N; i++  )
      {
         /* Bloc */

      }

      /* Suite du Programme */      
      </pre>

      </td>

      <td class="text-left">
      <pre lang="c">
      i = 0;
      while( i < N )
      {
         /* Bloc */
         i++;
      }

      /* Suite du Programme */
      </pre>
      </td>
    </tr>
  </tbody>
</table>
</div>

### boucle do/while

<div class="col-md-3">
<table class="table table-hover" >
  <thead>
    <tr>
      <th class="text-center" scope="col">Code structuré</th>
      <th class="text-center" scope="col">Code non structuré</th>      
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="text-left">
      <pre lang="c">
      do
      {
         /* Bloc */
      }
      while( /* Condition */ );

      /* Suite du Programme */
      </pre>
      </td>

      <td class="text-left">
        <pre lang="c">
        OD:

        /* Bloc */

        if( /* Condition */ ) goto OD;

        /* Suite du Programme */        
        </pre>
      </td>
    </tr>
  </tbody>
</table>
</div>

Comme pour la boucle `while` vue plus haut, la transformation vers un code non structuré de la boucle `do/while` requiert le remplacement du mot clé `while` par le mot clé `if`. Notez toutefois que la condition de la boucle reste inchangée (non inversée). Notez aussi qu'un seul `goto` est introduit et est utilisé pour revenir au début de la boucle `do/while`.
