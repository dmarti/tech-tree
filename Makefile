all : techtree.svg

deploy : all
	cp .git/HEAD .git/BAK
	git branch -D gh-pages || true
	git checkout -b gh-pages
	git add -f index.html techtree.txt techtree.svg
	git commit -m "temporary branch"
	git push -f --set-upstream origin gh-pages
	git rm --cached techtree.svg
	mv .git/BAK .git/HEAD
	git branch -D gh-pages || true

%.gv : %.txt
	sed 's/shape=/fontname="Sans-Serif", shape=/g' $< > $@

%.svg : %.gv
	neato -Tsvg $< > $@

clean :
	rm -f techtree.gv techtree.svg

.PHONY : all clean hooks spell epub

