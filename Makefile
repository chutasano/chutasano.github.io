# Makefile for building OCaml project using Dune

.PHONY: all html docs clean

OCAML_FILES := $(wildcard bin/*.ml bin/*.mli)
OCAML_FILES += bin/dune

HTML_GEN := _build/install/default/bin/main

BIBNAME := cs.bib
BIB := resources/$(BIBNAME)
BIB2 := resources/cites.bib

# Default target
all: html docs resources/*
	mkdir -p www/resources
	cp resources/main.css www
	cp resources/main.js www
	cp $(BIB) www/resources
	cp resources/googlefb3a4debafd61d62.html www
	cp resources/sitemap.xml www
	cp resources/robots.txt www
	cp -r resources/pdf www
	cp tex/cv.pdf www/pdf
	cd www; opam exec -- dune exec main

$(HTML_GEN): $(OCAML_FILES)
	opam exec -- dune build

docs: tex/cv.pdf tex/research_statement.pdf

tex/cv.pdf: $(BIB) tex/cv.tex resources/bib-cv.sh
	cp $(BIB) tex -f
	./resources/bib-cv.sh tex/$(BIBNAME)
	cd tex; latexmk cv.tex && latexmk -c cv.tex

tex/research_statement.pdf: $(BIB) $(BIB2) tex/research_statement.tex
	cp $(BIB) tex -f
	cp $(BIB2) tex -f
	./resources/bib-cv.sh tex/$(BIBNAME)
	cd tex; latexmk cv.tex && latexmk -c cv.tex

# Clean build artifacts
clean:
	opam exec -- dune clean
	rm -rf www
	rm -f tex/$(BIBNAME)
	cd tex; latexmk -C cv.tex

