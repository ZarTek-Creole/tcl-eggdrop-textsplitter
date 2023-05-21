# README.md

# Script TCL pour EGGDROP : textSplitter

## Table des matières
1. [Introduction](#introduction)
2. [Configuration](#configuration)
3. [Utilisation](#utilisation)
4. [Exemples](#exemples)
5. [Chargement du script dans EGGDROP](#chargement)
6. [Dépannage](#depannage)

## Introduction

Ce script TCL est conçu pour être utilisé avec EGGDROP sur IRC. Il fournit un outil appelé "textSplitter" qui permet de diviser des textes en blocs plus petits. Le fichier du script se nomme `text_splitter.tcl`.

Le script permet de configurer la longueur des segments et offre des méthodes pour gérer et manipuler les textes. Il respecte les codes IRC de formatage du texte et fait en sorte que les blocs de texte coupés soient toujours correctement formatés.

## Configuration

Avant d'utiliser le script, vous devez configurer la longueur du segment à utiliser lors de la division des textes. 

Vous pouvez le faire en utilisant la méthode `setSplitLength` comme suit :

```tcl
textSplitter::setSplitLength 60
```

La longueur par défaut est de 50. La longueur minimale que vous pouvez définir est de 10.

## Utilisation

Le script fournit plusieurs méthodes pour manipuler et gérer les textes. 

La méthode principale est `splitLine` qui divise un texte donné en plusieurs blocs selon la longueur du segment configurée. 

Voici un exemple d'utilisation :

```tcl
set text "Ce texte est un exemple pour illustrer l'utilisation de textSplitter. Il sera divisé en plusieurs blocs."
set splitText [textSplitter::splitLine $text]
```

## Exemples

Dans cet exemple, nous définissons la longueur du segment à 60 et nous divisons un texte. Le résultat est une liste de blocs de texte.

```tcl
textSplitter::setSplitLength 60
set text "Ce texte est un exemple pour illustrer l'utilisation de textSplitter. Il sera divisé en plusieurs blocs."
set splitText [textSplitter::splitLine $text]

# La valeur de splitText sera une liste de blocs de texte.
```

## Chargement du script dans EGGDROP

Pour charger le script TCL dans EGGDROP, suivez les étapes suivantes :

1. Assurez-vous que le script TCL `text_splitter.tcl` se trouve dans le répertoire des scripts de votre bot EGGDROP.

2. Dans votre fichier de configuration EGGDROP (habituellement `eggdrop.conf`), ajoutez la ligne suivante :
    ```tcl
    source scripts/text_splitter.tcl
    ```
3. Redémarrez votre bot EGGDROP. Le script `text_splitter.tcl` devrait maintenant être chargé et prêt à être utilisé.

## Dépannage

1. Si vous essayez de définir une longueur de segment inférieure à 10, vous obtiendrez une erreur. Assurez-vous de définir une longueur de segment de 10 ou plus.

2. Si vous essayez de diviser une chaîne vide, `splitLine` retournera une liste vide.

## Conclusion

Ce script TCL pour EGGDROP fournit un outil puissant pour manipuler et gérer les textes sur IRC. Avec lui

, vous pouvez diviser n'importe quel texte en blocs de taille gérable tout en respectant les codes de formatage IRC. Cela rend le script particulièrement utile pour gérer de grandes quantités de texte sur IRC.

Si vous rencontrez des problèmes ou si vous avez des questions, n'hésitez pas à ouvrir une issue sur ce dépôt GitHub.
