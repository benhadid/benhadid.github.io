---
layout: default
title: page.title
---

# Astuces d'utilisation dans Logisim
***

## Astuce #1 : Comment connecter un séparateur à une porte logique

Pour connecter un séparateur à une porte logique, certaines personnes connectent les fils un à un comme illustré à l'image de gauche. Il est plus facile de *coller* la porte logique au séparateur puis déplacer la porte loin du séparateur pour construire les fils de connexion.

| ![méthode naïve]({{site.baseurl}}/static_files/images/split_gate_bad.gif){: .center-image height="70%" width="70%"} | ![méthode rapide]({{site.baseurl}}/static_files/images/split_gate_good.gif){: .center-image height="70%" width="70%"} |
| :---: | :---: |
| méthode naïve | méthode rapide |


<br>


Cette astuce est très utile lorsque vous avez beaucoup d’entrées à connecter (comme 32 entrées par exemple). Vous pouvez également utiliser cette technique pour connecter des séparateurs avec d'autres séparateurs.

## Astuce #2 : Inverser une entrée d'une porte logique

Au lieu d’ajouter une porte 'not', vous pouvez ajouter un petit cercle pour inverser une entrée. Cela rendra votre circuit plus propre.

| ![NOT gate]({{site.baseurl}}/static_files/images/and_not_b.gif.png){: .center-image height="70%" width="70%"} | ![circle]({{site.baseurl}}/static_files/images/and_not_g.gif.png){: .center-image height="70%" width="70%"} |
| :---: | :---: |
| insertion d'une porte 'not' | insersion d'un cercle |


<br>


Pour ajouter un cercle, procédez comme suit :

1. Assurez-vous d'être en mode "Edit selection and add wires" (il suffit de cliquer sur la flèche noire en haut à gauche de la fenêtre).

2. Cliquez sur la porte logique à laquelle vous souhaitez ajouter le cercle.

3. Dans la section des propriétés de la porte (dans la section en bas à gauche de votre fenêtre), choisissez l’entrée à inverser.


## Astuce #3 : Changer l'apparence d'une porte logique

Vous pouvez modifier l'attribut d'orientation (Nord, Sud, Est ou Ouest) et le nombre d'entrées d'une porte logique. Cela permet de modifier l'apparence (et la fonctionnalité) de la porte. Vous pouvez également modifier l'attribut "Data Bits" pour indiquer le nombre de bits que chaque entrée aura (les exemples ci-dessous ont des entrées sur 1 bit).

| ![AND facing East]({{site.baseurl}}/static_files/images/and_4_east.gif.png){: .center-image height="70%" width="70%"} | ![OR facing South]({{site.baseurl}}/static_files/images/or_10_south.gif.png){: .center-image height="70%" width="70%"} |
| :---: | :---: |
| Porte ET à 4 entrées orientée vers l'est | Porte OU à 10 entrées orientée face au sud |


<br>


Pour modifier l'apparence d'une porte logique, procédez comme suit :

1. Assurez-vous d'être en mode "Edit selection and add wires" (il suffit de cliquer sur la flèche noire en haut à gauche de la fenêtre).

2. Cliquez sur la porte dont vous voulez changer l'apparence.

3. Dans la section des propriétés de la porte (dans la section en bas à gauche de votre fenêtre), éditez les paramètres "Facing" et "Appearance" à votre guise.


## Astuce #4 : Inverser les broches du Séparateur

Parfois, il est préférable d'inverser les broches du séparateur pour avoir un circuit logique moins encombré. Cela est particulièrement utile quand vous avez un séparateur avec beaucoup de broches à inverser.

| ![méthode naïve]({{site.baseurl}}/static_files/images/split_rev_order_bad.gif){: .center-image height="70%" width="70%"} | ![méthode rapide]({{site.baseurl}}/static_files/images/split_rev_order_good.gif){: .center-image height="70%" width="70%"} |
| :---: | :---: |
| méthode naïve | méthode rapide |


<br>


Cliquez avec le bouton droit sur un séparateur et choisissez "distribute ascending/descending" pour modifier la distribution.

## Astuce #5 : Changer l’apparence d'un séparateur

Apprenez à prononcer

Vous pouvez modifier l'orientation du séparateur (directions Nord, Sud, Est ou Ouest) ainsi que son apparence (Left-Handed, Right-Handed, Centered ou Legacy).Essayez de jouer avec ces différents attributs pour identifier ceux qui conviennent le mieux à votre circuit.

| ![Right-handed splitter]({{site.baseurl}}/static_files/images/split_south_right.gif.png){: .center-image height="70%" width="70%"} | ![Centered splitter]({{site.baseurl}}/static_files/images/split_center_east.gif.png){: .center-image height="70%" width="70%"} |
| :---: | :---: |
| séparateur "Right-handed"<br>orienté vers le sud | séparateur "Centered"<br>orienté vers l'est |


<br>


Pour modifier l'apparence d'un séparateur, procédez comme suit :

1. Assurez-vous d'être en mode "Edit selection and add wires" (il suffit de cliquer sur la flèche noire en haut à gauche de la fenêtre).

2. Cliquez sur le séparateur dont vous souhaitez modifier l'apparence.

3. Dans la section des propriétés du séparateur (dans la section en bas à gauche de votre fenêtre), éditez les paramètres "Facing" et "Appearance" à votre guise.
