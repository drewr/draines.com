HYDE = $(HOME)/tmp/python/bin/hyde
RESUMEORG = nohyde/DrewRaines.org

pdf:
	emacs --batch --visit=$(RESUMEORG) --funcall org-export-as-pdf

html:
	emacs --batch --visit=$(RESUMEORG) --funcall org-export-as-html-batch

txt:
	emacs --batch --visit=$(RESUMEORG) --funcall org-export-as-utf8

deploy: site.yaml clean pdf html txt
	$(HYDE) gen	
	cp nohyde/* deploy
	find deploy -name .DS_Store | xargs rm

pub: deploy
	@echo publishing...
	cd deploy; tar cf - --exclude \*~ * | ssh draines cd /www/htdocs/draines\; tar xf -

clean:
	rm -rf deploy
#	rm -f content/blog/tags/*.html

web: deploy
	$(HYDE) serve -p 8080

.PHONY: clean web pub
