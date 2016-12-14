all : techtree.svg

deploy : all
	git branch -D gh-pages || true
	rm -rf build && mkdir -p build
	cp -a Makefile .git index.html techtree.txt techtree.svg build
	make -C build gh-pages
	rm -rf build

gh-pages : 
	git checkout -b gh-pages
	git add -f Makefile index.html techtree.txt techtree.svg
	git commit -m "this is a temporary branch, do not commit here."
	git push -f --set-upstream origin gh-pages

%.gv : %.txt
	sed 's/shape=/fontname="Sans-Serif", shape=/g' $< > $@

%.svg : %.gv
	dot -Tsvg $< > $@

clean :
	rm -f techtree.gv techtree.svg
	rm -rf build

.PHONY : all clean deploy gh-pages

