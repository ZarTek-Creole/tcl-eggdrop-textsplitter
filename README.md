
# TCL-Eggdrop-TextSplitter

## Table des matières
1. [Présentation](#présentation)
2. [Installation](#installation)
3. [Usage](#usage)
    - [setSplitLength](#setsplitlength)
    - [getSplitLength](#getsplitlength)
    - [splitLine](#splitline)
    - [isDataNotEmpty](#isdatanotempty)
    - [updateCutIndex](#updatecutindex)
    - [isDataSpecialChar](#isdataspecialchar)
    - [updateTagStatus](#updatetagstatus)
4. [Dépannage](#dépannage)
5. [Contribuer](#contribuer)
6. [Donations](#donations)

## Présentation

TCL-Eggdrop-TextSplitter est un script TCL conçu pour fonctionner avec EGGDROP sur IRC. Ce script permet de diviser du texte en segments de taille définie, tout en prenant en compte le formatage IRC.

## Installation

Copiez le fichier `text_splitter.tcl` dans le répertoire `scripts` de votre bot Eggdrop. Ensuite, chargez le script à partir de votre fichier de configuration Eggdrop (`eggdrop.conf`) :

```bash
source scripts/text_splitter.tcl
```

## Usage

### setSplitLength

Cette procédure permet de définir la longueur du segment utilisé pour diviser les textes. 

Exemple d'utilisation :
```tcl
textSplitter::setSplitLength 80
```
Résultat attendu : La longueur du segment utilisé pour diviser les textes est maintenant de 80 caractères.

### getSplitLength

Cette procédure vous permet d'obtenir la longueur actuelle du segment utilisé pour diviser les textes.

Exemple d'utilisation :
```tcl
set currentSplitLength [textSplitter::getSplitLength]
```
Résultat attendu : La variable `currentSplitLength` contient la longueur actuelle du segment.

### splitLine

Cette procédure permet de diviser une ligne de texte en plusieurs segments de taille définie.

Exemple d'utilisation :
```tcl
set segments [textSplitter::splitLine $longText]
```
Résultat attendu : La variable `segments` contient une liste de segments de texte.

### isDataNotEmpty

Cette procédure vérifie si une donnée (chaîne de caractères) est vide après avoir supprimé tous les caractères spéciaux IRC.

Exemple d'utilisation :
```tcl
set isNotEmpty [textSplitter::isDataNotEmpty $data]
```
Résultat attendu : La variable `isNotEmpty` contient 1 si la chaîne n'est pas vide, 0 sinon.

### updateCutIndex

Cette procédure met à jour l'index de découpe utilisé pour diviser le texte en blocs.

Résultat attendu : Un nouvel indice de découpe est renvoyé.

### isDataSpecialChar

Cette procédure vérifie si un caractère à un certain index dans une chaîne de caractères est un caractère spécial IRC.

Exemple d'utilisation :
```tcl
set isSpecialChar [textSplitter::isDataSpecialChar $data $index]
```
Résultat attendu : La variable `isSpecialChar` contient

 1 si le caractère est un caractère spécial, 0 sinon.

### updateTagStatus

Cette procédure met à jour l'état des balises utilisées pour le formatage du texte dans IRC.

Résultat attendu : Un nouvel état des balises est renvoyé.

## Dépannage

Si vous rencontrez des problèmes lors de l'utilisation du script, n'hésitez pas à ouvrir un ticket sur la page d'issues du projet.

## Contribuer

Les contributions sont les bienvenues! Pour contribuer, veuillez forker le projet, faire vos modifications, puis soumettre une pull request. Pour toute question, veuillez ouvrir une issue ou nous contacter directement.

## Donations

Si vous trouvez ce projet utile et souhaitez soutenir le développement, vous pouvez faire un don à travers ce [lien](https://github.com/ZarTek-Creole/DONATE).

Nous apprécions grandement votre soutien !

## Licence

TCL-Eggdrop-TextSplitter est distribué sous la licence MIT. Voir `LICENSE` pour plus d'informations. En faite nous, il y a pas de LICENSE

## Contact

Si vous avez des questions ou des suggestions, n'hésitez pas à nous contacter :
[lien](https://github.com/ZarTek-Creole/tcl-eggdrop-textsplitter/issue)

