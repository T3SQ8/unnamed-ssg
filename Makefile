FS = |
htmltemp = template.html
mdfiles = $(wildcard *.md)

md = pandoc -f gfm -t html --toc --template $(htmltemp)
html = pandoc -f html -t html --toc --template $(htmltemp)
genrss = awk -F'$(FS)' -f genrss.awk
genindex = awk -F'$(FS)' -f genindex.awk

all: $(patsubst %.md,%.html,$(mdfiles)) index.html rss.xml

%.html: %.md
	$(md) $< > $@

index.html: index.db
	$(genindex) $< | $(html) > $@

rss.xml: index.db
	$(genrss) $< > $@
