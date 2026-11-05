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
	cp tex/research_statement.pdf www/pdf
	cp tex/teaching_statement.pdf www/pdf
	cd www; opam exec -- dune exec main

$(HTML_GEN): $(OCAML_FILES)
	opam exec -- dune build

docs: tex/cv.pdf tex/research_statement.pdf tex/teaching_statement.pdf

tex/cv.pdf: $(BIB) tex/cv.tex resources/bib-cv.sh
	cp $(BIB) tex -f
	./resources/bib-cv.sh tex/$(BIBNAME)
	cd tex; latexmk -pdf cv.tex && latexmk -c cv.tex

tex/research_statement.pdf: $(BIB) $(BIB2) tex/research_statement.tex resources/bib-cv.sh
	cp $(BIB) tex -f
	cp $(BIB2) tex -f
	./resources/bib-cv.sh tex/$(BIBNAME)
	cd tex; latexmk -pdf research_statement.tex && latexmk -c research_statement.tex

tex/teaching_statement.pdf: tex/teaching_statement.tex
	cd tex; latexmk -pdf teaching_statement.tex && latexmk -c teaching_statement.tex

tex/research_statement.pdf: $(BIB) $(BIB2) tex/research_statement.tex
	cp $(BIB) tex -f
	cp $(BIB2) tex -f
	./resources/bib-cv.sh tex/$(BIBNAME)
	cd tex; latexmk research_statement.tex && latexmk -c research_statement.tex

# Clean build artifacts
clean:
	opam exec -- dune clean
	rm -rf www
	rm -f tex/$(BIBNAME)
	cd tex; latexmk -C cv.tex
	cd tex; latexmk -C research_statement.tex
	cd tex; latexmk -C teaching_statement.tex

