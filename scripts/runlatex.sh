#!/bin/bash

pdflatex -interaction=nonstopmode $1 $> /dev/null
bibtex $1 &> /dev/null
pdflatex -interaction=nonstopmode $1 &> /dev/null
pdflatex -interaction=nonstopmode $1 &> /dev/null
