---
layout: default
title: Opérations bit-à-bit en langage C
---

# Opérations bit-à-bit en langage C

## Introduction

Toute information stockée dans la mémoire d'un ordinateur est sous forme d'une suite de bits. Par exemple le nombre entier 10 (en base décimal) implémenté par une mémoire d'une largeur de 16-bit sera représenté en mémoire par la séquence de bit suivante :

```c
  0000 0000 0000 1010
```

Soit en hexadécimal :

```c
  000A
```
Quand on évoque la position d'un bit dans un nombre binaire, l'indice 0 correspond au bit de poids le plus faible (i.e. le plus à droite), l'indice 1 au deuxième bit le plus faible, et ainsi de suite. Le bit de poids le plus fort est le bit le plus à gauche du nombre binaire.

En langage C, vous pouvez écrire un nombre en binaire (base 2) en le préfixant avec `0b`. Par exemple, si nous voulons représenter le nombre 26 en binaire, dans le langage C cela donne `0b11010`.

D'autre part, sur certaines machines ou systèmes d'exploitation, un `int` pourrait utiliser 2, 4 ou 8 octets (donc 16, 32 ou 64 bits). Par conséquent, si nous voulions déclarer des variables avec un **nombre déterminé** de bits, le langage C introduit une nouvelle classe de types :

    - `int8_t` (entier signé sur 8 bits)
    - `uint8_t` (entier non signé sur 8 bits)
    - `uint16_t` (entier non signé sur 16 bits)

Ces types sont définis dans l'entête **stdint.h** 
et garantissent que les variables déclarées ainsi aient le nombre de bits souhaité.

## Opérateurs bit-à-bit

Les « opérateurs bits » en langage C permettent de modifier et de tester un ou plusieurs bits d'une donnée. Ces opérateurs sont :

 - \~ (NON) ;
 - & (ET) ;
 - \| (OU) ;
 - ^ (OU exclusif) ;
 - \<\< (décalage à droite) ;
 - \>\> (décalage à gauche).

---

### L'opérateur "~" (NON)

L'opérateur unaire NOT inverse l'état d'un bit selon le tableau suivant :


<table class="styled-table">
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">A</th>
<th style="text-align:center">NOT A</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>
<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>
</tbody>
</table>

En langage C, le caractère tilda **`~`** est utilisé pour représenter l’opérateur NOT. Il agit sur chaque bit de la valeur. Exemple :

```c
   uint16_t a = 1;  /* a == 0b0000000000000001 */
   uint16_t b = ~a; /* b == 0b1111111111111110 */
```
---

### L'opérateur "&" (ET)

L'opérateur binaire ET combine l'état de 2 bits selon le tableau suivant :


<table class="styled-table">
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">A</th>
<th style="text-align:center">B</th>
<th style="text-align:center">A ET B</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>
</tbody>
</table>

En langage C, le symbole **`&`** représente cet opérateur et agit sur *chaque* bit de ces opérandes :

```c
   uint16_t a = 0xF0F0; /* a == 0b1111000011110000 */
   uint16_t b = 0x00FF; /* b == 0b0000000011111111 */
   uint16_t c = a & b;  /* c == 0b0000000011110000 soit 0x00F0 */
```
---

### L'opérateur "|" (OU)

L'opérateur binaire OU combine l'état de 2 bits selon le tableau suivant :

<table class="styled-table">
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">A</th>
<th style="text-align:center">B</th>
<th style="text-align:center">A OU B</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>
</tbody>
</table>


Le symbole **`|`** représente l'opérateur 'OR' en langage C. Il agit sur *chaque* bit de ces opérandes :

```c
   uint16_t a = 0xF0F0; /* a == 0b1111000011110000 */
   uint16_t b = 0x00FF; /* b == 0b0000000011111111 */
   uint16_t c = a | b;  /* c == 0b1111000011111111 soit 0xF0FF */
```
---

### L'opérateur "^" (OU exclusif)

L'opérateur binaire OU exclusif (XOR) combine l'état de 2 bits selon le tableau suivant :

<table class="styled-table">
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align:center">A</th>
<th style="text-align:center">B</th>
<th style="text-align:center">A XOR B</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">0</td>
<td style="text-align:center" markdown="span">**1**</td>
</tr>

<tr>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">1</td>
<td style="text-align:center" markdown="span">**0**</td>
</tr>
</tbody>
</table>

Le caractère **`^`** représente l'opérateur 'XOR' en langage C. Il agit sur *chaque* bit de ces opérandes :

```c
   uint16_t a = 0xF0F0; /* a == 0b1111000011110000 */
   uint16_t b = 0x00FF; /* b == 0b0000000011111111 */
   uint16_t c = a ^ b;  /* c == 0b1111000000001111 soit 0xF00F */
```
---

### L'opérateur "\>\>" (Décalage à droite)

```c
result = op_1 >> op_2
```

Cet opérateur permet de décaler une valeur donnée (l'opérande `op_1`) d'un certain nombre de bits à droite (la quantité de décalage est spécifiée par l'opérande `op_2`). Les bits de poids faible de l'opérande `op_1` sont perdus, et les bits de poids fort sont remplacés par des zéros. Le résultat de l'opération est stocké dans `result`.

En langage C, une combinaison de deux chevrons orientés vers la droite **`>>`** représente l'opérateur SHR :

```c
   uint16_t a = 0xF0F0; /* a == 0b1111000011110000 */
   uint16_t b = 2;      /* b == 0b0000000000000010 */
   uint16_t c = a >> b; /* c == 0b0011110000111100 soit 0x3C3C */
```
---

### L'opérateur "\<\<" (Décalage à gauche)

```c
result = op_1 << op_2
```

Cet opérateur permet de décaler une valeur donnée (l'opérande `op_1`) d'un certain nombre de bits à gauche (la quantité de décalage est spécifiée par l'opérande `op_2`). Les bits de poids fort de l'opérande `op_1` sont perdus, et les bits de poids faible sont remplacés par des zéros. Le résultat de l'opération est stocké dans `result`.


En langage C, une combinaison de deux chevrons orientés vers la gauche **`<<`** représente l'opérateur SHL :

```c
   uint16_t a = 0xF0F0; /* a == 0b1111000011110000 */
   uint16_t b = 2;      /* b == 0b0000000000000010 */
   uint16_t c = a << b; /* c == 0b1100001111000000 soit 0xC3C0 */
```
---
## Usage des opérateurs bit-à-bit

### Positionner un bit à 1 dans une valeur

Le principe est de combiner la valeur avec un masque grâce à l'opérateur OU. En effet, comme l'indique la table de vérité de l'opérateur OU, les bits du masque qui sont à 0 vont laisser les bits correspondants dans la valeur initiale inchangés et les bits du masque qui sont à 1 vont s'imposer. Exemple :

```c
   /* mettre à 1 le bit 4 de a : */
   uint16_t a = 0x000F; /* a == 0b0000000000001111 */
   uint16_t b = 0x0010; /* b == 0b0000000000010000  b est notre masque ! */
   uint16_t c = a | b;  /* c == 0b0000000000011111  soit  0x001F */

   printf ("%04X OU %04X = %04X\n, a, b, c);
```

Pour construire le masque, il suffit d'utiliser la constante `1` que l'on décale à gauche de la valeur correspondante au poids du bit. Par exemple :

```c
   uint16_t b = 1u << 0;  /* b == 0b0000000000000001  <==> Bit  0 */
   uint16_t b = 1u << 2;  /* b == 0b0000000000000100  <==> Bit  2 */
   uint16_t b = 1u << 15; /* b == 0b1000000000000000  <==> Bit 15 */
```

 *NOTE* : Comme pour toute manipulation de bits (y compris avec des constantes), on utilise des valeurs non signées (d'où le 'u' dans le code en dessus).

### Positionner un bit à 0 dans une valeur

Le principe est de combiner la valeur avec un masque grâce à l'opérateur ET. En effet, comme l'indique la table de vérité de l'opérateur ET, les bits du masque qui sont à 1 vont laisser les bits correspondants dans la la valeur initiale inchangés et les bits du masque qui sont à 0 vont s'imposer. Exemple :

```c
/* mettre à 0 le bit 3 de  a : */
   uint16_t a = 0x000F; /* a == 0b0000000000001111 */
   uint16_t b = 0xFFF7; /* b == 0b1111111111110111 b est notre masque ! */
   uint16_t c = a & b;  /* c == 0b0000000000000111 soit  0x0007 */

   printf ("%04X OU %04X = %04X\n, a, b, c);
```

Pour construire le masque, il suffit d'utiliser la constante `1` que l'on décale à gauche de la valeur correspondante au poids du bit, puis on inverse les bits avec l'opérateur NON. Par exemple :

```c
   uint16_t b = ~(1u << 0);  /* b == 0b1111111111111110 <==> Bit  0 */
   uint16_t b = ~(1u << 2);  /* b == 0b1111111111111011 <==> Bit  2 */
   uint16_t b = ~(1u << 15); /* b == 0b0111111111111111 <==> Bit 15 */
```

### Tester l'état d'un bit dans une valeur

Le principe est d'évaluer le résultat avec l'opérateur ET entre la valeur à tester d'une part et un masque qui contient des 0 sauf pour le bit à tester qui est mis à 1. Ainsi, le résultat contiendra des 0 pour les bits 0 du masque et l’état du bit évalué pour le bit actif (bit à 1) du masque. De ce fait, si le résultat final est 0, le bit testé est donc égale à 0, sinon le bit testé est égale à 1.

```c
/* tester l'état du bit 2 de a : */
   uint16_t a = 0x000F; /* a = 0b0000000000001111 */

   if (a & (1u << 2))
   {
      puts("bit 2 == 1");
   }
   else
   {
      puts("bit 2 == 0");
   }
```
