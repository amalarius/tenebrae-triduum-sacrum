# Chemin vers les scripts de transformation
RESP_TEX_BIN=../scripts/resp-tex.pl
PS_TEX_BIN=../scripts/ps-tex.pl
LECT_TEX_BIN=../scripts/lect-tex.pl
TIT_PS_TEX_BIN=../scripts/tit-ps-tex.pl

# Fichiers gabc à compiler
GABC_FILES=$(wildcard *.gabc) $(wildcard ../lect/*.gabc)\
	$(wildcard ../ps/neo-vulgate/*.gabc)
TEX_GEN_FILES=$(GABC_FILES:.gabc=.tex)

### Fichiers à transformer
# Traduction de répons et antiennes
RESP_FR_TXT=$(wildcard fr/resp_*.txt)
RESP_FR_TEX=$(RESP_FR_TXT:.txt=.tex)
ANT_FR_TXT=$(wildcard fr/ant_*.txt)
ANT_FR_TEX=$(ANT_FR_TXT:.txt=.tex)
VERS_FR_TXT=$(wildcard fr/vers_*.txt)
VERS_FR_TEX=$(VERS_FR_TXT:.txt=.tex)

# Psaumes latin/français
PS_TXT=$(wildcard ../ps/neo-vulgate/ps*.txt)\
	$(wildcard ../ps/neo-vulgate/at*.txt)\
	$(wildcard ../ps/neo-vulgate/benedictus*.txt)
PS_FR_TXT=$(wildcard ../ps/fr/ps*_fr.txt)\
	$(wildcard ../ps/fr/at*_fr.txt)\
	$(wildcard ../ps/fr/benedictus*_fr.txt)
PS_TEX=$(PS_TXT:.txt=.tex)

# Titres des psaumes en français
TIT_PS_FR_TXT=$(wildcard ../ps/fr/tit_*_fr.txt)
TIT_PS_FR_TEX=$(TIT_PS_FR_TXT:.txt=.tex)

# Leçons latin/français

# Traduction de versets

DOCUMENT=tenebrae-sabbato-sancto
PDF=$(DOCUMENT).pdf

all: $(PDF)

$(DOCUMENT).pdf : $(DOCUMENT).tex commun.tex $(TEX_GEN_FILES) $(RESP_FR_TEX)\
	$(ANT_FR_TEX) $(VERS_FR_TEX) $(TIT_PS_FR_TEX) $(PS_TEX)\
	$(RESP_TEX_BIN) $(PS_TEX_BIN) $(LECT_TEX_BIN) $(TIT_PS_TEX_BIN)
	lualatex $^

fr/resp%.tex: fr/resp%.txt
	$(RESP_TEX_BIN) $^
	
fr/ant%.tex: fr/ant%.txt
	$(RESP_TEX_BIN) $^

fr/vers%.tex: fr/vers%.txt
	$(RESP_TEX_BIN) $^
	
../ps/fr/tit_%_fr.tex: ../ps/fr/tit_%_fr.txt
	$(TIT_PS_TEX_BIN) $^

../ps/neo-vulgate/at23_2.tex: ../ps/neo-vulgate/at23_2.txt ../ps/fr/at23_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps4_8.tex: ../ps/neo-vulgate/ps4_8.txt ../ps/fr/ps4_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps14_4.tex: ../ps/neo-vulgate/ps14_4.txt ../ps/fr/ps14_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps15_7.tex: ../ps/neo-vulgate/ps15_7.txt ../ps/fr/ps15_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps23_5.tex: ../ps/neo-vulgate/ps23_5.txt ../ps/fr/ps23_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps26_4.tex: ../ps/neo-vulgate/ps26_4.txt ../ps/fr/ps26_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps29_8.tex: ../ps/neo-vulgate/ps29_8.txt ../ps/fr/ps29_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps50_2*.tex: ../ps/neo-vulgate/ps50_2*.txt ../ps/fr/ps50_fr.txt
	$(PS_TEX_BIN) -2 $^

../ps/neo-vulgate/ps53_8.tex: ../ps/neo-vulgate/ps53_8.txt ../ps/fr/ps53_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/ps63_7.tex: ../ps/neo-vulgate/ps63_7.txt ../ps/fr/ps63_fr.txt
	$(PS_TEX_BIN) -2 $^

../ps/neo-vulgate/ps75_7.tex: ../ps/neo-vulgate/ps75_7.txt ../ps/fr/ps75_fr.txt
	$(PS_TEX_BIN) -2 $^

../ps/neo-vulgate/ps87_4.tex: ../ps/neo-vulgate/ps87_4.txt ../ps/fr/ps87_fr.txt
	$(PS_TEX_BIN) -2 $^

../ps/neo-vulgate/ps91_2*.tex: ../ps/neo-vulgate/ps91_2*.txt ../ps/fr/ps91_fr.txt
	$(PS_TEX_BIN) -2 $^

../ps/neo-vulgate/ps150_8.tex: ../ps/neo-vulgate/ps150_8.txt ../ps/fr/ps150_fr.txt
	$(PS_TEX_BIN) -2 $^
	
../ps/neo-vulgate/benedictus_1.tex: ../ps/neo-vulgate/benedictus_1.txt ../ps/fr/benedictus_fr.txt
	$(PS_TEX_BIN) -2 $^
	
%.tex: %.gabc
	gregorio $^
	
clean:
	rm -f $(TEX_GEN_FILES) $(PDF) *~ *.log *.aux *.gaux *~
	rm -f $(RESP_FR_TEX) $(RESP_FR_TEX:.tex=.aux)
	rm -f $(ANT_FR_TEX) $(ANT_FR_TEX:.tex=.aux)
	rm -f $(TIT_PS_FR_TEX) $(TIT_PS_FR_TEX:.tex=.aux)
	rm -f $(PS_TEX) $(PS_TEX:.tex=.aux)
