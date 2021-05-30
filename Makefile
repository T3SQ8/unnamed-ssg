DEST = $(DESTDIR)/usr/local/bin

install:
	mkdir -p $(DEST)
	cp -f ssg-build $(DEST)
	chmod 755 $(DEST)/ssg-build

uninstall:
	rm -f $(DEST)/ssg-build

.PHONY: install uninstall
