#!/bin/bash
## This script builds the latex-template given by the SSE
## Usage: "sh build.sh Filename (Without extension)" -> e.g. "sh build.sh seminar" if the file is called seminar.tex
#1. PDFLaTeX
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#2. generate library
bibtex $1
#3. generate list of abbreviations
makeindex $1.nlo -s nomencl.ist -o $1.nls
#4. generate glossary
makeglossaries $1
#5. PDFLaTeX again
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#6. generate abbreviations again
makeindex $1.nlo -s nomencl.ist -o $1.nls
#7. last PDFLaTeX
pdflatex  -synctex=1 -interaction=nonstopmode --src-specials $1.tex
#8. clean temp files
find . -regextype posix-egrep -regex ".*\.(blg|aux|idx|ind|toc|lof|lot|mpx|tex1|txt1|undo|bbl|brf|ilg|log|lol|nlo|nls|out|bak|glg|glo|gls|glsdefs|ist)$" -type f -delete

