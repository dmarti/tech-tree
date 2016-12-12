all : techtree.svg

%.gv : %.txt
	sed 's/shape=/fontname="Sans-Serif", shape=/g' $< > $@

%.svg : %.gv
	neato -Tsvg $< > $@

clean :
	rm -f techtree.gv techtree.svg

.PHONY : all clean hooks spell epub

