
LATEXFLAGS= -f -shell-escape --interaction=nonstopmode -bibtex
LCC=latexmk

FIG_DIR= figures
FIGURES= $(wildcard $(FIG_DIR)/*.png)

TARGET_DIR= target
presentation.pdf: presentation.tex $(FIGURES)
	$(LCC) $(LATEXFLAGS) $<

figures/%.png: scripts/%.R
	Rscript $< 

.PHONY: clean
clean: 
	rm -rf $(TARGET_DIR)/*

