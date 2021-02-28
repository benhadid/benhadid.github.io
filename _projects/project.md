---
#layout: project
type: project
date: 2021-02-25T12:00:00+1:00
title: Projet - Processeur MIPS
attachment: /static_files/projects/mipscpu.zip
hide_from_announcements: True
due_event:
    type: due
    date: 2021-03-20T23:59:59+1:00
    description: 'Projet à remettre'    
---

# Énoncé

Pour ce mini-projet, vous utiliserez [Logisim](https://fr.wikipedia.org/wiki/Logisim) afin d'implémenter une version basique d'un processeur MIPS. Ce devoir est organisé en deux parties : A et B.

Dans la partie A (tâches 1 à 3), vous allez construire une « Unité Arithmétique et Logique (UAL) » et un « Banc de Registres » pour un processeur MIPS basique, ainsi qu'une implémentation du chemin de données nécessaire à l’exécution des instructions `addi`. Dans la partie B (tâches 4), vous ajouterez d’autres composants à votre processeur basique pour produire une version avancée qui exécutera des instructions MIPS réelles !

Commencez par télécharger le fichier de démarrage et décompressez son contenu dans le répertoire de votre choix. Voici la liste des fichiers que vous devez avoir :

```bash
proj_starter
  ├── cpu
  │   ├── alu.circ
  │   ├── branch_comp.circ
  │   ├── control_logic.circ
  │   ├── cpu_pipelined.circ
  │   ├── cpu_single.circ
  │   ├── imm_gen.circ
  │   ├── mem.circ
  │   └── regfile.circ
  ├── harnesses
  │   ├── alu_harness.circ
  │   ├── regfile_harness.circ
  │   ├── run_pipelined.circ
  │   ├── run_single.circ
  │   ├── test_pipelined_harness.circ
  │   └── test_single_harness.circ
  ├── logisim-evolution.jar
  ├── tests
  │   ├── part_a
  │   │   ├── ...
  ╎   ╎   ╎
  │   │   └── ...
  │   └── part_b
  │       ├── ...
  ╎       ╎
  │       └── ...
  └── test_runner.py
 ```

<div class="bs-callout bs-callout-danger">
 <b>REMARQUE</b> : Seul les fichiers : <b>alu.circ</b>,  <b>branch_comp.circ</b>, <b>control_logic.circ</b>, <b>cpu_single.circ</b>, <b>cpu_pipelined.circ</b>, <b>imm_gen.circ</b> et <b>regfile.circ</b> doivent être modifiés et soumis pour évaluation. Le circuit <b>mem.circ</b> est déjà implémenté pour vous.
</div>

# Partie A : Version basique

## Tâche 1 : Unité Arithmétique et logique (UAL)

Votre première tâche est de créer une UAL qui prend en charge toutes les opérations requises par les instructions de notre ISA (décrites plus en détail dans la section suivante).

le fichier squelette fourni `alu.circ` indique que votre UAL doit avoir trois entrées :

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="80%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de l'entrée</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center">Description</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:center" markdown="span">**A**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Données sur l'entrée A pour l'opération UAL</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">**B**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Données sur l'entrée B pour l'opération UAL</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">**ALUSel**</td>
<td style="text-align:center" markdown="span">4</td>
<td markdown="span">Sélectionne quelle opération l'UAL doit effectuer (voir ci-dessous pour la liste des opérations avec les valeurs correspondantes du commutateur).</td>
</tr>
</tbody>
</table>

... et deux sorties

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="80%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de la sortie</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:center" markdown="span">**Zero**</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Indique si la différence entre les entrées **A** et **B** est nulle</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">**Result**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Résultat de l'opération UAL</td>
</tr>
</tbody>
</table>

**REMARQUES** : Dans les slides du cours &laquo; [Architecture de Von Neumann](https://1drv.ms/p/s!Agf0g-qZKM8_yAyyv1se7-WxjsN2?e=GO7udR) &raquo;, et afin de construire une UAL de plusieurs bits (8 bits est donné comme exemple), il est indiqué de dupliquer votre circuit de 1 bit et faire les adaptations nécessaires pour obtenir une UAL de plusieurs bits. Bonne nouvelle ! vous n'avez pas à le faire dans ce mini-projet, Logisim fait déjà cela pour vous ! Il suffit simplement de choisir la bonne largeur de bits pour les entrées / sorties de vos composants et c'est tout (voir la figure ci-dessous) !

 ![Largeur de bits]({{site.baseurl}}/static_files/images/data_width.png){: height="55%" width="55%" .wp-caption .aligncenter}

Enfin, voici ci-dessous la liste des opérations (et les valeurs **ALUSel** associées) que votre UAL doit pouvoir effectuer. Vous pouvez utiliser tout bloc ou fonction intégrée de Logisim pour implémenter votre circuit. **Il n'est pas nécessaire de réimplémenter le circuit additionneur, de décalage ou le circuit multiplicateur ! Utilisez les blocs de circuit fournis par Logisim à cet effet**.

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="15%" />
<col width="30%" />
<col width="45%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Valeur de ALUSel</th>
<th style="text-align:center">Instruction</th>
<th style="text-align:center">Description</th>
<th style="text-align:center">Remarque</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;add</td>
<td markdown="span">&emsp;`Result = A + B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;and</td>
<td markdown="span">&emsp;`Result = A & B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">2</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;or</td>
<td markdown="span">&emsp;`Result = A | B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">3</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;xor</td>
<td markdown="span">&emsp;`Result = A ^ B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">4</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;srl</td>
<td markdown="span">&emsp;`Result = A >> B`</td>
<td markdown="span">Opération non signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">5</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;sra</td>
<td markdown="span">&emsp;`Result = A >> B`</td>
<td markdown="span">Opération signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">6</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;sll</td>
<td markdown="span">&emsp;`Result = A << B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">7</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;&mdash;</td>
<td markdown="span">&emsp;&emsp;&emsp;&emsp;&mdash;</td>
<td markdown="span">Non utilisé</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">8</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;slt</td>
<td markdown="span">&emsp;`Result = A < B ? 1 : 0`</td>
<td markdown="span">Comparaison signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">9</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;sltu</td>
<td markdown="span">&emsp;`Result = A < B ? 1 : 0`</td>
<td markdown="span">Comparaison non signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">10</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;mul</td>
<td markdown="span">&emsp;`Result = (A * B)[31:0]`</td>
<td markdown="span">Opération signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">11</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;mulhu</td>
<td markdown="span">&emsp;`Result = (A * B)[63:32]`</td>
<td markdown="span">Opération non signée</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">12</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;sub</td>
<td markdown="span">&emsp;`Result = A - B`</td>
<td markdown="span"></td>
</tr>

<tr>
<td style="text-align:center" markdown="span">13</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;&mdash;</td>
<td markdown="span">&emsp;&emsp;&emsp;&emsp;&mdash;</td>
<td markdown="span">Non utilisé</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">14</td>
<td style="text-align:left" markdown="span">&emsp;&emsp;mulh</td>
<td markdown="span">&emsp;`Result = (A * B)[63:32]`</td>
<td markdown="span">Opération signée</td>
</tr>
</tbody>
</table>


**Indications** :

  * L'opération `add` est déjà implémentée pour vous; n'hésitez pas à utiliser une structure similaire pour réaliser les autres fonctions.    

  * Lors de l'implémentation de `mul` et `mulh`, veuillez noter que le bloc Logisim de multiplication possède une sortie « Carry Out » qui pourrait vous être utile (le bloc additionneur possède également cette sortie, mais vous n'en aurez pas besoin pour ce projet).

  * Les séparateurs et les extenseurs de bits vous seront très utiles lors de l'implémentation des opérations de décalages.

  * Utilisez les tunnels ! Cela vous évitera de croiser des fils involontairement ce qui causera des erreurs inattendues.

  * Un multiplexeur (MUX) peut être utile pour décider quelle sortie de quel composant vous voulez transmettre. En d'autres termes, traiter les entrées dans tous les composants d'une manière simultanée, puis, en fonction de l'opération choisie, sélectionner la bonne sortie à transmettre.


<div class="bs-callout bs-callout-danger">
  <h4>ATTENTION</h4>

  <p>Vous pouvez apporter toutes les modifications souhaitées à <b>alu.circ</b>, mais les entrées et sorties du circuit doivent obéir au comportement spécifié ci-dessus. De plus, votre fichier <b>alu.circ</b> doit correspondre au socle <b>alu_harness.circ</b> fourni. Cela signifie que vous devez veiller à <b>NE PAS</b> réorganiser les entrées ou les sorties du circuit. Si vous avez besoin de plus d'espace, utilisez des tunnels !</p>

  <p>Si vous créez des sous-circuits supplémentaires, ils doivent également être dans <b>alu.circ</b> (c.-à-d. vous ne devez pas créer de nouveaux fichiers .circ).</p>

  <p>Pour vérifier que vos modifications n’ont pas rompu les correspondances entrés / sorties entre les deux circuits, ouvrez le fichier <b>alu_harness.circ</b> dans Logisim et assurez-vous qu’il n’y a pas d’erreurs de branchement.</p>
</div>

### **Tester votre UAL**

Un groupe de tests de cohérence UAL est fourni dans le répertoire `tests/part_a/alu`. L'exécution du script fourni `test_runner.py` (voir ci-dessous) exécutera les tests UAL et produira les résultats dans le répertoire `tests/part_a/alu/student_output`.

```bash
$ python3 test_runner.py part_a alu
```

Également fourni un fichier `binary_to_hex_alu.py` qui permet d'interpréter la sortie de l'UAL dans un format lisible. Pour l'utiliser, procédez comme suit :

```bash
$ cd tests/part_a/alu
$ python3 binary_to_hex_alu.py PATH_TO_OUTPUT_FILE
```

Par exemple, pour visualiser le fichier `reference_output/alu-add-ref.out`, procédez comme suit :

```bash
$ cd tests/part_a/alu
$ python3 binary_to_hex_alu.py reference_output/alu-add-ref.out
```

Si vous voulez voir la différence entre la sortie de votre circuit et la solution de référence, placez les sorties lisibles dans de nouveaux fichiers `.out` et comparez-les avec la commande `diff` (cf. `man diff`). Par exemple, pour le test `alu-add`, procédez comme suit :

```bash
$ cd tests/part_a/alu
$ python3 binary_to_hex_alu.py reference_output/alu-add-ref.out > reference.out
$ python3 binary_to_hex_alu.py student_output/alu-add-student.out > student.out
$ diff reference.out student.out
```

## Tâche 2 : Banc de Registres

Dans cette tâche, vous implémenterez **les 32 registres $0 &ndash; $31** spécifiés dans l'architecture MIPS. Pour faciliter l'implémentation, neuf registres seront exposés à des fins de test et de débogage (voir la liste ci-dessous). Veuillez vous assurer que les valeurs de ces registres sont attachées aux sorties appropriées dans le fichier `regfile.circ`.

Votre « Banc de Registres » devrait pouvoir lire ou écrire depuis/dans les registres spécifiés dans une instruction MIPS et cela sans affecter les autres registres. Il y a une exception notable : votre « Banc de Registres » ne doit **PAS** écrire dans le registre `$0` même si une instruction tente de le faire. Pour rappel, le registre zéro doit **TOUJOURS** avoir la valeur `0`.

Les registres exposés et leurs numéros correspondants sont indiqués ci-dessous.

<table class="styled-table">
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Numéro de registre</th>
<th style="text-align:center">Nom du registre</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">$0</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">4</td>
<td style="text-align:center" markdown="span">$a0</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">8</td>
<td style="text-align:center" markdown="span">$t0</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">9</td>
<td style="text-align:center" markdown="span">$t1</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">10</td>
<td style="text-align:center" markdown="span">$t2</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">16</td>
<td style="text-align:center" markdown="span">$s0</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">17</td>
<td style="text-align:center" markdown="span">$s1</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">29</td>
<td style="text-align:center" markdown="span">$sp</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">31</td>
<td style="text-align:center" markdown="span">$ra</td>
</tr>
</tbody>
</table>

<br>
Un squelette du « Banc de Registres » à implémenter est fourni dans le fichier `regfile.circ`. Le circuit possède six entrées :

<table class="styled-table">
<colgroup>
<col width="20%" />
<col width="15%" />
<col width="65%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de l'entrée</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center">Description</th>
</tr>
</thead>

<tbody>

<tr>
<td style="text-align:left" markdown="span">&emsp;**Clock**</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Entrée fournissant l'horloge. Ce signal peut être acheminé à d'autres sous-circuits ou directement raccordé aux entrées d’horloge des unités de mémoire dans Logisim, mais ne doit en aucune façon être raccordé à des portes logiques (c.-à-d. ne l’inversez pas, n'appliquez pas la porte "ET" dessus, etc.)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**RegWEn**</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Active l'écriture des données au prochain front montant de l'horloge</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**rs**</td>
<td style="text-align:center" markdown="span">5</td>
<td markdown="span">Détermine quelle valeur de registre est envoyée à la sortie **Read_Data_1** (voir ci-dessous)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**rt**</td>
<td style="text-align:center" markdown="span">5</td>
<td markdown="span">Détermine quelle valeur de registre est envoyée à la sortie **Read_Data_2** (voir ci-dessous)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**rd**</td>
<td style="text-align:center" markdown="span">5</td>
<td markdown="span">Sélectionne le registre qui recevra le contenu de **Write_Data** au prochain front montant de l'horloge, en supposant que **RegWEn** est à **1**</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**Write_Data**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Contient les données à écrire dans le registre identifié par l'entrée **rd** au prochain front montant de l'horloge, en supposant que **RegWEn** est à **1**</td>
</tr>
</tbody>
</table>

<br>
Le « Banc de Registres » dans `regfile.circ` possède également les sorties suivantes :

<table class="styled-table">
<colgroup>
<col width="20%" />
<col width="15%" />
<col width="65%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de la sortie</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>

<tbody>

<tr>
<td style="text-align:left" markdown="span">&emsp;**Read_Data_1**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre identifié par l'entrée **rs**</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;**Read_Data_2**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre identifié par l'entrée **rt**</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **ra**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$ra** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **sp**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$sp** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **t0**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$t0** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **t1**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$t1** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **t2**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$t2** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **s0**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$s0** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **s1**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$s1** (sortie utilisée pour le débogage et les tests)</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">&emsp;Valeur **s2**</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Renvoie la valeur contenue dans le registre **$s2** (sortie utilisée pour le débogage et les tests)</td>
</tr>
</tbody>
</table>

Les sorties de test en haut du fichier `regfile.circ` sont présentes à des fins de test et de débogage. Un « Banc de Registres » réel ne possède pas ces sorties ! Pour ce mini-projet, assurez-vous qu'ils sont correctement raccordés aux registres indiqués parce que s'ils ne le sont pas, l'évaluateur automatique ne pourra pas évaluer votre devoir correctement ( et vous obtiendrez un zéro. :( ).

**Indications** :

  * Utilisez le copier-coller à volonté ! Afin d'éviter un travail répétitif (et ennuyeux), commencez par créer un registre complètement fonctionnel et utiliser le ensuite comme modèle pour construire les autres.

  * Il est recommandé de ne pas utiliser l'entrée « `enable` » sur vos MUX. En fait, vous pouvez même désactiver cette fonctionnalité depuis le panel Logisim. Il est également conseillé de mettre sur « `off` » la propriété "three-state?".

  * Consultez l'étape 2 du TP [Travaux Pratiques #6 - Introduction à Logisim]({{site.baseurl}}/labs/06_lab.html) pour voir à quoi correspond chaque entrée/sortie d'un registre Logisim.

  * Comme pour la tâche de l'UAL, les multiplexeurs vous seront très utiles (les démultiplexeurs, également).

  * Que se passe-t-il dans le « Banc de Registres » après l'exécution d'une instruction machine. Quelles valeurs changent ? Quelles valeurs restent les mêmes ? Les registres sont déclenchés par une horloge - qu'est-ce que cela signifie ?

  * Pour rappel, les registres possèdent une entrée « `enable` » ainsi qu'une entrée d'horloge.

  * Quelle est la valeur du registre `$0` ?


<div class="bs-callout bs-callout-danger">
  <h4>ATTENTION</h4>

  <p>Vous pouvez apporter toutes les modifications souhaitées à <b>regfile.circ</b>, mais les entrées et la sortie doivent obéir au comportement spécifié ci-dessus. De plus, votre fichier <b>regfile.circ</b> doit correspondre au socle <b>regfile_harness.circ</b> fourni. Cela signifie que vous devez veiller à <b>NE PAS</b> réorganiser les entrées ou les sorties du circuit. Si vous avez besoin de plus d'espace, utilisez des tunnels !</p>

  <p>Si vous créez des sous-circuits supplémentaires, ils doivent également être dans <b>regfile.circ</b> (c.-à-d. vous ne devez pas créer de nouveaux fichiers .circ).</p>

  <p>Pour vérifier que vos modifications n’ont pas rompu les correspondances entrés/sorties entre les deux circuits, ouvrez le fichier <b>regfile_harness.circ</b> et assurez-vous qu’il n’y a pas d’erreurs de branchement.</p>
</div>

### **Tester votre « Banc de Registres »**

Un groupe de tests de cohérence du « Banc de Registres » est fourni dans le répertoire `tests/part_a/regfile`. L'exécution du testeur (voir ci-dessous) pour ce groupe exécutera également les tests UAL et produira le résultat des tests dans le répertoire `tests/part_a/regfile/student_output`.

```bash
$ python3 test_runner.py part_a regfile
```

Également fourni un fichier `binary_to_hex_regfile.py` qui fonctionne d'une manière similaire au fichier `binary_to_hex_alu.py` de la tâche n°1.

## Tâche 3 : L'instruction `addi`

Dans cette troisième et dernière tâche pour la partie A, vous allez implémenter un processeur capable d’exécuter une instruction : `addi` ! Vous pouvez choisir d'implémenter d'autres instructions supplémentaires, mais vous ne serez noté que si l'instruction `addi` s'exécute correctement pour la partie A.

### Info : Mémoire (circuit `mem.circ`)

L'unité de mémoire (fournie dans `mem.circ`) est déjà entièrement implémentée pour vous ! Cependant, l'instruction `addi` n'utilise **PAS** l'unité de mémoire, vous pouvez donc ignorer ce module pour la partie A.

### Info : Comparateur de Branchement (circuit `branch_comp.circ`)

L'unité « Comparateur de Branchement » fournie dans le fichier `branch_comp.circ` n'est pas implémentée, mais comme l'instruction `addi` n'utilise **PAS** cette unité vous pouvez donc l'ignorer pour la partie A.

### Info : Générateur d'Immédiat (circuit `imm_gen.circ`)

l'unité « Générateur d'Immédiat » fournie dans le fichier `imm_gen.circ` n'est pas implémentée. L'instruction `addi` utilise cette unité. Toutefois, comme il s'agit de la seule instruction à implémenter dans cette partie du projet, vous pouvez donc vous limiter à coder que l'immédiat associé à cette instruction sans vous soucier des autres types d'immédiat. Consultez l'image ci-dessous pour savoir comment l'immédiat de l'instruction `addi` doit être généré :

![addi format]({{site.baseurl}}/static_files/images/immediat_addi.png){: height="75%" width="75%" .aligncenter}

Pour éditer le « Générateur d'Immédiat », modifiez le fichier `imm_gen.circ` et non le circuit virtuel `imm_gen` inclus dans `cpu_*.circ`. Notez qu'à chaque modification du circuit `imm_gen.circ`, vous devez fermer et ouvrir le fichier `cpu_*.circ` pour appliquer les modifications dans votre CPU.

Voici un résumé des entrées et sorties de l'unité :

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="20%" />
<col width="60%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom</th>
<th style="text-align:center">Direction</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">inst</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">L'instruction en cours d'exécution</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">ImmSel</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">2</td>
<td markdown="span">Valeur déterminant comment reconstruire l'immédiat</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">Imm</td>
<td style="text-align:center" markdown="span">Sortie</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Valeur de l'immédiat associé à l'instruction</td>
</tr>
</tbody>
</table>

### Info: Processeur (circuits `cpu*.circ`)

Le kit de démarrage fournit également des squelettes pour votre processeur dans `cpu*.circ`. Vous utiliserez vos propres implémentations de l'UAL et du « Banc de Registres » lorsque vous construirez votre chemin de données. Pour la partie A, votre processeur doit pouvoir exécuter l'instruction `addi` en utilisant un « pipeline » à deux étages, avec IF dans la première étape et ID, EX, MEM et WB dans la deuxième étape. Pour commencer, cependant, il est recommandé de construire un processeur sans « pipeline » (utilisez le fichier squelette `cpu_single.circ` pour ce mode de fonctionnement). Une fois votre processeur à cycle unique fonctionne correctement, vous pouvez copier puis modifier votre processeur dans `cpu_pipelined.circ` pour produire une version << pipeline >> à deux étages.

Votre processeur est inséré dans le socle `test_single_harness.circ` (ou `test_pipelined_harness.circ`, selon le cas) qui contient l'unité de mémoire. Ce socle de processeur est inséré à son tour dans le socle de test `run_single.circ` (resp. `run_pipelined.circ`) qui fournit les instructions au processeur.

En sortie, votre processeur émettra l'adresse d'une instruction à récupérer depuis la mémoire d'instructions (IMEM). L'instruction sollicitée est transmise ensuite au processeur dans l'entrée appropriée.

En sortie également, le processeur émettra l'adresse d'une donnée en mémoire (DMEM) et éventuellement un signal d'activation de l'écriture de données en mémoire (WRITE_ENABLE). Pour la lecture, les données récupérées depuis l'adresse transmise seront communiquées au processeur dans l'entrée appropriée (READ_DATA).

Essentiellement, les socles `test_*_harness.circ` et `run_*.circ` simulent respectivement vos mémoires de données (DMEM) et d'instructions (IMEM). Prenez le temps de vous familiariser avec leur fonctionnement pour vous faire une idée globale sur le simulateur.

<div class="bs-callout bs-callout-danger">
  <h4>ATTENTION</h4>

<p>les socles <b>test_*_harness.circ</b> seront utilisés dans les tests de cohérence qui vous sont fournis, assurez-vous donc que votre processeur <b>cpu_*.circ</b> s'insère correctement dans le socle associé avant de tester votre implémentation, et particulièrement lorsque vous soumettez votre travail pour évaluation</p>

<p>Tout comme avec l'UAL et le « Banc de Registres », veillez à <b>NE PAS</b> déplacer les ports d'entrée ou de sortie !</p>
</div>

Le processeur dispose de trois entrées qui proviennent du socle :

<table class="styled-table">
<colgroup>
<col width="20%" />
<col width="15%" />
<col width="65%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de l'entrée</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">READ_DATA</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Données récupérées depuis la mémoire de données à l'adresse indiquée dans DMEM_ADDRESS (voir ci-dessous).</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">INSTRUCTION</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">L'instruction récupérée depuis la mémoire d'instructions à l'adresse indiquée par IMEM_ADDRESS (voir ci-dessous).</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">CLOCK</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Entrée fournissant l'horloge. Comme déjà indiquée dans la tâche « Banc de Registres », ce signal peut être acheminé à d'autres sous-circuits ou directement raccordé aux entrées d’horloge des unités de mémoire dans Logisim, mais ne doit en aucune façon être raccordé à des portes logiques (c’est-à-dire, ne l’inversez pas, n'appliquez pas la porte "ET" dessus, etc.).</td>
</tr>
</tbody>
</table>

<br>
... et fournit les sorties suivantes pour le socle :

<table class="styled-table">
<colgroup>
<col width="20%" />
<col width="15%" />
<col width="65%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom de la sortie</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center">Description</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:center" markdown="span">ra</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $ra (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">sp</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $sp (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">t0</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $t0 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">t1</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $t1 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">t2</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $t2 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">s0</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $s0 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">s1</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $s1 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">a0</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Renvoie la valeur contenue dans le registre $a0 (sortie utilisée pour le débogage et les tests)</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">DMEM_ADDRESS</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">L'adresse à partir de laquelle une lecture/écriture depuis/dans la mémoire de données est requise</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">WRITE_DATA</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Données à transmettre à la mémoire de données</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">WRITE_ENABLE</td>
<td style="text-align:center" markdown="span">4</td>      
<td markdown="span">Fournit le masque de validation d'écriture à la mémoire de données</td>      
</tr>

<tr>
<td style="text-align:center" markdown="span">IMEM_ADDRESS</td>
<td style="text-align:center" markdown="span">32</td>      
<td markdown="span">Cette sortie est utilisée pour sélectionner depuis la mémoire ROM dans <b>run_*_harness.circ</b> l'instruction à présenter à l'entrée INSTRUCTION (voir ci-dessus) du processeur</td>      
</tr>  
</tbody>
</table>

### Info : Unité de Contrôle

L'unité de contrôle fournie dans le fichier `control_logic.circ` n'est pas implémentée. La conception de votre unité de contrôle sera probablement votre plus grand défi dans la partie B de ce devoir. Pour la partie A, comme `addi` est la seule instruction que vous implémenterez, vous pouvez mettre une constante pour chaque signal de contrôle. Toutefois, au fur et à mesure que vous avancez dans votre implémentation de `addi`, réfléchissez aux endroits où vous devriez effectuer des modifications/additions futures afin de prendre en charge d'autres instructions en plus de `addi`.

Pour éditer l'unité de contrôle, modifiez le fichier `control_logic.circ` et non le circuit virtuel `control_logic` inclus dans `cpu_*.circ`. Notez qu'à chaque modification du circuit `control_logic.circ`, vous devez fermer et ouvrir `cpu_*.circ` pour appliquer les modifications dans votre CPU.

<div class="bs-callout bs-callout-danger">
  <h4>ATTENTION</h4>

<p>Pendant l'implémentation de votre unité de contrôle, vous pouvez <b>ajouter</b> des ports d'entrées ou de sorties supplémentaires au circuit de démarrage dans <b>control_logic.circ</b>. Vous pouvez également utiliser les ports déjà fournis (ou un sous ensemble de ces ports) en fonction des besoins de votre implémentation. Cela dit, veuillez <b>ne modifier ni supprimer aucun des ports</b> existants au cours de ce processus.
</p>
</div>

### Guide : Processeur à cycle unique

Ce guide vous aidera à implémenter l'instruction `addi` de votre processeur. Chaque section ci-dessous contient des questions auxquelles vous devez réfléchir et des indications importantes. Il est nécessaire de lire et comprendre chaque question avant de passer à la suivante ! Vous pouvez même consulter les réponses en cliquant sur  &#9654; si vous n'êtes pas capables de trouver les réponses vous-mêmes. Rappelons les cinq étapes d'exécution d'une instruction dans un processeur MIPS :

  1. Récupération d'instruction (IF)
  2. Décodage d'instruction (ID)
  3. Exécution de l'instruction (EX)
  4. Lecture/écriture depuis/vers la mémoire de données (MEM)
  5. Écriture *éventuelle* dans le « Banc de Registres » (WB)

#### **Étape 1 : Récupération d'instruction (IF)**

A ce stade de l'exécution, la question principale qui se pose est : Comment obtenir l'instruction actuelle ? Nous avons vu dans le cours que les instructions sont stockées dans la mémoire d'instructions, et chacune de ces instructions est accessible via une adresse.

<details close="">
<summary markdown="span">
1. Quel fichier du projet implémente la mémoire d'instructions ? Comment est-elle connectée au processeur ?
</summary>
<p style="color: firebrick" markdown="span">
La mémoire d'instructions est le module ROM dans le fichier `run_*.circ`. Ce fichier fournit une entrée pour votre CPU nommée `INSTRUCTION` et prend une sortie de votre CPU. Cette sortie est appelée `IMEM_ADDRESS` dans votre fichier `cpu_*.circ` et elle s'appelle `FETCH_ADDR` dans `run_*.circ`.
</p>
</details>

<details close="">
<summary markdown="span">
2. Dans vos circuits `cpu*.circ`, comment le changement de l'adresse transmise à travers `IMEM_ADDRESS` affecterait-il l'entrée `INSTRUCTION` ?
</summary>
<p style="color: firebrick" markdown="span">
L'instruction que `run_*.circ` transmet à votre processeur doit être l'instruction récupérée depuis l'adresse `IMEM_ADDRESS` (ou `FETCH_ADDR`) dans la mémoire d'instructions.
</p>
</details>

<details close="">
<summary markdown="span">
3. Comment vérifier si `IMEM_ADDRESS` est correct ?
</summary>
<p style="color: firebrick" markdown="span">
`IMEM_ADDRESS` est l'adresse de l'instruction en cours d'exécution. Cette adresse est donc sauvegardée dans le registre `PC`. Pour ce mini-projet, votre registre `PC` démarrera à la valeur `0` car c'est la valeur par défaut dans un registre Logisim.
</p>
</details>

<details close="">
<summary markdown="span">
4. Comment le registre `PC` change-t-il pour les programmes qui ne possèdent pas d'instructions de sauts ou de branchement ?
</summary>
<p style="color: firebrick" markdown="span">
Comme le registre `PC` contient l'adresse de l'instruction en cours d'exécution, il faut incrémenter ce registre de la taille d'une instruction pour passer à l'instruction suivante. Cela signifie que votre `PC` augmentera généralement de 4 (en supposant que l'instruction en cours n'est pas un saut ou un branchement).
</p>
</details>
<br>
Une implémentation simple du registre `PC` est fournie dans `cpu_*.circ`. Cette implémentation ne prend pas en compte les instructions de saut et de branchement que vous implémenterez dans la partie B du projet. Mais pour l'instant, seulement des instructions `addi` seront exécutées dans notre processeur.

Rappelons que nous allons éventuellement implémenter un processeur en pipeline à 2 étages, de sorte que l'étape IF est séparée des étapes restantes. Quel circuit sépare les différentes étapes dans un pipeline ? Plus précisément, quel circuit sépare IF de l'étage suivant ? Auriez-vous besoin d'ajouter quelque chose ici ?
<br>

#### **Étape 2 : Décodeur d'instruction (ID)**

Une fois l'étape « IF » implémentée, l'instruction à traiter proviendra à l'entrée `INSTRUCTION` du processeur. La seconde étape consiste donc à décomposer cette instruction selon les formats d'instruction MIPS vus en cours, et cela afin de déterminer quoi en faire dans les étapes ultérieures d’exécution.

<details close="">
<summary markdown="span">
1. Quel type d'instruction est `addi` ? Quels sont les différents champs de bits associés à ce type d'instruction ? Quelles sont leurs plages de bits ?
</summary>
<p style="color: firebrick" markdown="span">
`addi` est une instruction de « **type I** ». Les champs de bits sont : - `opcode [31-26]` - `rs [25-21]` - `rt [20-16]` - `imm [15-0]`.</p>
</details>

<details close="">
<summary markdown="span">
2. Dans Logisim, quel outil utiliseriez-vous pour séparer différents groupes de bits ?
</summary>
<p style="color: firebrick" markdown="span">
Le Séparateur de bits (Splitter) !
</p>
</details>
<br>
&emsp;&nbsp;3\. Implémentez l'étape de « décodage d'instruction » en utilisant l'entrée `INSTRUCTION`. Vous devez utiliser des tunnels pour étiqueter et grouper les bits.
<details close="">
<summary markdown="span">
4. Dans une instruction `addi`, nous avons besoin de lire le contenu d'un registre du « Banc de Registres » pour l'additionner à une constante. Quel champ de l'instruction doit être connecté au « Banc de Registres » ? À quelle entrée du « Banc de Registres » doit-il être branché ?
</summary>
<p style="color: firebrick" markdown="span">
Le champ d'instruction `rs` doit être branché sur l'entrée « read register 1 » du « Banc de Registres ».
</p>
</details>
<!-- Le résultat de l'opération sera plus tard réinscrit dans le registre destination spécifié dans l'instruction.-->
<br>
&emsp;&nbsp;5\. Implémentez l'étape de lecture à partir du « Banc de Registres ». N'oubliez pas d'intégrer votre « Banc de Registres »  développé dans la tâche n°2 de ce projet. N'oubliez pas de connecter l'horloge !
<details close="">
<summary markdown="span">
6. En quoi le « Générateur d'Immédiat » (circuit `imm_gen.circ`) pourrait vous être utile ?
</summary>
<p style="color: firebrick" markdown="span">
Pour l'instruction `addi`, le « Générateur d'Immédiat » prend 16 bits de l'instruction en entrée et produit un immédiat signé de 32 bits. Vous devez implémenter cette logique dans le sous-circuit du générateur d'immédiat !
</p>
</details>
<br>

#### **Étape 3 : Exécution de l'instruction (EX)**

L'étape d'exécution est l'endroit où le calcul de la plupart des instructions est effectué. C'est également ici que l'idée d'utiliser un module de contrôle sera introduite.

<details close="">
<summary markdown="span">
1. Pour l'instruction `addi`, que serait les données en entrée de votre UAL ?
</summary>
<p style="color: firebrick" markdown="span">
Read Data 1 (rs) du « Banc de Registres » et la constante produite par le « Générateur d'Immédiat ».
</p>
</details>

<details close="">
<summary markdown="span">
2. A quoi sert `ALUSel` dans l'UAL ?
</summary>
<p style="color: firebrick" markdown="span">
Il détermine quelle opération l'UAL doit effectuer.
</p>
</details>

<details close="">
<summary markdown="span">
3. Bien qu'il soit possible pour l'instant de simplement coller une constante pour `ALUSel`, pourquoi cela serait déconseillé si vous preniez en considération que d'autres instructions seront implémentées dans le futur ?
</summary>
<p style="color: firebrick" markdown="span">
Lors de l'implémentation de plus d'instructions, l'entrée `ALUSel` de l'UAL pourrait changer en fonction de l'opération demandée. Donc, on a besoin d'une sorte de circuit qui change la valeur de `ALUSel` en fonction de l'instruction en cours d'exécution.
</p>
</details>
<br>
&emsp;&nbsp;4\. Intégrez dans votre processeur l'UAL développée dans la tâche n°1 de ce projet et connectez correctement les entrées. Avez-vous besoin de connecter une horloge ? Pourquoi ou pourquoi pas ?
<br>

#### **Étape 4 : Lecture/écriture depuis/vers la mémoire de données (MEM)**

L'étape **MEM** est l'endroit où la mémoire de données peut être modifiée à l'aide des instructions de stockage de données et lue à l'aide des instructions de lecture de données. Comme l'instruction `addi` n'utilise pas la mémoire de données, nous pouvons ignorer cette partie du circuit pour l'instant et continuer avec l'étape suivante d'exécution.

#### **Étape 5 : Écriture *éventuelle* dans le « Banc de Registres » (WB)**

L'étape d'écriture (WriteBack) est l'endroit où les résultats d'une opération doivent être sauvegardés dans un registre.

<details close="">
<summary markdown="span">
1. Est-ce que l'instruction `addi` requiert une écriture dans un registre ?
</summary>
<p style="color: firebrick" markdown="span">
OUI ! l'instruction `addi` prend la sortie d'un calcul d'addition dans l'UAL et la réécrit dans le « Banc de Registres ».
</p>
</details>

&emsp;&nbsp;2\. Nous avons vu dans le cours que l'étape **WB** permet d'écrire dans le « Banc de Registres » la sortie de l'**UAL** ou de la mémoire de données **DMEM**. Créons donc la phase d'écriture dans cette perspective même si nous nous intéressons seulement à l'instruction `addi` pour l'instant. Comme seule une donnée à la fois peut être écrite dans le « Banc de Registres » dans l'architecture MIPS, nous devons utiliser un MUX pour choisir laquelle des sorties de l'UAL ou de **DMEM** (`READ_DATA`) à transmettre. Plus tard, lorsque vous implémenterez d'autres instructions dans la partie B du projet, vous devriez revoir l'implémentation de ce multiplexeur pour gérer plus de cas.

<details close="">
<summary markdown="span">
3. Que devons-nous utiliser comme entrée de sélection du MUX ? De quoi dépend l'entrée ?
</summary>
<p style="color: firebrick" markdown="span">
On devrait pouvoir choisir entre trois entrées MUX : (1) UAL, (2) MEM [`READ_DATA`] et (3) PC + 4 (quand est-ce on aura besoin de celui-là ?). Le signal de commande qui détermine laquelle de ces entrées est transmise au « Banc de Registres » est appelé `WBSel`. Pour l'instant, WBSel devrait avoir une seule valeur - quelle qu'elle soit pour `addi`.
</p>
</details>

<details close="">
<summary markdown="span">
4. Maintenant que les entrées du MUX sont fixées, nous devons brancher sa sortie ! Où doit-elle être raccordée ?
</summary>
<p style="color: firebrick" markdown="span">
La sortie du MUX véhicule les données que vous souhaitez écrire dans le « Banc de Registres », elle doit donc être raccordée à l'entrée `Write Data` du « Banc de Registres ».
</p>
</details>

&emsp;&nbsp;5\. Il y a deux autres entrées sur le « Banc de Registres » qui sont importantes pour l'écriture des données : `RegWEn` et `Write_Data`. L'une d'entre elles devra être récupérée de l'étape de décodage d'instructions (ID) et l'autre correspond à un nouveau signal de commande que vous devez concevoir dans la partie B du projet. Veuillez finaliser l'étape de l'écriture en implémentant correctement ces entrées pour l'instruction `addi`.

Si vous avez effectué toutes les étapes correctement, vous devriez avoir un processeur à cycle unique qui fonctionne pour les instructions `addi`. Exécutez `python3 test_runner.py part_a addi_single` depuis le terminal et vérifiez si votre implémentation fonctionne correctement !

### Guide : Parallélisation (pipelining) de votre processeur

Il est maintenant temps de transformer votre processeur à cycle unique en une version « pipeline » ! Pour ce projet, vous allez implémenter un pipeline à deux étages, qui est encore conceptuellement similaire au pipeline à cinq étages introduit dans le cours. Les deux étages que vous mettrez en oeuvre sont les suivantes :

  1. Récupération d'instruction (PIF) : Une instruction est récupérée depuis la mémoire d'instructions.
  2. Exécution de l'instruction (PEX) : L'instruction est décodée, exécutée et validée (résultat sauvegardé). Il s'agit d'une combinaison des quatre dernières étapes (ID, EX, MEM et WB) dans un processeur à cycle unique.

Comme le décodage et l'exécution de l'instruction sont gérés dans l'étape d'exécution, **votre processeur `addi` en pipeline sera plus ou moins identique à sa version en << cycle unique >>, à l'exception de la latence de démarrage d'un cycle d'horloge**. Nous allons, cependant, appliquer les règles de conception de pipeline vues en cours afin de préparer notre processeur pour la partie B de ce projet.

Quelques points à considérer pour une conception du pipeline en deux étages :

  - Les étages PIF et PEX auront-ils des valeurs `PC` identiques ou différentes ?
  - Avez-vous besoin de stocker le `PC` entre les étages de pipeline ?

D'autre part, on remarquera un problème d'amorçage ici : pendant le premier cycle d'exécution, les registres introduits entre les différentes étapes du pipeline sont initialement (vides), mais le vide n'existe pas en hardware. Comment allons-nous gérer cette première instruction fictive ? A quoi correspondrait le vide dans notre processeur ? C-à-d. à quelle valeur devons-nous initialer les registres nouvellement introduits pour ne « **rien faire** » pendant le premier cycle d'exécution ?

Il arrive que Logisim remet automatiquement les registres à zéro au démarrage (ou lors de la réinitialisation); ce qui, pour notre problème de cpu en pipeline, simulera une instruction `nop` ! Merci Logisim ! N'oubliez pas d'aller dans << **Simulate \| Reset Simulation** >> pour réinitialiser votre processeur.

Après avoir << pipeliné >> votre processeur, vous devriez être en mesure de réussir le test `python3 test_runner.py part_a addi_pipelined`. Notez que le précédent test `python3 test_runner.py part_a addi_single` devrait échouer maintenant ( pourquoi ? Consultez les sorties de référence pour chaque test et réfléchissez aux effets du pipeline sur les différentes étapes ).


<!--{:start="7"}-->


## Comprendre les tests effectués

Les tests cpu inclus dans le code de démarrage sont des copies des fichiers `run_*.circ` et contiennent des instructions préalablement chargées dans la mémoire d'instructions (`Instruction Memory`). Lorsque **logisim-evolution** est lancé à partir de la [ligne de commande](http://www.cburch.com/logisim/docs/2.6.0/en/guide/verify/index.html), votre circuit est automatiquement mis en marche. L’exécution est cadencée par l'horloge, le `PC` de votre processeur est mis à jour, l'instruction récupérée est traitée, et les valeurs de chacune des sorties du circuit de test sont imprimées sur le terminal.

Prenons l'exemple du test `addi-pipelined`. Le circuit `cpu-addi.circ` contient trois instructions `addi` (`addi $t0, $0, 5`, `addi $t1, $t0, 7` et `addi $s0, $t0, 9`). Ouvrez le fichier `tests/part_a/addi_pipelined/cpu-addi.circ` dans Logisim et examinez de plus près les différentes parties du circuit de test. En haut, vous verrez l’endroit où le socle testeur `test_harness` est connecté aux sorties de débogage. Initialement, ces sorties sont toutes des `UUUUU`, mais cela ne devrait pas être le cas une fois votre circuit `cpu_pipelined.circ` est implémenté.

Le socle `test_harness` prend en entrée le signal d'horloge `clk` et l'`Instruction` fournie par le module de mémoire `Instruction Memory`. En sortie, le socle transmet pour affichage les valeurs des registres de débogage provenant de votre circuit de processeur `cpu_pipelined.circ`. La sortie additionnelle `fetch_addr` transmet l'adresse de la prochaine instruction à lire à la mémoire d'instructions `Instruction Memory`.

<div class="bs-callout bs-callout-danger">
  <p>Veillez à ne déplacer aucune des entrées/sorties de votre processeur, ni à ajouter des entrées/sorties supplémentaires. Cela modifiera la forme du sous-circuit du processeur et, par conséquent, les connexions dans les fichiers de test risquent de ne plus fonctionner correctement.</p>
</div>

Sous le socle `test_harness`, vous verrez la mémoire d'instructions contenant le code machine en hexadécimal des trois instructions `addi` testés (0x20080005, 0x21090007, 0x21100009). La mémoire d'instructions prend une entrée (appelée `fetch_addr`) et délivre l'instruction stockée à cette adresse. Dans MIPS, `fetch_addr` est une valeur de 32 bits, mais comme Logisim limite la taille des unités ROM à $$2^{16}$$, nous devons utiliser un séparateur pour récupérer seulement 14 bits de `fetch_addr` (en ignorant les deux bits les plus bas).

<details close="">
<summary markdown="span">
Pourquoi les deux bits LSB de l'adresse `fetch_addr` sont ignorés ?
</summary>
<p style="color: firebrick" markdown="span">
Dans MIPS, les instructions sont récupérées mot-par-mot depuis la mémoire d'instructions. Donc, on a besoin de convertir `fetch_addr` qui est une adresse d'octets, en une adresse de mots en supprimant les deux bits les plus bas (On y reviendra dans le cours sur les caches).
</p>
</details>

<br>
Ainsi, quand le circuit de test est mis en marche, chaque tick de l'horloge pilote l'exécution du socle `test_harness` et  incrémente le compteur appelé `Time_Step` (ce compteur se trouve à droite de la mémoire d'instructions, faites un zoom-out dans Logisim s'il n'est pas visible sur votre écran).

A chaque tick de l'horloge, l'exécution en [ligne de commande](http://www.cburch.com/logisim/docs/2.6.0/en/guide/verify/index.html) de logisim-evolution imprimera les valeurs de chacune de vos sorties de débogage vers le terminal. L'horloge continuera à tourner jusqu'à ce que `Time_Step` soit égal à la constante d'arrêt pour ce circuit de test (pour ce fichier de test en particulier, la constante d'arrêt est 5).

Enfin, nous comparons la sortie de votre circuit au résultat attendu; si la sortie de votre circuit est différente, vous échouerez au test.

### Les tests `addi`

Deux tests pour l'instruction `addi` sont fournis dans le kit de démarrage : un test pour le processeur à cycle unique et un test pour le processeur en pipeline. Vous pouvez exécuter le test pour la version « pipeline » avec la commande suivante (remplacez `pipelined` par `single` pour tester la version « cycle unique ») :

```bash
$ python3 test_runner.py part_a addi_pipelined # For a pipelined CPU
```

Vous pouvez consulter les fichiers `.s` (MIPS) et `.hex` (code machine) utilisés pour le test dans `tests/part_a/addi_pipelined/inputs`.

Pour faciliter l'interprétation de votre sortie, un script Python (`binary_to_hex_cpu.py`) est également inclus. Ce script fonctionne comme les scripts `binary_to_hex_alu.py` et `binary_to_hex_regfile.py` utilisés dans les tâches de conception de l'UAL et du « Banc de Registres » (Tâches n° 1 et 2). Pour utiliser le script, exécutez :

```bash
$ cd tests/part_a/addi_pipelined
$ python3 binary_to_hex_cpu.py student_output/CPU-addi-pipelined-student.out
```

ou, pour visualiser la sortie de référence, exécutez:

```bash
$ cd tests/part_a/addi_pipelined
$ python3 binary_to_hex_cpu.py reference_output/CPU-addi-pipelined-ref.out
```

## Soumettre la partie A du devoir

Assurez-vous à nouveau que vous n'avez pas déplacé/modifié vos ports d'entrée/sortie et que vos circuits s'insèrent sans problème dans les socles de test fournis.

Pour l'évaluation de cette partie du projet, vous devez soumettre un fichier **zippé** contenant tous les circuits que vous devez implémenter. C.-à-d. les circuits **alu.circ**, **regfile.circ**, **imm_gen.circ**, **control_logic.circ** et **cpu_\*.circ**.

```bash
votre_fichier.zip
 ├── alu.circ
 ├── regfile.circ
 ├── imm_gen.circ
 ├── control_logic.circ
 ├── cpu_single.circ
 └── cpu_pipelined.circ
 ```

Par exemple, pour mettre les fichiers **file1.circ** et **file2.circ** dans un fichier zip nommé  **votre_fichier.zip** :
  1. Ouvrez une console (Ctrl-Alt-T sous Ubuntu), puis allez dans le répertoire contenant les fichiers **file1.circ** et **file2.circ**.
  2. Tapez la commande :
     ```bash
     zip votre_fichier.zip  file1.circ file2.circ
     ```

Soumettez ensuite le fichier résultat **votre_fichier.zip** à l'évaluateur automatique. Cette partie du projet utilisera les mêmes fichiers de test déjà fournis dans le kit de démarrage pour l'évaluation de votre travail. Il n'y a pas de test caché !

---

# Partie B : Version avancée

## Tâche 4 : Plus d'instructions

Dans la tâche n°3, vous avez implémenté un processeur basique en pipeline à deux étages capable d'exécuter les instructions `addi`. Maintenant, vous allez renforcer votre processeur en implémentant plus d'instructions !

### L'architecture du jeu d'instructions (ISA)

Votre implémentation du CPU sera évaluée uniquement sur les instructions énumérées ci-dessous. Votre processeur doit prendre en charge ces instructions, mais n'hésitez pas à implémenter des instructions supplémentaires si cela vous tente ! Assurez-vous, cependant, qu'aucune de vos instructions additionnelles n'affecte le fonctionnement des instructions spécifiées ici. L'implémentation d'instructions supplémentaires n'affectera pas votre score pour ce projet.


<table class="styled-table">
<colgroup>
<col width="15%" />
<col width="30%" />
<col width="32%" />
<col width="8%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Instruction</th>
<th style="text-align:center">Description</th>
<th style="text-align:center">Opération</th>
<th style="text-align:center">Type</th>
<th style="text-align:center">Opcode/Func</th>

</tr>
</thead>
<tbody>

<tr>
<td style="text-align:left" markdown="span">**add** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Addition</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] + R[rt]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x20</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sub** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Soustraction</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] - R[rt]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x22</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**addi** rt, rs, imm</td>
<td style="text-align:left" markdown="span">Addition<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rt] ← R[rs] + imm<sub>±</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x8</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**mul** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Multiplication</td>
<td style="text-align:left" markdown="span">R[rd] ← (R[rs] x R[rt])[31:0]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x18</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**mulh** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Multiplication</td>
<td style="text-align:left" markdown="span">R[rd] ← (R[rs] x R[rt])[63:32]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x10</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**mulhu** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Multiplication;<br>(params non signés)</td>
<td style="text-align:left" markdown="span">R[rd] ← (R[rs] x R[rt])[63:32]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x19</td>
</tr>


<tr>
<td style="text-align:left" markdown="span">**and** rd, rs, rt</td>
<td style="text-align:left" markdown="span">ET logique</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] & R[rt]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x24</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**or** rd, rs, rt</td>
<td style="text-align:left" markdown="span">OU logique</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] | R[rt]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x25</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**xor** rd, rs, rt</td>
<td style="text-align:left" markdown="span">OU exclusif</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] ^ R[rt]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x26</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**andi** rt, rs, imm</td>
<td style="text-align:left" markdown="span">ET logique<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] & imm<sub>0</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xC</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**ori** rt, rs, imm</td>
<td style="text-align:left" markdown="span">OU logique<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] | imm<sub>0</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xD</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**xori** rt, rs, imm</td>
<td style="text-align:left" markdown="span">OU exclusif<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] ^ imm<sub>0</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xE</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sll** rd, rt, sh</td>
<td style="text-align:left" markdown="span">Décalage logique à gauche</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \<\< sh</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x0</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**srl** rd, rt, sh</td>
<td style="text-align:left" markdown="span">Décalage logique à droite</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \>\>\> sh</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x2</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sra** rd, rt, sh</td>
<td style="text-align:left" markdown="span">Décalage arithmétique à droite</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \>\> sh</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x3</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sllv** rd, rt, rs</td>
<td style="text-align:left" markdown="span">Décalage logique à gauche<br>avec registre</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \<\< rs</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x4</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**srlv** rd, rt, rs</td>
<td style="text-align:left" markdown="span">Décalage logique à droite<br>avec registre</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \>\>\> rs</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x6</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**srav** rd, rt, rs</td>
<td style="text-align:left" markdown="span">Décalage arithmétique à droite<br>avec registre</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rt] \>\> rs</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x7</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**slt** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Positionné si inférieur</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] < R[rt] ? 1 : 0</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x2A</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sltu** rd, rs, rt</td>
<td style="text-align:left" markdown="span">Positionné si inférieur (non signés)</td>
<td style="text-align:left" markdown="span">R[rd] ← R[rs] < R[rt] ? 1 : 0</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x2B</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**slti** rt, rs, imm</td>
<td style="text-align:left" markdown="span">Positionné si inférieur<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rt] ← R[rs] < imm<sub>±</sub> ? 1 : 0</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xA</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sltiu** rt, rs, imm</td>
<td style="text-align:left" markdown="span">Positionné si inférieur (non signée)<br>(2<sup>ème</sup> param. : immédiat)</td>
<td style="text-align:left" markdown="span">R[rt] ← R[rs] < imm<sub>±</sub> ? 1 : 0</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xB</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**j** imm</td>
<td style="text-align:left" markdown="span">Saut étiquette</td>
<td style="text-align:left" markdown="span">PC ← PC & 0xF0000000 | (imm \<\< 2)</td>
<td style="text-align:center" markdown="span">J</td>
<td style="text-align:left" markdown="span">&emsp;0x2</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**jal** imm</td>
<td style="text-align:left" markdown="span">Saut et liaison</td>
<td style="text-align:left" markdown="span">$ra ← PC + 4;<br>PC ← PC & 0xF0000000 | (imm \<\< 2)</td>
<td style="text-align:center" markdown="span">J</td>
<td style="text-align:left" markdown="span">&emsp;0x3</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**jalr** rd, rs</td>
<td style="text-align:left" markdown="span">Saut et lien sur registre</td>
<td style="text-align:left" markdown="span">R[rd] ← PC + 4;<br>PC ← R[rs]</td>
<td style="text-align:center" markdown="span">R</td>
<td style="text-align:left" markdown="span">&emsp;0x0 / 0x9</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**beq** rt, rs, imm</td>
<td style="text-align:left" markdown="span">Branchement si égalité</td>
<td style="text-align:left" markdown="span">if (R[rs] == R[rt])<br>&emsp;PC ← PC + 4 + (imm<sub>±</sub>\<\< 2)</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x4</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**bne** rt, rs, imm</td>
<td style="text-align:left" markdown="span">Branchement si différent</td>
<td style="text-align:left" markdown="span">if (R[rs] != R[rt])<br>&emsp;PC ← PC + 4 + (imm<sub>±</sub>\<\< 2)</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x5</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**lui** rt, imm</td>
<td style="text-align:left" markdown="span">Chargement immédiat</td>
<td style="text-align:left" markdown="span">R[rt] ← imm \<\< 16</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0xF</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**lb** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Chargement octet</td>
<td style="text-align:left" markdown="span">R[rt] ← Mem( R[rs] + imm<sub>±</sub>, octet )<sub>±</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x20</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**lh** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Chargement demi-mot</td>
<td style="text-align:left" markdown="span">R[rt] ← Mem( R[rs] + imm<sub>±</sub>, demi )<sub>±</sub></td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x21</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**lw** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Chargement mot</td>
<td style="text-align:left" markdown="span">R[rt] ← Mem( R[rs] + imm<sub>±</sub>, mot )</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x23</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sb** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Sauvegarde octet</td>
<td style="text-align:left" markdown="span">Mem( R[rs] + imm<sub>±</sub> ) ← R[rt][7:0]</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x28</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sh** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Sauvegarde demi-mot</td>
<td style="text-align:left" markdown="span">Mem( R[rs] + imm<sub>±</sub> ) ← R[rt][15:0]</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x29</td>
</tr>

<tr>
<td style="text-align:left" markdown="span">**sw** rt, imm(rs)</td>
<td style="text-align:left" markdown="span">Sauvegarde mot</td>
<td style="text-align:left" markdown="span">Mem( R[rs] + imm<sub>±</sub> ) ← R[rt]</td>
<td style="text-align:center" markdown="span">I</td>
<td style="text-align:left" markdown="span">&emsp;0x2b</td>
</tr>

</tbody>
</table>


**Remarques** :

 1. La notation imm<sub>±</sub> dans le tableau ci-dessus signifie << Application d'une extension de signe à l'immédiat imm >>. La même remarque s'applique à Mem(...)<sub>±</sub>. Dans ce cas l'extension de signe est appliquée à l'octet ou le demi-mot récupéré depuis la mémoire.
 2. La notation imm<sub>0</sub> signifie << Application d'une extension par des zéros à l'immédiat imm >>.

### Info : Mémoire RAM (circuit `mem.circ`)

L'unité de mémoire DMEM (fournie dans `mem.circ`) est déjà entièrement implémentée pour vous et raccordée aux sorties de votre processeur dans `test_harness.circ` ! C.-à-d. Il n'est pas nécessaire d'ajouter l'unité mémoire (`mem.circ`) à nouveau à votre implémentation. Au fait, cela entraînera un échec des scripts d'auto évaluation ce qui ne sera pas bon pour votre score :(.

Notez que l'implémentation fournie de l'unité DMEM permet les inscriptions au niveau **octet**. Cela signifie que le signal `Write_En` a une largeur de 4 bits et agit comme un masque d'écriture pour les données en entrée. Par exemple, si `Write_En` vaut `0b1000`, alors seul l'octet le plus significatif du mot adressé en mémoire sera écrasé (ex: `sb $a0, 3($s0)`).

D'autre part, le port `ReadData` renverra toujours, indépendamment de `Write_En`, la valeur en mémoire (un mot entier) à l'adresse fournie. L'unité de mémoire ignore les deux bits de poids faible dans l'adresse que vous lui fournissez et traite son entrée comme une adresse de mot plutôt qu'une adresse d'octet. Par exemple, si vous entrez l'adresse 32 bits `0x00001007` (ex: `lb $a0, 7($s0)`, avec `$s0=0x0001000`), elle sera traitée comme l'adresse de mot `0x00001004`, et vous obtiendrez en sortie les 4 octets aux adresses `0x00001004`, `0x00001005`, `0x00001006` et `0x00001007`. Vous devez donc implémenter la logique de masque nécessaire pour inscrire que les octets requis (octet n° 3 pour l'exemple `lb $a0, 7($s0)`) dans le << banc de registres >>.

Finalement, rappelez-vous que les accès non alignés à la RAM entraîneront des exceptions dans MIPS. Et comme nous n'implémentons aucune gestion des exceptions dans ce projet, vous pouvez supposer que seuls les accès sur des adresses alignées sont utilisés pour les instructions `lw`, `lh`, `sh` et `sw`. Cela signifie que les adresses utilisées avec les instructions `lw` et `sw` (resp. `lh` et `sh`) sont des multiples de 4 (resp. multiples de 2). La valeur 4 (resp. 2) correspond à la taille en octets d'un mot (resp. demi-mot) en mémoire.

Voici un résumé des entrées et sorties de la mémoire :

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="20%" />
<col width="60%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom</th>
<th style="text-align:center">Direction</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">WriteAddr</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Adresse à lire / écrire en mémoire</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">WriteData</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Valeur à écrire dans la mémoire</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">Write_En</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">4</td>
<td markdown="span">Le masque d'écriture pour les instructions qui écrivent dans la mémoire et zéro sinon</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">CLK</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Entrée fournissant l'horloge du CPU</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">ReadData</td>
<td style="text-align:center" markdown="span">Sortie</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Valeur des données stockées à l'adresse indiquée</td>
</tr>
</tbody>
</table>

### Info : Unité de Branchement (circuit `branch_comp.circ`)

L'<< Unité de Branchement >> (squelette fourni dans le fichier `branch_comp.circ`) devrait calculer la nouvelle valeur du compteur ordinal (i.e. newPC) quand l'instruction en cours d'exécution est un branchement ou un saut par << immediat >> dans le code.

Pour éditer ce circuit, modifiez le fichier `branch_comp.circ` et non le circuit virtuel `branch_comp` inclus dans `cpu_*.circ`. Notez qu'à chaque modification du circuit `branch_comp.circ`, vous devrez fermer et ouvrir `cpu_*.circ` pour appliquer les modifications dans votre CPU.

Voici un résumé des entrées et sorties de cette unité :

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="20%" />
<col width="60%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom</th>
<th style="text-align:center">Direction</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>

<tr>
<td style="text-align:center" markdown="span">inst</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">L'instruction en cours d'exécution</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">ximm</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">L'immédiat renvoyé par la sortie **Imm** du << Générateur d'Immédiat >> </td>
</tr>

<tr>
<td style="text-align:center" markdown="span">PC</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">La valeur du registre PC</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">zero</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">La valeur renvoyé par la sortie **zero** de l'UAL</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">BrUn</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">2</td>
<td markdown="span">Valeur permettant d'identifier l'instruction de branchement/saut à traiter</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">newPC</td>
<td style="text-align:center" markdown="span">Sortie</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Nouvelle valeur à transmettre au PC</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">BrJmp</td>
<td style="text-align:center" markdown="span">Sortie</td>
<td style="text-align:center" markdown="span">1</td>
<td markdown="span">Indique si l'instruction traitée est un branchement/saut dans le code</td>
</tr>
</tbody>
</table>

### Info : Générateur d'Immédiat (circuit `imm_gen.circ`)

l'unité << Générateur d'Immédiat >> (squelette fourni dans le fichier `imm_gen.circ`) devrait calculer les constantes << Imm >> des instructions de type I et la valeur du champ << shmt >> dans les instructions de décalage. Consultez la figure ci-dessous pour savoir comment chaque immédiat doit être formaté dans votre processeur :

![addi format]({{site.baseurl}}/static_files/images/immediat_extensions.png){: height="75%" width="75%" .aligncenter}

Pour éditer le « Générateur d'Immédiat », modifiez le fichier `imm_gen.circ` et non le circuit virtuel `imm_gen` inclus dans `cpu_*.circ`. Notez qu'à chaque modification du circuit `imm_gen.circ`, vous devez fermer et ouvrir le fichier `cpu_*.circ` pour appliquer les modifications dans votre CPU.

Encore une fois, voici un résumé des entrées et sorties de l'unité :

<table class="styled-table">
<colgroup>
<col width="10%" />
<col width="10%" />
<col width="20%" />
<col width="60%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">Nom</th>
<th style="text-align:center">Direction</th>
<th style="text-align:center">Largeur en bits</th>
<th style="text-align:center" >Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">inst</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">L'instruction en cours d'exécution</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">ImmSel</td>
<td style="text-align:center" markdown="span">Entrée</td>
<td style="text-align:center" markdown="span">2</td>
<td markdown="span">Valeur déterminant comment reconstruire l'immédiat</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">Imm</td>
<td style="text-align:center" markdown="span">Sortie</td>
<td style="text-align:center" markdown="span">32</td>
<td markdown="span">Valeur de l'immédiat associé à l'instruction</td>
</tr>
</tbody>
</table>


### Info : Unité de contrôle (circuit `control_logic.circ`)

Afin d'exécuter correctement chaque instruction MIPS, les signaux de contrôle jouent un rôle très important dans un processeur (et ce projet !). Le squelette fourni dans le fichier `control_logic.circ` est basé sur l'unité de contrôle vue en cour pour un processeur MIPS.

Veuillez jetez un œil sur les présentations Powerpoint du cours pour commencer. Essayez de parcourir le chemin de données avec différents types d'instructions; lorsque vous rencontrez un MUX ou un autre composant, déterminez la valeur du sélecteur ou d'activation dont vous aurez besoin pour cette instruction.

Vous pouvez, si vous le désirez, ajouter plus d'entrées ou de sorties au circuit de démarrage existant en fonction de votre implémentation du circuit de contrôle. Vous pouvez également choisir de n'utiliser qu'un sous ensemble des ports fournis. Cela dit, veuillez ne modifier ni supprimer aucun des ports existants au cours de ce processus.

Il existe deux approches principales pour implémenter le circuit logique de commande afin qu'il puisse extraire l'<< opcode / func >> d'une instruction et définir les signaux de commande de manière appropriée. La première méthode est le contrôle par circuit câblé. C’est généralement l’approche préférée pour les architectures RISC telles que MIPS et RISC-V. Ici, on utilisera les portes logiques « ET », « OU » et « NON » avec les divers composants qui peuvent être construits à partir de ces portes (comme les MUX et les DEMUX) pour implémenter des tables de vérité et de [Karnaugh](https://fr.wikipedia.org/wiki/Table_de_Karnaugh) correspondant aux fonctions identifiées.

L’autre façon de faire est d’utiliser une mémoire ROM (mémoire en lecture seule). Chaque instruction implémentée par un processeur est mappée à une adresse dans cette mémoire où on y stocke le mot de commande et de contrôle pour cette instruction. Un décodeur d’adresse prend donc une instruction en entrée (c.-à-d. le << opcode / func >>) et identifie l’adresse du mot contenant les signaux de contrôle pour cette instruction. Cette approche est courante dans les architectures CISC telles que les processeurs Intel x86-64 et offre une certaine flexibilité, car elle peut être reprogrammée en modifiant le contenu de la mémoire ROM.

Pour éditer l'unité de contrôle, modifiez le fichier `control_logic.circ` et non le circuit virtuel `control_logic` inclus dans `cpu_*.circ`. Notez qu'à chaque modification du circuit `control_logic.circ`, vous devrez fermer et ouvrir `cpu_*.circ` pour appliquer les modifications dans votre CPU.

### Info: Processeur (circuit `cpu_*.circ`)

Le circuit dans `cpu_*.circ` doit implémenter le chemin de données principal et connecter tous les sous-circuits ensemble (UAL, Unité de Branchement, unité de contrôle, Générateur d'Immédiat, mémoire RAM et Banc de Registres).

Dans la partie A, vous avez implémenté un simple pipeline en deux étages dans votre processeur. Vous devez réaliser que les << aléas de données >> ne posent PAS de problème ici car tous les accès à toutes les sources de données se produisent dans une seule étape du pipeline (le deuxième étage).

Cependant, comme la partie B de ce projet nécessite la prise en charge des instructions de branchement et de saut, il y a bien des << aléas de contrôle >> à gérer. En particulier, l’instruction immédiatement après un branchement ou un saut n’est pas nécessairement exécutée si la branche est prise. Cela rend votre tâche un peu plus complexe car au moment où vous réalisez qu’une branche ou un saut est en phase d’exécution, vous avez déjà accédé à la mémoire d’instructions et récupéré (éventuellement) la mauvaise prochaine instruction. Vous devez donc « annuler » l’instruction récupérée si l’instruction en cours d’exécution est un saut ou un branchement **validé**. Vous ne devez annuler l’instruction récupérée que si une branche est prise (n’annuler pas autrement). L’annulation d’instructions DOIT être accomplie en insérant un `nop` dans l’étape d’exécution du pipeline au lieu de l’instruction récupérée. Notez que l'instruction `sll $0, $0, 0` ou le code machine associé `0x00000000` est une instruction `nop` pour notre processeur.

Quelques points à considérer pour votre implémentation :
  -  Les étapes PIF et PEX auront-elles des valeurs PC identiques ou différentes ?
  -  Avez-vous besoin de stocker le PC entre les différentes étapes du pipeline ?
  -  Où insérer un `nop` éventuel dans le flux d'instructions ?
  -  Quelle adresse doit être demandée ensuite pendant que l'étape PEX exécute un `nop` ? Est-ce différent de la normale ?


### **Tester votre Processeur**

Des tests de cohérence sont fournis pour votre processeur dans `tests/part_b/pipelined`.

```bash
$ python3 test_runner.py part_b pipelined
```

Vous pouvez consulter les fichiers `.s` (MIPS) et `.hex` (code machine) utilisés pour les tests dans `tests/part_b/pipelined/inputs`.

Vous pouvez également utiliser le script Python `binary_to_hex_cpu.py`, comme dans la tache n° 3 ce projet, afin visualiser et mieux interpréter vos résultats.


## Soumettre la partie B du devoir

Si vous avez terminé la tâche n° 4, vous avez terminé la partie B du projet. Félicitations pour votre nouveau processeur !

Assurez-vous à nouveau que vous n'avez pas déplacé/modifié vos ports d'entrée/sortie et que vos circuits s'insèrent sans problème dans les socles de test fournis.

Pour soumettre votre travail, créez un fichier **zippé** contenant tous les circuits que vous deviez implémenter dans les deux parties de ce projets. C.-à-d. les circuits **alu.circ**, **regfile.circ**, **branch_comp.circ**, **imm_gen.circ**, **control_logic.circ**, **cpu_single.circ** et **cpu_pipelined.circ**.

```bash
votre_fichier.zip
 ├── alu.circ
 ├── regfile.circ
 ├── imm_gen.circ
 ├── branch_comp.circ
 ├── control_logic.circ
 ├── cpu_single.circ
 └── cpu_pipelined.circ
 ```

Par exemple, pour mettre les fichiers **file1.circ** et **file2.circ** dans un fichier zip nommé  **votre_fichier.zip** :
  1. Ouvrez une console (Ctrl-Alt-T sous Ubuntu), puis allez dans le répertoire contenant les fichiers **file1.circ** et **file2.circ**.
  2. Tapez la commande :
     ```bash
     zip votre_fichier.zip  file1.circ file2.circ
     ```

Soumettez ensuite le fichier résultat **votre_fichier.zip** à l'évaluateur automatique. Cette partie du projet utilisera les mêmes fichiers de test déjà fournis dans le kit de démarrage pour l'évaluation de votre travail ainsi que d'autres tests cachés.
