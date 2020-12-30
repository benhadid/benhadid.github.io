---
type: lab
date: 2019-09-19T4:00:00+4:30
title: 'Travaux Pratiques #8 - Mémoire Cache'
attachment: /static_files/labs/lab_08.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event: 
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #8 - à remettre'
---

# Objectifs  

  - Découvrir comment les schémas d'accès à la mémoire déterminent les taux de succès de cache.
  
  - Déterminer quels schémas d'accès à la mémoire produisent de BONS taux de succès.

  - Être en mesure d'optimiser le code pour produire de bons taux de succès de cache.


# Outils de &laquo; Visualisation de Cache &raquo; dans MARS

Cet exercice utilise des outils de visualisation de cache dans MARS afin de vous familiariser avec le comportement du cache et la terminologie des mesures de performance. Ce n'est pas un exercice réel, mais plutôt une explication sur la façon d'utiliser MARS comme outil de visualisation du cache !

Commencez par télécharger le fichier de démarrage et décompressez son contenu dans le répertoire de votre choix. Ensuite, ouvrez le fichier `cache.s` dans MARS et examinez son contenu pour avoir une idée approximative de ce que fait le programme avant de procéder avec la suite.

  -	La partie la plus importante à comprendre dans le programme est la section intitulée "PSEUDOCODE" en haut du fichier.  Fondamentalement, nous allons simplement remettre à zéro certains éléments d'un tableau (option 0) ou les incrémenterez (option 1).

  - **Quels** éléments sont accédés dans le tableau est déterminé par le pas `step size` ($a1). Et le nombre de fois que nous faisons cela est contrôlé par le paramètre `repcount` ($a2). **Ces deux paramètres affecteront directement les taux de succès et d'échec dans le cache**. L'option ($a3) changera également certaines choses, tout comme les paramètres propres du cache.
 
Pour chacun des scénarios de l'exercice 1 ci-dessous, vous répéterez les étapes suivantes :

  1.	Définir dans `caches.s` les paramètres de programme appropriés comme indiqué au début de chaque scénario (en modifiant les valeurs immédiates des instructions `li` signalés dans la fonction `main`)
  
  2.	Exécuter << **Tools->Data Cache Simulator** >>.
  
  3.	Définir les paramètres de cache appropriés comme indiqué au début de chaque scénario.
  
  4.	Activer le journal d'exécution (Runtime Log), puis cliquez sur "Connect to MIPS".
  
  5.	Exécuter << **Tools->Memory Reference Visualizer** >> et cliquez sur "Connect to MIPS".
  
  6.	Au fur et à mesure que vous avancez dans le code dans MARS, tout accès au segment de données de la mémoire (chargement ou sauvegarde) sera visualisé (les accès à la mémoire d'instructions ne sont pas affichées).

Le << Data Cache Simulator >> affichera l'état de votre cache de données et le << Memory Reference Visualization >> montrera quelles parties de la mémoire sont accédées et combien de fois. Rappelons que ces outils fonctionnent indépendamment de votre code, donc si vous effectuez un << reset >> sur le code `cache.s` (ou autre), vous devez également réinitialiser le contenu du cache et de la mémoire !

**REMARQUE** : Si vous exécutez le code en un coup (au lieu d'une exécution pas-à-pas), vous obtiendrez l'état final du cache et le taux de succès. Afin de mieux voir quels << pas / itérations >> affectent les taux de succès et d'échec dans le programme, insérez un << point d'arrêt >> dans la **boucle** `wordLoop` juste avant ou après chaque accès à la mémoire.

# Exercice 1 : (Quelques scénarios d'accès à la mémoire)

## Tâches à réaliser : 

Simulez les scénarios suivants et notez les taux finaux de succès de cache avec le programme `cache.s`. Essayez de déduire quel sera le taux de succès AVANT d'exécuter le code. Après avoir exécuté chaque simulation, assurez-vous de comprendre LE POURQUOI des résultats obtenus (cela pourrait finir comme une question dans l'examen)!

Voici quelques questions auxquelles vous devriez pouvoir répondre et qui vous aideront à mieux comprendre les problèmes posés dans les scénarios ci-dessous : 

 -	Quelle est la taille du bloc mémoire / ligne de cache ?
 -	Combien d'accès consécutifs (en tenant compte de la taille du pas) accèdent au même bloc ?
 -	Combien de données tiennent dans TOUT le cache ?
 -	À quelle distance en mémoire se trouvent les blocs qui correspondent à la même ligne de cache (et pourraient donc créer des conflits) ?
 -	Quelle est l'associativité du cache ?
 -	À quel endroit du cache un bloc particulier en mémoire sera mappé ?
 -	Pour décider si un accès spécifique au cache est un échec ou un succès : a-t-on déjà accédé à cette donnée ? Si tel est le cas, est-elle toujours dans le cache ou non ?

### Scénario 1 

**Paramètres du cache :** (à définir dans la fenêtre << Cache Visualization >>)

 - **Placement Policy (type du cache):** Direct Mapping  (cache direct). 
 - **Block Replacement Policy (politique de remplacement de bloc):** LRU.
 - **Set size (nombre de blocs par ligne de cache) :** 1. (MARS ne vous autorisera pas à changer cette valeur. Pourquoi?)
 - **Number of blocks (nombre de blocs dans le cache):** 4.
 - **Cache block size (taille du bloc de cache):** 2 (en mots).

**Paramètres du programme :** (à définir en initialisant les registres $a? dans `cache.s`)
 
 - **Array Size (taille du tableau) :** 128 (octets).
 - **Step Size (pas) :** 8.
 - **repcount (nombre de répétitions) :** 4.
 - **Option :** 0.

**Indication :** : S'il vous est difficile de visualiser ce qui est mis dans le cache à chaque accès mémoire en examinant simplement le code, essayez avec du papier et un crayon ! Notez ce que serait la décomposition (Tag / Index / Offset) des adresses 32 bits et déterminez quelles adresses mémoire mappent vers quelle lignes dans le cache avec les bits d'Index.

1. Quelle combinaison de paramètres produit le taux de succès que vous observez ? (Indice : votre réponse doit être de la forme : << Parce que [paramètre A] en octets est exactement égal à [paramètre B] en octets.>>). **Remarque :** N'oubliez pas que la << taille du cache >> est un paramètre valide que vous définissez implicitement en choisissant la << taille du bloc >> et le << nombre de lignes >>.

2. Quel est le taux de succès du cache si nous augmentons arbitrairement le paramètre `repcount` ? Pourquoi ?

3. Comment pourrions-nous modifier un paramètre dans le programme pour augmenter notre taux de succès ? (Indice: votre réponse doit être de la forme: "Remplacez \[paramètre\] par \[valeur\]"). **Remarque :** Il n'est pas important si nous accédons aux mêmes éléments du tableau. Donnez simplement une modification des paramètres du programme qui augmenterait le taux de succès. Assurez-vous, cependant, que la valeur proposée soit valide.

### Scénario 2 

**Paramètres du cache :**

 - **Placement Policy (type du cache):** N-way Set Associative (cache N-associatif). 
 - **Block Replacement Policy (politique de remplacement de bloc):** LRU.
 - **Set size (nombre de blocs par ligne de cache) :** 4. 
 - **Number of blocks (nombre de blocs dans le cache):** 16.
 - **Cache block size (taille du bloc de cache):** 4 (en mots)

**Paramètres du programme :**
 
 - **Array Size (taille du tableau) :** 256 (octets)
 - **Step Size (pas) :** 2
 - **repcount (nombre de répétitions) :** 1
 - **Option :** 1

1. Combien d'accès mémoire y a-t-il par itération de la boucle interne ? (pas celle impliquant `repcount`) ? Ce n'est pas 1 !

2. Quel est le motif de répétition des succès / échecs ? POURQUOI ? (**Indice :** ils se répètent tous les 4 accès). Maintenant, donnez le taux de succès en termes de ce motif de répétition.

3. Qu'arrive-t-il à notre taux de succès si le nombre de répétitions `repcount` passe à l'infini (c.-à-d. notre boucle devient infini) ? Pourquoi ?

Vous auriez dû remarquer que le taux de succès était assez élevé pour le scénario 2, et votre réponse à la question précédente devrait vous donner une bonne compréhension de pourquoi. Si vous ne savez pas pourquoi, considérez la taille du tableau et comparez-la à la taille du cache. Maintenant, considérez ce qui suit :

Supposons que nous ayons un programme qui itère `repcount` fois sur un très grand tableau (c.-à-d. bien plus grand que la taille du cache). Pendant chaque itération, nous mappons une fonction différente aux éléments de notre tableau (par exemple, si `repcount = 1024`, nous mappons 1024 fonctions différentes sur chacun des éléments du tableau). Pour référence, dans le scénario 2, nous n'avions qu'une fonction d'incrémentation et une itération.

{:start="4"}
4. En tenant compte de la déscription ci-dessus, comment pouvons-nous restructurer les accès au tableau `array` pour atteindre un taux de succès comme celui obtenu avant (en supposons que chaque élément du tableau est modifié indépendamment des autres, c.-à-d. qu'il n'est pas important si la répétition k est appliquée à l'élément `arr[i+1]` avant qu'elle ne soit appliquée à l'élément `arr[i]`, etc.) ? 

**Indication :** Il ne serait pas judicieux de parcourir la totalité du tableau à chaque répétition car il est beaucoup plus volumineux que votre cache. Cela réduirait la quantité de localité temporelle exposée par votre programme et de ce fait impacterait négativement le taux de succès du cache. 

L'idée est d'exposer plus de localité afin que nos caches puissent profiter de notre comportement prévisible. Donc, nous devrions essayer d'accéder à \_\_\_\_\_\_\_\_ du tableau à la fois et appliquer toutes les \_\_\_\_\_\_\_\_ à ces \_\_\_\_\_\_\_\_ avant de continuer avec un nouveau \_\_\_\_\_\_\_\_. Cela nous permettra de garder \_\_\_\_\_\_\_\_ du tableau bien au chaud dans le cache pendant toute la procédure et ne pas avoir à faire le tour plus tard ! (Les 1<sup>er</sup>, 3<sup>ème</sup> et 5<sup>ème</sup> espaces doivent être identiques. Ce n'est pas un terme de vocabulaire spécifique que vous devriez utiliser pour les remplir. C'est plutôt une idée que vous devriez avoir).
 
# Exercice 2 : (Ordre des boucles et multiplication matricielle)

Pour rappel, les matrices sont des structures de données à deux dimensions dans lesquelles chaque élément de données est accessible via deux indices. Pour multiplier deux matrices, nous pouvons simplement utiliser trois boucles imbriquées. Par exemple, en supposant des matrices A, B et C de dimensions n-par-n et stockées dans des tableaux de colonnes à une dimension :

```C
for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
        for (int k = 0; k < n; k++)
            C[i+j*n] += A[i+k*n] * B[k+j*n];
```

Les opérations de multiplication matricielle sont au cœur de nombreux algorithmes d'algèbre linéaire, et une multiplication matricielle efficace est essentielle pour de nombreuses applications dans les sciences appliquées.

Dans le code ci-dessus, notez que les boucles sont ordonnées i, j, k. Si nous examinons la boucle la plus interne (celle qui incrémente k), on voit que elle...

 -	accède le tableau B avec un pas de 1
 -	accède le tableau A avec un pas de n
 -	accède le tableau C avec un pas de 0 (ne dépend pas de k)

Pour calculer **correctement** la multiplication matricielle, l'ordre des boucles n'a pas d'importance. **MAIS**, l'ordre dans lequel nous choisissons d'accéder aux éléments des matrices peut avoir **un impact important sur les performances**. Les caches fonctionnent mieux (i.e. un meilleur taux de succès) lorsque les accès à la mémoire exposent une localité spatiale et temporelle, permettant la réutilisation des blocs de données déjà contenus dans le cache. L'optimisation des schémas d'accès à la mémoire dans un programme est essentielle pour obtenir de bonnes performances.

Ouvrez le fichier en langage C `matrixMultiply.c` dans l'éditeur de votre choix et examinez son contenu. Vous remarquerez que le fichier contient six implémentations (l'une d'elles est illustrée ci-dessus) de multiplication de matrices en utilisant des ordres différents des trois boucles imbriquées.

**Tâche :** Déduisez les pas utilisés dans chaque ensemble de boucles imbriquées des cinq autres implémentations.

Compilez et exécutez le fichier `matrixMultiply.c` avec la commande suivante, puis répondez aux questions ci-dessous. 

```bash
$ make ex2
```

Notez que la commande de compilation dans le Makefile utilise l'indicateur '-O3'. Ce paramètre permet d'activer toutes les optimisations de performance possible du compilateur. La commande ci-dessous exécutera quelques multiplications de matrice selon les six implémentations différentes dans le fichier, et affichera la vitesse à laquelle chaque implémentation a exécuté l'opération. L'unité << Gflops/s >> signifie : << Giga-opérations en virgule flottante par seconde >>. Plus le nombre est grand, plus le calcul est rapide !

1. Quel(s) ordre(s) de boucles donne(nt) le meilleur résultat ? Pourquoi ?

2. Quel(s) ordre(s) de boucles donne(nt) le pire résultat ? Pourquoi ?

3. Comment la façon dont nous parcourons les matrices affecte-t-elle les performances ?


# Exercice 3: (Transposition de matrice par bloc)
 
## Transposition matricielle

Nous souhaitons permuter les lignes et les colonnes d'une matrice (voir figure ci-dessous). Cette opération est appelée *transposition de matrice* et une implémentation efficace peut être très utile, particulièrement quand on effectue des opérations assez compliquées en algèbre linéaire. La transposée de la matrice A est souvent désignée par A<sup>*T*</sup>.

![Transposition]({{site.baseurl}}/static_files/images/matrix_transpose.png){: .aligncenter width="60%" height="60%" }     

## Le cache-blocking

Dans l'exercice précédent sur les multiplications de matrices, nous parcourons (avec des pas différents) toutes les valeurs des matrices A et B pour calculer une valeur de la matrice C. Ainsi, nous accédons constamment à de nouvelles valeurs de la mémoire et obtenons très peu de localité temporelle et / ou spatiale des accès mémoire ! 

Nous pouvons améliorer la quantité de réutilisation des données dans les caches en implémentant une technique appelée << cache-blocking >>. Plus formellement, Le << cache-blocking >> est une technique qui consiste à ré-écrire une opération sur les tableaux de sorte à forcer la réutilisation des données présentes dans le cache. Elle doit donc prendre en compte la taille du cache comme argument. Dans le cas de la transposition matricielle, on envisage d'effectuer la transposition un bloc à la fois.

![BlocTransposition]({{site.baseurl}}/static_files/images/block_matrix_transpose.png){: .aligncenter width="60%" height="60%"}     

Dans l'image ci-dessus, nous transposons chaque sous-matrice $$A_{ij}$$ de la matrice $$A$$ dans son **emplacement final** dans la matrice de sortie, une sous-matrice à la fois. Nous pouvons vérifier que la transposition de chaque sous-matrice individuelle est équivalent à la transposition de la matrice entière.

Puisque la transposition de la matrice entière est effectuée une sous-matrice à la fois, cela permet de consolider en cache les accès mémoire à ce petit morceau de données lors de la transposition de cette sous-matrice particulière; ce qui augmente le degré de localité temporelle (et spatiale) que nous exposons et améliore ainsi les performances.

Dans cet exercice, vous allez compléter une implémentation pour la transposition de matrice et analyser ses performances.
En particulier, votre tâche consiste à implémenter la technique du << cache-blocking >> dans la fonction `transpose_blocking()` dans le fichier `transpose.c`. **Vous ne devez PAS supposer que la largeur de la matrice (`n`) est un multiple de la taille du bloc `blocksize`**. Après avoir implémenté la fonction `transpose_blocking()`, vous pouvez compiler et exécuter votre code en tapant :

```bash
$ make ex3
$ ./transpose n blocksize
```

où `n` est la largeur de la matrice et `blocksize` est la taille du bloc. Par exemple, `n` = 10000 et `blocksize` = 33. 

Si votre implémentation de `transpose_blocking()` est correcte, la méthode de découpage en blocs devrait montrer une amélioration substantielle des performances par rapport à la version 'naïve'.

**Conseils :** (si vous ne savez pas par où commencer !)

Commencez par examiner la fonction `transpose_naive()` incluse dans le fichier. Notez que l'indice `y` parcourt verticalement TOUTE la matrice `src` dans une itération de la boucle externe avant de se remettre à `0`. Une autre façon de dire cela est que l'indice `x` est mis à jour seulement après que l'indice `y` ait parcouru toute la plage d'indices `[0 .. n-1]`. C'est le comportement que nous voudrions changer, on aimerait éviter de parcourir tous les indices du tableau.

En bref : remplissez `dst` avec un bloc carré à la fois, où chaque bloc est de dimension `blocsize` par `blocsize`.

Au lieu de mettre à jour `x` uniquement lorsque `y` ait parcouru tous les indices `0` à `n-1`, vous voudriez passer à la ligne suivante de `dst` après avoir parcouru la largeur (axe horizontal) d'un seul bloc. De même, vous voudriez parcourir seulement la hauteur d'un bloc (axe vertical) avant de passer au bloc suivant. Quelle est la taille d'un bloc ? Elle est donnée par le paramètre `blocksize` !

**Indication :** Une solution simple nécessite quatre boucles `for`.

Enfin, comme la largeur de la matrice `n` n'est pas nécessairement un multiple de la taille de bloc `blocksize`, la colonne / ligne finale de blocs sera un peu coupée (voir les blocs $$A_{3\_}$$ et $$A_{\_3}$$ dans la figure ci-dessous). Pour résoudre ce problème, vous pouvez faire l'exercice en supposant au début que `n` est un multiple de `blocksize`, puis ajouter une condition quelque part dans le code pour ne rien faire lorsque vos index dépassent les limites de la matrice.

![CutBlocTransposition]({{site.baseurl}}/static_files/images/size_mismatch_matrix_transpose.png){: .aligncenter width="60%" height="60%"}     

Une fois que votre implémentation fonctionne corrèctement, l'étape suivante est d'effectuer une analyse des performances du code.

## Modifier les dimensions des matrices

Exécutez votre code plusieurs fois avec une valeur de `blocksize` fixée à 20 et les valeurs 100, 1000, 2000, 5000 et 10000 pour `n`. 

- À quel moment la version de transposition par << cache-blocking >> devient plus rapide que la version 'naïve' ? 

- Pourquoi la version en << cache-blocking >> nécessite-t-elle que la matrice ait une certaine taille avant de surpasser les performances de la version 'naïve' ?

## Modifier la taille de bloc

Fixez `n` à 10000 et exécutez votre code avec une taille de bloc `blocksize` égale à 50, 100, 500, 1000, 5000.

- Comment les performances changent-elles lorsque la taille du bloc augmente ? Pourquoi ?


**Note finale :** Dans les deux derniers exercices, les paramètres de cache de notre machine nous sont inconnus. Nous nous sommes simplement assurés que notre code présente un degré plus élevé de localité, et cela <!--, comme par magie,--> a amélioré considérablement les performances ! Cela indique que les caches, quels que soient leurs caractéristiques spécifiques, fonctionneront toujours mieux sur du code qui présente un haut degré de localité.


<!--
Les caches exploitent la localité spatiale et temporelle des accès mémoire. Bien que le code présente naturellement ces deux choses, nous pouvons généralement le modifier pour qu'il présente PLUS de ces deux choses, améliorant ainsi notre taux de réussite du cache et augmentant ainsi notre vitesse d'exécution.
-->