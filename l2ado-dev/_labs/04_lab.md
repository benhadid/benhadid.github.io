---
type: lab
date: 2019-09-19T4:00:00+4:30
title: 'Travaux Pratiques #4 - Introduction à MARS'
attachment: /static_files/labs/lab_04.zip
#solutions: /static_files/labs/lab_solutions.pdf
due_event: 
    type: due
    date: 2019-09-26T23:59:00+3:30
    description: 'Travaux Pratiques #4 - à remettre'
---

# Objectifs

  - Get familiar with the MARS simulator. 
  - Learn how to assemble, run, and debug a MIPS program.


# Le Simulateur MARS 

MARS, the Mips Assembly and Runtime Simulator, will assemble and simulate the execution of MIPS assembly language programs. It can be used either from a command line or through its integrated development environment (IDE). MARS is written in Java and requires at least Release 1.5 of the J2SE Java Runtime Environment (JRE) to work. It is distributed as an executable JAR file. The MARS home page is http://www.cs.missouristate.edu/MARS/.

There are two main windows in MARS, as shown in Figure 1.1. 
 - The Edit window: used to create and modify a MIPS program 
 - The Execute window: used to run and debug a MIPS program 

To switch between the Edit and the Execute windows, use the tabs at the top. 

The Execute window contains three main panes: 

 1. Text Segment: shows the machine code and related addresses. 
 2. Data Segment: shows memory locations that hold variables in the data segment. 
 3. Labels: shows addresses of labelled items, i.e. variables and jump endpoints. 

There are two tabbed message areas at the bottom of Figure 1.1: 
 1. The Mars Messages tab: Used for messages such as assembly or runtime errors and informational messages. You can click on assembly error messages to select the corresponding line of code in the editor. 
 2. The Run I/O tab: Used at runtime for displaying console output and entering console input as program execution progresses. 

Figure 1.2 shows the MARS Execute window’s panes, and emphasizes the following features : 
  1. The Execute window’s tab. 
  2. Assembly code displayed with addresses and machine code. 
  3. Values stored in the data segment. These are directly editable. 
  4. Controls for navigating the data memory area. Allows switching to view the stack segment. 
  5. Switching between decimal and hexadecimal addresses and values in memory and registers. 
  6. Labels and their corresponding memory addresses. 
  7. Values stored in registers. These are directly editable. 
  8. Checkboxes used to setup breakpoints for each MIPS instruction. Useful in debugging. 
  9. Execution speed selection. Useful in debugging. 

At all times, the MIPS register window appears on the right-hand side of the screen, even when you are editing and not running a program. While writing a program, this serves as a useful reference for register names and their use. Move the mouse over the register name to see the tool tips. 

There are three register tabs: 
 - The Register File: integer registers $0 through $31, HI, LO, and the Program Counter PC. 
 - Coprocessor 0: exceptions, interrupts, and status codes. 
 - Coprocessor 1: floating point registers. 

# Assemble, Run, and Debug a MIPS Program 

To  assemble the file currently in the Edit tab, select Assemble from the Run menu, or use the Assemble toolbar icon. 

If there are syntax errors in the program, they will appear in the Mars Messages tab at the bottom of the MARS screen. Each error message contains the line and column where the error occurred. 

Once a MIPS program assembles successfully, the registers are initialized, and the Text Segment and the Data Segment are filled, as shown in Figure 1.3.


After running the Assemble command, you can now execute the program. The Run menu and the toolbar contain the following execution options :



You can set a breakpoint at any instruction by checking the checkbox in front of the instruction in the text segment pane. 

During execution, the instruction being executed is highlighted in yellow, and the register that was last modified is highlighted in green. Also, the variable that was last updated in the data segment is highlighted  in  blue.  It’s  usually  only possible to see the highlighting when you are stepping or running at less than full speed.

For more details about the MARS simulator, refer to the MARS documentation at the following link: http://courses.missouristate.edu/KenVollmar/MARS


# In-Lab Tasks 

1. Test a simple MIPS program. Consider the following program shown below :

```mips
```

a) Type the program shown in the Figure above. 
b) Find out how to show and hide line numbers. 
c) Assemble and run the program. 
d) What output does the program produce? and where does it appear? 

2. Explore the MARS simulator: 
a)   Download and assemble the Fibonacci.asm program from the MARS website. 
b)   Identify the locations and values of the initialized data. 
c)   Toggle the display format between decimal and hexadecimal. 
d)   Run the program at a speed of 3 instructions per second or less. 
e)   Single-step through the program and watch how register and memory values change. 
f)   Observe the output of the program in the Run I/O display window. 
g)   Set  a  breakpoint  at  the  first  instruction  that  prints  results. What is the address of this instruction? 
h)   Run the program at full speed and watch how it stops at the breakpoint. 
i)   Change the line:

space: .asciiz " "    # space to insert between numbers 

to: 

space: .asciiz "\n"   # space to insert between numbers

Run the program again. What do you notice? 





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
