

- Installer les fonts avant.

- Régler l'environnement dans le zshrc :export OSFONTDIR="/usr/local/share/fonts;$HOME/.fonts;/Users/mf/Library/Fonts"

- Détection des nouvelles polices :
mtxrun --script fonts --reload

-Génération des polices de Luatex à partir des polices systèmes :
context --generate

-A mettre dans l'en tête du fichier latex (exemple) :
\usepackage{fontspec}
\setmainfont{Inter}
\setsansfont{Inter}
\setmonofont{Hack}

-Lancer la compilation: 
lualatex -synctex=1 -interaction=nonstopmode  fichier.tex
