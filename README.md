# Template Typst - Université de La Réunion

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Typst](https://img.shields.io/badge/Typst-0.12%2B-239dad)](https://typst.app)

Template Typst pour la rédaction de documents académiques (rapports, TP, mémoires) aux couleurs de l'Université de La Réunion.

**Version Typst requise :** 0.12 ou supérieure

## Aperçu

Ce template propose 3 styles de page de couverture :

| Style | Description | Exemple |
|-------|-------------|---------|
| **moderne** | Bandeau coloré en haut, design contemporain | `exemple-rapport.typ` |
| **classique** | Style sobre et académique | `exemple-stage-recherche.typ` |
| **minimaliste** | Design épuré, focus sur le contenu | `exemple-tp-nextcloud.typ` |

## Structure du projet

```
.
├── template/
│   └── template-univ-reunion.typ    # Template principal
├── examples/
│   ├── exemple-rapport.typ          # Exemple style moderne (SAÉ Cybersécurité)
│   ├── exemple-rapport.pdf
│   ├── exemple-tp-nextcloud.typ     # Exemple style minimaliste (TP Docker)
│   ├── exemple-tp-nextcloud.pdf
│   ├── exemple-stage-recherche.typ  # Exemple style classique (Rapport recherche)
│   └── exemple-stage-recherche.pdf
├── img/                             # Logos et images
│   ├── UR_LOGO_2025_BLEU.jpg
│   ├── Univ_LOGO_2025.png
│   ├── MESRE_RVB.png
│   ├── logo-IUT-departements_RT.png
│   └── ESIROI-logo.jpg
├── docs/                            # Documentation
│   └── installation-typst.md
└── README.md
```

## Installation

Voir le guide d'installation de Typst : [docs/installation-typst.md](docs/installation-typst.md)

## Utilisation rapide

### 1. Importer le template

```typst
#import "template/template-univ-reunion.typ": *
```

### 2. Créer la page de couverture

```typst
#page-couverture(
  logo-univ: "img/UR_LOGO_2025_BLEU.jpg",
  logo-composante: "img/logo-IUT-departements_RT.png",  // Optionnel
  titre: "Titre du document",
  sous-titre: "Sous-titre",
  type-document: "Rapport de Stage",
  auteurs: ("Nom Prénom",),
  encadrants: ("M. Encadrant",),
  formation: "BUT 3 Réseaux & Télécoms",
  annee-universitaire: "2024-2025",
  date: "Juin 2025",
  style: "moderne",  // "moderne", "classique" ou "minimaliste"
)
```

### 3. Configurer le document

```typst
#show: univ-report.with(
  titre: "Titre court pour header",
  auteurs: ("Nom Prénom",),
  date: datetime.today(),
  lang: "fr",
  resume: [Résumé en français...],
  mots-cles: "mot1, mot2, mot3",
  abstract: [English abstract...],
  keywords: "keyword1, keyword2",
  toc: true,
)
```

### 4. Rédiger le contenu

```typst
= Introduction

== Contexte

Votre texte ici...

#info-box(title: "Information", type: "info")[
  Contenu de la boîte d'information.
]
```

### 5. Ajouter la page finale

```typst
#page-garde-finale(
  logo-centre: "img/logo-IUT-departements_RT.png",
  logo-droite: "img/MESRE_RVB.png",
  nom: "Nom Prénom",
  email: "prenom.nom@etudiant.univ-reunion.fr",
  telephone: "+262 6 92 XX XX XX",
  adresse: "Adresse",
)
```

## Fonctionnalités

### Boîtes d'information

```typst
#info-box(title: "Titre", type: "info")[Contenu]
#info-box(title: "Titre", type: "warning")[Contenu]
#info-box(title: "Titre", type: "success")[Contenu]
```

### Page de remerciements

```typst
#page-remerciements[
  Texte des remerciements...
]
```

### Glossaire

```typst
#glossaire((
  ("SIEM", "Security Information and Event Management"),
  ("SOC", "Security Operations Center"),
))
```

### Citation

```typst
#citation-block(
  quote: "Texte de la citation",
  author: "Auteur",
  source: "Source"
)
```

## Compilation

```bash
# Compiler un document (depuis la racine du projet)
typst compile --root . examples/exemple-rapport.typ

# Compiler avec watch (recompilation automatique)
typst watch --root . examples/exemple-rapport.typ
```

## Couleurs officielles

Le template utilise les couleurs de la charte graphique de l'Université de La Réunion :

- **Bleu outre-mer** : `#203363` (couleur principale)
- **Bleu clair** : `#2E5090` (variante)
- **Gris** : `#5A5A5A` (texte secondaire)

## Polices

- **Corps de texte** : Raleway (sans-serif)
- **Titres** : Playfair Display (serif)

## Licence

Ce template est mis à disposition sous licence MIT.

## Auteur

Développé pour les étudiants et enseignants de l'Université de La Réunion.
