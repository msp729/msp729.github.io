.SECONDEXPANSION:
	

OUTDIR := docs

all: univ.css index.html academia proj cob
	

academia: academia/index.html zfc peano nf
	

zfc: academia/zfc.html $(patsubst src/%.tex,%.svg,$(wildcard src/academia/zfc/*.tex))
	

peano: academia/peano.html $(patsubst src/%.tex,%.svg,$(wildcard src/academia/peano/*.tex))
	

nf: academia/nf.html $(patsubst src/%.tex,%.svg,$(wildcard src/academia/zfc/*.tex))
	

proj: proj/index.html proj/jpde.html
	

cob: cob/index.html cob/plans.html cob/roadmap.html
	

%.html: $$(src/$$*.pug)
	bin/chkdir $(OUTDIR)/$*.html
	bin/pug < src/$*.pug > $(OUTDIR)/$*.html
	echo Compiling src/$*.pug to $(OUTDIR)/$*.html

%.css: $$(src/$$*.styl)
	stylus < src/$*.styl > $(OUTDIR)/$@
	echo Compiling src/$*.styl to $(OUTDIR)/$*.css

%.svg: $$(src/$$*.tex)
	bin/chkdir obj/$*
	bin/chkdir docs/$*
	lualatex --interaction=batchmode --output-directory=obj/$(@D) src/$*.tex > /dev/null
	echo Compiling src/$*.tex to obj/$*.pdf
	pdfcrop obj/$*.pdf obj/$*_.pdf > /dev/null
	pdf2svg obj/$*_.pdf $(OUTDIR)/$*.svg
	echo Compiling cropped obj/$*_.pdf to $(OUTDIR)/$*.svg

