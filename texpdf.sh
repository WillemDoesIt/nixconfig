#!/usr/bin/env bash
pdflatex "$1"
pdflatex "$1"
rm -f "${1%.tex}".{aux,log,toc,out}
