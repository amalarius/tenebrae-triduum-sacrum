
GABC_FILES=$(wildcard *.gabc) $(wildcard ../lect/*.gabc) 
TEX_GABC_FILES=$(GABC_FILES:.gabc=.tex)

DOCUMENT=ténèbres-samedi-saint
PDF=$(DOCUMENT).pdf

all: $(PDF)

$(DOCUMENT).pdf : $(DOCUMENT).tex $(TEX_GABC_FILES)
	lualatex $^

%.tex: %.gabc
	gregorio $^
	
clean:
	rm -f $(TEX_GABC_FILES) $(PDF) *~ *.log *.aux *.gaux 
