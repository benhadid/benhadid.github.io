---
type: lab
date: 2021-02-20T10:00:00+1:00
title: 'Travaux Pratiques #6 - Introduction à Logisim'
attachment: /static_files/labs/lab_06.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event:
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #7 - à remettre'
---

# Objectifs  

  - Apprendre à concevoir et déboguer des circuits logiques simples dans Logisim

  - Acquérir une expérience dans la conception et le débogage de circuits combinatoire dans Logisim  

# Initiation à Logisim

Dans ce TP, vous allez être introduit au logiciel [Logisim](https://fr.wikipedia.org/wiki/Logisim) pour implémenter des circuits logiques simples. Veuillez consulter le [tutoriel]({{site.baseurl}}/static_files/docs/Logisim_tutoriel.html) pour une introduction rapide.

Pour lancer le logiciel sur une machine de laboratoire (ou la VM), exécutez la commande suivante depuis un terminal :

```bash
$ logisim
```

## Étape 0 : Les  bases

Commençons par créer un circuit très simple pour connecter des portes logiques et des fils. Mais avant cela, notez une fonctionnalité très utile dans Logisim : la fonction zoom ! Elle se trouve dans le coin inférieur gauche (cf. figure ci-dessous ) et vous facilitera la vie au cours des quatre prochaines semaines.
![Zoom]({{site.baseurl}}/static_files/images/zoom_button.png){: height="75%" width="75%" .wp-caption .aligncenter }


  1. ![AND Gate]({{site.baseurl}}/static_files/images/and.gif) Commencez par cliquer sur le bouton "AND gate" (panneau à gauche - rubriques "Gates"). Vous remarquerez qu'une ombre d'une porte ET suivra les déplacements de votre curseur. Cliquez une fois dans la fenêtre schématique principale pour placer une porte ET.

  2. ![Input Pin]({{site.baseurl}}/static_files/images/input.gif) Cliquez sur le bouton "**Pin**" (rubrique "**Wiring**"). Maintenant, placez deux broches d’entrée  à gauche de votre porte ET.

  3. ![Input Pin]({{site.baseurl}}/static_files/images/input.gif) Cliquez sur le bouton "**Pin**". Placez ensuite une broche de sortie à droite de votre porte ET. Dans le panneau "Selection: Pin", changer la valeur de Output? à "Yes" et le paramètre Facing à "West".  Votre schéma devrait ressembler à ceci :
     ![2 Inputs AND Gate]({{site.baseurl}}/static_files/images/and_2_1.gif){: .wp-caption .aligncenter }

  4. ![Selection Tool]({{site.baseurl}}/static_files/images/selection.gif) Cliquez sur le bouton "**Select tool**". Cliquez et faites glisser pour connecter les broches d'entrée sur le côté gauche de la porte ET. Cela prendra plusieurs étapes, car vous ne pouvez tracer que des fils verticaux et horizontaux. Dessinez simplement un fil horizontalement, relâchez le bouton de la souris, puis cliquez et faites glisser vers le bas en partant de la fin du fil pour continuer verticalement. Vous pouvez attacher le fil à n'importe quelle broche de la porte ET du côté gauche. Répétez la même procédure pour connecter la sortie (côté droit) de la porte ET. Après avoir effectué ces étapes, votre schéma devrait ressembler à ceci:
     ![2 Inputs AND Gate]({{site.baseurl}}/static_files/images/connected_and_2_1.gif){: .wp-caption .aligncenter }     
  Vous pouvez également modifier le nombre d'entrées de la "porte ET" en cliquant dessus à l'aide de l'outil "**Select tool**" et en modifiant les propriétés "Number of Inputs" dans le panneau inférieur gauche de la fenêtre. Cela peut également être fait avant de déposer le composant.

  5. ![Poke Tool]({{site.baseurl}}/static_files/images/poke.gif) Enfin, cliquez sur l'outil "**Poke**" et essayez de cliquer sur les broches d'entrée de votre schéma. Observez ce qui se passe. Est-ce que cela correspond à ce que vous pensez qu'une porte ET devrait faire ?

## Étape 1 : Les sous-circuits

Tout comme les programmes écris dans un langage évolué peuvent contenir des fonctions auxiliaires, un schéma de circuit peut contenir des sous-circuits. Dans cette partie, nous allons créer plusieurs sous-circuits pour démontrer leur utilisation.

**REMARQUE IMPORTANTE :** La documentation de Logisim stipule que vous ne pouvez pas nommer un sous-circuit après un mot-clé (par exemple, "NAND"). Les noms de circuits doivent également commencer par "A-Za-z".

  1. Ouvrez le schéma de l'exercice 1 (**File | Open -> ex1.circ**). La fenêtre du sous-circuit NAND1 est automatiquement sélectionnée pour vous par Logisim.

  2. Dans cette fenêtre, créez un circuit NAND simple avec deux broches d'entrée sur le côté gauche et une broche de sortie sur le côté droit. Faites-le sans utiliser la porte NAND qui se trouve dans le dossier Gates (c.-à-d. utilisez uniquement les portes AND, OR et NOT). Vous pouvez modifier les étiquettes des entrées et des sorties en sélectionnant l'entrée / la sortie à l'aide de l'outil de sélection (**Select tool**) et en modifiant la propriété "Label" dans le panneau inférieur gauche de la fenêtre.

  3. Pour créer d'autres sous-circuits supplémentaires : NOR, XOR, MUX 2-to-1 et MUX 4-to-1 ; double-cliquez sur le nom du circuit dans le volet "Design" à gauche et répétez les instructions données dans l'étape 2 pour chaque sous-circuit. N'utilisez pas de portes intégrées autres que AND, OR et NOT. Cependant, une fois que vous avez construit un sous-circuit, vous pouvez l'utiliser pour en créer d'autres (cliquez sur le sous-circuit créé dans le volet des composants puis cliquez à nouveau sur la fenêtre de conception de circuit pour l'insérer comme composant).

**Remarques** :
  - Veuillez ne pas changer les noms des sous-circuits ou en créer de nouveaux; insérez vos solutions dans les circuits respectivement nommé ou bien l'auto-évaluateur ne fonctionnera pas correctement ( ça ne sera pas bon pour votre score :( ) !

  - Pour le MUX 4-to-1, `Sel0` et `Sel1` correspondent respectivement aux 0<sup>ème</sup> et 1<sup>er</sup> bits du sélecteur 2-bits.

  - Essayez de Réutiliser vos sous-circuits personnalisés lors de la conception d'autres circuits.

## Étape 2 : État de stockage

Implémentons à présent un circuit qui incrémente une valeur en continu. La différence entre ce circuit et les circuits que vous avez construits jusqu'à présent est l'**écriture** de cette valeur dans l'**état** d'un **registre**. Ce qui suit va vous montrer comment ajouter des registres à votre circuit.

  1. Ouvrez le schéma de l'exercice 2 (Fichier-> Ouvrir-> ex2.circ) et accédez au sous-circuit AddMachine (vide).

  2. La bibliothèque "Arithmetic" contient des éléments qui effectueront des opérations mathématiques de base :
    ![Logisim Arithmetic]({{site.baseurl}}/static_files/images/logisim_arithmetic.gif){: .aligncenter  }

  3. Sélectionnez le sous-circuit "Adder" (additionneur) dans la bibliothèque "Arithmétique" et placez le dans votre sous-circuit AddMachine.

  4. Sélectionnez "Register" dans la bibliothèque "Memory" et placez un registre dans votre sous-circuit. Vous trouverez ci-dessous une image représentant les parties d’un registre.
    ![Logisim Register]({{site.baseurl}}/static_files/images/register.png){: .wp-caption .aligncenter }

  5. Connectez une horloge à votre registre. Vous pouvez trouver l'élément du circuit d'horloge dans le dossier "Wiring" du navigateur de circuits.

  6. Connectez la sortie de l'additionneur à l'entrée du registre et la sortie du registre à l'entrée de l'additionneur. Il est possible que vous obtenez l'erreur "Largeurs incompatibles" lorsque vous connectez les composants. Cela signifie que le câble que vous tracez essaie de connecter deux broches avec des largeurs de bit différentes. Si vous cliquez sur l'additionneur avec l'outil "Sélection", vous remarquerez qu'il existe une propriété "Data Bits" dans le champ inférieur gauche de la fenêtre. Cette valeur détermine le nombre de bits de chaque entrée et sortie de l'additionneur. Modifiez ce champ si nécessaire pour faire disparaître  l'erreur.

  7. Branchez une constante "1" définit sur 8 bits à la seconde entrée de l'additionneur. Vous pouvez trouver l'élément de circuit "Constant" dans la bibliothèque "Wiring".

  8. Ajoutez deux broches de sortie à votre circuit afin de pouvoir surveiller ce qui sort de l'additionneur et du registre. La sortie de l'additionneur doit être connectée à ADD_OUT et la sortie du registre à REG_OUT. Au final, votre circuit devrait ressembler à ceci :
     ![Add Machine]({{site.baseurl}}/static_files/images/AddMachine.png){: .wp-caption .aligncenter }

  9. Lancez maintenant l'exécution de votre circuit depuis le menu **Simulate->Ticks Enabled** (ou la combinaison clavier **Control + K**). Votre circuit devrait maintenant afficher un compteur en binaire.

  10. Si vous souhaitez exécuter votre circuit plus rapidement, vous pouvez modifier la fréquence des ticks dans **Simulate->Tick Frequency**.

<div class="bs-callout bs-callout-danger">
<h4>ATTENTION</h4>
<p>
Ne déplacez / modifiez <b>PAS</b> les broches d'entrée et de sortie dans le fichier fourni <b>ex2.circ</b>. Cela brisera la connexion avec le socle de test. Si votre circuit ne passe pas les tests et que vous pensez qu'il est correct, assurez-vous que votre circuit s'insère corrèctement dans le socle de test dans <b>testing/circ_files/ex2_test.circ</b>.
</p>
</div>


## Étape 3 : Fonctionnalités avancées

Les parties suivantes vous présenteront des techniques / concepts plus avancés dans Logisim. Voici deux fonctionnalités de logisim que vous trouverez utiles.

### **Les tunnels**

Un [tunnel](http://www.cburch.com/logisim/docs/2.6.0/en/libs/base/tunnel.html) vous permet de dessiner un "fil invisible" pour lier deux points ensemble. Les tunnels sont regroupés par des étiquettes sensibles à la casse. Ils sont utilisés pour connecter des fils comme suit:

![Logisim Tunnel]({{site.baseurl}}/static_files/images/tunnels1.png){: .wp-caption }

Ce qui a un effet tel que :

![Logisim Linking]({{site.baseurl}}/static_files/images/tunnels2.png){: .wp-caption }

Nous vous recommandons fortement d'utiliser des tunnels avec Logisim, car ils rendent vos circuits beaucoup plus propres et donc plus faciles à déboguer.

### **Extenseur de bit (Extender)**

Lorsque vous modifiez la largeur d'un fil, vous devez utiliser un [extenseur de bit](http://www.cburch.com/logisim/docs/2.6.0/en/libs/base/extender.html) pour plus de clarté. Par exemple, considérez l'implémentation suivante de l'extension d'un fil de 8 bits en un fil de 16 bits:

![Logisim Extender 1]({{site.baseurl}}/static_files/images/extend1.png){: .wp-caption }

Alors que ce qui suit est beaucoup plus simple, plus facile à lire et moins sujet aux erreurs:

![Logisim Extender 2]({{site.baseurl}}/static_files/images/extend2.png){: .wp-caption }

En outre, considérez le cas de rejeter des bits. Dans cet exemple, un fil de 8 bits est converti en un fil de 4 bits en rejetant les autres bits :

![Logisim Extender 3]({{site.baseurl}}/static_files/images/extend3.png){: .wp-caption }

Malgré son nom, un extenseur de bits peut également effectuer cette même opération :

![Logisim Extender 4]({{site.baseurl}}/static_files/images/extend4.png){: .wp-caption }

### **Séparateur (Splitter)**

C'est le dernier outil essentiel dont vous aurez besoin dans cette classe. Pour démontrer son utilisation, vous allez construire un circuit qui manipule un nombre de 8 bits.

1. Créez un nouveau sous-circuit et nommez-le "Ex4".

2. Ajoutez une broche d'entrée 8 bits à votre circuit et étiquetez-la "In".

3. Ajoutez une broche de sortie à 1 bit étiquetée "Out1" et une broche de sortie à 8 bits étiquetée "Out2" à votre circuit.

4. Allez dans le dossier Câblage et sélectionnez le circuit Splitter. Ce circuit prendra un fil et le divisera en un ensemble de fils de plus petite largeur. Inversement, il peut également prendre de nombreux jeux de fils et les combiner dans un bus plus grand.

5. Avant de placer votre circuit, changez la propriété "Bit Width In" (largeur de bus) à 8 et la propriété "Fan Out" (# de branches) à 3. Si vous déplacez votre curseur sur le schéma, votre curseur devrait ressembler à ceci : ![Logisim Splitter]({{site.baseurl}}/static_files/images/splitter.gif)

6. Maintenant, sélectionnez les bits à envoyer à quelle partie de votre ventilateur. Le bit le moins significatif est le bit 0 et le bit le plus significatif est le bit 7. Modifiez les bits 1, 2 et 6 pour qu'ils apparaissent sur le bras de ventilateur 1 (celui du milieu). faites en sorte que tous les autres bits sortent du bras de ventilateur par défaut. FYI: l'option "None" signifie que le bit sélectionné ne sortira PAS sur les bras du ventilateur.

7. Une fois que vous avez configuré votre séparateur, vous pouvez le placer dans votre circuit.

8. Acheminez "In" vers le séparateur. Attachez une porte ET à 2 entrées aux bras du ventilateur 0 et 2 et acheminez la sortie de la porte ET à la sortie Out1.

9. Maintenant, supposez que l'entrée est un nombre "de signe et de magnitude". Ajoutez les portes logiques et autres circuits necessaires pour que Out2 soit la valeur négative de l’entrée. [Signe et magnitude](https://en.wikipedia.org/wiki/Signed_number_representations#Signed_magnitude_representation) est une autre façon de représenter les valeurs signées - comme le complément à 2.

10. Nous aurons besoin d'un autre séparateur pour recombiner les ventilateurs en un seul bus 8 bits. Placez un autre séparateur avec les propriétés appropriées (Bit Width In: 8, Fan Out: 3, corrigez les largeurs de ventilateur). Jouez avec les propriétés Facing et Appearance pour rendre votre circuit final aussi propre que possible.

## Étape 4 : Additionneur 4 bits

Maintenant que vous avez acquis un peu d'expérience avec Logisim, nous allons concevoir un circuit un peu plus compliqué - un additionneur 4 bits.

Un additionneur est un [circuit logique](https://fr.wikipedia.org/wiki/Circuit_logique) permettant de réaliser une addition. Ce circuit est très présent dans les ordinateurs pour le calcul arithmétique mais également pour le calcul d'adresses ou d'indice de tableau dans le processeur.

Un additionneur [complet](https://fr.wikipedia.org/wiki/Additionneur) à un bit ajoute trois nombres à un bit, souvent écrits sous les noms `A`, `B` et `Cin`; `A` et `B` sont les opérandes, et `Cin` est un la retenue (résultat éventuel d'un ajout antérieur). L'additionneur complet est généralement composé d'une cascade d'additionneurs, qui ajoutent des nombres binaires de 8, 16, 32, etc.

Dans la notation ci-dessous, A[4] indique que l'entrée est nommée " **A** " et possède 4 bits de large. L'entrée ne doit pas être nommée " **A[4]** " dans Logisim.

<table class="styled-table">
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<thead>
</thead>
<tbody>
<tr>
<th markdown="span">Add4 :</th>
<td markdown="span">S = A + B + Cin; Cout = retenue</td>
</tr>
<tr>
<th markdown="span">Opérandes :</th>
<td markdown="span">A[4], B[4], Cin</td>
</tr>
<tr>
<th markdown="span">Résultat :</th>
<td markdown="span">S[4], Cout</td>
</tr>
</tbody>
</table>

La sortie `S` est calculée en ajoutant `A` , `B` et `Cin`. `A` , `B` et `S` sont des nombres complément à deux. Si un débordement se produit, la sortie `Cout` doit être activée. Dans ce cas, la sortie `S` correspond à la valeur calculée quand toutes les erreurs de débordement sont ignorées.


**INDICATION** : Utilisez des sous-circuits pour faciliter le câblage en créant un additionneur à 1 bit, puis un additionneur à 4 bits, puis éventuellement un additionneur à 32 bits.

### **Table de vérité d'un additionneur 1-bit**

Une table de vérité montre comment la sortie d'un circuit logique répond à diverses combinaisons d'entrées. Par exemple, si toutes les entrées d'un additionneur complet sont des «0», les sorties seront également «0». Remplissez la table de vérité ci-dessous.

<table class="styled-table">
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">A</th>
<th style="text-align:center">B</th>
<th style="text-align:center">Cin</th>
<th style="text-align:center">Cout</th>
<th style="text-align:center">S</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**0**</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span"></td>
<td style="text-align:center" markdown="span"></td>
</tr>

</tbody>
</table>

### **Implémentation de l'additionneur 1-bit**

La table de vérité ci-dessus peut également être exprimée en utilisant l'algèbre booléenne.

```
   S =  A ⊕ B ⊕ Cin  
Cout = (A ∧ B) ∨ (Cin ∧ (A ⊕ B) )
```
Une technique appelée table de Karnaugh, du nom de Maurice Karnaugh, ingénieur en télécommunications aux laboratoires Bell en 1953, rendra très simple la conversion de la table de vérité en algèbre booléenne. Vous pouvez consulter cette [article](https://fr.wikipedia.org/wiki/Table_de_Karnaugh) sur les tables de Karnaugh pour rafraîchir votre mémoire. Ainsi, le circuit suivant est une représentation schématique de notre additionneur 1-bit.

![Full Adder]({{site.baseurl}}/static_files/images/Full_Adder.png){: .wp-caption img .aligncenter }

Implémentez cet additionneur 1-bit dans Logisim et vérifiez que votre circuit fonctionne correctement (utilisez la table de vérité plus haut pour vos comparaisons).

### **Construire un additionneur 4-bits sous Logisim**

Un additionneur 4-bits est réalisé en cascadant 4 additionneurs à 1 bit, où la sortie de l'additionneur courant alimente l'additionneur suivant.

![Full 4-bit Adder]({{site.baseurl}}/static_files/images/4bitAdder.png){: height="50%" width="50%" .wp-caption .aligncenter}

Construire l'additionneur 4-bits dans Logisim en réutilisant l'additionneur 1-bit que vous avez conçu précédemment en tant que sous-circuit.

**INDICATIONS** :
 - Utilisez des *séparateurs*
 - Utilisez des *tunnels*
 - Utilisez des sondes (probes) pour le débogage de votre circuit. Vous pouvez connecter des sondes aux bus d'entrée / sortie et définir l'affichage des valeurs en décimal pour une vérification rapide. Veuillez vous référer à la [page d'aide](http://www.cburch.com/logisim/docs/2.6.0/en/libs/base/probe.html) pour plus d'informations.

## Étape 5 : Rotation à droite

Avec des séparateurs et des multiplexeurs, vous allez implémenter un bloc logique combinatoire non trivial : `rotr`, qui signifie << Rotate Right >>. L'idée est que `rotr A, B` << fera pivoter >> les bits de l'entrée `A` vers la droite `B` bits fois. Ainsi, si `A` est `0b1011010101110011` et `B` est `0b0101` (5 en décimal), la sortie du bloc `rotr` sera `0b1001110110101011`. Notez que les 5 bits les plus à droite ont été extraits de l'extrémité droite de la valeur de `A` et injectés de nouveau à son extrémité gauche. En langage [RTL](https://fr.wikipedia.org/wiki/Register_Transfer_Language), l'opération ressemble à ceci `R = A >> B | A << (16 - B)`.

À l'aide de Logisim, implémentez dans `ex3.circ` le sous circuit nommé `rotr` ayant les entrées suivantes :
  - `A` (16-bit), la donnée sur 16 bits à faire pivoter
  - `B` (4-bit), la quantité de rotation (pourquoi 4 bits ?)

La sortie du circuit doit être la valeur de l'entrée `A` pivotée à droite de `B` positions. Vous n'êtes **PAS** autorisé à utiliser les composants de décalages Logisim dans votre solution. Toutefois, tout autre composant combinatoire (MUX, constantes, portes logiques, additionneurs, etc.) est autorisé. Votre solution ne doit **PAS** également utiliser d’horloge ou des éléments cadencés, comme les registres.

**Indication 1** : Avant de commencer, vous devez réfléchir très attentivement à la façon dont vous pourriez décomposer ce problème. Pensez à utiliser des sous-circuits (squelettes déjà fournis) ! Si vous ne le faites pas, attendez-vous à le regretter.

**Indication 2** : La représentation RTL de `rotr` donnée ci-dessus ne signifie pas forcement que c'est la meilleure façon d'implémenter la solution au problème. Pensez aux bits de l'entrée `B` et réfléchissez à la manière d'utiliser efficacement les séparateurs (*i.e.* splitters) ! Pouvez-vous faire quelque chose avec la forme binaire de `B` ? Pour rappel, un `1` peut représenter un signal `ON` et un `0` représentera dans ce cas un signal `OFF`. Disons que nous voulons effectuer une rotation 9 fois. 9 est **1001** en binaire, ou `1 * 8 + 0 * 4 + 0 * 2 + 1 * 1`. Pouvez-vous utiliser cela pour créer un circuit propre ? Utiliser les emplacements de sous-circuits `rot*` fournis dans `ex3.circ` !

<div class="bs-callout bs-callout-danger">
  <h4>ATTENTION</h4>

  <p>Votre fichier <b>ex3.circ</b> doit correspondre au socle <b>ex3_test.circ</b> fourni. Cela signifie que vous devez veiller à <b>ne pas réorganiser les entrées ou les sorties</b>. Si vous avez besoin de plus d'espace, utilisez des tunnels !</p>

  <p>Pour vérifier que vos modifications n’ont pas rompu les correspondances entrés / sorties entre les deux circuits, ouvrez le fichier <b>ex3_test.circ</b> et assurez-vous qu’il n’y a pas d’erreurs de branchement.</p>
</div>


## Tester vos circuits

Pour tester vos implémentations des circuits de ce TP, lancez le script suivant (depuis le répertoire contenant les fichiers  de démarrage) :

```bash
./test.sh
```

Si vous obtenez le message d'erreur "Permission denied", exécutez l'instruction :

```bash
chmod +x test.sh
```

Puis relancez à nouveau le script de test. Ce script copie vos circuits `ex?.circ` dans le répértoire de test, exécute les circuits testeur `ex?_test.circ` avec différentes entrées et comparera les sorties de vos circuits aux résultats attendus. Par conséquent, veuillez ne rien modifier dans le dossier `test`. Vous êtes encouragé, par contre, à consulter le contenu de ce répértoire pour avoir une idée sur les éléments utilisés pour tester automatiquement votre circuit. Cela vous sera très utile pour votre mini-project !
