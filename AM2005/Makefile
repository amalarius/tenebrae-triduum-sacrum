
GABC_FILES=$(wildcard *.gabc) $(wildcard ../lect/*.gabc) 
TEX_GEN_FILES=$(GABC_FILES:.gabc=.tex)

DOCUMENT=tenebrae-sabbato-sancto
PDF=$(DOCUMENT).pdf

all: $(PDF)

$(DOCUMENT).pdf : $(DOCUMENT).tex $(TEX_GEN_FILES)
	lualatex $^

%.tex: %.gabc
	gregorio $^
	
clean:
	rm -f $(TEX_GEN_FILES) $(PDF) *~ *.log *.aux *.gaux *~
