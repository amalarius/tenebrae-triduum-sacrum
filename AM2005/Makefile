# Chemin vers les scripts de transformation
RESP_TEX_BIN=../scripts/resp-tex.pl
PS_TEX_BIN=../scripts/ps-tex.pl
LECT_TEX_BIN=../scripts/lect-tex.pl

# Fichiers gabc à compiler
GABC_FILES=$(wildcard *.gabc) $(wildcard ../lect/*.gabc)\
	$(wildcard ../ps/neo-vulgate/*.gabc)
TEX_GEN_FILES=$(GABC_FILES:.gabc=.tex)

### Fichiers à transformer
# Traduction de répons et antiennes
RESP_FR_TXT=$(wildcard fr/resp_*.txt)
ANT_FR_TXT=$(wildcard fr/ant_*.txt)
RESP_FR_TEX=$(RESP_FR_TXT:.txt=.tex)
ANT_FR_TEX=$(ANT_FR_TXT:.txt=.tex)

# Psaumes latin/français

# Leçons latin/français

# Traduction de versets

DOCUMENT=tenebrae-sabbato-sancto
PDF=$(DOCUMENT).pdf

all: $(PDF)

$(DOCUMENT).pdf : $(DOCUMENT).tex $(TEX_GEN_FILES) $(RESP_FR_TEX) $(ANT_FR_TEX)
	lualatex $^

fr/resp%.tex: fr/resp%.txt
	$(RESP_TEX_BIN) $^
	
fr/ant%.tex: fr/ant%.txt
	$(RESP_TEX_BIN) $^
	
%.tex: %.gabc
	gregorio $^
	
clean:
	rm -f $(TEX_GEN_FILES) $(PDF) *~ *.log *.aux *.gaux *~
	rm -f $(RESP_FR_TEX) $(RESP_FR_TXT:.txt=.aux)
	rm -f $(ANT_FR_TEX) $(ANT_FR_TXT:.txt=.aux)
