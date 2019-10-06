NAME = adamMC
TEX_FILE = $(NAME).tex
PARAM = $(TEX_FILE)
OPTIONS = -synctex=1

# should be executed no matter what
.PHONY: clean
.PHONY: pdf

all: pdf

$(NAME).bbl: bib.bib
	pdflatex $(OPTIONS) $(PARAM)
	bibtex $(NAME)
	pdflatex $(OPTIONS) $(PARAM)

pdf: $(NAME).bbl
	pdflatex $(OPTIONS) $(PARAM)

withoutBibtex:
	pdflatex $(OPTIONS) $(PARAM)

# deletes the produced files of LaTeX
clean:
	rm -f *.log *.aux *.blg *.ilg *.ind *.toc *.bbl *.bcf *.idx *.out *.run.xml *.thm *.synctex.gz *.tdo
