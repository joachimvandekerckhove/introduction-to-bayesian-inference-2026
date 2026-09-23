# On calling 'make', compile both APA and pretty formats and then make clean

all: draft clean pretty clean

# Clean up the aux files
clean:
	rm -f *.aux *.log *.blg *.bbl *.out *.fff
	rm -f *.toc *.lof *.lot *.fls *.fdb_latexmk

# Compile in APA format to pdf/draft.pdf
draft:
	pdflatex "\def\apaformat{1}\input{main}"
	pdflatex "\def\apaformat{1}\input{main}"
	bibtex main
	bibtex main
	bibtex main
	pdflatex "\def\apaformat{1}\input{main}"
	pdflatex "\def\apaformat{1}\input{main}"
	pdflatex "\def\apaformat{1}\input{main}"
	mv main.pdf pdf/draft.pdf

# Compile in pretty format to pdf/pretty.pdf
pretty:
	pdflatex main.tex
	pdflatex main.tex
	bibtex main
	bibtex main
	bibtex main
	pdflatex main.tex
	pdflatex main.tex
	pdflatex main.tex
	mv main.pdf pdf/pretty.pdf

.PHONY: all
