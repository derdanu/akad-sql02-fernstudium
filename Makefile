filename = vorlage

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	pdflatexcmd = pdflatex
	pdfviewercmd = evince
endif

ifeq ($(UNAME_S), Darwin)
	pdflatexcmd = /usr/texbin/pdflatex
	pdfviewercmd = open
endif


all: latex
latex:
	$(pdflatexcmd) $(filename)
	$(pdflatexcmd) $(filename)

view:
	if [ -f $(filename).pdf ]; then \
		$(pdfviewercmd) $(filename).pdf; \
	else \
		$(MAKE) all ;\
		$(MAKE) view ;\
	fi

debug: 
	$(MAKE) latex ;\
	$(MAKE) view ;\


clean:
	git clean -fx
distclean:
	git checkout -f master
	$(MAKE) clean
