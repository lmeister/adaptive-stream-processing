#!/bin/bash
## This script builds the latex-template given by the SSE
## Usage: "sh build.sh Filename (Without extension)" -> e.g. "sh build.sh seminar" if the file is called seminar.tex
#1. PDFLaTeX
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#2. Generieren der Bibliothek
bibtex $1
#3. Generieren des Abkürzungsverzeichnisses
makeindex $1.nlo -s nomencl.ist -o $1.nls
#4. Generieren des Glossars
makeglossaries $1
#5. Erneut PDFLaTeX (2mal!)
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#6. Erneutes Generieren des Abkürzungsverzeichnisses
makeindex $1.nlo -s nomencl.ist -o $1.nls
#7. Ein letztes Mal PDFLaTeX
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#8. Temporäre Dateien entfernen
find . -regextype posix-egrep -regex ".*\.(blg|aux|idx|ind|toc|lof|lot|mpx|tex1|txt1|undo|bbl|brf|ilg|log|lol|nlo|nls|out|bak|glg|glo|gls|glsdefs|ist)$" -type f -delete

