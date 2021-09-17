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
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dirindex
	chmod 755 $(DESTDIR)$(PREFIX)/bin/genindex
	chmod 755 $(DESTDIR)$(PREFIX)/bin/gentoc
	chmod 755 $(DESTDIR)$(PREFIX)/bin/relpath
	chmod 755 $(DESTDIR)$(PREFIX)/bin/genrss
	chmod 755 $(DESTDIR)$(PREFIX)/bin/markdown2html
	chmod 755 $(DESTDIR)$(PREFIX)/bin/wraphtml
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f man/markdown2html.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/relpath.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/dirindex.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/genrss.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/ssg-build.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/genindex.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/gentoc.1 $(DESTDIR)$(MANPREFIX)/man1/
	cp -f man/wraphtml.1 $(DESTDIR)$(MANPREFIX)/man1/
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/markdown2html.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/relpath.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dirindex.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/genrss.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/ssg-build.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/genindex.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/gentoc.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/wraphtml.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dirindex
	rm -f $(DESTDIR)$(PREFIX)/bin/genindex
	rm -f $(DESTDIR)$(PREFIX)/bin/gentoc
	rm -f $(DESTDIR)$(PREFIX)/bin/relpath
	rm -f $(DESTDIR)$(PREFIX)/bin/genrss
	rm -f $(DESTDIR)$(PREFIX)/bin/markdown2html
	rm -f $(DESTDIR)$(PREFIX)/bin/wraphtml
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f $(DESTDIR)$(MANPREFIX)/man1/markdown2html.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/relpath.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/dirindex.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/genrss.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/ssg-build.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/genindex.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/gentoc.1 
	rm -f $(DESTDIR)$(MANPREFIX)/man1/wraphtml.1 

.PHONY: install uninstall
