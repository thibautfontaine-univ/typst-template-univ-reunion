# Installation de Typst

Typst est un système de composition de documents moderne, rapide et facile à utiliser. Ce guide vous explique comment l'installer sur les principales plateformes.

## Qu'est-ce que Typst ?

Typst est une alternative moderne à LaTeX pour la rédaction de documents scientifiques et techniques. Il offre :

- **Compilation rapide** : Temps de compilation quasi-instantané
- **Syntaxe simple** : Plus intuitive que LaTeX
- **Prévisualisation en temps réel** : Voir les changements immédiatement
- **Gestion des erreurs claire** : Messages d'erreur compréhensibles

## Installation

### macOS

Via Homebrew :

```bash
brew install typst
```

### Linux (Debian / Ubuntu)

```bash
# Télécharger la dernière release
curl -sL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz | tar xJf -

# Déplacer dans /usr/local/bin
sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

# Nettoyer
rm -rf typst-x86_64-unknown-linux-musl

# Vérifier l'installation
typst --version
```

### Windows

Via Winget :

```powershell
winget install --id Typst.Typst
```

Ou installation manuelle :

1. Téléchargez la dernière release depuis [GitHub](https://github.com/typst/typst/releases)
2. Extrayez l'archive
3. Ajoutez le dossier au PATH système

## Vérification de l'installation

```bash
typst --version
```

Vous devriez voir quelque chose comme :

```
typst 0.12.0
```

## Utilisation de base

### Compiler un document

```bash
typst compile document.typ
```

### Compilation avec watch (auto-recompilation)

```bash
typst watch document.typ
```

Le PDF sera recompilé automatiquement à chaque modification du fichier source.

## Éditeur recommandé : VS Code

1. Installez l'extension **Typst LSP** depuis le marketplace
2. Installez l'extension **Typst Preview** pour la prévisualisation en temps réel

Configuration recommandée (`settings.json`) :

```json
{
  "typst-lsp.exportPdf": "onSave",
  "typst-lsp.experimentalFormatterMode": "on"
}
```

## Ressources

- **Documentation officielle** : [typst.app/docs](https://typst.app/docs)
- **Éditeur en ligne** : [typst.app](https://typst.app)
- **GitHub** : [github.com/typst/typst](https://github.com/typst/typst)
- **Packages** : [typst.app/universe](https://typst.app/universe)
