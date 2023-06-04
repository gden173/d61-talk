
LATEXFLAGS= -f -shell-escape --interaction=nonstopmode -bibtex
LCC=latexmk

CLEAN_UP= *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.toc *.vrb *.bcf *.xml

FIG_DIR= figures
FIGURES= $(wildcard $(FIG_DIR)/*.png)

all: presentation.pdf clean

presentation.pdf: presentation.tex $(FIGURES)
	$(LCC) $(LATEXFLAGS) $<

.PHONY: figures/%.png
figures/%.png: scripts/%.R
	Rscript $< 

.PHONY: clean
clean: 
	rm -rf  $(CLEAN_UP) 

