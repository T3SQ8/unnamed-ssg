DEST = $(DESTDIR)/usr/local/bin
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dirindex $(DESTDIR)$(PREFIX)/bin
	cp -f genindex $(DESTDIR)$(PREFIX)/bin
	cp -f gentoc $(DESTDIR)$(PREFIX)/bin
	cp -f relpath $(DESTDIR)$(PREFIX)/bin
	cp -f genrss $(DESTDIR)$(PREFIX)/bin
	cp -f markdown2html $(DESTDIR)$(PREFIX)/bin
	cp -f wraphtml $(DESTDIR)$(PREFIX)/bin
	cp -f gitgenrss $(DESTDIR)$(PREFIX)/bin
	cp -f jsoncomment $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dirindex
	chmod 755 $(DESTDIR)$(PREFIX)/bin/genindex
	chmod 755 $(DESTDIR)$(PREFIX)/bin/gentoc
	chmod 755 $(DESTDIR)$(PREFIX)/bin/relpath
	chmod 755 $(DESTDIR)$(PREFIX)/bin/genrss
	chmod 755 $(DESTDIR)$(PREFIX)/bin/markdown2html
	chmod 755 $(DESTDIR)$(PREFIX)/bin/wraphtml
	chmod 755 $(DESTDIR)$(PREFIX)/bin/gitgenrss
	chmod 755 $(DESTDIR)$(PREFIX)/bin/jsoncomment

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dirindex
	rm -f $(DESTDIR)$(PREFIX)/bin/genindex
	rm -f $(DESTDIR)$(PREFIX)/bin/gentoc
	rm -f $(DESTDIR)$(PREFIX)/bin/relpath
	rm -f $(DESTDIR)$(PREFIX)/bin/genrss
	rm -f $(DESTDIR)$(PREFIX)/bin/markdown2html
	rm -f $(DESTDIR)$(PREFIX)/bin/wraphtml
	rm -f $(DESTDIR)$(PREFIX)/bin/gitgenrss
	rm -f $(DESTDIR)$(PREFIX)/bin/jsoncomment

.PHONY: install uninstall
