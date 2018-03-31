all : topics.svg hooks

deploy : all
	(git branch -D gh-pages || true) &> /dev/null
	rm -rf build && mkdir -p build
	cp -a Makefile .git index.html *.txt *.svg build
	make -C build gh-pages
	rm -rf build

gh-pages :
	basename `pwd` | grep -q build || exit 1
	rm -f .git/hooks/pre-push
	git checkout -b gh-pages
	git add -f Makefile *.html *.txt *.svg
	git commit -m "this is a temporary branch, do not commit here."
	git push -f --set-upstream origin gh-pages

%.gv : %.txt
	sed 's/shape=/fontname="Sans-Serif", shape=/g' $< > $@

%.svg : %.gv
	dot -Tsvg $< > $@

clean :
	rm -f *.gv *.svg
	rm -rf build
	git branch -D gh-pages || true

hooks : .git/hooks/pre-push

.git/hooks/% : Makefile
	echo "#!/bin/sh" > $@
	echo "make `basename $@`" >> $@
	chmod 755 $@

pre-push : deploy

.PHONY : all clean hooks deploy pre-push

