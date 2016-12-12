all : techtree.svg

%.svg : %.txt
	neato -Tsvg $< > $@

clean :
	echo "FIXME"

.PHONY : all clean hooks spell epub

